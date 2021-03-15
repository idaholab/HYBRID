within NHES.Desalination.Media.BrineProp.Examples;
model SingleSaltBrine
  //SPECIFY MEDIUM
  package Medium = BrineProp.BrineDriesner
    "Driesner EOS for NaCl solution";
  //package Medium = BrineProp.BrineDuan "Duan for NaCl solution";
  Medium.BaseProperties props;
equation
  //specify thermodynamic state
  props.p = 1e5;
  props.T = 20 + 273.15;
  //specify brine composition
  props.Xi = {0.0839077010751};
end SingleSaltBrine;
