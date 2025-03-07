#!/bin/bash

# Set environment variables
export ASSIGNMENT_DIR="C:/Users/iandr/OneDrive/Desktop/LBS/Data Management/assignment2"
export LOG_FILE="$ASSIGNMENT_DIR/etl_pipeline.log"
export DB_NAME="$ASSIGNMENT_DIR/portfolio_updates.db"


# Create data directory if it doesn't exist

# Create an empty log file if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
  touch "$LOG_FILE"
  echo "Log file created: $LOG_FILE"
fi

# Run R scripts in the correct order and log outputs

C:/PROGRA~1/R/R-43~1.1/bin/x64/Rscript api_stock.R >> "$LOG_FILE" 2>&1
C:/PROGRA~1/R/R-43~1.1/bin/x64/Rscript web_scraping.R >> "$LOG_FILE" 2>&1
C:/PROGRA~1/R/R-43~1.1/bin/x64/Rscript data_processing.R >> "$LOG_FILE" 2>&1
C:/PROGRA~1/R/R-43~1.1/bin/x64/Rscript load_data.R >> "$LOG_FILE" 2>&1
C:/PROGRA~1/R/R-43~1.1/bin/x64/Rscript send_email.R >> "$LOG_FILE" 2>&1

# Print completion message
echo "ETL pipeline completed successfully at $(date)" >> "$LOG_FILE"
