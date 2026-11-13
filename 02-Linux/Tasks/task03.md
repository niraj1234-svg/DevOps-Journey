# Task 03 – Log File Analysis with AWK, Grep & Sed

## Objective
Analyze Linux log files using grep, awk, and sed.

## 1. Download the Log File

    wget https://raw.githubusercontent.com/logpai/loghub/master/Linux/Linux_2k.log

Verify download:

    ls -lh Linux_2k.log
    head -5 Linux_2k.log

## 2. Search Errors Using GREP

Find all occurrences of the word "error":

    grep -in "error" Linux_2k.log

- grep: Searches for matching text.
- -i: Case-insensitive search.
- -n: Displays line numbers.

Count matching lines:

    grep -ic "error" Linux_2k.log

- -c: Displays the count of matching lines.

## 3. Extract Timestamps and Process Names Using AWK

Command:

    awk '{print $1, $2, $3, $5}' Linux_2k.log

Save extracted information:

    awk '{print $1, $2, $3, $5}' Linux_2k.log > extracted_logs.txt

Field explanation:

- $1: Month
- $2: Day
- $3: Time
- $5: Process/Service

Note: This Linux log file does not consistently contain a separate log-level field such as ERROR, INFO, or WARNING. Therefore, we extract the process/service name instead.

## 4. Redact IP Addresses Using SED

Command:

    sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/[REDACTED]/g' Linux_2k.log

Save sanitized logs into a separate file:

    sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/[REDACTED]/g' Linux_2k.log > sanitized_logs.log

### Command Breakdown

- sed: Stream editor used to modify text.
- -E: Enables extended regular expressions.
- s: Substitution operation.
- ([0-9]{1,3}\.){3}: Matches three groups of 1–3 digits followed by a dot.
- [0-9]{1,3}: Matches the final group of 1–3 digits.
- [REDACTED]: Replacement text.
- g: Replaces all matching occurrences in each line.

Example:

Before:
Connection from 192.168.1.100

After:
Connection from [REDACTED]

Note: This pattern matches IPv4-looking strings but does not validate whether each IP address is actually valid.

### What Happens Without g?

Without g, sed replaces only the first matching IP address in each line.

## 5. Bonus – Find the 10 Most Frequent Log Entries

Command:

    sort Linux_2k.log | uniq -c | sort -nr | head -10

Command explanation:

- sort: Sorts lines so duplicate entries become adjacent.
- uniq -c: Counts repeated lines.
- sort -nr: Sorts counts in descending numerical order.
- head -10: Displays the top 10 entries.

## 6. Important Commands Summary

| Command | Purpose |
|---|---|
| grep | Search text |
| awk | Extract and process fields |
| sed | Modify or replace text |
| sort | Sort lines |
| uniq -c | Count duplicate lines |
| head | Display first lines |
| > | Save output to a file |

## 7. Completion Checklist

- [ ] Downloaded Linux_2k.log
- [ ] Searched for errors using grep
- [ ] Extracted timestamps and process names using awk
- [ ] Redacted IP addresses using sed
- [ ] Saved sanitized logs into a separate file
- [ ] Found the 10 most frequent log entries
- [ ] Verified command outputs

## 8. Key Learning

- GREP is used to search.
- AWK is used to extract and process structured text.
- SED is used to modify text.
- SORT and UNIQ help analyze repeated log entries.
