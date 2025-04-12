# 1 Abstract

Being able to accurately model the volatility surface for stock options is of great importance where better models will often lead to more profitable trading and investment strategies. Because of this lots of research has been done in this subject and various models from machine learning to mathematical models have been used. These other models have a key weakness: they don't quantify uncertainty. We will explore how utilizing a non-parametric gaussian process will provide useful posterior distributions and quantify the inherent uncertainty.

# 2 Introduction

Due to the ever changing dynamic nature of the financial markets, effective asset forecasting is challenging. The black scholes equation, often nicknamed the trillion dollar equation provided a framework to price stock options. However one of the main limitations of this model is the subjective nature of the volatility input. If the if we were able to enhance the volatility input the accuracy of the black scholes model would be significantly enhanced. There has been lots of work on this aspect recently, but each has limitations ... This is where using a non-parametric gaussian process presents a unique advantage. 


# 3 Literature Review




# 4 Data & Preprocessing

The data set is comprised of option data from the year 2022. We wish to model medium term option data (21-365 days to Expiry). After the data was obtained, uneccessary columns were dropped and after that we filtered out the short term (0-20 DTE) and long term (365+ DTE) and we were left with 270,000 data points.

SPY 

# 5 Methodology

# 6 Model Setup

# 7 Results

# 8 Conclusion

# References