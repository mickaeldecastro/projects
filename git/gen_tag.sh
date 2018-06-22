#!/bin/bash

TYPE=$1

#get last tag 
VERISON=$(git log --tags --no-walk --pretty=format:%d | sed 1q | sed -n "s:.*tag\: \(.*\), tag.*:\1:ip")

if [ -z "$VERSION" ]; then
   VERSION=`git describe --tags $(git rev-list --tags --max-count=1)`
fi

#Convert to array
VERSION_BITS=(${VERSION//./ })

#Get numbers from array 
VNUM1=${VERSION_BITS[0]}
VNUM1=$(echo $VNUM1 | sed 's/[^0-9]*//g')
VNUM2=${VERSION_BITS[1]}
VNUM3=${VERSION_BITS[2]}

#Check tag type
if [ "$TYPE" == "major" ]; then
    VNUM1=$((VNUM1+1))
    VNUM2=0
    VNUM3=0
fi
if [ "$TYPE" == "minor" ]; then
    VNUM2=$((VNUM2+1))
    VNUM3=0
fi
if [ "$TYPE" == "patch" ]; then
    VNUM3=$((VNUM3+1))
fi

#Create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"

echo "$NEW_TAG"

