Hierarchical Model Description


1. Prior Level

Latent Function

$f(x)$: The latent (unobserved) function that we want to learn.

Gaussian Process Prior

Definition:$$
f(x) \sim GP(\mu(x), K(x,x'))
$$ This means that the function $f$, when evaluated at any set of points, is assumed to follow a Gaussian Process.

Components:

Gaussian Process (GP):A collection of random variables, any finite number of which have a joint Gaussian distribution.

Mean Function $\mu(x)$:In this model, a zero mean is specified: $$
\mu(x) = 0
$$ This implies that, before seeing any data, our best guess for the function’s value at any input $x$ is zero.

Covariance (Kernel) Function $K(x,x')$:Determines how function values at different input locations $x$ and $x'$ are related.It encodes our assumptions about the function's smoothness, amplitude, and other general properties.

2. Data Level

Input Variables

$x_i$:The input for the $i$-th observation. $$
x_i = (\text{TimeToExpiry}_i, \text{Moneyness}_i)
$$

TimeToExpiry$_i$:The time until the option expires for the $i$-th observation.

Moneyness$_i$:A measure of how "in-the-money" or "out-of-the-money" the option is for the $i$-th observation.

Observed Outputs

$y_i$:The observed output (e.g., option price) for the $i$-th observation.It is assumed that: $$
y_i = f(x_i) + \text{noise}
$$ where the noise accounts for observation errors or inherent variability.

3. Likelihood Level

Conditional Observation Model

Modeling $y_i$:The likelihood of observing $y_i$ given the latent function value $f(x_i)$ and noise variance $\sigma_n^2$ is specified by: $$
y_i \mid f(x_i), \sigma_n^2 \sim \text{Normal}(f(x_i), \sigma_n^2)
$$

Mean:$f(x_i)$ (the true function value).

Variance:$\sigma_n^2$ (the variance of the observation noise).

4. Noise Level (Equivalent to Likelihood)

Noise Term

$\varepsilon_i$:An alternative formulation to express the noise in the observation: $$
\varepsilon_i \sim \text{Normal}(0, \sigma_n^2)
$$ This means that each noise term is drawn from a Normal distribution with:

Mean: 0

Variance: $\sigma_n^2$

This hierarchical model uses a Gaussian Process to place a prior over the latent function $f(x)$, models the input variables $x_i$ (with components like TimeToExpiry and Moneyness), and then defines a likelihood for the observed outputs $y_i$ as the true function plus Gaussian noise. This structure provides a flexible framework for learning complex, noisy relationships in data.

Data

Hierarchical Model 

1. Prior Level

Latent Function:

$f(x)$ The unknown function we wish to learn.

Gaussian Process (GP):

$f(x) \sim GP(\mu(x), K(x,x'))$

Mean Function:$\mu(x) = 0$

Kernel Function:$$
K_{\text{Matern-3/2}}(r) = \sigma_f^2 \left( 1 + \frac{\sqrt{3}\,r}{l} \right) \exp\left( -\frac{\sqrt{3}\,r}{l} \right)
$$

where: - $r = \|x - x'\|$ is the Euclidean distance between points $x$ and $x'$; - $\sigma_f^2$ is the signal  variance; - $l$ is the length-scale parameter.

2. Data Level

Inputs ($x_i$):

$x_i = (\text{TimeToExpiry}_i, \text{Moneyness}_i)$

TimeToExpiry$_i$: Time remaining until the option expires.

Moneyness$_i$ (Forward Moneyness):$$
\text{Moneyness} = \frac{\text{Underlying Price}}{\text{Forward Price}}
$$

Underlying Price: Current price of the asset.

Forward Price:$$
F = S \, e^{rT}
$$ where:

$S$: Spot (underlying) price.

$r$: Risk-free rate (interest rate on a 3-month U.S Treasury bill).

$T$: Time to expiration.

Observation ($y_i$):

$y_i$ : The observed option price.

Model:$$
y_i = f(x_i) + \varepsilon_i
$$

$\varepsilon_i \sim \mathcal{N}(0, \sigma_n^2)$

