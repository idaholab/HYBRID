within NHES.Systems.ExperimentalSystems.TEDS.Models.ThermoclineTank;
model Thermocline_matprops_v3
  import TRANSFORM;

  replaceable package Medium =
      TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium annotation (
      choicesAllMatching=true);

//Tank Parameters
parameter SI.Length Radius_Tank=7.3 "Radius of the thermocline tank [m]";
parameter Real Porosity=0.25 "Porosity in the tank";
SI.Area XS_fluid = Porosity*(Radius_Tank^2.0)*Modelica.Constants.pi "Cross Sectional Area seen by the fluid at each axial location";
SI.Length Height_Tank = 14.6 "Tank Height [m]";

//Discretization
parameter Integer nodes=200 "Number of axial nodes";

SI.Length dz = Height_Tank/nodes "delta height in each node";

//Attempt to input medium package
SI.Density d_T[nodes]= Medium.density(mediums.state);
SI.Pressure ps[nodes] = fill(1e5,nodes);

parameter Real userspecificheat= 2474.5 "Should be input in J/kg*K";
//SI.SpecificHeatCapacity Cf[nodes] = Medium.specificHeatCapacityCp(mediums.state);

SI.SpecificHeatCapacity Cf[nodes] = fill(userspecificheat,nodes); //This can be used if the user knows an approximately constant value over their desired operations range, else comment this line and uncomment the one above it.

Medium.BaseProperties mediums[nodes];

//End attempt to input medium package.

SI.Temperature Tf[nodes] "Fluid Temperature up and down the thermocline";
SI.Temperature Tr[nodes] "Filler Temperature up and down the thermocline";

//SI.Density fluid_density=753.75 "Fluid Density Assumed Constant for now kg/m^3"; //First go is to match the paper
parameter SI.Density filler_density = 2630 "Filler Density (Granite)";

//SI.SpecificHeatCapacity Cf = 2474.5 "J/kg*K of fluid This is a single value across the entire fluid spectrum. This needs to be input each time f";
parameter SI.SpecificHeatCapacity Cr = 775.0 "J/kg*K of granite";

//SI.ThermalConductivity kf = 0.086 "W/m*K of fluid";
parameter SI.ThermalConductivity kr = 2.8 "W/m*K of filler";

SI.ReynoldsNumber Re[nodes] "Unitless";
SI.MassFlowRate mf;  //=-128.74 "kg/s";
SI.Velocity vel[nodes] "meter/s";
SI.CoefficientOfHeatTransfer h_c[nodes] "W/m^2*K";
SI.PrandtlNumber Pr[nodes] "Unitless";
SI.Length r_char "hydraulic radius [m]";
parameter SI.Length dr=0.04 "nominal diameter of filler material [m]";

SI.ThermalConductivity kf[nodes] = Medium.thermalConductivity(mediums.state) "W/m*K of fluid";
SI.DynamicViscosity mu_f[nodes] = Medium.dynamicViscosity(mediums.state);
SI.Density fluid_density[nodes] = Medium.density(mediums.state);

SI.Length Sr "Heat Transfer Surface Area of rocks per unit length of tank [m]";
parameter Real fs=3.0 "Surface Shape Factor ,may vary between 2 and 3 
depending rocks packing scheme (default is 3.0)";
parameter SI.Temperature T_inlet_hot = 395+273.15;
parameter SI.Temperature T_inlet_cold = 310+273.15;

SI.Temperature Tf_edge[nodes+1] "Boundary Nodes for fluid temperatures";

SI.Length z_star[nodes];

  Modelica.Blocks.Interfaces.RealInput m_flow_in
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

//Initialization Step **********************************************
initial equation

for i in 1:nodes loop
  Tf[i]=395+273.15;
  Tr[i]=395+273.15;
end for;

// Start of the actual Thermocline Equation Set**********************
equation

//Resetting the density, and dynamic viscosity as function of temperature at each node
  mediums.p = ps;
  mediums.T = Tr;

mf = m_flow_in;

//Ensure there is no divide by zero circumstance.*********************************************
if mf > -0.002 and mf < 0.002 then
  Re = fill(0.0001,nodes); //Simply forces the answer to not be equal to 0
else
  for i in 1:nodes loop
    Re[i] = 4*r_char*(abs(mf)/(Porosity*(Radius_Tank^2.0)*Modelica.Constants.pi))/mu_f[i];
  end for;
end if;

//Pr = Cf*mu_f./kf;
for i in 1:nodes loop
  Pr[i] = Cf[i]*mu_f[i]/kf[i];
end for;

r_char = Porosity*dr/(4.0*(1-Porosity));
for i in 1:nodes loop
  h_c[i] = (0.191*abs(mf)*Cf[i]/(Porosity*Modelica.Constants.pi.*(Radius_Tank^2.0)))*(Re[i]^(-0.278))*(Pr[i]^(-2/3));
end for;

Sr = fs*Modelica.Constants.pi*(1-Porosity)*(Radius_Tank^2.0)/(dr/2);

//Fluid Energy**************************************************************
//for i in 1:nodes loop
  vel = mf./(fluid_density*XS_fluid);
//end for;

 if mf >= 0 then
    for i in 2:nodes loop
      (h_c[i]*Sr/(fluid_density[i]*Cf[i]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[i]-Tf[i]) = der(Tf[i]) + vel[i]* (Tf[i]-Tf[i-1])/dz;
    end for;
  //Boundary Condition for positive flow from cold to hot.
  (h_c[1]*Sr/(fluid_density[1]*Cf[1]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[1]-Tf[1]) = der(Tf[1]) + vel[1]* (Tf[1]-T_inlet_hot)/dz;
 else
    for i in 1:nodes-1 loop
      (h_c[i]*Sr/(fluid_density[i]*Cf[i]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[i]-Tf[i]) = der(Tf[i]) + vel[i]* (Tf[i+1]-Tf[i])/dz;
    end for;
    //Boundary Condition for positive flow from cold to hot.
    (h_c[nodes]*Sr/(fluid_density[nodes]*Cf[nodes]*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[nodes]-Tf[nodes]) = der(Tf[nodes]) + vel[nodes]* (T_inlet_cold-Tf[nodes])/dz;
 end if;

Tf_edge[1]=T_inlet_hot;
Tf_edge[nodes+1]=Tf[nodes];
for i in 2:nodes loop
  Tf_edge[i] = (Tf[i]+Tf[i-1])/2;
end for;

//Rock Energy
for i in 1:nodes loop
    h_c[i]*Sr*(Tr[i]-Tf[i])*dz = -filler_density*Cr*(1-Porosity)*Modelica.Constants.pi*(Radius_Tank^2.0)*dz*der(Tr[i]);
end for;

for i in 1:nodes loop
  z_star[i] = (i-1)*Height_Tank + dz/2; //Should put it at the halfway point of the tank.
end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-84,-100},{104,76}}, fileName=
              "modelica://NHES/Resources/Images/Systems/photo_termocline_test.gif")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"));
end Thermocline_matprops_v3;
