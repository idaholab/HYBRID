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

import buildingspy.io.outputfile as of

import numpy.testing

class Test_io_Reader(unittest.TestCase):
    """
       This class contains the unit tests for
       :mod:`buildingspy.io.Reader`.
    """

    def test_get_simulation_statistics(self):
        '''
        Tests the :mod:`buildingspy.io.Reader.get_simulation_statistics`
        function.
        '''
        import os

        # Name of temporary file
        staFil = "test_stat_file.txt"
        # Write a file that contains the simulation statistics as reported by Dymola
        s ="""
Translation of Buildings.Examples.ChillerPlant.DataCenterContinuousTimeControl:

The DAE has 1795 scalar unknowns and 1795 scalar equations.

Statistics

Original Model
  Number of components: 415
  Variables: 4407
  Constants: 52 (52 scalars)
  Parameters: 2104 (2093 scalars)
  Unknowns: 2251 (1891 scalars)
  Differentiated variables: 64 scalars
  Equations: 1709
  Nontrivial: 1381
Translated Model
  Constants: 1356 scalars
  Free parameters: 527 scalars
  Parameter depending: 465 scalars
  Outputs: 25 scalars
  Continuous time states: 33 scalars
  Time-varying variables: 644 scalars
  Alias variables: 1044 scalars
  Number of mixed real/discrete systems of equations: 0
  Sizes of linear systems of equations: {11, 13}
  Sizes after manipulation of the linear systems: {0, 2}
  Sizes of nonlinear systems of equations: {2, 1, 3, 9}
  Sizes after manipulation of the nonlinear systems: {1, 0, 1, 3}
  Number of numerical Jacobians: 0
  Initialization problem
    Sizes of linear systems of equations: {3, 3, 3, 3}
    Sizes after manipulation of the linear systems: {0, 0, 0, 0}
    Sizes of nonlinear systems of equations: {1, 9, 3, 2, 120}
    Sizes after manipulation of the nonlinear systems: {1, 3, 1, 1, 17}
    Number of numerical Jacobians: 0
        """

        with open(staFil, 'w') as fil:
            fil.write(s)

        # Test the function
        stats = of.get_model_statistics(staFil, 'dymola')
        self.assertEqual(stats['initialization']['nonlinear'],
                         "1, 3, 1, 1, 17",
                         "Parsing nonlinear equations for initialization problem failed")
        self.assertEqual(stats['translated'],
                         True,
                         "Parsing translation aborted failed")
        self.assertEqual(stats['simulation']['nonlinear'],
                         "1, 0, 1, 3",
                         "Parsing nonlinear equations for simulation problem failed")
        self.assertEqual(stats['initialization']['linear'],
                         "0, 0, 0, 0",
                         "Parsing linear equations for initialization problem failed")
        self.assertEqual(stats['simulation']['linear'],
                         "0, 2",
                         "Parsing linear equations for simulation problem failed")
        self.assertEqual(stats['initialization']['numerical Jacobians'],
                         "0",
                         "Parsing numerical Jacobian for initialization problem failed")
        self.assertEqual(stats['simulation']['numerical Jacobians'],
                         "0",
                         "Parsing numerical Jacobian for simulation problem failed")

        os.remove(staFil)

if __name__ == '__main__':
    unittest.main()
