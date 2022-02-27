#!/bin/sh

name="dog-days"

mkdir tmp
cp -r ../* tmp 2>/dev/null
rm -rf tmp/distrib tmp/.git
cd tmp
zip -9 -r $name.love * >/dev/null
cd ..
mv tmp/$name.love .
rm -rf tmp
cat love.exe $name.love > $name.exe
