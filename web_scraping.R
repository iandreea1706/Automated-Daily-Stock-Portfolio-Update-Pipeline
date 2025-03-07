# # # # Load necessary libraries
# # # library(rvest)
# # # library(httr)
# # # library(xml2)
# # # 
# # # # Set environment variable for data directory
# # # data_dir <- Sys.getenv("DATA_DIR")
# # # if (data_dir == "") {
# # #   data_dir <- "data"
# # # }
# # # dir.create(data_dir, showWarnings = FALSE)
# # # 
# # # # Function to get news articles from the "Latest" section of Yahoo Finance UK
# # # get_latest_section_news <- function() {
# # #   url <- "https://uk.finance.yahoo.com/"
# # #   
# # #   # Fetch the webpage with a custom User-Agent
# # #   response <- tryCatch({
# # #     GET(url, user_agent("Mozilla/5.0"))
# # #   }, error = function(e) {
# # #     message("Error fetching URL: ", url)
# # #     return(NULL)
# # #   })
# # #   
# # #   # If response is NULL, return an empty data frame
# # #   if (is.null(response)) {
# # #     return(data.frame())
# # #   }
# # #   
# # #   # Parse the webpage content
# # #   webpage <- tryCatch({
# # #     read_html(content(response, as = "text", encoding = "UTF-8"))
# # #   }, error = function(e) {
# # #     message("Error parsing content: ", url)
# # #     return(NULL)
# # #   })
# # #   
# # #   # Identify the "Latest" section and extract news headlines and links from it
# # #   latest_section <- webpage %>% html_nodes(xpath = "//h3[contains(text(), 'Latest')]/following-sibling::ul") 
# # #   
# # #   # Extract the actual news headlines and links under the "Latest" section
# # #   headlines <- latest_section %>% html_nodes("li a") %>% html_text(trim = TRUE)
# # #   links <- latest_section %>% html_nodes("li a") %>% html_attr("href")
# # #   
# # #   # Ensure all links are absolute by prepending the base URL to relative links
# # #   full_links <- ifelse(grepl("^/", links), paste0("https://uk.finance.yahoo.com", links), links)
# # #   
# # #   # Ensure the headlines and links are aligned, and take only the first 10
# # #   n_items <- min(10, length(headlines), length(full_links))
# # #   if (n_items == 0) {
# # #     return(data.frame())
# # #   }
# # #   
# # #   # Combine the first 10 headlines and links into a dataframe
# # #   news_df <- data.frame(
# # #     headline = headlines[1:n_items],
# # #     link = full_links[1:n_items],
# # #     stringsAsFactors = FALSE
# # #   )
# # #   
# # #   return(news_df)
# # # }
# # # 
# # # 
# # # # Fetch the top 10 news articles from the "Latest" section of Yahoo Finance UK
# # # latest_news_data <- get_latest_section_news()
# # # 
# # # latest_news_data
# # # write.csv(latest_news_data, file = "latest_news.csv", row.names = FALSE)
# # # 
# # # 
# # # # Save the news data to a CSV file
# # # #news_file <- paste0(data_dir, "/latest_section_news.csv")
# # # write.csv(latest_news_data, file = news_file, row.names = FALSE)
# # # Load necessary libraries
# # library(rvest)
# # library(httr)
# # library(xml2)
# # 
# # # Set environment variable for data directory
# # data_dir <- Sys.getenv("DATA_DIR")
# # if (data_dir == "") {
# #   data_dir <- "data"
# # }
# # dir.create(data_dir, showWarnings = FALSE)
# # 
# # # Function to get news articles from the "Latest" section of Yahoo Finance UK
# # # get_latest_section_news <- function() {
# # #   url <- "https://uk.finance.yahoo.com/"
# # #   
# # #   # Fetch the webpage with a custom User-Agent
# # #   response <- tryCatch({
# # #     GET(url, user_agent("Mozilla/5.0"))
# # #   }, error = function(e) {
# # #     message("Error fetching URL: ", url)
# # #     return(NULL)
# # #   })
# # #   
# # #   # If response is NULL, return an empty data frame
# # #   if (is.null(response)) {
# # #     return(data.frame())
# # #   }
# # #   
# # #   # Parse the webpage content
# # #   webpage <- tryCatch({
# # #     read_html(content(response, as = "text", encoding = "UTF-8"))
# # #   }, error = function(e) {
# # #     message("Error parsing content: ", url)
# # #     return(NULL)
# # #   })
# # #   
# # #   # Identify the "Latest" section and extract news headlines and links from it
# # #   latest_section <- webpage %>% html_nodes(xpath = "//h3[contains(text(), 'Latest')]/following-sibling::ul") 
# # #   
# # #   # Extract the actual news headlines and links under the "Latest" section
# # #   headlines <- latest_section %>% html_nodes("li a") %>% html_text(trim = TRUE)
# # #   links <- latest_section %>% html_nodes("li a") %>% html_attr("href")
# # #   
# # #   # Filter out invalid links and make sure the URLs are complete
# # #   full_links <- links[grepl("/news/", links)]
# # #   full_links <- paste0("https://uk.finance.yahoo.com", full_links)
# # #   
# # #   # Ensure the headlines and links are aligned, and take only the first 10
# # #   n_items <- min(10, length(headlines), length(full_links))
# # #   if (n_items == 0) {
# # #     return(data.frame())
# # #   }
# # #   
# # #   # Combine the first 10 headlines and links into a dataframe
# # #   news_df <- data.frame(
# # #     headline = headlines[1:n_items],
# # #     link = full_links[1:n_items],
# # #     stringsAsFactors = FALSE
# # #   )
# # #   
# # #   return(news_df)
# # # }
# # get_latest_section_news <- function() {
# #   url <- "https://uk.finance.yahoo.com/"
# #   
# #   # Fetch the webpage with a custom User-Agent
# #   response <- tryCatch({
# #     GET(url, user_agent("Mozilla/5.0"))
# #   }, error = function(e) {
# #     message("Error fetching URL: ", url)
# #     return(NULL)
# #   })
# #   
# #   # If response is NULL, return an empty data frame
# #   if (is.null(response)) {
# #     return(data.frame())
# #   }
# #   
# #   # Parse the webpage content
# #   webpage <- tryCatch({
# #     read_html(content(response, as = "text", encoding = "UTF-8"))
# #   }, error = function(e) {
# #     message("Error parsing content: ", url)
# #     return(NULL)
# #   })
# #   
# #   # Identify the "Latest" section and extract news headlines and links from it
# #   latest_section <- webpage %>% html_nodes(xpath = "//h3[contains(text(), 'Latest')]/following-sibling::ul") 
# #   
# #   # Extract the actual news headlines and links under the "Latest" section
# #   headlines <- latest_section %>% html_nodes("li a") %>% html_text(trim = TRUE)
# #   links <- latest_section %>% html_nodes("li a") %>% html_attr("href")
# #   
# #   # Ensure that only valid links are used and the headlines are filtered
# #   valid_links <- ifelse(grepl("^/news/", links), paste0("https://uk.finance.yahoo.com", links), NA)
# #   
# #   # Filter out headlines that include stock percentages or empty strings
# #   valid_headlines <- headlines[!grepl("[-+]?\\d+\\.\\d+%", headlines) & headlines != ""]
# #   
# #   # Align valid headlines and links (remove empty/invalid ones)
# #   valid_links <- valid_links[!is.na(valid_links)]
# #   n_items <- min(10, length(valid_headlines), length(valid_links))
# #   
# #   if (n_items == 0) {
# #     return(data.frame())
# #   }
# #   
# #   # Combine the valid headlines and links into a dataframe
# #   news_df <- data.frame(
# #     headline = valid_headlines[1:n_items],
# #     link = valid_links[1:n_items],
# #     stringsAsFactors = FALSE
# #   )
# #   
# #   return(news_df)
# # }
# # 
# # # Fetch the top 10 news articles from the "Latest" section of Yahoo Finance UK
# # latest_news_data <- get_latest_section_news()
# # 
# # # Save the news data to a CSV file
# # news_file <- paste0(data_dir, "/latest_section_news.csv")
# # write.csv(latest_news_data, file = news_file, row.names = FALSE)
# # 
# # # latest_news_data
# # write.csv(latest_news_data, file = "latest_news_data.csv", row.names = FALSE)
# # # Print message after successful completion
# # 
# # # Print the news data to the console for verification
# # print(latest_news_data)
# 
# # # Load necessary libraries
# # library(rvest)
# # library(httr)
# # library(dplyr)
# # 
# # # Get environment variables
# # data_dir <- Sys.getenv("DATA_DIR")
# # if (data_dir == "") {
# #   data_dir <- "data"
# # }
# # dir.create(data_dir, showWarnings = FALSE)
# # 
# # # Define the URL to scrape
# # url <- "https://uk.finance.yahoo.com/quote/%5EFTSE/latest-news/"
# # 
# # # Read the webpage with custom User-Agent
# # response <- tryCatch({
# #   GET(url, user_agent("Mozilla/5.0"))
# # }, error = function(e) {
# #   message("Error fetching URL: ", url)
# #   return(NULL)
# # })
# # 
# # # Parse the webpage content
# # webpage <- read_html(content(response, as = "text", encoding = "UTF-8"))
# # 
# # # Extract titles and links
# # titles <- webpage %>% html_nodes(".stream-items .story-item h3") %>% html_text(trim = TRUE)
# # links <- webpage %>% html_nodes(".stream-items .story-item a") %>% html_attr("href")
# # 
# # # Combine data
# # news_data <- data.frame(
# #   Headline = titles,
# #   Link = links,
# #   stringsAsFactors = FALSE
# # )
# # news_data <- news_data %>% 
# #   slice(1:10)
# #   
# # # Save data to CSV
# # write.csv(news_data, file = paste0(data_dir, "/news_data.csv"), row.names = FALSE)
# # write.csv(news_data, file = "news_data.csv", row.names = FALSE)
# # 
# # # Print the result
# # print(news_data)
# # Load necessary libraries
# library(rvest)
# library(httr)
# 
# # Get environment variables
# data_dir <- Sys.getenv("DATA_DIR")
# if (data_dir == "") {
#   data_dir <- "data"
# }
# dir.create(data_dir, showWarnings = FALSE)
# 
# # Define the URL to scrape
# url <- "<your_news_website_url_here>"
# 
# # Read the webpage with custom User-Agent
# response <- tryCatch({
#   GET(url, user_agent("Mozilla/5.0"))
# }, error = function(e) {
#   message("Error fetching URL: ", url)
#   return(NULL)
# })
# 
# # Parse the webpage content
# webpage <- read_html(content(response, as = "text", encoding = "UTF-8"))
# 
# # Extract titles and links, ensuring they are matched by selecting the same parent nodes
# news_items <- webpage %>% html_nodes(".stream-items .story-item")
# 
# # Extract titles and links within the same loop to ensure they are matched correctly
# titles <- news_items %>% html_nodes("h3") %>% html_text(trim = TRUE)
# links <- news_items %>% html_nodes("a") %>% html_attr("href")
# 
# # Combine data
# news_data <- data.frame(
#   Title = titles,
#   Link = links,
#   stringsAsFactors = FALSE
# )
# 
# # Save data to CSV
# write.csv(news_data, file = "news_data.csv", row.names = FALSE)
# 
# # Print the result
# print(news_data)

