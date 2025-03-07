library(gmailr)
library(magrittr) 

# I saved the credientials obtained from OAuth (Google) in the credidentials.json file
#gm_auth_configure(path = "credidentials.json")

# I ran these 2 lines the first time, so I could authentificate with Google
#gm_auth(email = "iandreea1706@gmail.com", cache = "my_oauth_token_file")
#gm_auth(token = "d813835eec7d12f99e9e4948de6da6ad_iandreea1706@gmail.com")


gm_auth_configure(path = "C:/Users/iandr/OneDrive/Desktop/LBS/Data Management/assignment2/credidentials.json")

# Authenticate non-interactively using the saved token
gm_auth(email = "iandreea1706@gmail.com", token = "my_oauth_token_file")

# The date for when the email is suppossed to send to the professor
deadline_time <- as.POSIXct("2024-10-22 06:00:00")

# Read the portfolio update from the text file
portfolio_update <- readLines("portfolio_update.txt")


current_time <- Sys.time()

recipient <- if (format(current_time, "%Y-%m-%d %H:%M:%S") == format(deadline_time, "%Y-%m-%d %H:%M:%S")) {
  "utilizator.anonim@gmail.com"  # Send to professor on the deadline
} else {
  "iandreea1706@gmail.com"  # Send to my personal email for daily updates
}


# Define the email details: recipient, sender, subject and email body
email <- gm_mime() %>%
  gm_to(recipient) %>%
  gm_from("iandreea1706@gmail.com") %>%
  gm_subject(paste("4246101, assignment 2")) %>%
  gm_text_body(paste(portfolio_update, collapse = "\n"))

# Send the email
gm_send_message(email)

# Print confirmation
cat("Portfolio update email sent successfully!")

