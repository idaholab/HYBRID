#!/bin/bash
#Licensed under Apache 2.0 License.
#© 2020 Battelle Energy Alliance, LLC
#ALL RIGHTS RESERVED
#.
#Prepared by Battelle Energy Alliance, LLC
#Under Contract No. DE-AC07-05ID14517
#With the U. S. Department of Energy
#.
#NOTICE:  This computer software was prepared by Battelle Energy
#Alliance, LLC, hereinafter the Contractor, under Contract
#No. AC07-05ID14517 with the United States (U. S.) Department of
#Energy (DOE).  The Government is granted for itself and others acting on
#its behalf a nonexclusive, paid-up, irrevocable worldwide license in this
#data to reproduce, prepare derivative works, and perform publicly and
#display publicly, by or on behalf of the Government. There is provision for
#the possible extension of the term of this license.  Subsequent to that
#period or any extension granted, the Government is granted for itself and
#others acting on its behalf a nonexclusive, paid-up, irrevocable worldwide
#license in this data to reproduce, prepare derivative works, distribute
#copies to the public, perform publicly and display publicly, and to permit
#others to do so.  The specific term of the license can be identified by
#inquiry made to Contractor or DOE.  NEITHER THE UNITED STATES NOR THE UNITED
#STATES DEPARTMENT OF ENERGY, NOR CONTRACTOR MAKES ANY WARRANTY, EXPRESS OR
#IMPLIED, OR ASSUMES ANY LIABILITY OR RESPONSIBILITY FOR THE USE, ACCURACY,
#COMPLETENESS, OR USEFULNESS OR ANY INFORMATION, APPARATUS, PRODUCT, OR
#PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY
#OWNED RIGHTS.
SCRIPT_NAME=`readlink $0`
if test -x "$SCRIPT_NAME";
then
    SCRIPT_DIRNAME=`dirname $SCRIPT_NAME`
else
    SCRIPT_DIRNAME=`dirname $0`
fi
SCRIPT_DIR=`(cd $SCRIPT_DIRNAME; pwd)`
cd $SCRIPT_DIR

VERB=0
for i in "$@"
do
  if [[ $i == "--verbose" ]]
  then
    VERB=1
    echo Entering verbose mode...
  fi
done

rm -Rvf sqa_built_documents
mkdir sqa_built_documents

# add custom, collective inputs to TEXINPUTS
#
# Since on Windows we use MikTeX (which is a native Windows program), the TEXTINPUTS variable used i
#   to tell the LaTeX processor where to look for .sty files must be set using Windows-style paths
#   (not the Unix-style ones used on other platforms).  This also means semi-colons need to be used
#   to separate terms instead of the Unix colon.
#
if [ "$(uname)" == "Darwin" ] || [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
  export TEXINPUTS=.:$SCRIPT_DIR/tex_inputs/:$TEXINPUTS
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]  || [  "$(expr substr $(uname -s) 1 4)" == "MSYS" ]
then
  export TEXINPUTS=.\;`cygpath -w $SCRIPT_DIR/tex_inputs`\;$TEXINPUTS
fi
# copy files that are not built
# SQAP
cp sqap/*.pdf sqa_built_documents/
cp sqap/*.docx sqa_built_documents/
# Configuration Item list
cp CIlist/*.docx sqa_built_documents/
# Dashboard
cp HYBRID_SQA_Status_Dashboard.pptx sqa_built_documents/

if git describe
then
    git describe | sed 's/_/\\_/g' > ../new_version.tex
    echo "\\\\" >> ../new_version.tex
    git log -1 --format="%H %an\\\\%aD" . >> ../new_version.tex
    if diff ../new_version.tex ../version.tex
    then
        echo No change in ../version.tex
    else
        mv ../new_version.tex ../version.tex
    fi
fi

for DIR in  sdd rtr srs srs_rtr_combined; do
    cd $DIR
    echo Building in $DIR...
    if [ "$(uname)" == "Darwin" ] || [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
    then
      if [[ 1 -eq $VERB ]]
      then
        make; MADE=$?
      else
        make > /dev/null; MADE=$?
      fi    
    elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]  || [  "$(expr substr $(uname -s) 1 4)" == "MSYS" ]
    then
      if [[ 1 -eq $VERB ]]
      then
        bash.exe make_win.sh; MADE=$?
      else
        bash.exe make_win.sh > /dev/null; MADE=$?
      fi
    fi
    if [[ 0 -eq $MADE ]]; then
        echo ...Successfully made docs in $DIR
        cp *.pdf ../sqa_built_documents
    else
        echo ...Failed to make docs in $DIR
        exit -1
    fi
    cd $SCRIPT_DIR
done


