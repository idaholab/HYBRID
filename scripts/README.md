This folder contains the scripts or utility software that are used to setup the hybrid 
repository, execute python wrappers (DYMOLA from Python), etc.
The current utility software and scripts are:
- dymola_launcher.py: This software is used to simulate DYMOLA models within a python enviroment. The software must be run with the following options:
    - ``-i'' , for specifying the DYMOLA input file
    - ``-wd'', for specifying the working directory
- write_hybridrc.py and write_hybridrc.sh: This scripts is used to set the DYMOLA python interface path. They are equivalent and they must be run with the following options:
    - ``-p'' , the DYMOLA python interface path
- read_hybridrc.sh: This scripts is used to read the DYMOLA python interface path.  It is used by the installation and run_test script
- rook.ini: This file contains the settings for the regression test system (rook)
In addition, within this folder, the following subfolders are stored:
- testers: This folder contains the testers for the ROOK regression test system. 
