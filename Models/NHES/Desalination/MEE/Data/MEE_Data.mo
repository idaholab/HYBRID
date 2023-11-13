within NHES.Desalination.MEE.Data;
model MEE_Data
  extends MEE.BaseClasses.Record_Data;
  parameter Integer nE= 6 "Number of Effects";
  parameter Boolean use_preheater=false;

  //Temperatures
  parameter Modelica.Units.SI.Temperature T_b_in= 302.15 "Brine Inlet Temperature" annotation(Dialog(group="Temperatures"));
  parameter Modelica.Units.SI.Temperature T_h=363.15 "First effect Temperature" annotation(Dialog(group="Temperatures"));
  parameter Modelica.Units.SI.Temperature T_l=323.15 "Last effect Temperature" annotation(Dialog(group="Temperatures"));
  parameter Modelica.Units.SI.Temperature Tsys[:]=linspace(T_h,T_l,nE)  "All effects Temperatures" annotation(Dialog(group="Temperatures"));

  //Pressures
  parameter Modelica.Units.SI.Pressure p_h=1e5 "First effect Pressure" annotation(Dialog(group="Pressures"));
  parameter Modelica.Units.SI.Pressure p_l=0.3e5
                                                "Last effect Pressure" annotation(Dialog(group="Pressures"));
  parameter Modelica.Units.SI.Pressure psys[:]=linspace(p_h,p_l,nE)  "All effects Pressures" annotation(Dialog(group="Pressures"));

  //Flow Rates and Salinity Control
  parameter Boolean use_flowrates= true "if true use set input flowrates else in salinity control"  annotation(Dialog(group="Flow Control"));
  parameter Modelica.Units.SI.MassFlowRate m_h=4 "First effect mass flows" annotation(Dialog(group="Flow Control",enable=use_flowrates));
  parameter Modelica.Units.SI.MassFlowRate m_l=4 "Last effect mass flows" annotation(Dialog(group="Flow Control",enable=use_flowrates));
  parameter Modelica.Units.SI.MassFlowRate msys[:]=linspace(m_h,m_l,nE)  "All effects mass flows" annotation(Dialog(group="Flow Control",enable=use_flowrates));
  parameter Modelica.Units.SI.MassFraction X_nom=0.11
                                                   "Nominal effect salinity" annotation(Dialog(group="Flow Control",enable= not use_flowrates));

  parameter Modelica.Units.SI.MassFraction Xsys[:]=fill(X_nom,nE)  "All effects salinity" annotation(Dialog(group="Flow Control",enable= not use_flowrates));

  parameter Modelica.Units.SI.Volume Vnom=1  annotation(Dialog(tab="Geometry"));
  parameter Modelica.Units.SI.Volume Vsys[:]=fill(Vnom,nE)  annotation(Dialog(tab="Geometry"));
  parameter Modelica.Units.SI.Area Anom=1  annotation(Dialog(tab="Geometry"));
  parameter Modelica.Units.SI.Area Asys[:]=fill(Anom,nE)  annotation(Dialog(tab="Geometry"));
  parameter Modelica.Units.SI.Area Axnom=1e4  annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.Area Axsys[:]=fill(Axnom,nE) annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.Diameter Donom=0.05 annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.Diameter Dosys[:]=fill(Donom,nE) annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.Thickness thnom=0.007 annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.Thickness thsys[:]=fill(thnom,nE) annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.ThermalConductivity knom=83
    "Thermal Conductivity of the Cladding" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.ThermalConductivity ksys[:]=fill(knom,nE)
    "Thermal Conductivity of the Cladding" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Integer nVnom=5 "Number of Nodes in HX" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Integer nVsys[:]=fill(nVnom,nE) "Number of Nodes in HX" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
  parameter Modelica.Units.SI.MassFlowRate m_brine_outnom=1
    "Nominal mass flow rate in brine exit valve" annotation(Dialog(group="Brine Valve"));
    parameter Modelica.Units.SI.MassFlowRate m_brine_outsys[:]=fill(m_brine_outnom,nE)
    "Nominal mass flow rate in brine exit valve" annotation(Dialog(group="Brine Valve"));
  parameter Modelica.Units.SI.AbsolutePressure dpnom=0.001e5
    "Nominal pressure drop across the brine exit valve" annotation(Dialog(group="Brine Valve"));
  parameter Modelica.Units.SI.AbsolutePressure dpsys[:]=fill(dpnom,nE)
    "Nominal pressure drop across the brine exit valve" annotation(Dialog(group="Brine Valve"));
  parameter Modelica.Units.SI.AbsolutePressure pTnom=1e5 "Init Tube pressure" annotation(Dialog(group="Tube Initailization"));
  parameter Modelica.Units.SI.AbsolutePressure pTsys[:]=fill(pTnom,nE) "Init Tube pressure"  annotation(Dialog(group="Tube Initailization"));
  parameter Real KVnom=-0.03 "Gain of PID in brine valve controller"  annotation(Dialog(group="Brine Valve"));
  parameter Real KVsys[:]=fill(KVnom,nE)
                                        "Gain of PID in brine valve controller"  annotation(Dialog(group="Brine Valve"));
  parameter Modelica.Units.SI.Time Tinom=0.75
    "Time constant of Integrator block" annotation(Dialog(group="Brine Valve"));
  parameter Modelica.Units.SI.Time Tisys[:]=fill(Tinom,nE)
    "Time constant of Integrator block" annotation(Dialog(group="Brine Valve"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MEE_Data;
