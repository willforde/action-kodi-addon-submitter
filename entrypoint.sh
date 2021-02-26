#!/bin/sh -l

# Add sub directory parameter if requsired
if [ "$5" = true ] ; then
  SUBDIRECTORY="-s"
else
  SUBDIRECTORY=""
fi

# Create pull request or just push
if [ "$6" = true ] ; then
  PUSH_OR_PULL="--push-branch"
else
  PUSH_OR_PULL="--pull-request"
fi

if [ "$4" = true ] ; then
  submit-addon -z $3 -m $SUBDIRECTORY
  echo ::set-output name=addon-zip::$(ls *.zip | awk '$0 !~ /\+matrix\./')
  echo ::set-output name=addon-zip-matrix::$(ls *+matrix*.zip)
  submit-addon -r $1 -b $2 $PUSH_OR_PULL $3 -m $SUBDIRECTORY
else
  submit-addon -z $3 $SUBDIRECTORY
  echo ::set-output name=addon-zip::$(ls *.zip)
  echo ::set-output name=addon-zip-matrix::
  submit-addon -r $1 -b $2 $PUSH_OR_PULL $3 $SUBDIRECTORY
fi
