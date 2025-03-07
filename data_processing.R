# 3. Data Processing

library(dplyr)

# Data Clean-up


# Load the stock and news data
stock_data <- read.csv("stock_data.csv")
news_data <- read.csv("FTSE_news.csv")


clean_stock_data <- function(stock_data) {
  # Remove any rows with missing prices (open, close, high, low) or volume
  stock_data <- stock_data %>%
    filter(!is.na(open) & !is.na(close) & !is.na(high) & !is.na(low) & !is.na(volume))
  
  # Convert date to a proper Date format if needed
  stock_data$date <- as.Date(stock_data$date)
  
  # Ensure numeric fields are properly formatted and round to two decimal places
  stock_data <- stock_data %>%
    mutate(
      open = round(open, 2),
      close = round(close, 2),
      high = round(high, 2),
      low = round(low, 2),
      volume = as.integer(volume)  # Convert volume to integer
    )
  
  return(stock_data)
}

# Clean and format news data
clean_news_data <- function(news_data) {
  # Remove any rows with missing headlines or links
  news_data <- news_data %>%
    filter(!is.na(Headline) & !is.na(Link))
  
  # Trim whitespace from headlines and ensure links are properly formatted
  news_data <- news_data %>%
    mutate(
      headline = trimws(Headline),
      link = trimws(Link)
    )
  
  return(news_data)
}

# Clean stock and news data
stock_data_cleaned <- clean_stock_data(stock_data)
news_data_cleaned <- clean_news_data(news_data)

# Print the cleaned data for verification
print(stock_data_cleaned)
print(news_data_cleaned)

calculate_percentage_change <- function(open, close) {
  change <- ((close - open) / open) * 100
  return(round(change, 2))
}

create_portfolio_update <- function(stock_data, news_data) {
  # Combine stock summaries
  stock_data <- stock_data %>%
    mutate(percentage_change = calculate_percentage_change(open, close))
  stock_summary <- stock_data %>%
    mutate(summary = paste0(ticker, ": £", close, 
                            " (", ifelse(percentage_change >= 0, "+", ""), percentage_change, "%)\n")) %>%
    pull(summary) %>%
    paste(collapse = "\n")
  
  
  # Format news summary with numbered headlines
  news_summary <- news_data %>%
    mutate(summary = paste0(row_number(), ". ", Headline, " - ", Link)) %>%
    pull(summary) %>%
    paste(collapse = "\n\n")
  
  # Create the full update in the requested format
  portfolio_update <- paste(
    "Daily Portfolio Update - ", Sys.Date(), "\n\n",
    "Stock Summary:\n", stock_summary, "\n\n",
    "Today's News:\n", news_summary
  )
  
  return(portfolio_update)
}

# Generate the portfolio update
portfolio_update <- create_portfolio_update(stock_data, news_data)

# Save the portfolio update to a text file
writeLines(portfolio_update, con = "portfolio_update.txt")

# Print the portfolio update to check
cat(portfolio_update)