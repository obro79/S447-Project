

## A Dirichlet Process-Based Adaptive Kernel for Nonparametric Gaussian Process Regression For Volatility Surface Fitting

Can a Dirichlet Process be used to generate adaptive, data-driven kernels for a Gaussian Process model, improving accuracy in option pricing?

Datasets for Option data. 

(1) CBOE
(2) Yahoo Finance 
(3) Polygo.io 

https://arxiv.org/html/2009.10862v5

Methodology: 

1. Get Option data from Sources and preprocessing and cleaning them to ensure they include all the neccessary info like moneyness, time-to-maturity, implied volatility, and option prices.


## Background/Motivation

Stock options are financial contracts that give the holder the right, but not the obligation, to buy (call option) or sell (put option) a stock at a predetermined price before or at expiration. Stock options can be American-style (exercisable anytime before expiration) or European-style (exercisable only at expiration).

We will focus on European option as modeling it is less complex. 

For European Options a closed form solution exists called the Black-Scholes model: 

# Black-Scholes Model

The **Black-Scholes formula** is used to price **European call and put options**.

## **Formula**
For a **European call option**:
\[
C = S_0 N(d_1) - Ke^{-rT} N(d_2)
\]

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
