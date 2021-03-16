within NHES.GasTurbine.CombustionChamber.BaseClasses;
partial model CombustionChamberBase "Combustion chamber"
  extends GasTurbine.Icons.Mixer;

  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Air = Modelica.Media.Interfaces.PartialMedium "Air" annotation (Dialog(group="Working fluids (Medium)"));
  replaceable package Fuel = Modelica.Media.Interfaces.PartialMedium "Fuel" annotation (Dialog(group="Working fluids (Medium)"));
  replaceable package Exhaust = Modelica.Media.Interfaces.PartialMedium
    "Flue gas " annotation (Dialog(group="Working fluids (Medium)"));

  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  parameter Modelica.Units.SI.Volume V "Inner volume";
  parameter Modelica.Units.SI.Area S=0 "Inner surface";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer gamma=0
    "Heat Transfer Coefficient" annotation (Evaluate=true);
  parameter Modelica.Units.SI.HeatCapacity Cm=0 "Metal Heat Capacity"
    annotation (Evaluate=true);
  parameter Modelica.Units.SI.Temperature Tm_start=Tstart
    "Metal wall start temperature" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.SI.SpecificEnthalpy LHV=43094*1e3
    "Lower heating value of fuel";
  parameter Modelica.Units.SI.Pressure pstart=1.01325*1e5
    "Pressure start value" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.SI.Temperature Tstart "Temperature start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.SI.MassFraction Xstart[Exhaust.nX]=Exhaust.reference_X
    "Start flue gas composition" annotation (Dialog(tab="Initialisation"));
//  parameter ThermoPower.Choices.Init.Options initOpt=ThermoPower.Choices.Init.Options.noInit
//    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  Air.ThermodynamicState state_air "State of inlet air";
  Exhaust.BaseProperties fluegas(
    p(start=pstart),
    T(start=Tstart),
    Xi(start=Xstart[1:Exhaust.nXi]));
  Modelica.Units.SI.MassFlowRate wf "Fuel flow rate";
  Modelica.Units.SI.Mass M "Gas total mass";
  Modelica.Units.SI.Mass MX[Exhaust.nXi] "Partial flue gas masses";
  Modelica.Units.SI.InternalEnergy E "Gas total energy";
  Modelica.Units.SI.Temperature Tm(start=Tm_start) "Wall temperature";
  Modelica.Units.SI.Temperature Td "Air inlet temperature";
  Modelica.Units.SI.Temperature Tf "Firing temperature";
  Air.SpecificEnthalpy hia "Air specific enthalpy";
  Fuel.SpecificEnthalpy hif "Fuel specific enthalpy";
  Exhaust.SpecificEnthalpy ho "Outlet specific enthalpy";
  Modelica.Units.SI.Power HR "Heat rate";

  Modelica.Units.SI.Time ResTime "Residence time";
  Real eta_comb "Combustion efficiency";

  Modelica.Fluid.Interfaces.FluidPort_a
          ina(redeclare package Medium = Air, m_flow(min=if allowFlowReversal
           then -Modelica.Constants.inf else 0)) "Inlet air" annotation (
      Placement(transformation(extent={{-50,-10},{-30,10}},  rotation=0),
          iconTransformation(extent={{-50,-10},{-30,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a
          inf(redeclare package Medium = Fuel, m_flow(min=if
          allowFlowReversal then -Modelica.Constants.inf else 0)) "Inlet fuel"
                 annotation (Placement(transformation(extent={{-10,30},{10,50}},
                   rotation=0), iconTransformation(extent={{-10,30},{10,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b
          out(redeclare package Medium = Exhaust, m_flow(max=if
          allowFlowReversal then +Modelica.Constants.inf else 0)) "Flue gas"
    annotation (Placement(transformation(extent={{30,-10},{50,10}},  rotation=
           0), iconTransformation(extent={{30,-10},{50,10}})));

equation
  M = fluegas.d*V "Gas mass";
  E = fluegas.u*M "Gas energy";
  MX = fluegas.Xi*M "Component masses";
  HR = wf*LHV*eta_comb;
  der(M) = ina.m_flow + wf + out.m_flow "Gas mass balance";
  der(E) = ina.m_flow*hia + wf*hif + out.m_flow*ho + HR - gamma*S*(
    fluegas.T - Tm) "Gas energy balance";
  if Cm > 0 and gamma > 0 then
    Cm*der(Tm) = gamma*S*(fluegas.T - Tm) "Metal wall energy balance";
  else
    Tm = fluegas.T;
  end if;

  // Set gas properties
  out.p = fluegas.p;
  out.h_outflow = fluegas.h;
  out.Xi_outflow = fluegas.Xi;
  state_air = Air.setState_phX(ina.p, inStream(ina.h_outflow), inStream(ina.Xi_outflow));

  // Equations for reverse flow (not used)
  ina.h_outflow = 0;
  ina.Xi_outflow = Air.reference_X[1:Air.nXi];
  inf.h_outflow = 0;
  inf.Xi_outflow = Fuel.reference_X[1:Fuel.nXi];

  // Boundary conditions
  ina.p = fluegas.p;
  inf.p = fluegas.p;

  wf = inf.m_flow;
  assert(ina.m_flow >= 0, "The model does not support flow reversal");
  hia = inStream(ina.h_outflow);
  assert(wf >= 0, "The model does not support flow reversal");
  hif = inStream(inf.h_outflow);
  assert(out.m_flow <= 0, "The model does not support flow reversal");
  ho = fluegas.h;

  Td = Air.temperature(state_air);
  Tf = fluegas.T;

  ResTime = noEvent(M/max(abs(out.m_flow), Modelica.Constants.eps));

initial equation
  // Initial conditions
  //if initOpt == ThermoPower.Choices.Init.Options.noInit then
    // Do nothing
  //elseif initOpt == ThermoPower.Choices.Init.Options.steadyState then

  // Steady State
    der(fluegas.p) = 0;
    der(fluegas.T) = 0;
    der(fluegas.Xi) = zeros(Exhaust.nXi);
    if (Cm > 0 and gamma > 0) then
      der(Tm) = 0;
    end if;
  //elseif initOpt == ThermoPower.Choices.Init.Options.steadyStateNoP then
//     der(fluegas.T) = 0;
//     der(fluegas.Xi) = zeros(Exhaust.nXi);
//     if (Cm > 0 and gamma > 0) then
//       der(Tm) = 0;
//     end if;
//   else
//     assert(false, "Unsupported initialisation option");
//   end if;

  annotation (Documentation(info="<html>
This is the model-base of a Combustion Chamber, with a constant volume.
<p>The metal wall temperature and the heat transfer coefficient between the wall and the fluid are uniform. The wall is thermally insulated from the outside. It has been assumed that inlet gases are premixed before entering in the volume.
<p><b>Modelling options</b></p>
<p>This model has three different Medium models to characterize the inlet air, fuel, and flue gas exhaust.
<p>If <tt>gamma = 0</tt>, the thermal effects of the surrounding walls are neglected.
</p>
</html>"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),        graphics={
                   Text(
          extent={{-126,-48},{130,-88}},
          lineColor={0,0,255},
          textString="%name")}));
end CombustionChamberBase;
