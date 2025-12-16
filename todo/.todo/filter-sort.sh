#!/bin/bash
# Custom sort/filter for todo.txt (runs before colorization)
# 1. Always strip creation dates after priority (e.g., "03 (B) 2024-01-15 Task" -> "03 (B) Task")
# 2. Filter out lines with future t:YYYY-MM-DD threshold dates (bypass with TODOTXT_SHOW_FUTURE=1)

today=$(date +%Y-%m-%d)

while IFS= read -r line; do
    # Strip creation date: "NN (X) YYYY-MM-DD " or "NN YYYY-MM-DD "
    line=$(echo "$line" | sed -E 's/^([0-9]+ )(\([A-Z]\) )?[0-9]{4}-[0-9]{2}-[0-9]{2} /\1\2/')

    # Filter future threshold dates unless TODOTXT_SHOW_FUTURE=1
    if [[ "$TODOTXT_SHOW_FUTURE" != "1" ]] && [[ $line =~ t:([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
        threshold_date="${BASH_REMATCH[1]}"
        # Only print if date is NOT in the future (today or earlier)
        if [[ "$threshold_date" < "$today" || "$threshold_date" == "$today" ]]; then
            echo "$line"
        fi
    else
        echo "$line"
    fi
done | env LC_COLLATE=C sort -f -k2
