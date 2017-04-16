# newsbeuter-pinboard-read

## Description

This bash script was designed for the RSS reader [newsbeuter](http://newsbeuter.org) to be able to update 'unread' bookmarks kept on [Pinboard](https://pinboard.in).

## Installing

Prerequisites:
1. jq
2. Your pinboard 'unread items' feed in newsbeuter. The URL should look like https://feeds.pinboard.in/rss/secret:11223344/u:username/toread/?count=100 where the values after `secret:` and `u:` are replaced as appropriate. See the small 'RSS' link on your pinboard user page, on the top right of the list of links.

To setup, you will need to define the variables `PINBOARD_USER` and `PINBOARD_KEY` in your ~/.profile or similar, and export them for other applications to use. For example:
```
export PINBOARD_USER='username'
export PINBOARD_KEY='1122334455'
```

Then, in ~/.config/newsbeuter/config, add:
```
macro SPACE pipe-to "~/bin/toggle_pinboard_read.sh"; toggle-article-read "read"
```

## Usage
To use, select an item from your pinboard unread items RSS feed, and press `,` to activate macro mode in newsbeuter, then `SPACEBAR` to activate the macro.

Your item should be marked as read on pinboard, and in newsbeuter.
