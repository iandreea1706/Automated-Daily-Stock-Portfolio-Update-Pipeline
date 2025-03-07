# Automated Daily Stock Portfolio Update Pipeline

## Author
Andreea Iordache

## Short Description
This project automates the daily update of a stock portfolio by fetching stock price data, retrieving related news articles, processing and storing the data in a structured format, and sending a summary report via email. The pipeline integrates API calls, web scraping, data processing, and database management to generate and deliver an informative daily update.

## Prerequisites and Dependencies

Ensure the following dependencies are installed before running the project:

### Required Software:
- R (Recommended version: 4.3.1 or later)
- Git Bash (for Windows users)

### Install Required R Packages:
Run the following command in R to install the necessary libraries:
```r
install.packages(c("httr", "jsonlite", "purrr", "dplyr", "rvest", "xml2", "DBI", "RSQLite", "gmailr"))
```

### API Key Setup:
- Obtain an API key from **polygon.io** for stock data retrieval.
- Store it securely in an environment variable:
  ```sh
  export POLYGON_API_KEY=your_api_key
  ```

## Installation and Setup Instructions

1. **Download the project files** and place them in a dedicated directory.
2. **Ensure all required dependencies are installed.**
3. **Configure API Keys**
   - Set up your **Polygon.io API key** as an environment variable.
   - Configure Gmail authentication for automated email delivery.

## Project Structure Overview

### **Scripts**

#### `api_stock.R`
- Fetches stock price data using the **polygon.io** API.
- Retrieves previous close data for a set of tickers and stores it in `stock_data.csv`.

#### `web_scraping.R`
- Scrapes the latest financial news headlines and links from Yahoo Finance.
- Saves the extracted headlines into `FTSE_news.csv`.

#### `data_processing.R`
- Cleans and processes the stock and news data.
- Computes daily percentage price changes for stocks.
- Formats a **daily portfolio update report**.
- Saves the final report to `portfolio_update.txt`.

#### `load_data.R`
- Loads the processed data into an SQLite database (`portfolio_updates.db`).
- Structures the database with separate tables for stock prices and news headlines.
- Exports the database content into an Excel file (`portfolio_database.xlsx`).

#### `send_email.R`
- Authenticates with Gmail.
- Sends an email containing the **daily portfolio update**.
- Automatically determines the recipient (self for testing or professor on submission day).

### **Additional Files**
- **`stock_data.csv`**: Stores the fetched stock prices.
- **`FTSE_news.csv`**: Contains scraped financial news headlines.
- **`portfolio_update.txt`**: The final report to be emailed.
- **`portfolio_updates.db`**: SQLite database storing stock and news data.
- **`portfolio_database.xlsx`**: Excel version of the database for easy access.

## Usage Instructions

### **Running the Full Pipeline**
Run the following command in Git Bash (or a terminal):
```sh
Rscript api_stock.R && Rscript web_scraping.R && Rscript data_processing.R && Rscript load_data.R && Rscript send_email.R
```
This will:
1. Fetch stock data
2. Scrape financial news
3. Process and format the data
4. Store the data in a database
5. Send the portfolio update email

### **Running Individual Scripts**
To run any specific script, use:
```sh
Rscript script_name.R
```
Example:
```sh
Rscript data_processing.R
```

## Output Description

- **Portfolio update email**: Sent daily with stock prices and news.
- **Stock Data (`stock_data.csv`)**: Contains daily stock prices including open, close, high, low, volume.
- **News Data (`FTSE_news.csv`)**: Contains top 10 finance-related headlines and links.
- **Portfolio Update (`portfolio_update.txt`)**: Summarizes stock performance and news.
- **Database (`portfolio_updates.db`)**: Stores all processed stock and news data.
- **Excel File (`portfolio_database.xlsx`)**: Stores structured portfolio data.

## Troubleshooting and FAQs

### **API Key Issues**
- If stock data retrieval fails, ensure your **Polygon.io API key** is valid.
- If using Gmail, ensure authentication is correctly configured in `send_email.R`.

### **Missing Dependencies**
- If an error states that a package is missing, install it using:
  ```r
  install.packages("package_name")
  ```

### **Email Not Sending**
- Ensure you have **enabled access to less secure apps** in Gmail.
- Verify Gmail API authentication.

### **Database Not Updating**
- Check if `stock_data.csv` and `FTSE_news.csv` exist before running `load_data.R`.
- Ensure R has permission to write to the directory.

## Additional Notes
- The pipeline is **fully automated** and can be scheduled as a **cron job** for daily execution.
- The **portfolio update email** is automatically sent to the specified recipient.
- SQLite database allows for efficient long-term storage of stock price and news data.

---
### **Future Improvements**
- Implement **real-time stock tracking**.
- Extend to **multiple market indices** (e.g., S&P 500, NASDAQ).
- Improve **sentiment analysis** for news impact prediction.

This project ensures a **seamless, daily stock portfolio update** with **automated processing, structured storage, and email reporting**.

