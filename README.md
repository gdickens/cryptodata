# cryptodata
Cryptocurrency price vs. Google search volume explorer - Final assignment submission for 'Developing Data Products' course

Background:
In September 2017 SEMrush, a search engine marketing agency, reported that the price of bitcoin was strongly correlated with the volume of Google search requests for bitcoin.

To investigate this further this Shiny app provides a simplified interface for exploring the linear relationship between Google search volumes and the price of major cryptocurrencies based on data from Coinmarketcap.com. 

How to use:
For the purposes of ease-of-use, the tool is organized around a number of separate sections which allow Cryptocurrency price data and Google search volumes to be compared, including:

A time series plot showing google search volumes and the selected cryptocurrency price over time.
A scatter plot demonstrating the strength of the correlation for the selected cryptocurrency.
To use the application, please select the Cryptocurrency you're interested from the dropdown list and wait for the application to retrieve, process and plot the data in either the 'Time Series Plot' or 'Scatter Plot' tab.


Application overview:
The application uses a number of R packages including 'rvest' to scrape web data from coinmarketcap.com, 'coinmarketcapr' to interact with coinmarketcap.com and gtrendsR to download the google trends data for the selected Cryptocurrency. 