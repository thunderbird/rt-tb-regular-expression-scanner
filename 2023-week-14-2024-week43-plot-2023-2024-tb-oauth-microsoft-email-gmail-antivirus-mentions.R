library(tidyverse)
tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions <-
  read_csv("2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.csv")
# Delete first and last row
tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions <- tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions[-1, ]
tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions <- tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions %>% 
  filter(row_number() <= n() -1)
tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions <- gather(
  tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions,
  key = "regex_mentions",
  value = "number_of_mentions",
  c(
    "gmail mentions" ,
    "ms email mentions" ,
    "OAuth mentions",
    "antivirus mentions"
  )
)
p <- ggplot(data = tb_2023_2024_oauth_microsoft_email_gmail_antivirus_mentions, 
            aes(x = iso_week, y = number_of_mentions)) + geom_point()
p + facet_wrap(~regex_mentions)