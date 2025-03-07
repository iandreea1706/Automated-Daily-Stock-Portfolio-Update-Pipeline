# Load necessary libraries
library(DBI)
library(RSQLite)
library(openxlsx)
library(dplyr)

# Set environment variables
data_dir <- Sys.getenv("DATA_DIR")
db_name <- Sys.getenv("DB_NAME")

# Creates the database name if it doesn't already exist
if (db_name == "") {
  db_name <- "portfolio_updates.db"
}

# Creates a data directory if it doesn't already exist
if (data_dir == "") {
  data_dir <- "data"
}

# Connect to SQLite database
con <- dbConnect(SQLite(), dbname = file.path(data_dir, db_name))

# 1. Create stocks table with the columns that are also present in the dataframe obtained from api_stock
dbExecute(con, "
CREATE TABLE IF NOT EXISTS stocks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ticker TEXT NOT NULL,
    date TEXT NOT NULL,
    open REAL NOT NULL,
    close REAL NOT NULL,
    high REAL NOT NULL,
    low REAL NOT NULL,
    volume INTEGER NOT NULL,
    vw REAL NOT NULL
);
")

# Read stock data 
stock_data <- read.csv("stock_data.csv", stringsAsFactors = FALSE)

# Remove duplicate rows for each ticker
stock_data_unique <- stock_data %>%
  distinct(ticker, date, .keep_all = TRUE)

# Insert stock data into the stocks table
stock_insert_query <- "
INSERT INTO stocks (ticker, date, open, close, high, low, volume, vw)
VALUES (:ticker, :date, :open, :close, :high, :low, :volume, :vw)
"

#  Prepares an SQL statement for execution without immediately executing it -> parameterised queries
stmt <- dbSendStatement(con, stock_insert_query)

# Inserts the actual values into the table

for (i in seq_len(nrow(stock_data_unique))) {
  dbBind(stmt, param = list(
    ticker = stock_data_unique$ticker[i],
    date = stock_data_unique$date[i],
    open = stock_data_unique$open[i],
    close = stock_data_unique$close[i],
    high = stock_data_unique$high[i],
    low = stock_data_unique$low[i],
    volume = stock_data_unique$volume[i],
    vw = stock_data_unique$vw[i]
  ))
}

# Frees up resources
dbClearResult(stmt)


# 2. Create news headlines table
dbExecute(con, "
CREATE TABLE IF NOT EXISTS headlines (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    headline TEXT NOT NULL,
    link TEXT NOT NULL
);
")

# Read headlines data 
headlines_data <- read.csv("ftse_news.csv", stringsAsFactors = FALSE)


# Remove duplicate rows
headlines_data_unique <- headlines_data %>%
  distinct(Headline, .keep_all = TRUE)

# Insert headlines data into the headlines table
headline_insert_query <- "
INSERT INTO headlines (headline, link)
VALUES (:headline, :link)
"

#  Prepares an SQL statement for execution without immediately executing it -> parameterised queries

stmt <- dbSendStatement(con, headline_insert_query)

# Inserts the actual values into the table

for (i in seq_len(nrow(headlines_data_unique))) {
  dbBind(stmt, param = list(
    headline = headlines_data_unique$Headline[i],
    link = headlines_data_unique$Link[i]
  ))
}

#  Frees up space

dbClearResult(stmt)


# List all tables in the database
tables <- dbListTables(con)
tables <- tables[tables != "sqlite_sequence"]  # Exclude sqlite_sequence table
tables

# Create a new Excel workbook
wb <- createWorkbook()

# Loop through each table to get its data and add to the Excel workbook
for (table in tables) {
  # Fetch the entire table
  table_data <- dbReadTable(con, table)
  
  # Add a sheet with the table name
  addWorksheet(wb, table)
  
  # Write the data to the sheet
  writeData(wb, table, table_data)
  
  # get table schema
  table_info <- dbGetQuery(con, paste0("PRAGMA table_info(", table, ");"))

  # Add primary key information
  table_info$is_primary_key <- ifelse(table_info$pk == 1, "Yes", "No")

   # Combine with table name
   table_info <- data.frame(
     table_name = table,
    column_name = table_info$name,
    column_type = table_info$type,
    is_primary_key = table_info$is_primary_key,
    stringsAsFactors = FALSE
    )

   # Append to the metadata data frame
  metadata <- rbind(metadata, table_info)
}
  # Create the output CSV file name in the data directory
csv_file <- file.path(data_dir, "database_metadata.csv")

  # Write the metadata to a single CSV file
write.csv(metadata, file = csv_file, row.names = FALSE)


# Save the excel workbook
saveWorkbook(wb, "portfolio_database.xlsx", overwrite = TRUE)

# Commit and disconnect from the database
dbDisconnect(con)

# Output message
cat("Data successfully loaded into the database and Excel: ", db_name, "\n")

