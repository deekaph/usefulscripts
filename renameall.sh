# A bash script for renaming every file in CWD to be another extension
# 
# Useful for example if you have a cache directory where everything's named something it's not, such as .0 instead of .mp4
# 
# Use "file" util to determine filetype.

#!/bin/bash

# Prompt for the origin extension
read -p "Enter the origin extension (e.g., .0): " origin_ext
# Validate the input for the origin extension
if [[ -z "$origin_ext" ]]; then
    echo "Error: Origin extension cannot be empty."
    exit 1
fi

# Prompt for the target extension
read -p "Enter the target extension (e.g., .mp4): " target_ext
# Validate the input for the target extension
if [[ -z "$target_ext" ]]; then
    echo "Error: Target extension cannot be empty."
    exit 1
fi

# Directory to process (default is the current directory)
DIRECTORY="${1:-.}"

# Check if the directory exists
if [[ ! -d "$DIRECTORY" ]]; then
    echo "Error: Directory '$DIRECTORY' does not exist."
    exit 1
fi

# Loop through all files with the origin extension in the directory
for file in "$DIRECTORY"/*"$origin_ext"; do
    # Skip if no files with the origin extension are found
    [[ -e "$file" ]] || continue

    # Get the new filename by replacing the origin extension with the target extension
    new_file="${file%$origin_ext}$target_ext"

    # Rename the file
    mv "$file" "$new_file"

    # Check if the rename was successful
    if [[ $? -eq 0 ]]; then
        echo "Renamed: '$file' -> '$new_file'"
    else
        echo "Error renaming '$file'."
    fi
done

echo "Renaming process completed."
