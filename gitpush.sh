# Browse to git directory
cd /mnt/media

# Add all files to the repository
git add .

# Commit changes with current date time stamp
git commit -m "config files on $(date +'%d-%m-%Y %H:%M:%S')"

# Push changes to GitHub
git push -u origin HEAD
