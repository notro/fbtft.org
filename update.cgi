#!/bin/bash

HOME=$(readlink -f ../..)

source "$HOME/.rvm/scripts/rvm"

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>build</title>'
echo '</head>'
echo '<body>'
echo '<pre>'
echo Date: $(date)
echo Trigger: $QUERY_STRING
echo

cd $HOME/fbtft.org/
$DOCUMENT_ROOT/../fbtft.org/build $QUERY_STRING

echo '</pre>'
echo '</body>'
echo '</html>'

exit 0