# Load necessary libraries
library(rvest)
library(httr)

# Define the URL
url <- "https://uk.finance.yahoo.com/quote/%5EFTSE/latest-news/"

# Make the GET request with a custom user-agent
page <- GET(url, user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"))

# Parse the HTML content
webpage <- read_html(page)

# Extract the articles based on 'li' nodes and ensure we're getting the news articles with titles
article_nodes <- webpage %>% html_nodes("li")

# Filter only the nodes that contain 'h3' tags, which represent news articles
articles <- article_nodes %>% html_nodes("h3")

# Extract titles from the filtered articles
titles <- articles %>% html_text(trim = TRUE)

# Extract the links from the parent 'a' tags that wrap the titles
links <- articles %>% html_nodes(xpath = "..") %>% html_attr("href")

# Make sure we only get the first 10 valid titles and links
titles <- titles[1:10]
links <- links[1:10]

# Ensure links are not NA and handle both absolute and relative links
full_links <- ifelse(grepl("^https", links), links, paste0("https://uk.finance.yahoo.com", links))

# Combine titles and valid links into a data frame
news_data <- data.frame(
  Headline = titles,
  Link = full_links,
  stringsAsFactors = FALSE
)

# Print the result
print(news_data)

# Optionally, write to a CSV file
write.csv(news_data, "FTSE_news.csv", row.names = FALSE)

