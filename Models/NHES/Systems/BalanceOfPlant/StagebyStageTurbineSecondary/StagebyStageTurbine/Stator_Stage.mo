within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine;
model Stator_Stage
  "Non-moving deflection structure within a turbine, helping remove more energy from fluid in the rotor stage"
  constant Integer nV=2 "Set # of nodes, at present they are used one for deflection or turbine work and the second is the gap between stages";
  constant Modelica.Units.SI.Acceleration grav=9.81 "gravity";
  constant Real pi = 3.14159 "pi";
  constant Real maxangle = Modelica.Constants.pi/2;

  parameter Boolean isenthalpic = false "Automatically sets Q term such that isentropic conditions occur in the stator region (h_in = h_out).";
  Modelica.Units.SI.MassFlowRate mdot[nV + 1]
    "Mass flow rate edge-wise along the two nedes";
  Modelica.Units.SI.Velocity v_z[nV + 1]
    "Translational velocity edge-wise along the two nodes";
  Modelica.Units.SI.Velocity v_r[nV] "Rotational velocity in each node";
  Modelica.Units.SI.Velocity v_the[nV] "Angular velocity in each node";
  Modelica.Units.SI.Velocity vnet[nV] "Total velocity in each node";
  Modelica.Units.SI.Velocity v_rin "Inlet rotational velocity";
  Modelica.Units.SI.Velocity v_rout "Outlet rotational velocity";
  Modelica.Units.SI.Velocity v_thein "Inlet angular velocity";
  Modelica.Units.SI.Velocity v_theout "Outlet rotational velocity";
  Modelica.Units.SI.Pressure p[nV] "Node pressure";
  Modelica.Units.SI.Pressure pin "Inlet pressure";
  Modelica.Units.SI.Pressure pout "Outlet pressure";
  Modelica.Units.SI.SpecificEnthalpy h[nV] "Node enthalpy";
  Modelica.Units.SI.SpecificEnthalpy hin "Inlet enthalpy";
  Modelica.Units.SI.SpecificEnthalpy hout "Outlet enthalpy";

  Modelica.Units.SI.Power hflow[nV + 1]
    "Enthalpy flow rate across node boundaries";
  Modelica.Units.SI.AngularVelocity omega[nV] "Angular velocity";
  Modelica.Units.SI.Frequency f_fluid[nV] "Angular frequency";
  parameter Modelica.Units.SI.Angle alpha[nV]={pi/4,pi/4}
    "Angular deflection of each node outlet"
    annotation (dialog(group="Geometry"));
  Modelica.Units.SI.Impulse mom[nV] "Momentum in each node";
  Modelica.Units.SI.Force momdot[nV + 1]
    "Rate of momentum flux across node boundaries";
  Modelica.Units.SI.Force radmomdot[nV + 1] "Radial momentum flux";
  Modelica.Units.SI.Force rotmomdot[nV + 1] "Rotational momentum flux";
  Medium.ThermodynamicState states[nV];
  Medium.ThermodynamicState statein;
  Medium.ThermodynamicState stateout;
  Modelica.Units.SI.Density rhoflow[nV + 1]
    "Upstream density flowing across boundaries";
  Modelica.Units.SI.Velocity dv_r[nV] "Change in radial velocity";
  Modelica.Units.SI.Velocity dv_z[nV] "Change in translational velocity";
  Modelica.Units.SI.Velocity dv_the[nV] "Change in rotational velocity";
  parameter Modelica.Units.SI.Area A_flow[nV + 1]=0.1*ones(nV + 1) "Flow area"
    annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length dz[nV]={0.3,0.1} "Axial length"
    annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length dheight[nV]=zeros(nV) "Elevation change"
    annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length ri[nV + 1]=zeros(nV + 1)
    "Inner radius of flow area" annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length ro[nV + 1]={0.18,0.21,0.22}
    "Outer radius of flow area" annotation (dialog(group="Geometry"));
  parameter Real Kfld=0.5 "K_nom + fL/D in turbine"
                                                   annotation(dialog(group = "Geometry"));
  Modelica.Units.SI.Length rave[nV + 1]
    "Calculated mass averaged radius based on constant density and assumption of annulus flow";
  Modelica.Units.SI.Area Amid[nV] "Flow area at midpoint";
  Modelica.Units.SI.Volume Vol[nV] "Node volume";
  Modelica.Units.SI.Mass m[nV] "Node mass";
  Modelica.Units.SI.Velocity mach "Speed of sound";
  Modelica.Units.SI.Force Ff[nV]
    "Wall friction force, currently used as a K = K_nom+fL/d = constant";
  Modelica.Units.SI.Force Fthe[nV] "Angular force";
  Modelica.Units.SI.Force Fr[nV] "Radial force";
  Modelica.Units.SI.Force Fz[nV] "Translational force";
  Modelica.Units.SI.Power q[nV] "Heat conduction/convection";
  Modelica.Units.SI.Power Q[nV] "Total node energy imparted";

  Modelica.Units.SI.SpecificEntropy s[nV] "Node entropy";
  Modelica.Units.SI.Length dr[nV] "Change in flow radius";
  replaceable package Medium = Modelica.Media.Water.StandardWater
  constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init=3000e3 "Initial enthalpy"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate m_init=66.3 "Initial mass flow rate"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.Pressure p_in_init=500000 "Initial inlet pressure"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.Pressure p_out_init=500000 "Initial outlet pressure"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.Velocity v_the_init=0 "Initial rotational velocity"
    annotation (dialog(group="Initialization"));

  parameter Modelica.Units.SI.Velocity v_r_init=0 "Initial radial velocity"
    annotation (dialog(group="Initialization"));

  BaseClasses.FluidFlow Inlet(redeclare replaceable package Medium =
                       Medium) annotation (Placement(transformation(extent={{-112,
            -12},{-92,8}}), iconTransformation(extent={{-118,-22},{-78,18}})));
  BaseClasses.FluidFlow Outlet(redeclare replaceable package Medium =
                                   Medium) annotation (Placement(
        transformation(extent={{86,-10},{106,10}}), iconTransformation(extent=
           {{70,-34},{130,26}})));

