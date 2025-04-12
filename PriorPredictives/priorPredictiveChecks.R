library(cmdstanr)
library(mvtnorm) 
library(tidyverse) 

pairwise_dist <- function(X) {
  dist(X, method = "euclidean", diag = TRUE, upper = TRUE) |> as.matrix()
}


cov_matern32_R <- function(X, sigma_f, l) {
  N <- nrow(X)
  if (N == 0) return(matrix(0, 0, 0))
  sq_sigma_f <- sigma_f^2
  sqrt3 <- sqrt(3.0)

  
  r_matrix <- pairwise_dist(X)

  term_matrix <- sqrt3 * r_matrix / l
  K <- sq_sigma_f * (1.0 + term_matrix) * exp(-term_matrix)
  diag(K) <- sq_sigma_f 
  return(K)
}


true_sigma_f <- 1.0
true_l <- 0.8
true_sigma_n <- 0.2


N_sim <- 100 
D_sim <- 2   
set.seed(123) 


X_sim <- matrix(runif(N_sim * D_sim, min = -2, max = 2), nrow = N_sim, ncol = D_sim)


K_true <- cov_matern32_R(X_sim, true_sigma_f, true_l)


diag(K_true) <- diag(K_true) + 1e-9


K_noisy_true <- K_true + diag(rep(true_sigma_n^2, N_sim))


mu_true <- rep(0, N_sim)
y_sim <- rmvnorm(1, mean = mu_true, sigma = K_noisy_true)[1, ] 

cat("Simulated data prepared.\\n")


stan_file <- "model.stan" 
cat("Compiling Stan model:", stan_file, "\\n")
tryCatch({
  model <- cmdstan_model(stan_file, cpp_options = list(stan_threads = TRUE))
  cat("Model compiled.\\n")
}, error = function(e) {
  cat("Error compiling model:\\n")
  print(e)
  stop("Compilation failed.")
})



x_sim_list <- apply(X_sim, 1, function(row) as.numeric(row))

stan_data <- list(
  N = N_sim,
  D = D_sim,
  x = x_sim_list,
  y = as.numeric(y_sim) 
)

cat("Stan data prepared. N =", N_sim, "D =", D_sim, "\\n")


cat("Running Stan sampler...\\n")
tryCatch({
  fit <- model$sample(
    data = stan_data,
    seed = 456,
    chains = 4,
    parallel_chains = 4, 
    threads_per_chain = 1, 
    iter_warmup = 500,
    iter_sampling = 500,
    refresh = 100 
    
    
  )
  cat("Sampling completed.\\n")
}, error = function(e) {
  cat("Error during sampling:\\n")
  print(e)
  stop("Sampling failed.")
})


cat("\\n--- Parameter Recovery Check ---\\n")


summary_df <- fit$summary()
print(summary_df)


true_params <- list(sigma_f = true_sigma_f, l = true_l, sigma_n = true_sigma_n)
print("True values:")
print(true_params)

cat("\\nChecking if true values are within 90% credible intervals...\\n")

check_interval <- function(param_name, true_value, summary_df) {
  row <- summary_df[summary_df$variable == param_name, ]
  if (nrow(row) == 0) return(FALSE)
  lower <- row$`q5%`
  upper <- row$`q95%`
  return(true_value >= lower && true_value <= upper)
}

coverage <- sapply(names(true_params), function(p) {
  check_interval(p, true_params[[p]], summary_df)
})
print(coverage)


cat("\\nPlotting posterior distributions...\\n")
draws_df <- fit$draws(format = "df")


plot_list <- list()
for (param in names(true_params)) {
    true_val <- true_params[[param]]
    p <- ggplot(draws_df, aes_string(x = param)) +
        geom_histogram(aes(y = ..density..), bins = 30, fill = "lightblue", color = "black") +
        geom_density(color = "blue") +
        geom_vline(xintercept = true_val, color = "red", linetype = "dashed", size = 1) +
        labs(title = paste("Posterior for", param),
             subtitle = paste("True value (red line) =", round(true_val, 3))) +
        theme_minimal()
    plot_list[[param]] <- p
    print(p) 
}




cat("\\nSampler Diagnostics:\\n")
tryCatch({
  fit$cmdstan_diagnose()
}, error = function(e) {
  cat("Could not run cmdstan_diagnose: ", conditionMessage(e), "\\n")
})


cat("\\nCheck complete.\\n")