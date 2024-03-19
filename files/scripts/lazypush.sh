#!/usr/bin/env bash

git add .

commit_message = "[LAZY] Updated: "

modified_files=$(git diff --cached --name-only)

for file in $modified_files; do
  filename=$(basename "$file")
  commit_message += "$filename, "
done

git commit -m "$commit_message"

git push