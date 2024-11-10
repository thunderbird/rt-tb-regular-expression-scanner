# rt-tb-regular-expression-scanner
Experimental Thunderbird Support regular expression scanner
## 1. 2024-11-09 Add Windows version e.g. q['windows'] = 7 or q['windows'] = 10
```bash
./scan-tb-question-answer-file.rb \
link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
2023-2024-yearly-thunderbird-answers.csv
```
## 7. 2024-11-03 Plot 2024 Week 24 to 2024 Week 43
* 2024-week-24-2024-week43-plot-2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.R and PLOTS/2024-week-24-2024-week43-plot-2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.png
## 6. 2024-11-03 Plot 2024 Week 1 to 2024 Week 43
* 2024-week-1-2024-week43-plot-2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.R and PLOTS/2024-week-1-2024-week43-plot-2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.png
## 5. 2024-11-03 Plot 2023 Week 14 to 2024 Week 43
* 2023-week-14-2024-week43-plot-2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.R and PLOTS/2023-week-14-2024-week43-plot-2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.png
## 4. 2024-11-03 concat all the files with regex mentions: anti-virus, microsoft email, gmail, oauth
```bash
mlr --csv join -f 2023-2024-thunderbird-oauth-mentions.csv -j iso_week \
then join -f 2023-2024-thunderbird-microsoft-email-mentions.csv -j iso_week \
then join -f 2023-2024-thunderbird-gmail-email-mentions.csv -j iso_week \
2023-2024-thunderbird-antivirus-mentions.csv \
> 2023-2024-tb-oauth-microsoft-email-gmail-antivirus-mentions.csv
```
## 3. 2024-11-03 add anti-virus
```bash
mlr --csv --from regex-matches-link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
filter '${av:unknown} == "0"' \
then cut -f link,iso_week,yyyy_mm_dd \
then sort -f iso_week \
then count -g iso_week -o "antivirus mentions" > 2023-2024-thunderbird-antivirus-mentions.csv
```
## 2. 2024-11-03 add microsoft email and gmail 

**microsoft email:**

```bash
mlr --csv --from regex-matches-link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
filter '${m:microsoftemail} == "1"' \
then cut -f link,iso_week,yyyy_mm_dd \
then sort -f iso_week \
then count -g iso_week -o "ms email mentions" > 2023-2024-thunderbird-microsoft-email-mentions.csv
```

**gmail email:**
```bash
mlr --csv --from regex-matches-link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
filter '${m:gmail} == "1"' \
then cut -f link,iso_week,yyyy_mm_dd \
then sort -f iso_week \
then count -g iso_week -o "gmail mentions" > 2023-2024-thunderbird-gmail-email-mentions.csv
```

## 1. 2024-11-03 Rename the count field to "OAuth mentions"

```bash
mlr --csv --from regex-matches-link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
filter '${oa:oauth} == "1"' \
then cut -f link,iso_week,yyyy_mm_dd \
then sort -f iso_week \
then count -g iso_week -o "OAuth mentions" \
> 2023-2024-thunderbird-oauth-mentions.csv
```

<details markdown="1">
<summary markdown="span">output:</summary>

```   
iso_week,OAuth mentions
2023-13,1
2023-14,1
2023-15,3
2023-16,8
2023-17,3
2023-18,2
2023-19,5
2023-20,5
2023-21,9
2023-22,7
2023-23,12
2023-24,9
2023-25,2
2023-26,8
2023-27,6
2023-28,8
2023-29,19
2023-30,7
2023-31,2
2023-32,10
2023-33,3
2023-34,4
2023-35,4
2023-36,5
2023-37,12
2023-38,2
2023-39,7
2023-40,17
2023-41,7
2023-42,7
2023-43,7
2023-44,5
2023-45,4
2023-46,6
2023-47,6
2023-48,8
2023-49,4
2023-50,6
2023-51,1
2023-52,4
2024-01,4
2024-02,1
2024-03,6
2024-04,9
2024-05,6
2024-06,7
2024-07,6
2024-08,4
2024-09,6
2024-10,3
2024-11,6
2024-12,2
2024-13,1
2024-14,3
2024-15,5
2024-16,12
2024-17,6
2024-18,4
2024-19,3
2024-20,7
2024-21,3
2024-22,9
2024-23,7
2024-24,8
2024-25,12
2024-26,13
2024-27,18
2024-28,11
2024-29,21
2024-30,19
2024-31,11
2024-32,18
2024-33,9
2024-34,16
2024-35,4
2024-36,5
2024-37,25
2024-38,21
2024-39,24
2024-40,27
2024-41,11
2024-42,14
2024-43,8
2024-44,6
```
</details>

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

