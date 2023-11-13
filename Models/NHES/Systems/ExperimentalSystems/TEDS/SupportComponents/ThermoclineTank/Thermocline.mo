within NHES.Systems.ExperimentalSystems.TEDS.SupportComponents.ThermoclineTank;
model Thermocline
  import TRANSFORM;

//  replaceable package Medium =
//    Modelica.Media.Interfaces.Types "Medium in the component"
//      annotation (choicesAllMatching = true);

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
SI.Temperature Ts = 95+273.15 "K";
SI.DynamicViscosity eta = Medium.dynamicViscosity(mediums[1].state);
SI.ThermalConductivity lambda = Medium.thermalConductivity(mediums[1].state);
SI.Density d_T[nodes]= Medium.density(mediums.state);
SI.Pressure ps[nodes] = fill(1e5,nodes);
Medium.BaseProperties mediums[nodes];

//End attempt to input medium package.

SI.Temperature Tf[nodes] "Fluid Temperature up and down the thermocline";
SI.Temperature Tr[nodes] "Filler Temperature up and down the thermocline";

SI.Density fluid_density=753.75 "Fluid Density Assumed Constant for now kg/m^3"; //First go is to match the paper
parameter SI.Density filler_density = 2630 "Filler Density (Granite)";

SI.SpecificHeatCapacity Cf = 2474.5 "J/kg*K of fluid";
parameter SI.SpecificHeatCapacity Cr = 775.0 "J/kg*K of granite";
SI.ThermalConductivity kf = 0.086 "W/m*K of fluid";
parameter SI.ThermalConductivity kr = 2.8 "W/m*K of filler";

SI.ReynoldsNumber Re "Unitless";
SI.MassFlowRate mf;  //=-128.74 "kg/s";
SI.Velocity vel "meter/s";
SI.CoefficientOfHeatTransfer h_c "W/m^2*K";
SI.PrandtlNumber Pr "Unitless";
SI.Length r_char "hydraulic radius [m]";
parameter SI.Length dr=0.04 "nominal diameter of filler material [m]";
SI.DynamicViscosity mu_f= 1.8e-04 "Pa*s";
SI.Length Sr "Heat Transfer Surface Area of rocks per unit length of tank [m]";
parameter Real fs=3.0 "Surface Shape Factor ,may vary between 2 and 3 
depending rocks packing scheme (default is 3.0)";
parameter SI.Temperature T_inlet_hot = 395+273.15;
parameter SI.Temperature T_inlet_cold = 310+273.15;
//SI.SpecificEnthalpy h_enth[nodes+1];

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

if mf > -0.002 and mf < 0.002 then
  Re = 0.0001; //Simply forces the answer to not be equal to 0
else
  Re = 4*r_char*(abs(mf)/(Porosity*(Radius_Tank^2.0)*Modelica.Constants.pi))/mu_f;
end if;

Pr = Cf*mu_f/kf;

r_char = Porosity*dr/(4.0*(1-Porosity));

h_c = (0.191*abs(mf)*Cf/(Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Re^(-0.278))*(Pr^(-2/3));

Sr = fs*Modelica.Constants.pi*(1-Porosity)*(Radius_Tank^2.0)/(dr/2);

//Fluid Energy
vel = mf/(fluid_density*XS_fluid);

 if mf >= 0 then
    for i in 2:nodes loop

    (h_c*Sr/(fluid_density*Cf*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[i]-Tf[i]) = der(Tf[i]) + vel* (Tf[i]-Tf[i-1])/dz;

    end for;

//Boundary Condition for positive flow from cold to hot.
(h_c*Sr/(fluid_density*Cf*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[1]-Tf[1]) = der(Tf[1]) + vel* (Tf[1]-T_inlet_hot)/dz;

 else

    for i in 1:nodes-1 loop
     // fluid_density*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)*vel*(h_enth[i]-h_enth[i+1]) +
     //   h_c*Sr*(Tr[i]-Tf[i])*dz = fluid_density*Cf*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)*dz*der(Tf[i]);

      //(h_c*Sr/(fluid_density*Cf*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[i]-Tf[i]) = der(Tf[i]) + vel* (Tf_edge[i+1]-Tf_edge[i])/dz;

    (h_c*Sr/(fluid_density*Cf*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[i]-Tf[i]) = der(Tf[i]) + vel* (Tf[i+1]-Tf[i])/dz;

    end for;

    //Boundary Condition for positive flow from cold to hot.
    (h_c*Sr/(fluid_density*Cf*Porosity*Modelica.Constants.pi*(Radius_Tank^2.0)))*(Tr[nodes]-Tf[nodes]) = der(Tf[nodes]) + vel* (T_inlet_cold-Tf[nodes])/dz;

 end if;

Tf_edge[1]=T_inlet_hot;
Tf_edge[nodes+1]=Tf[nodes];
for i in 2:nodes loop
  Tf_edge[i] = (Tf[i]+Tf[i-1])/2;
end for;

//Rock Energy
for i in 1:nodes loop
    h_c*Sr*(Tr[i]-Tf[i])*dz = -filler_density*Cr*(1-Porosity)*Modelica.Constants.pi*(Radius_Tank^2.0)*dz*der(Tr[i]);
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
end Thermocline;
