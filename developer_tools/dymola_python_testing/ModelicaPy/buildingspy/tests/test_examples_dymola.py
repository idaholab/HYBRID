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
from test.test_support import EnvironmentVarGuard

class Test_example_dymola_runSimulation(unittest.TestCase):
    """
       This class contains the unit tests for
       :mod:`buildingspy.examples`.
    """

    def setUp(self):
        ''' Ensure that environment variables that are needed to run
            the tests are set
        '''
        self.env = EnvironmentVarGuard()
        # Set MODELICALIBRARY which is required to run
        # runSimulationTranslated.py
        self.env.setdefault("MODELICALIBRARY", "/usr/local/Modelica/Library")
        
    def test_runSimulation(self):
        '''
        Tests the :mod:`buildingspy/examples/dymola/runSimulation`
        function.
        '''
        import buildingspy.examples.dymola.runSimulation as s
        s.main()

    def test_runSimulationTranslated(self):
        '''
        Tests the :mod:`buildingspy/examples/dymola/runSimulationTranslated`
        function.
        '''
        import buildingspy.examples.dymola.runSimulationTranslated as s
        s.main()

    def test_plotResult(self):
        '''
        Tests the :mod:`buildingspy/examples/dymola/plotResult`
        function.
        '''
        import os
        import buildingspy.examples.dymola.plotResult as s
        s.main()
        # Remove the generated plot files
        os.remove("plot.pdf")
        os.remove("plot.png")

if __name__ == '__main__':
    unittest.main()
