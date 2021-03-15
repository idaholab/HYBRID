within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
model TESTBVcontroller
  Modelica.Blocks.Interfaces.RealInput Demand
    annotation (Placement(transformation(extent={{-126,68},{-100,94}})));
  Modelica.Blocks.Interfaces.RealInput TESTBVPosition4
    annotation (Placement(transformation(extent={{-126,-26},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput TESTBVPosition3
    annotation (Placement(transformation(extent={{-126,-2},{-100,24}})));
  Modelica.Blocks.Interfaces.RealInput TESTBVPosition2
    annotation (Placement(transformation(extent={{-126,22},{-100,48}})));
  Modelica.Blocks.Interfaces.RealInput TESTBVPosition1
    annotation (Placement(transformation(extent={{-126,46},{-100,72}})));
  Modelica.Blocks.Interfaces.RealOutput FlowErr1
    annotation (Placement(transformation(extent={{100,76},{120,96}})));
  Modelica.Blocks.Interfaces.RealOutput FlowErr2
    annotation (Placement(transformation(extent={{100,54},{120,74}})));
  Modelica.Blocks.Interfaces.RealOutput FlowErr3
    annotation (Placement(transformation(extent={{100,34},{120,54}})));
  Modelica.Blocks.Interfaces.RealOutput FlowErr4
    annotation (Placement(transformation(extent={{100,12},{120,32}})));
  Modelica.Blocks.Interfaces.RealInput m_TBV
    annotation (Placement(transformation(extent={{-128,-52},{-102,-26}})));
parameter Real NominalReactorSteamFlow0=(15.2e6)/3600     "Nominal Reactor Steam Flow Rate (lbm/sec)";//lbm/sec
parameter Real PeakSteamflowPercent=5                     "Percent of nominal reactor steam flow IHX has been designed for";
parameter Real TESSetpointfrac[4]                         "TES fractions setpoints for opening and closing the valves [e.g. 0.15, 0.5, 0.75, 0.8]";

Real TESFlowDemand0;
Real Relative_Demand;
Real Error;
Real TESSetpoint[4];
Integer TESTBVPosition4lock(start=0);
Integer TESTBVPosition3lock(start=0);
Integer TESTBVPosition2lock(start=0);
Integer TESTBVPosition1lock(start=0);

algorithm
  TESFlowDemand0:=PeakSteamflowPercent*NominalReactorSteamFlow0/100;

  for i in 1:4 loop
    TESSetpoint[i]:=TESSetpointfrac[i]*TESFlowDemand0;
  end for;

  Relative_Demand:=(1 - (Demand/100))*NominalReactorSteamFlow0;

  Error:=(Relative_Demand - m_TBV)/TESFlowDemand0;
     if Error > 1 then
       Error:=1;
     end if;
     if Error < -1 then
       Error:=-1;
     end if;

//Section to see what valves open or close
//Valves are designed to open in order 1,2,3,4 and close in order 4,3,2,1
//************************************************************************
//************************************************************************

//Locking Mechanism for valves
if TESTBVPosition4 > 0.0000105 then
  TESTBVPosition4lock:=1;
else
  TESTBVPosition4lock:=0;
end if;
if TESTBVPosition3 > 0.0000105 then
  TESTBVPosition3lock:=1;
else
  TESTBVPosition3lock:=0;
end if;
if TESTBVPosition2 > 0.0000105 then
  TESTBVPosition2lock:=1;
else
  TESTBVPosition2lock:=0;
end if;
if TESTBVPosition1 > 0.0000105 then
  TESTBVPosition1lock:=1;
else
  TESTBVPosition1lock:=0;
end if;

if Error > 0. then
  if Relative_Demand > TESSetpoint[4] then
       FlowErr1:=Error;
       FlowErr2:=Error;
       FlowErr3:=Error;
       FlowErr4:=Error;
  elseif Relative_Demand > TESSetpoint[3] and Relative_Demand < TESSetpoint[4] then
       FlowErr1:=Error;
       FlowErr2:=Error;
       FlowErr3:=Error;
       FlowErr4:=0;
  elseif Relative_Demand > TESSetpoint[2] and Relative_Demand < TESSetpoint[3] then
       FlowErr1:=Error;
       FlowErr2:=Error;
       FlowErr3:=0;
       FlowErr4:=0;
  else FlowErr1:=Error;
       FlowErr2:=0;
       FlowErr3:=0;
       FlowErr4:=0;
  end if;
elseif Error < 0. then
  if TESTBVPosition4lock == 1 then
       FlowErr4:=Error;//Closes Valve 4
       FlowErr3:=0;
       FlowErr2:=0;
       FlowErr1:=0;
  elseif TESTBVPosition3lock == 1 and TESTBVPosition4lock == 0 then
       FlowErr4:=Error;
       FlowErr3:=Error;//Closes Valve 3
       FlowErr2:=0;
       FlowErr1:=0;
  elseif TESTBVPosition2 == 1 and TESTBVPosition3 == 0 then
       FlowErr4:=Error;
       FlowErr3:=Error;
       FlowErr2:=Error; //Closes Valve 2
       FlowErr1:=0;
  else FlowErr4:=Error;
       FlowErr3:=Error;
       FlowErr2:=Error;
       FlowErr1:=Error; //Closes Valve 1
  end if;
end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TESTBVcontroller;
