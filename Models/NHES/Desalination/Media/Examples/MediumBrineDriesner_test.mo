within NHES.Desalination.Media.Examples;
model MediumBrineDriesner_test
  extends Modelica.Icons.Example;
  import SIunits =
         Modelica.Units.SI;

  package Medium = Media.BrineProp.BrineDriesner "Driesner EOS for NaCl solution";

  Medium.BaseProperties props;

  Medium.ThermodynamicState stateDefined;
  Medium.ThermodynamicState stateDefined_phX;

  SI.SpecificEnthalpy h;
  SI.Density d;
  SI.DynamicViscosity eta;

  SI.Density dd;

  SI.Temperature T;
  SI.SpecificInternalEnergy u;

  SI.SpecificEnthalpy h2;

  Real xN;

  parameter SI.MassFraction X[:] = {0.0839077010751};

  SI.MassFraction[Medium.nX] Xcal;

  SI.Pressure Pr_Pa;
  SI.Temperature Tr;
  SI.SpecificEnthalpy hr;
  SI.MassFraction Xi_r[Medium.nX];

  Medium.ThermodynamicState stateRetentate;

  SI.Pressure Pp_Pa;
  SI.Temperature Tp;
  SI.SpecificEnthalpy hp;
  SI.MassFraction Xi_p[Medium.nX];

  Medium.ThermodynamicState statePermeate;

equation
  //specify thermodynamic state
  props.p = 1e5;
  props.T = 20 + 273.15;
  props.Xi = NHES.Desalination.Media.BrineProp.Xi2X({0.0839077010751});

  //specify thermodynamic state
  stateDefined = Medium.setState_pTX(1e5, 20+273.15, {0.0839077010751,1-0.0839077010751});
  stateDefined_phX = Medium.setState_phX(1e5, 85440.5, NHES.Desalination.Media.BrineProp.Xi2X({0.0839077010751}));

 h = Medium.specificEnthalpy(stateDefined);
 d = Medium.density(stateDefined);
 eta = Medium.dynamicViscosity(stateDefined);

 dd = Medium.density_pTX(1e5, 20+273.15, {0.0839077010751});

 T = Medium.temperature_phX(1e5, 85440.5, {0.0839077010751,1-0.0839077010751});

Xcal = NHES.Desalination.Media.BrineProp.Xi2X(X);

u = Medium.specificInternalEnergy(stateDefined);

h2 = NHES.Desalination.Media.BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_Driesner(1e5, 20+273.15, X[1]);

xN = Medium.nXi;

Pr_Pa = 15.4958*1e5;
Tr = 25.2598 + 273.15;
Xi_r = NHES.Desalination.Media.BrineProp.Xi2X({0.00665601});
hr = NHES.Desalination.Media.BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_Driesner(Pr_Pa, Tr, Xi_r[1]);
stateRetentate = Medium.setState_phX(Pr_Pa, hr, Xi_r);

Pp_Pa = 1.01325*1e5;
Tp = 25.1299 + 273.15;
Xi_p = NHES.Desalination.Media.BrineProp.Xi2X({3.18849e-5});
hp = NHES.Desalination.Media.BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_Driesner(Pp_Pa, Tp, Xi_p[1]);
statePermeate = Medium.setState_phX(Pp_Pa, hp, Xi_p);

end MediumBrineDriesner_test;
