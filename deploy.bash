# 这个存在的目的是由于，github action 或者 vecel 的远程打包与本地不符，故采用本地打包的方式上传代码

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
rm -rf public