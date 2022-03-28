git clone https://github.com/Lruihao/FixIt.git FixIt
rm -rf FixIt/.git
rm -rf FixIt/exampleSite
git clone https://github.com/real-jacket/hugo-blog.git FixIt/exampleSite
rm -rf FixIt/exampleSite/.git
cp -rf .git FixIt/exampleSite/.git
cd FixIt
git checkout $VERCEL_GIT_COMMIT_SHA