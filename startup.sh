#!/usr/bin/env bash
#
# David Archuleta
# Copyright (C) 2014 <davearch.email.arizona.edu>

##### Constants #####
SITENAME=""
COMNAME='/\* Copyright 2014 David Archuleta \*/'
#####################

##### Functions #####

assertUsableName () {
    if [[ -z "$SITENAME" ]]; then
        echo -e 'must enter a name to continue\n'
        echo -e 'ERROR exit 1'
        exit 1; 
    fi
    if [[ "$SITENAME" =~ '[\. ]' ]]; then
        echo 'enter a name with no spaces'
        exit 1
    fi
}

scriptsDir () {
    if [[ $(pwd) = "$HOME/Documents/Webpages/$SITENAME" ]]; then 
        mkdir scripts
        cd ./scripts
        echo -e $COMNAME >> $SITENAME.js 
        curl -L -O http://code.jquery.com/jquery-latest.min.js
        echo -e '\n'
    else 
        cd $HOME/Documents/Webpages/$SITENAME
        scriptsDir
    fi
}

cssDir () {
    if [[ $(pwd) = "$HOME/Documents/Webpages/$SITENAME" ]]; then
        mkdir css
        cd ./css
        echo -e $COMNAME >> $SITENAME.css
        curl -L -O http://meyerweb.com/eric/tools/css/reset/reset.css
        echo -e '\n'
        curl -L -O https://raw.github.com/andytlr/cssgrid/version2/css/1140.css
        echo -e '\n'
        curl -L -O https://raw.github.com/andytlr/cssgrid/version2/css/ie.css
        echo -e '\n'
     else
        cd $HOME/Documents/Webpages/$SITENAME
        cssDir
    fi
}

makeIndex () {
    if [[ $(pwd) = "$HOME/Documents/Webpages/$SITENAME" ]]; then
       echo -e '<!DOCTYPE html>' >> index.html
       echo -e '<!-- Copyright David Archuleta 2014 -->' >> index.html
    else
       cd $HOME/Documents/Webpages/$SITENAME
       makeIndex
    fi
}
makeImagesDir () {
        if [[ $(pwd) = "$HOME/Documents/Webpages/$SITENAME" ]]; then
            mkdir images
        else
            cd $HOME/Documents/Webpages/$SITENAME
            makeImagesDir
        fi
}
##### END OF FUNCTIONS

##### START MAIN #####

echo -e "The new directory will be installed under ~/Documents/Webpages/\n"
echo -n "Enter name: "
read SITENAME

assertUsableName 
   
echo -e "Creating Directory.."
mkdir $HOME/Documents/Webpages/$SITENAME
cd $HOME/Documents/Webpages/$SITENAME

echo -e "Creating Scripts Directory..."
echo -e "Installing jQuery and creating overwrite script..."
scriptsDir
cd $HOME/Documents/Webpages/$SITENAME 

echo -e "Creating css Directory..."
echo -e "Installing stylesheets to get started..."
cssDir
cd $HOME/Documents/Webpages/$SITENAME

echo -e "Creating images Directory..."
makeImagesDir
cd $HOME/Documents/Webpages/$SITENAME
echo -e "Creating index.html file..."
makeIndex
echo -e "Done!"
