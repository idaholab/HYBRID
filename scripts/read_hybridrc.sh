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
# USES:
# read .hybridrc file

ECE_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# fail if ANYTHING this script fails (mostly, there are exceptions)
set -e

function read_hybridrc ()
{
  # $1 should be the keyword we're looking for
  # returns keyword argument through echo
  ## note that "| xargs" trims leading and trailing whitespace
  local TARGET=`echo $1 | xargs`
  # location of the RC file
  local RCNAME="${ECE_SCRIPT_DIR}/../.hybridrc"
  # if the RC file exists, loop through it and read keyword arguments split by "="
  if [ -f "$RCNAME" ]; then
    while IFS='=' read -r KEY ARG || [[ -n "$keyarg" ]]; do
      # trim whitespace
      KEY=`echo $KEY | xargs`
      ARG=`echo $ARG | xargs`
      # check for key match
      if [ "$KEY" = "$TARGET" ]; then
        echo "$ARG"
        return 0
      fi
    done < ${RCNAME}
  fi
  # if not found, return empty
  echo ''
}

