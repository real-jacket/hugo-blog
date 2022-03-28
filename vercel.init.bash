git clone https://github.com/Lruihao/FixIt.git FixIt
rm -rf FixIt/exampleSite
git clone https://github.com/real-jacket/hugo-blog.git FixIt/exampleSite
rm -rf FixIt/exampleSite/.git
rm -rf FixIt/.git
cp -rf .git FixIt/.git
cd FixIt
git checkout $VERCEL_GIT_COMMIT_SHA