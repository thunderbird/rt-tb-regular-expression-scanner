# rt-tb-regular-expression-scanner
Experimental Thunderbird Support regular expression scanner
## 1. 2024-11-02 Get the daily question and answer files
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
   then put -f make-question-link.mlr \
   then put '$iso_week = strftime($created_epoch, "%V")' \
   then  put '$yyyy_mm_dd = strftime($created_epoch, "%Y-%m-%d")' \
   then sort -f id \
   2023-2024-yearly-thunderbird-questions.csv \
   > link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv
   ```
## 2. 2024-11-02 Add: oauth, hotmail/office365/o365, gmail/googlemail etc synthetic boolean columns
```bash
./scan-tb-question-answer-file.rb \
link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
2023-2024-yearly-thunderbird-answers.csv
```
## 3. 2024-11-02 BUG! The iso_weeks don't have the year! So iso_week is wrong! and the output below is wrong
```bash
mlr --csv --from regex-matches-link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
filter '${oa:oauth} == "1"' \
then cut -f link,iso_week,yyyy_mm_dd \
then sort -f iso_week \
then count-distinct -f iso_week
```
## 4. 2024-11-02 Fix bug in iso_week
```bash
mlr --csv put '$created_epoch = strptime($created, "%Y-%m-%d %H:%M:%S %z")' \
then put -f make-question-link.mlr \
then put '$iso_week = strftime($created_epoch, "%Y-%V")' \
then  put '$yyyy_mm_dd = strftime($created_epoch, "%Y-%m-%d")' \
then sort -f id \
2023-2024-yearly-thunderbird-questions.csv \
> link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv
```

## 5.  2024-11-02 With iso_week in the form yyyy-iso_week Add: oauth, hotmail/office365/o365, gmail/googlemail etc synthetic boolean columns
```bash
./scan-tb-question-answer-file.rb \
link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
2023-2024-yearly-thunderbird-answers.csv
```
