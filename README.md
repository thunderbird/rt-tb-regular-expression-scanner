# rt-tb-regular-expression-scanner
Experimental Thunderbird Support regular expression scanner
## 2024-11-02 Get the daily question and answer files
1. git pull of latest questions and answers: `pushd /Users/roland/Documents/GIT/github-action-thunderbird-aaq ; git pull; popd`
2. create 2023 and 2024 answer CSV:
   ```bash
   mlr --csv sort -f id /Users/roland/Documents/GIT/github-action-thunderbird-aaq/202*/*thunderbird-answers-for-questions-desktop.csv \
   > 2023-2024-yearly-thunderbird-answers.csv
   ```
1. create 2023 and 2024 question CSV:
   ```bash
   mlr --csv sort -f id /Users/roland/Documents/GIT/github-action-thunderbird-aaq/202*/*thunderbird-creator-answers-desktop-all-locales.csv \
   > 2023-2024-yearly-thunderbird-questions.csv
   ```
1. add yyyy_mm_dd, iso_week and link field to question CSV
   ```bash
   mlr --csv put '$created_epoch = strptime($created, "%Y-%m-%d %H:%M:%S %z")' \
   then put -f ../make-question-link.mlr \
   then put '$iso_week = strftime($created_epoch, "%V")' \
   then  put '$yyyy_mm_dd = strftime($created_epoch, "%Y-%m-%d")' \
   2023-2024-yearly-thunderbird-questions.csv \
   then sort -f id \
   > link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv
   ```
