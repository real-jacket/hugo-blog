rm -rf public
git clone https://github.com/real-jacket/real-jacket.github.io.git public
hugo --minify
cd ./public
if [ -n "$(git status -s)" ];then
    git config --local user.email "action@github.com"
    git config --local user.name "GitHub Action"
    git add .
    msg="rebuilding site $(date)"
    if [ -n "$*" ]; then
    msg="$*"
    fi
    git commit -m "$msg"
    git push 
fi