initial equation
  //initial equations are complete, and assume that all forces in the system are 0.
  //This may change, but is currently fine as of 3/5/20.
   for i in 1:nV loop
    h[i] = h_init;
    mdot[i+1] = m_init;

    v_the[i] = v_the_init;
    v_r[i] = v_r_init;
    Ff[i] = 0;
  //  states[i] = Medium.setState_phX(p_in_init,h_init,Medium.X_default);
    Fr[i] = 0;
    Fz[i] = -Fthe[i];
   // states[i].d*A_flow[i]*v_z[i] = mdot[i];
   end for;
  // states[2].d*A_flow[nV+1]*v_z[nV+1] = mdot[nV+1];
  // Fthe[1] = v_the_init*m_init*abs(v_the_init)/dz[1];
  // Fthe[nV] = 0;
    pin = p_in_init;
 //   pout = p_out_init;
     p[2] = 0.5*pin+0.5*p_out_init;
 // pout = p_out_init;

equation
  statein= Medium.setState_phX(pin,hin,Inlet.Xi_outflow);
  stateout = Medium.setState_phX(pout,hout,Outlet.Xi_outflow);
  mach = Medium.velocityOfSound(states[1]);
  for i in 1:nV loop

    //Calculation for inner geometry, fluid state tracking variable.
    dr[i] = rave[i+1]-rave[i];
    states[i] = Medium.setState_phX(p[i],h[i],Medium.X_default);
    s[i] = Medium.specificEntropy(states[i]);
    Amid[i]*2 = A_flow[i+1]+A_flow[i];
    Vol[i] = Amid[i]*dz[i];
    mom[i] = mdot[i]*v_z[i+1];
    m[i] =Vol[i]*states[i].d;
    v_the[i] = rave[i]*omega[i];
    f_fluid[i] = omega[i]/(2*pi);
    //Current assumption. Heat flow between the fluid and the turbine stages could be added. At present we'll assume thermal equilibrium.
    q[i] =0;
    //Power on the fluid is the sum of all forces dotted with their respective velocities plus heat

    vnet[i]*vnet[i] = (v_r[i]*v_r[i]+v_the[i]*v_the[i]+v_z[i+1]*v_z[i+1]);
    //Calcultion of all forces is delayed slightly using the derivative term. The goal is to give slightly smoother behavior to simulations.
    //Radial force is calculated as the amount required to cause the center of mass to move so that the density profile is even.
    der(Fr[i]) = mdot[i+1]*(dr[i]/dz[i]*v_z[i+1]-v_r[i])*abs(dr[i]/dz[i]*v_z[i+1]-v_r[i])/dz[i];
    //If statement ensures that no by-zero division occurs
    if
      (alpha[i]>0.0 or alpha[i]<0.0) then
      //Angular force of deflection is rho*A*(delv^2), the derivative could then be construed as mdot (rho*Vol/time)*(delv)^2/distance.
    der(Fthe[i]) = mdot[i+1]*(tan(alpha[i])*v_z[i+1]-v_the[i])*abs(tan(alpha[i])*v_z[i+1]-v_the[i])/dz[i];
      //Looking at the force vector, as it is perpendicular to the stator/vane, then using the angular dependency we obtain the value below.
    der(Fz[i]) = -der(Fthe[i])/tan(alpha[i]);
      else
        //Neither force should exist if there's no deflection.
      der(Fthe[i]) = -Fthe[i];
      der(Fz[i]) = -Fz[i];
    end if;
    der(Ff[i]) = (0.5*states[i].d*v_z[i+1]*abs(v_z[i])*Kfld-Ff[i])/0.01;

  end for;
  for i in 1:nV+1 loop
    v_z[i]*A_flow[i]*rhoflow[i] = mdot[i];
    momdot[i] = abs(v_z[i])*mdot[i];
    rave[i] = 0.75*(ro[i]^4-ri[i]^4)/(ro[i]^3-ri[i]^3);
  end for;
  if isenthalpic then
  der(Q[1]) = (hin-h[1])*mdot[1]/0.01;
  der(Q[2]) = (h[1]-h[2])*mdot[2]/0.01;
  else
    for i in 1:nV loop
      Q[i] = Fr[i]*abs(dv_r[i]) + Fthe[i]*abs(dv_the[i]) + q[i] + Fz[i]*abs(dv_z[i]);
    end for;
  end if;

