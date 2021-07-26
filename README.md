# HYBRID

HYBRID is a collection of a transient process models developed in the Modelica langauage capable of representing the physical dynamics of various integrated energy systems and processes. The models are developed in a modular way so as to allow users to quickly assemble and test various configurations and control systems. 

The systems studied are modular and made of an assembly of components. For example, a system could contain a hybrid nuclear reactor, a gas turbine, a battery and some renewables. This system would correspond to the size of a balance area, but in theory any size of system is imaginable. The system is modeled in the ‘Modelica/Dymola’ language.

To assess the economics of the system, an optimization procedure varying different parameters can be run using the INL [FORCE](https://ies.inl.gov/SitePages/Technology%20-%20System%20Simulation.aspx) platform that combines HYBRID with HERON and RAVEN. 


Currently,the HYBRID repository is based on:

* RAVEN : RAVEN v 1.1 (and newer). See [GITHUB WEBSITE](https://github.com/idaholab/raven)
* TRANSFORM-Library : TRANsient Simulation Framework of Reconfigurable Models. See [GITHUB WEBSITE](https://github.com/ORNL-Modelica/TRANSFORM-Library)
* DYMOLA: DYMOLA 2020x. See [Dymola Website](https://www.3ds.com/products-services/catia/products/dymola/?woc=%7B%22category%22%3A%5B%22category%2Fdymola%22%5D%7D&wockw=card_content_cta_1_url%3A%22https%3A%2F%2Fblogs.3ds.com%2Fcatia%2F%22)

### License

Copyright 2020 Battelle Energy Alliance, LLC

Licensed under the Apache 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  https://opensource.org/licenses/Apache-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.



Licensing
-----
This software is licensed under the terms you may find in the file named "LICENSE" in this directory.


Developers
-----
By contributing to this software project, you are agreeing to the following terms and conditions for your contributions:

You agree your contributions are submitted under the Apache-2 license. You represent you are authorized to make the contributions and grant the license. If your employer has rights to intellectual property that includes your contributions, you represent that you have received permission to make contributions and grant the required license on behalf of that employer.

Authors
-----
* Andrea Alfonsi
* Aaron Epiney
* Cristian Rabiti 
* Jong Suk Kim
* Konor Frick (Technical Lead/ Owner)
* Paul Talbot
* Robert Kinoshita
* Derek Stucki
* Michael Greenwood
* Roberto Ponciroli
* Yu Tang
* Daniel Mikkelson (Maintainer)
* Amey Shigrekar


### Other Software
Idaho National Laboratory is a cutting edge research facility which is a constantly producing high quality research and software. Feel free to take a look at our other software and scientific offerings at:

[Primary Technology Offerings Page](https://www.inl.gov/inl-initiatives/technology-deployment)

[Supported Open Source Software](https://github.com/idaholab)

[Raw Experiment Open Source Software](https://github.com/IdahoLabResearch)

[Unsupported Open Source Software](https://github.com/IdahoLabCuttingBoard)
