

## Team: Owen Fisher & Jack Wu
## Theme: Bayesian Non-parametric Models
## Github Link: https://github.com/obro79/S447-Project
## Datasets:

(1) CBOE: https://www.cboe.com/market_data_services/us/options/  (API so need to set that up and downlad the data)
(2) Yahoo Finance: https://finance.yahoo.com/quote/AAPL/options/ (Can view the dataframe through the link, but will use Yfinance API to get download the data)
(3) Polygo.io: https://polygon.io/dashboard (API so need to set that up and downlad the data)


## **Methodology** 

(1) Load data from chosen dataset and clean.

(2) Fit a Dirichlet Process model to group data. (Non-parametric Model)

(3) Assign a Gaussian Process prior to each cluster, i.e. (Non-parametrci Model)
$$f_k (x) \sim GP({\mu}_k (x), K_k (x,x'))$$.

(4) Train the individual GP and mean parameters using likelihood updates from the data in each cluster.

(5) For a new input $$x^*$$, compute the probability that this input belongs to each of the clusters (a likelihood update), and take a weighted sum of the kernel functions. Also take a weighted sum of the mean functions.

(6) For a fit, just draw from the GP distribution fitted with the weighted average. For a point estimate, take the $$\mu$$ function evaluated at the $$x^*$$.

## Teamwork

To ensure that both team members contribute roughly equally to the project, we have devised the following:

- **Task Division**: We will split the project into milestones with specific tasks, deliverables, and deadlines for each team member.
- **Regular Updates**: We will meet weekly to review progress and adjust tasks to ensure balanced contributions.


## A Dirichlet Process-Based Adaptive Kernel for Nonparametric Gaussian Process Regression For Volatility Surface Fitting

Can a Dirichlet Process be used to generate adaptive, data-driven kernels for a Gaussian Process model, improving accuracy in option pricing?


https://arxiv.org/html/2009.10862v5

## Background/Motivation

Financial data is subject to frequent and unpredictable regime shifts. Whether it is public sentiment, rate hikes, or new administrations. For this reason, financial data is highly heterogenous. Traditional Gaussian Process regression models do not capture this, since a constant covariance kernel function is assumed. We don't capture the varying structure in different parts of the data. To address this, in this project, we want to introduce a Dirichlet clustering process to break the data apart and adapt mean and kernel parameters for each individual grouping. With each cluster having its own GP prior, and after taking a weighted average for the parameters of the overarching GP distribution we use to draw fits from, we expect to be able to outperform traditional regression methods in option pricing.

Stock options are financial contracts that give the holder the right, but not the obligation, to buy (call option) or sell (put option) a stock at a predetermined price before or at expiration. Stock options can be American-style (exercisable anytime before expiration) or European-style (exercisable only at expiration).

We will focus on European option as modeling it is less complex. 

For European Options a closed form solution exists called the Black-Scholes model: 

# Black-Scholes Model

The **Black-Scholes formula** is used to price **European call and put options**.

## **Formula**
For a **European call option**:

$ C = S_0 N(d_1) - Ke^{-rT} N(d_2) $

For a **European put option**:
\[
P = Ke^{-rT} N(-d_2) - S_0 N(-d_1)
\]

where:

\[
d_1 = \frac{\ln(S_0 / K) + (r + \sigma^2 / 2)T}{\sigma \sqrt{T}}
\]

\[
d_2 = d_1 - \sigma \sqrt{T}
\]

## **Parameters**
- \( C \), \( P \) = Call and put option prices
- \( S_0 \) = Current stock price
- \( K \) = Strike price of the option
- \( T \) = Time to expiration (in years)
- \( r \) = Risk-free interest rate (continuous compounding)
- \( \sigma \) = Volatility of the stock (standard deviation of returns)
- \( N(d) \) = Cumulative standard normal distribution function

## **Key Assumptions**
- No dividends during the option's lifetime
- No arbitrage opportunities
- Constant volatility and risk-free rate
- Stock prices follow a **Geometric Brownian Motion (GBM)**

One key limitation of Black Scholes Model is the assumption of constant volatility. Real-world volatility is dynamic and evolves over time, making a static assumption unrealistic. By constructing a dynamic volatility surface using a Dirichlet Process Gaussian Process (DP-GP), we can significantly improve the accuracy of the Black Scholes Model.

Existing volatility modeling approaches, such as SABR and SVI, rely on fixed parametric forms. While these models can capture some market behaviors, their rigidity limits their ability to adapt to the evolving nature of financial markets. In contrast, DP-GP provides several key advantages:

Uncertainty Estimation: Provides confidence intervals, improving risk management.
More Generalizable: Works across different asset classes and market conditions.
No Manual Calibration: Learns volatility structure from data instead of requiring manual parameter tuning.
Handles Regime Shifts: Automatically detects market changes and adapts accordingly.
By leveraging the nonparametric and flexible nature of DP-GP, we overcome the limitations of traditional models, providing a more accurate and robust framework for volatility estimation and option pricing.

A more accurate volatility prediction using DP-GP can unlock multiple profit opportunities in financial markets. Since implied volatility is a core input for option pricing and risk management, better volatility estimates can provide a trading edge


options: https://www.investopedia.com/ask/answers/062415/how-does-implied-volatility-impact-pricing-options.asp
dirichlet processes: https://www.stat.ubc.ca/~bouchard/courses/stat547-sp2011/notes-part2.pdf