//Now unused assumptions.
   // if(i == nV) then
  //  if conserve_kinetic then
   //  mdot[3]*vnet[2]*vnet[2]=mdot[2]*vnet[1]*vnet[1];
   // elseif isobaric then
  //    pout= p[2];
   // elseif isentropic then
   //   s[2] = s[1];
  //  elseif isenthalpic then
  //  der(Fz[i]) = -0.90*(h[i]-h[i-1])*m[i]*mach/dz[i]/dz[i];
  //  else
 //   if(alpha[i]>0 or alpha[i]<0) then
 //     Fz[i] = -abs(Fthe[i]/tan(alpha[i]));
 //   end if;
 //   else
//
 //   der(Fz[i]) = 0;
 //   end if;

  //5 conservation equations, for mass, energy, and a velocity equation for each of rotational, radial, and translational speeds
  //Node 1//
  der(m[1]) + mdot[2]-mdot[1] = 0;
  m[1]*der(Medium.specificInternalEnergy(states[1])) + hflow[2]-hflow[1] = -p[1]*Vol[1]*(v_z[2]-v_z[1])/dz[1] - v_z[2]*Ff[1]+Q[1];
  //m[1]*der(v_z[2]) + momdot[2]-momdot[1] + Amid[1]*((p[2]-p[1])+states[1].d*grav*dheight[1])/dz[1] = -Ff[1]+Fz[1];
  m[1]*der(v_z[2]) + momdot[2]-momdot[1]+A_flow[2]*p[2]-A_flow[1]*p[1] = -Ff[1]+Fz[1];
  m[1]*der(v_r[1]) + radmomdot[2] - radmomdot[1] = Fr[1];
  m[1]*der(v_the[1]) + rotmomdot[2]-rotmomdot[1] = Fthe[1];

  //Node 2//
  der(m[2])  + mdot[3]-mdot[2] = 0;
  m[2]*der(Medium.specificInternalEnergy(states[2]))  + hflow[3]-hflow[2] =-p[2]*Vol[2]*(v_z[3]-v_z[2])/dz[2] - v_z[3]*Ff[2]+Q[2];
  m[2]*der(v_z[3]) + momdot[3]-momdot[2]+A_flow[3]*pout-A_flow[2]*p[2]=-Ff[2]+Fz[2];// + Ff[2] = Fz[2];
  m[2]*der(v_r[2]) + radmomdot[3]-radmomdot[2] = Fr[2];
  m[2]*der(v_the[2]) + rotmomdot[3]-rotmomdot[2] = Fthe[2];

  //Those equations ignore intrafluid friction terms that certainly exist, but are impossible to use without radial and angular discretization.
 //boundary conditions//
  dv_r[1] = semiLinear(
      BaseClasses.NZer(v_z[1]),
      v_r[1] - v_rin,
      v_r[1] - v_r[2]);
  dv_r[2] = semiLinear(
      BaseClasses.NZer(v_z[2]),
      v_r[2] - v_r[1],
      v_r[2] - v_rout);
  dv_z[1] = v_z[2]-v_z[1];
  dv_z[2] = v_z[3]-v_z[2];
  dv_the[1] = semiLinear(
      BaseClasses.NZer(v_z[1]),
      v_the[1] - v_thein,
      v_the[1] - v_the[2]);
  dv_the[2] = semiLinear(
      BaseClasses.NZer(v_z[2]),
      v_the[2] - v_the[1],
      v_the[2] - v_theout);

  //semiLinear function takes care of donor directions. Note that in rhoflow[], the second value must be negative to ensure that
  //the donor density is always >0 across the boundaries (what does -2kg/m^3 mean?)
  hflow[1] = semiLinear(mdot[1],hin,h[1]);
  //hflow[1] = semiLinear(mdot[1],Medium.specificInternalEnergy(statein),Medium.specificInternalEnergy(states[1]));
  radmomdot[1] = semiLinear(mdot[1],v_rin,v_r[1]);
  rotmomdot[1] = semiLinear(mdot[1],v_thein,v_the[1]);
  rhoflow[1] = semiLinear(
      BaseClasses.NZer(v_z[1]),
      Medium.density(Medium.setState_phX(
        pin,
        hin,
        Medium.X_default)),
      -states[1].d);
  //interface-by-interface enthalpy flow calculations.
  hflow[2] = semiLinear(mdot[2],h[1],h[2]);
  //hflow[2] = semiLinear(mdot[2],Medium.specificInternalEnergy(states[1]),Medium.specificInternalEnergy(states[2]));
  radmomdot[2] = semiLinear(mdot[2],v_r[1],v_r[2]);
  rotmomdot[2] = semiLinear(mdot[2],v_the[1],v_the[2]);
  rhoflow[2] = semiLinear(
      BaseClasses.NZer(v_z[2]),
      states[1].d,
      -states[2].d);
  hflow[3] = semiLinear(mdot[3],h[2],hout);
 // hflow[3] = semiLinear(mdot[3],Medium.specificInternalEnergy(states[2]),Medium.specificInternalEnergy(stateout));
  radmomdot[3] = semiLinear(mdot[3],v_r[2],v_rout);
  rotmomdot[3] = semiLinear(mdot[3],v_the[2],v_theout);
  rhoflow[3] = semiLinear(
      BaseClasses.NZer(v_z[3]),
      states[2].d,
      -Medium.density(Medium.setState_phX(
        pout,
        hout,
        Medium.X_default)));

  //Connections to the inlet and outlet nodes.
  hout = states[2].h;
  v_theout = v_the[2];
  v_rout = v_r[2];
  p[1] = pin;

  hin=inStream(Inlet.h_outflow);

  Inlet.h_outflow = hin;
    Inlet.p = p[1];
  Inlet.m_flow = mdot[1];
  v_rin = Inlet.v_r;
  inStream(Inlet.v_r) = v_rin;
  Inlet.v_theta = v_thein;
  inStream(Inlet.v_theta) = v_thein;
  pout = Outlet.p;
  hout = Outlet.h_outflow;
    Outlet.m_flow + mdot[3]=0;
  Outlet.v_r = v_rout;
  Outlet.v_theta = v_theout;

  Inlet.Xi_outflow = inStream(Outlet.Xi_outflow);
  Inlet.C_outflow = inStream(Outlet.C_outflow);
  Outlet.Xi_outflow = inStream(Inlet.Xi_outflow);
  Outlet.Xi_outflow = inStream(Inlet.C_outflow);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{40,-40},{48,-26},{40,-6},{100,-6},{100,-40},{40,-40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-40},{40,-40},{48,-26},{42,-10},{28,-10},{36,-24},{30,-40}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-40},{30,-40},{36,-24},{26,-6},{-100,-6},{-100,-40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,40},{30,40},{36,24},{26,6},{-100,6},{-100,40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,40},{40,40},{48,26},{42,10},{28,10},{36,24},{30,40}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,40},{48,26},{40,6},{100,6},{100,40},{40,40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,40},{100,40},{100,52},{-100,44},{-100,40}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-40},{100,-40},{100,-52},{-100,-44},{-100,-40}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,6},{100,-6}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-66,42},{-18,4}},
          lineColor={0,0,0},
          textString="1"),
        Text(
          extent={{46,40},{94,2}},
          lineColor={0,0,0},
          textString="2")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The stator stage of a turbine is a deflection stage. Fluid enters the stage and is deflected to rotate around the axis of translation in order to impinge upon turbine blades in the next stage. This model contains 2 fluid nodes and 2 fluid flow ports. The fluid deflection is considered to happen between the first and second nodes. </p>
