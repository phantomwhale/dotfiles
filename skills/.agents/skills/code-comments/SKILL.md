---
name: code-comments
description: >-
  How to write comment in code. Use when writing code and adding
  comments to describe what the code does
license: MIT
context: fork
metadata:
  author: BenTurner
  version: "1.0"
---

# Code Comments

When you are adding code comments to help describe code, make sure to:

* Never refer to a linear ticket or anything outside the code itself. Linear tickets can get linked in commit messages or PR descriptions, but code comments should focus on the current state of the code, to help the developer understand any subtle complexity for the code below it and/or to point towards other methods or objects this code interacts with in a noteworthy fashion
* Try to keep comments tight and focused; extra context can go into commit messages, these should just highlight when the code below has something particularly strange or important that is worth distracting the reader from the code itself
* When modifying any code, check the comments around the code and above the method and/or class being modified, in case the changes require an update to the comments

Never be reluctant to skip adding a comment if there isn't a special reason to do so.
