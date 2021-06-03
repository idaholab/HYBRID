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
'''
Simulating a model with two different parameter values
======================================================

This module provides an example that illustrates the
use of the python to run a Modelica simulation.

The module
:mod:`buildingspy.simulate.Simulator` that can be used to automate running simulations.
For example, to translate and simulate the model
``Buildings.Controls.Continuous.Examples.PIDHysteresis.mo``
with controller parameters ``con.eOn = 1`` and ``con.eOn = 5``, use
the following commands:

.. literalinclude:: ../../buildingspy/examples/dymola/runSimulation.py

This will run the two test cases and store the results in the directories
``case1`` and ``case2``.

Simulating a model with two different parameter values but without recompilation
================================================================================

In the above example, the value of the parameter ``con.eOn`` can be
changed after the model has been translated.
To avoid unrequired translations, the functions
:func:`buildingspy.simulate.Simulator.translate` and
:func:`buildingspy.simulate.Simulator.simulate_translated` can
be used to translate a model, and then simulate it with different
parameter values.
The following commands accomplish this:

.. literalinclude:: ../../buildingspy/examples/dymola/runSimulationTranslated.py

.. note:: If a parameter cannot be changed after
          model translation, then
          :func:`buildingspy.simulate.Simulator.simulate_translated`
          will throw an exception.

Plotting of Time Series
=======================

This module provides an example that illustrates the
use of the python to plot results from a Dymola simulation.
See also the class :class:`buildingspy.io.postprocess.Plotter`
for more advanced plotting.

The file ``plotResult.py`` illustrates how to plot results from a
Dymola output file. To run the example, proceed as follows:

 1. Open a terminal or dos-shell.
 2. Set the PYTHONPATH environment variables to the
    directory that contains ```buildingspy``` as a subdirectory, such as

    .. code-block:: bash

       cd buildingspy/examples/dymola
       export PYTHONPATH=${PYTHONPATH}:../../..

 3. Type

    .. code-block:: bash

       python plotResult.py

This will execute the script ``plotResult.py``, which contains
the following instructions:

.. literalinclude:: ../../buildingspy/examples/dymola/plotResult.py

The script generates the following plot:

.. image:: ../../buildingspy/examples/dymola/plot.png
   :width: 560px
   :alt: Plot generated by ``plotResult.py``
   :align: center

'''