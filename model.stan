// Gaussian Process Regression with Matern 3/2 Kernel

functions {
  // Matern 3/2 covariance function for pairs of inputs
  matrix cov_matern32(vector[] x, real sigma_f, real l) {
    int N = size(x);
    matrix[N, N] K;
    real sq_sigma_f = square(sigma_f);
    real sqrt3 = sqrt(3.0);

    for (i in 1:(N-1)) {
      K[i, i] = sq_sigma_f; // Diagonal element
      for (j in (i + 1):N) {
        real r = distance(x[i], x[j]); // Euclidean distance
        real term = sqrt3 * r / l;
        K[i, j] = sq_sigma_f * (1.0 + term) * exp(-term);
        K[j, i] = K[i, j]; // Symmetric
      }
    }
    K[N, N] = sq_sigma_f; // Last diagonal element
    return K;
  }
}

data {
  int<lower=1> N;        // Number of data points
  int<lower=1> D;        // Number of input dimensions (should be 2)
  vector[D] x[N];        // Inputs (standardized TTE, standardized Moneyness)
  vector[N] y;           // Observed outputs (standardized log(IV))
}

parameters {
  real<lower=0> sigma_f; // Signal standard deviation (amplitude)
  real<lower=0> l;       // Length-scale
  real<lower=0> sigma_n; // Noise standard deviation
}

model {
  // Priors (Weakly informative - adjust based on data scale if not standardized)
  sigma_f ~ normal(0, 1); // Prior on signal amplitude
  l ~ normal(0, 1);       // Prior on length-scale (adjust based on input scale)
  sigma_n ~ normal(0, 1); // Prior on noise level

  // Likelihood
  {
    matrix[N, N] K = cov_matern32(x, sigma_f, l);
    matrix[N, N] K_noisy;
    vector[N] mu = rep_vector(0.0, N); // Zero mean function assumed

    // Add observation noise and jitter for numerical stability
    for (n in 1:N) {
      K[n, n] = K[n, n] + 1e-9; // Jitter
    }
    K_noisy = K + diag_matrix(rep_vector(square(sigma_n), N));

    // Standard GP likelihood
    y ~ multi_normal_cholesky(mu, cholesky_decompose(K_noisy));

  }
}

generated quantities {
 // Optional: Can generate posterior predictions or log-likelihood here
}