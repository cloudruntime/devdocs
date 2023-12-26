#!/bin/bash
workPath=$(dirname $0)
cd $workPath
echo "work path is $workPath"
workPath=$(pwd)
echo "change work path to abstract $workPath"
echo "cd $workPath"
cd $workPath

# update to latest code
git pull
echo "Update by git pull"

echo "Start to build $targetProject ..."
rm -rf public
env HUGO_ENV="production" hugo121 --baseURL="https://cloudruntime.net/devdocs/"
if [ $? -ne 0 ]; then
    echo "Fail to build html content by hugo, exit"
    exit 1
fi
echo "Success to build cloudruntime develop documentation"

publishPath="/var/www/cloudruntime/devdocs/"
echo "Start to publish cloudruntime site ..."
mkdir -p $publishPath
cd $publishPath
rm -rf $publishPath/*
if [ $? -ne 0 ]; then
    echo "Fail to remove files in $publishPath, exit"
    exit 1
fi

cd $workPath
cd public
cp -r * $publishPath
if [ $? -ne 0 ]; then
    echo "Fail to copy files to $publishPath, exit"
    exit 1
fi
echo "Suceess to publish cloudruntime develop documentation to $publishPath"
echo "Done"