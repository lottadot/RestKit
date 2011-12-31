#
# Build the doxygen documentation for the project and place into Docs/html
#
# Created by Shane Zatezalo ( @lottadot ) Based on:
#  https://github.com/j4n0/jobsket/blob/master/doxygen.sh
# and used information from:
#  http://stackoverflow.com/questions/2424362/create-class-diagram-from-already-existent-iphone-code
#
# Install:
# brew install doxygen
# brew install Graphviz
# (this failed for me, had to use http://www.graphviz.org/pub/graphviz/stable/macos/lion/graphviz-2.28.0.pkg )
#
# URL's:
# http://www.graphviz.org/
# http://www.stack.nl/~dimitri/doxygen/
#

COMPANY_RDOMAIN_PREFIX=org.restkit     # your app id
PRODUCT_NAME=Restkit	               # your app name
SOURCE_ROOT=Code				       # source folder
TEMP_DIR=build/tmp                     # a tmp folder
DOXYFILE=Doxyfile      				   # doxygen config file
DOXYGEN_PATH=doxygen                   # Installation: sudo port install doxygen

# create the config file if needed
if ! [ -f $DOXYFILE ] 
then 
  echo doxygen config file does not exist
  $DOXYGEN_PATH -g $DOXYFILE
fi


#  Append the proper input/output directories and docset info to the config file.
echo mkdir -p $TEMP_DIR
mkdir -p $TEMP_DIR
cp $DOXYFILE $TEMP_DIR/Doxyfile
#DOCSET_PATH=build/$PRODUCT_NAME.docset
#For Restkit, we want the final HTML to be in Docs/html not build/Restkit-html 
#HTML_PATH=build/$PRODUCT_NAME-html
HTML_PATH=Docs
echo "INPUT              = \"$SOURCE_ROOT\"" >> $TEMP_DIR/Doxyfile
#echo "OUTPUT_DIRECTORY   = $DOCSET_PATH" >> $TEMP_DIR/Doxyfile
echo "OUTPUT_DIRECTORY   = $HTML_PATH" >> $TEMP_DIR/Doxyfile
echo "RECURSIVE          = YES"          >> $TEMP_DIR/Doxyfile
echo "EXTRACT_ALL        = YES"          >> $TEMP_DIR/Doxyfile
echo "JAVADOC_AUTOBRIEF  = YES"          >> $TEMP_DIR/Doxyfile
echo "GENERATE_LATEX     = NO"           >> $TEMP_DIR/Doxyfile
echo "SEARCHENGINE       = NO"           >> $TEMP_DIR/Doxyfile
#echo "GENERATE_DOCSET    = YES"          >> $TEMP_DIR/Doxyfile
#echo "DOCSET_FEEDNAME    = $PRODUCT_NAME Documentation" >> $TEMP_DIR/Doxyfile
#echo "DOCSET_BUNDLE_ID   = $COMPANY_RDOMAIN_PREFIX.$PRODUCT_NAME" >> $TEMP_DIR/Doxyfile

#echo "HTML_STYLESHEET  = Tools/doxygen/terminal-style.css" >> $TEMP_DIR/Doxyfile
echo "HTML_HEADER      = Tools/doxygen/header.html"        >> $TEMP_DIR/Doxyfile
echo "HTML_FOOTER      = Tools/doxygen/footer.html"        >> $TEMP_DIR/Doxyfile


#  Run doxygen on the updated config file.
$DOXYGEN_PATH $TEMP_DIR/Doxyfile


# #  Doxygen generates a make file that invokes docsetutil. 
# echo 
# echo RUNNING MAKE FILE... 
# make -C $DOCSET_PATH/html install
# 
# 
# #  Build an applescript file to tell Xcode to load a docset.
# rm -f $TEMP_DIR/loadDocSet.scpt
# echo "tell application \"Xcode\"" >> $TEMP_DIR/loadDocSet.scpt
# echo "load documentation set with path \"/Users/$USER/Library/Developer/Shared/Documentation/DocSets/$COMPANY_RDOMAIN_PREFIX.$PRODUCT_NAME.docset\"" >> $TEMP_DIR/loadDocSet.scpt
# echo "end tell" >> $TEMP_DIR/loadDocSet.scpt
# osascript $TEMP_DIR/loadDocSet.scpt


exit 0
