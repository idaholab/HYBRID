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
#!/usr/bin/env python
import unittest

class Test_development_refactor(unittest.TestCase):
    """
       This class contains the unit tests for
       :mod:`buildingspy.development.refactor.Refactor`.
    """
    
    def test_sort_package_order(self):
        import random
        import buildingspy.development.refactor as r
        __MOD=0
        __REC=1
        __PAC=2
        
        o  = [[__PAC, "UsersGuide"], 
              [__MOD, "a"],
              [__MOD, "y"], 
              [__REC, "a_data"],
              [__PAC, "B"], 
              [__PAC, "Z"],
              [__PAC, "Data"],
              [__PAC, "Types"],
              [__PAC, "Examples"],
              [__PAC, "Validation"],
              [__PAC, "Experimental"],
              [__PAC, "Interfaces"],
              [__PAC, "BaseClasses"],
              [__PAC, "Internal"], 
              [__PAC, "Obsolete"]]

        random.seed(1)
        for i in range(10):
            # Copy the list to prevent the original list to be modified.
            s = list(o)
            # Shuffle the list randomly.
            random.shuffle(s)
            s = r._sort_package_order(s)
            self.assertEqual(o, s, "Sorting failed with i=%d." % i)
        # Reset the random number generator.
        random.seed()
        
if __name__ == '__main__':
    unittest.main()

