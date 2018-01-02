        
        library(shiny)
        library(rvest)
        library(coinmarketcapr)
        library(gtrendsR)
        
        coinlist<-get_marketcap_ticker_all('USD')
        
        #Set-up overall application user-interface page structure
        fluidPage(
        titlePanel("Cryptocurrency price vs. Google search volume explorer"), 
        #Create dropdown list of cryptocurrencies (drawn from top 100 available on coinmarketcap.com)    
        wellPanel(selectInput('coin','Select cryptocurrency to plot (type to search):',sort(coinlist$name),selected = "Bitcoin"),p(tags$b("Please note that plots can take some time to load as the data is retrieved on demand."),"Please see the 'About' page for information on running the application.")),
        #Code for creating 'About' page 
        tabsetPanel(tabPanel("About",p(tags$b("Background:")),p("In September 2017 SEMrush, a search engine marketing agency, reported that the price of bitcoin was strongly correlated with the volume of Google search requests for bitcoin",a("(source).", href="http://markets.businessinsider.com/currencies/news/bitcoin-price-correlation-google-search-2017-9-1002381710",target="_blank")),
        p("To investigate this further this Shiny app provides a simplified interface for exploring the linear relationship between Google search volumes and the price of major cryptocurrencies based on data from Coinmarketcap.com.",
        br(),
        p(tags$b("How to use:")),
        p( "For the purposes of ease-of-use, the tool is organized around a number of separate sections which allow Cryptocurrency price data and Google search volumes to be compared, including:"
        ),
        
        tags$li("A time series plot showing google search volumes and the selected cryptocurrency price over time.",
        tags$li("A scatter plot demonstrating the strength of the correlation for the selected cryptocurrency. The strength of the correlation ('R') is also reported in the figure title.")),
        p("To use the application, please select the Cryptocurrency you're interested from the dropdown list and wait for the application to retrieve, process and plot the data in either the 'Time Series Plot' or 'Scatter Plot' tab."),
        br(),
        p(tags$b("Application overview:")),
        p("The application uses a number of R packages including 'rvest' to scrape web data from coinmarketcap.com, 'coinmarketcapr' to interact with coinmarketcap.com and gtrendsR to download the google trends data for the selected Cryptocurrency.",a("Please see here for the code underlying the application (via Github).", href="https://github.com/gdickens/cryptodata",target="_blank")))),
        
        #create tab for the 'Time Series Plot'
        tabPanel("Time Series Plot",
                 p("The following plot displays the price and search volumes of the selected cryptocurrency for 90 days from the beginning of October 2017. If the two variables are linearly associated we might expect that on average price and search volume would increase and decrease with one another. This association is more formally examined and tested in the 'Scatter Plot' tab:"),
                 plotOutput("distPlot")),
        #create tab for the 'Scatter Plot' 
        tabPanel("Scatter Plot", p("The plot below plots the selected cryptocurrency's price against the related Google search volume. If an association exists we might expect there would be a clear pattern and the the absolute value of the correlation coefficient (see 'R' in the figure title) to be close to 1:"), 
                 plotOutput("scatterPlot"))
        ))