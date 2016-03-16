#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Remove the public folder to make room for the gh-pages subtree
rm -rf public/*

# Build the project.
#hugo

# Redirect to http://odvinc.ru
mkdir public
echo blog.odvinc.ru > public/CNAME 
cat > public/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="0; url=http://odvinc.ru/">
</head>
<body>
</body>
</html>
EOF

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
git subtree push --prefix=public git@github.com:odvinc/blog.odvinc.ru.git gh-pages