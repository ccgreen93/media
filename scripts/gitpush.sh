# Browse to git directory
script_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
parent_dir="$(dirname "$script_path")"
cd "${parent_dir}"

# Add all files to the repository
git add .

# Commit changes with current date time stamp
git commit -m "config files on $(date +'%d-%m-%Y %H:%M:%S')"

# Push changes to GitHub
git push -u origin HEAD
