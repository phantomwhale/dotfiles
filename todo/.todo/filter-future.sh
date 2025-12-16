#!/bin/bash
# Filter out lines with t:YYYY-MM-DD where the date is in the future
# Bypass with: TODOTXT_SHOW_FUTURE=1

if [[ "$TODOTXT_SHOW_FUTURE" == "1" ]]; then
    cat
    exit 0
fi

today=$(date +%Y-%m-%d)
while IFS= read -r line; do
    if [[ $line =~ t:([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
        threshold_date="${BASH_REMATCH[1]}"
        # Only print if date is NOT in the future (today or earlier)
        if [[ "$threshold_date" < "$today" || "$threshold_date" == "$today" ]]; then
            echo "$line"
        fi
    else
        # No t:DATE pattern, print the line
        echo "$line"
    fi
done
