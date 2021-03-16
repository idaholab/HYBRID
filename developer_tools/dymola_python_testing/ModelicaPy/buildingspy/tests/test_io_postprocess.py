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
from buildingspy.io.postprocess import Plotter
import numpy.testing

class Test_io_Plotter(unittest.TestCase):
    """
       This class contains the unit tests for
       :mod:`buildingspy.io.Plotter`.
    """

    def test_interpolate(self):
        '''
        Tests the :mod:`buildingspy.io.Plotter.interpolate`
        function.
        '''
        t10 = range(10)
        t100 = range(100)
        f = lambda x: 10+2*x
        y10  = map(f, t10)
        y100 = map(f, t100)
        y10Int = Plotter.interpolate(t10, t100, y100)
        numpy.testing.assert_allclose(y10, y10Int)
        # Add one more element to t100. This emulates an event
        # at t=10, in which case dymola adds two points
        t100.append(10)
        y100=map(f, sorted(t100))
        y10Int = Plotter.interpolate(t10, sorted(t100), y100)
        numpy.testing.assert_allclose(y10, y10Int)

    def test_convertToPeriodic(self):
        '''
        Test the :mod:`buildingspy.io.Plotter.convertToPeriodic`
        function.
        '''
        import numpy as np
        import random
        import copy

        t = np.arange(0, 1000, 1.0)
        y = copy.copy(t)
        # Shuffle the y vector
        random.shuffle(y, random.seed(1))
        (tP, yP) = Plotter.convertToPeriodic(10, t, y)
        # Test whether the time vector is periodic
        for i in range(10):
            numpy.testing.assert_allclose(tP[i*10:(i+1)*10], range(10))
        # Test whether y remains unchanged
        numpy.testing.assert_allclose(y, yP)
        # Should raise an exception of t[0] != 0
#fixme                self.assertRaises(ValueError, Plotter.convertToPeriodic(10, range(1,1000), y))
        # Test for period to be larger than time vector
#fixme        self.assertRaises(ValueError, Plotter.convertToPeriodic(100, range(10), range(10)))

    def test_boxplot(self):
        '''
        Test the :mod:`buildingspy.io.Plotter.boxplot`
        function.
        '''
        import numpy as np
        # Construct 3 days of data with 1/2 hour time interval
        # The first time stamp is 0, the last time stamp is 72
        t = np.arange(0, 24*3+0.5, 0.5)
        y = t
        # Convert to period of 24 hours
#        (tP, y) = Plotter.convertToPeriodic(24, t, y)
        # Create plot
        Plotter.boxplot(t, y, increment=0.5, nIncrement=2*24,
                notch=0, sym='b+', vert=1, whis=1.5,
                positions=None, widths=None, patch_artist=False, bootstrap=None, hold=None)

if __name__ == '__main__':
    unittest.main()