<p>The key parameter in stator and rotor stage components is alpha. The alpha values are the designed deflection angles within the model. NOTE: These have so far been used in a [x, 0] format. An alpha value of 0 indicates that there is no deflection on that node. The deflection is assumed to occur at the end of the node that is indicated. </p>
<p>The fluid velocity derivatives are dependent on the translational, rotational, and radial forces exerted either by the fluid or on the fluid. Each velocity essentially follows the same equation: </p>
<p><span style=\"font-family: Calibri; font-size: 11pt;\"><img src=\"file:///C:/Users/MIKKDM/AppData/Local/Temp/3/msohtmlclip1/01/clip_image002.png\"/></span> </p>
<p>The radial force is taken as an internal expansion force of the fluid to move the center of the mass flow while the fluid flows from node 1 to node 2. The center of mass is taken assuming a constant density and internal and external radius values. </p>
<p>The resulting force in the axial and rotational directions is due to the structure of the stator stage of the turbine machine. The force has two components, each acting in the direction of rotation or translation. The model is centered around the <b>rotation </b>of the fluid. Thus, the stator stage is assumed to deflect the rotation of the fluid to a certain design angle alpha. </p>
<p><span style=\"font-family: Calibri; font-size: 11pt;\"><img src=\"file:///C:/Users/MIKKDM/AppData/Local/Temp/3/msohtmlclip1/01/clip_image004.png\"/></span> </p>
<p>The energy content removed from the fluid, which impacts the calculated enthalpy, in the stator stage is the sum of the force vectors dotted with the velocity (which results in the component forces multiplied by the change in the velocities). </p>
</html>"));
end Stator_Stage;
