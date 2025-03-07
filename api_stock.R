library(httr)
library(jsonlite)
library(purrr)

api_key <- "lqgnjxexVly_l4vQ0pREbgO2uuc1vAEC" 

# 1. Portfolio Selection
# Tickers for the portfolio
# I selected 5 of the FTSE100:
#CNA - 	CENTRICA PLC ORD 6 14/81P
#BP - 	BP PLC $0.25
#NWG - 	NATWEST GROUP PLC ORD 107.69P
#GSK - 	GSK PLC ORD 31 1/4P
#TSCO - 	TESCO PLC ORD 6 1/3P
tickers <- c("CNA", "BP", "NWG", "GSK", "TSCO")

# 2. Data Acquisition
# 2.1 Stock Data via API using polygon.io
#I created a function that collects the stock data using the API, just as we did in workshop 2
get_stock_data <- function(ticker) {
  base_url_stock <- "https://api.polygon.io/v2/aggs/ticker"
  #this is the link necessary for the previous close data
  #I obtained it from the polygon.io documentation
  #We just concatenate the link
  query <- paste0("/", ticker, "/prev?adjusted=true&apiKey=", api_key)
  
  # Make the GET request
  response <- GET(url = paste0(base_url_stock, query))
  
  # Check for successful response
  if (status_code(response) != 200) {
    stop("Failed to retrieve stock data for ticker: ", ticker)
  }
  
  # Parse the JSON content
  data <- fromJSON(content(response, as = "text", encoding = "UTF-8"))
  
  # Print the structure of the response for debugging
  #print(paste("Response for", ticker, ":"))
  #print(data)
  
  # Check if status is OK and data is available
  if (data$status != "OK" || length(data$results) == 0) {
    stop("No valid stock data available for ticker: ", ticker)
  }
  
  # Extract stock data from the results data frame, more exactly the first row
  stock_info <- data$results[1, ] 
  
  # Create a dataframe to store stock information
  # This is the information present in the json file that we obtained using the api
  stock_df <- data.frame(
    ticker = stock_info[["T"]],  # Ticker symbol
    date = as.POSIXct(stock_info[["t"]] / 1000, origin = "1970-01-01", tz = "GMT"),  # Convert UNIX timestamp to date
    open = stock_info[["o"]],    # Open price
    close = stock_info[["c"]],   # Close price
    high = stock_info[["h"]],    # High price
    low = stock_info[["l"]],     # Low price
    volume = stock_info[["v"]],  # Trading volume
    vw = stock_info[["vw"]],     # Volume-weighted average price
    stringsAsFactors = FALSE
  )
  
  # Returns the newly created dataframe that contains all the stock data
  return(stock_df)
}



# Fetch stock data for all tickers using map_df from the purrr package
all_stock_data <- map_df(tickers, ~ {
  Sys.sleep(1)  # To respect rate limits (if necessary)
  get_stock_data(.x)
})

# I printed the dataframe to check the results
all_stock_data
# I saved the data in a csv file called stock_data.csv
write.csv(all_stock_data, file = "stock_data.csv", row.names = FALSE)



