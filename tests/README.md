This folder contains the tests that will be run for each Pull Request (Merge Request) by
the regression test system (ROOK). Two subfolders are stored here:
- dymola_tests: This folder contains all the tests related to dymola only (compoent tests, system tests, etc,).  All the tests in this folder should use the test type ``HybridTester''.
- raven_tests: This folder contains all the tests related to RAVEN executing dymola models. All the tests in this folder should use the test type ``RavenFramework''.
