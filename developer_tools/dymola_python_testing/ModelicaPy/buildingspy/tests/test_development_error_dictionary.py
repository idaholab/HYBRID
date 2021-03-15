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

class Test_development_error_dictionary(unittest.TestCase):
    """
       This class contains the unit tests for
       :mod:`buildingspy.development.error_dictionary.ErrorDictionary`.
    """

    def test_keys(self):
        import buildingspy.development.error_dictionary as e
        err_dic = e.ErrorDictionary()
        k = sorted(err_dic.keys())

        k_expected = sorted(['differentiated if',
                      'experiment annotation',
                      'file not found',
                      'invalid connect',
                      'numerical Jacobians',
                      'parameter with start value only',
                      'redeclare non-replaceable',
                      'redundant consistent initial conditions',
                      'type incompatibility',
                      'type inconsistent definition equations',
                      'unspecified initial conditions',
                      'unused connector',
                      'stateGraphRoot missing'])

        self.assertEqual(len(k), len(k_expected), "Wrong number of keys.")
        for i in range(len(k)):
            self.assertEqual(k[i], k_expected[i], "Wrong key, expected \"{}\".".format(k_expected[i]))

    def test_tool_messages(self):
        import buildingspy.development.error_dictionary as e
        err_dic = e.ErrorDictionary()
        k = sorted(err_dic.tool_messages())
        k_expected = sorted(['Differentiating (if',
                      'Warning: Failed to interpret experiment annotation',
                      'which was not found',
                      'The model contained invalid connect statements.',
                      'Number of numerical Jacobians:',
                      "Warning: The following parameters don't have any value, only a start value",
                      'Warning: Redeclaration of non-replaceable requires type equivalence',
                      'Redundant consistent initial conditions:',
                      'but they must be compatible',
                      'Type inconsistent definition equation',
                      'Dymola has selected default initial condition',
                      'Warning: The following connector variables are not used in the model',
                      "A \\\"stateGraphRoot\\\" component was automatically introduced."])

        self.assertEqual(len(k), len(k_expected), "Wrong number of tool messages.")
        for i in range(len(k)):
            self.assertEqual(k[i], k_expected[i], "Wrong tool message, expected \"{}\".".format(k_expected[i]))


if __name__ == '__main__':
    unittest.main()
