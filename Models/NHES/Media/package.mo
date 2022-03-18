within NHES;
package Media
  extends NHES.Icons.MediaPackage;
  import Modelica.Units.SI.*;


   constant Modelica.Media.IdealGases.Common.DataRecord He(
    name="He_MSL_HighTLimit",
    MM=0.004002602,
    Hf=0,
    H0=1548349.798456104,
    Tlimit=2000,
    alow={0,0,2.5,0,0,0,0},
    blow={-745.375,0.9287239740000001},
    ahigh={0,0,2.5,0,0,0,0},
    bhigh={-745.375,0.9287239740000001},
    R_s=2077.26673798694);
end Media;