output:

```
iso_week,OAuth mentions
2023-13,1
2023-14,1
2023-15,3
2023-16,8
2023-17,3
2023-18,2
2023-19,5
2023-20,5
2023-21,9
2023-22,7
2023-23,12
2023-24,9
2023-25,2
2023-26,8
2023-27,6
2023-28,8
2023-29,19
2023-30,7
2023-31,2
2023-32,10
2023-33,3
2023-34,4
2023-35,4
2023-36,5
2023-37,12
2023-38,2
2023-39,7
2023-40,17
2023-41,7
2023-42,7
2023-43,7
2023-44,5
2023-45,4
2023-46,6
2023-47,6
2023-48,8
2023-49,4
2023-50,6
2023-51,1
2023-52,4
2024-01,4
2024-02,1
2024-03,6
2024-04,9
2024-05,6
2024-06,7
2024-07,6
2024-08,4
2024-09,6
2024-10,3
2024-11,6
2024-12,2
2024-13,1
2024-14,3
2024-15,5
2024-16,12
2024-17,6
2024-18,4
2024-19,3
2024-20,7
2024-21,3
2024-22,9
2024-23,7
2024-24,8
2024-25,12
2024-26,13
2024-27,18
2024-28,11
2024-29,21
2024-30,19
2024-31,11
2024-32,18
2024-33,9
2024-34,16
2024-35,4
2024-36,5
2024-37,25
2024-38,21
2024-39,24
2024-40,27
2024-41,11
2024-42,14
2024-43,8
2024-44,6
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
## 6. 2024-11-02 OAuth complaints have  gone up since week 28
```bash
mlr --csv --from regex-matches-link_epoch_time_yyyy_mm_dd_iso_week_2023-2024-yearly-thunderbird-questions.csv \
filter '${oa:oauth} == "1"' \
then cut -f link,iso_week,yyyy_mm_dd \
then sort -f iso_week \
then count-distinct -f iso_week
```
<details markdown="1">
<summary markdown="span">output:</summary>
   
```
iso_week,count
2023-13,1
2023-14,1
2023-15,3
2023-16,8
2023-17,3
2023-18,2
2023-19,5
2023-20,5
2023-21,9
2023-22,7
2023-23,12
2023-24,9
2023-25,2
2023-26,8
2023-27,6
2023-28,8
2023-29,19
2023-30,7
2023-31,2
2023-32,10
2023-33,3
2023-34,4
2023-35,4
2023-36,5
2023-37,12
2023-38,2
2023-39,7
2023-40,17
2023-41,7
2023-42,7
2023-43,7
2023-44,5
2023-45,4
2023-46,6
2023-47,6
2023-48,8
2023-49,4
2023-50,6
2023-51,1
2023-52,4
2024-01,4
2024-02,1
2024-03,6
2024-04,9
2024-05,6
2024-06,7
2024-07,6
2024-08,4
2024-09,6
2024-10,3
2024-11,6
2024-12,2
2024-13,1
2024-14,3
2024-15,5
2024-16,12
2024-17,6
2024-18,4
2024-19,3
2024-20,7
2024-21,3
2024-22,9
2024-23,7
2024-24,8
2024-25,12
2024-26,13
2024-27,18
2024-28,11
2024-29,21
2024-30,19
2024-31,11
2024-32,18
2024-33,9
2024-34,16
2024-35,4
2024-36,5
2024-37,25
2024-38,21
2024-39,24
2024-40,27
2024-41,11
2024-42,14
2024-43,8
2024-44,6
```
</details>
