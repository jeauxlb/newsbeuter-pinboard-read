#!/bin/bash

# We have a few things to do:
# 1. Check to see if the URL exists on pinboard
# 2. If it does, then we need to get its current read status, and toggle it

username="$PINBOARD_USER"
token="$PINBOARD_KEY"

input=`cat`

url=$(echo "$input" | /usr/local/bin/grep '^Link:.*' | sed 's/^Link: \(.*\)/\1/g')
title=$(echo "$input" | /usr/local/bin/grep '^Title:' | sed 's/^Title:\( \[priv\]\)\{0,\} //g')

if [ "$url" != "" -a "$title" != "" ]; then
	# Check that URL exists in pinboard already
	exists=`curl -G "https://api.pinboard.in/v1/posts/get" --data-urlencode "auth_token=${username}:${token}" --data-urlencode "url=${url}" --data-urlencode "description=${title}" --data-urlencode "toread=no" --data-urlencode "replace=yes" --data-urlencode "format=json" 2>/dev/null`
	check_exists=$(echo "$exists" | jq -r '.posts[0].toread')

	if [ "$check_exists" != "null" ]; then
		# Invert the 'toread' flag
		#toread=$([ "$check_exists" == "no" ] && echo "yes" || echo "no")

		# We always want to set this to no (if you want to toggle instead, comment the line below and uncomment the line above)
		toread="no"

		# Get the correct date
		date=$(echo "$exists" | jq -r '.posts[0].time')

		output=`curl -G "https://api.pinboard.in/v1/posts/add" --data-urlencode "auth_token=${username}:${token}" --data-urlencode "url=${url}" --data-urlencode "description=${title}" --data-urlencode "toread=${toread}" --data-urlencode "replace=yes" --data-urlencode "datetime=${date}" 2>/dev/null`

		output=`echo $output | sed 's/^.*code="\([^"]*\)".*$/\1/'`

		if [ "$output" != "done" ] ; then
		  echo "$output"
		fi
	fi
fi
