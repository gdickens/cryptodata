        library(rvest)
        library(shiny)
        library(coinmarketcapr)
        library(gtrendsR)
        
        coinlist <- get_marketcap_ticker_all('USD')
        
        function(input, output) {
        
        output$distPlot <- renderPlot({
        #construct URL to extract data from coinmarketcap.com based on the user's input
                url <-
            read_html(
                paste(
                    "https://coinmarketcap.com/currencies/",
                    gsub(" ", "-", input$coin),
                    "/historical-data/?start=20171001&end=20171229",
                    sep = ""
                )
            )
        
        coindata <- url %>%
            html_table() %>%
            as.data.frame()
        #clean the data and format the date variable. Also creates a date field in character format for merging with google trends data        
        coindata[coindata == "-"] <- NA
        coindata$Date <- as.POSIXct(coindata$Date, format = "%b %d, %Y")
        coindata$Date_ch<-format(coindata$Date, "%Y-%m-%d")
        
        #load the gtrendsR package and downloads search volume for selected cryptocurrency
        library(gtrendsR)
        coin_trend <- gtrends(input$coin, time = "2017-10-01 2017-12-29")
        coinhits <- coin_trend$interest_over_time
        coinhits$Date_ch<-format(coinhits$date, "%Y-%m-%d")
        
        coindata<-merge(coindata,coinhits,by="Date_ch")    
        
        # draw a plot showing the price over time
        par(mar=c(5,5,5,5))
        plot(coindata$Date, coindata$Close,xlab="Date (2017)",ylab="Price (USD)",main=paste(input$coin," price (USD) vs. Google search volume for \"",input$coin,"\"",sep=""))
        grid()
        par(new = T)
        with(coindata, plot(Date, hits, pch=16, axes=F, xlab=NA, ylab=NA, cex=1.2,col="red"))
        axis(side = 4)
        mtext(side = 4.5, 'Google Search Volume',line=3)
        legend("topleft",legend= c("Price","Search Volume"),pch=c(1,16),col=c("black","red"))
        })
        
        output$scatterPlot <- renderPlot({
        #construct URL to extract data from coinmarketcap.com based on the user's input
        
        url <-
            read_html(
                paste(
                    "https://coinmarketcap.com/currencies/",
                    gsub(" ", "-", input$coin),
                    "/historical-data/?start=20171001&end=20171229",
                    sep = ""
                )
            )
        
        coindata <- url %>%
            html_table() %>%
            as.data.frame()
        
        #clean the data and format the date variable. Also creates a date field in character format for merging with google trends data        
        coindata[coindata == "-"] <- NA
        coindata$Date <- as.POSIXct(coindata$Date, format = "%b %d, %Y")
        coindata$Date_ch<-format(coindata$Date, "%Y-%m-%d")
        
        #load the gtrendsR package and downloads search volume for selected cryptocurrency
        library(gtrendsR)
        coin_trend <- gtrends(input$coin, time = "2017-10-01 2017-12-29")
        coinhits <- coin_trend$interest_over_time
        coinhits$Date_ch<-format(coinhits$date, "%Y-%m-%d")
        
        coindata<-merge(coindata,coinhits,by="Date_ch")    
        
        #create a scatter plot with the google search volume and price of the selected cryptocurrency. Also calculates correlation coefficient (R)    
        plot(coindata$hits, coindata$Close,xlab="Search Volume", ylab="Price (USD)",main=paste(input$coin," price (USD) vs. Google search volume for the term \"",input$coin,"\""," R = ", round(cor(coindata$hits,coindata$Close),2), sep=""))
        grid()
        
        })
        }
