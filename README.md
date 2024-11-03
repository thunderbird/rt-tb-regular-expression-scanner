# rt-tb-regular-expression-scanner
Experimental Thunderbird Support regular expression scanner
## 2024-11-02 Get the daily question and answer files
1. git pull of latest questions and answers: `pushd /Users/roland/Documents/GIT/github-action-thunderbird-aaq ; git pull; popd`
2. create 2023 and 2024 answer file:
   ```bash
   mlr --csv sort -f id /Users/roland/Documents/GIT/github-action-thunderbird-aaq/202*/*thunderbird-answers-for-questions-desktop.csv \
   > 2023-2024-yearly-thunderbird-answers.csv
   ```
