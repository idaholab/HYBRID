within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine;
model Rotor_Stage
  "For most variable comments, see Stator_Stage. This stage is the power producing stage wherein the turbine blades rotate based on the energy impinged by the flowing fluid"
  constant Integer nV=2;
  constant Modelica.Units.SI.Acceleration grav=9.81;
  constant Real pi = 3.14159;
  parameter Modelica.Units.SI.MassFlowRate m_flow_nom=60;
  Modelica.Units.SI.Angle defl[nV];
  Modelica.Units.SI.MassFlowRate mdot[nV + 1];
  Modelica.Units.SI.Velocity v_z[nV + 1];
  Modelica.Units.SI.Velocity v_r[nV];
  Modelica.Units.SI.Velocity v_the[nV];
  Modelica.Units.SI.Velocity vnet[nV + 1];
  Modelica.Units.SI.Velocity v_rin;
  Modelica.Units.SI.Velocity v_rout;
  Modelica.Units.SI.Velocity v_thein;
  Modelica.Units.SI.Velocity v_theout;
  Modelica.Units.SI.Pressure p[nV];
  constant Modelica.Units.SI.Angle maxangle=-Modelica.Constants.pi/2;
  Modelica.Units.SI.Pressure pin;
  Modelica.Units.SI.Pressure pout;
  Modelica.Units.SI.SpecificEnthalpy h[nV];
  Modelica.Units.SI.SpecificEnthalpy hin;
  Modelica.Units.SI.SpecificEnthalpy hout;

  Modelica.Units.SI.Power hflow[nV + 1];
  Modelica.Units.SI.AngularVelocity omega[nV];
  Modelica.Units.SI.Frequency f_fluid[nV];
  parameter Modelica.Units.SI.Angle alpha[nV]={pi/4,pi/4}
    annotation (dialog(group="Geometry"));
//  stream Modelica.SIunits.SpecificEnthalpy hin;
  Modelica.Units.SI.Impulse mom[nV];
  Modelica.Units.SI.Force momdot[nV + 1];
  Modelica.Units.SI.Force radmomdot[nV + 1];
  Modelica.Units.SI.Force rotmomdot[nV + 1];
  Medium.ThermodynamicState states[nV];
  Modelica.Units.SI.Density rhoflow[nV + 1];
  Modelica.Units.SI.Velocity dv_r[nV] "Change in radial velocity";
  Modelica.Units.SI.Velocity dv_z[nV] "Change in translational velocity";
  Modelica.Units.SI.Velocity dv_the[nV] "Change in rotational velocity";
  parameter Modelica.Units.SI.Area A_flow[nV + 1]=0.1*ones(nV + 1) "Flow areas"
    annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length dz[nV]={0.3,0.1} "Axial length"
    annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length dheight[nV]=zeros(nV) "Height difference"
    annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length ri[nV + 1]=zeros(nV + 1) "Inner radii"
    annotation (dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length ro[nV + 1]={0.21,0.21,0.21} "Outer radii"
    annotation (dialog(group="Geometry"));
  //parameter Modelica.SIunits.Area Asurf annotation(dialog(group = "Geometry"));
  Modelica.Units.SI.Length rave[nV + 1];
  Modelica.Units.SI.Torque tau;
  Modelica.Units.SI.Velocity Turb_speed "Linear rotational velocity of turbine blades";
  Modelica.Units.SI.Area Amid[nV];
  Modelica.Units.SI.Volume Vol[nV];
  Modelica.Units.SI.Mass m[nV];

  Modelica.Units.SI.Force Ff[nV];
  Modelica.Units.SI.Force Fthe[nV];
  Modelica.Units.SI.Force Fr[nV];
  Modelica.Units.SI.Force Fz[nV];
  Modelica.Units.SI.Power q[nV];
  Modelica.Units.SI.Power Q[nV];
  Modelica.Units.SI.Velocity vturbexit;
  Modelica.Units.SI.SpecificEntropy s[nV];
  Modelica.Units.SI.Length dr[nV];
  Modelica.Units.SI.MomentOfInertia I[nV];
  replaceable package Medium = Modelica.Media.Water.StandardWater
  constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init=3000e3 "Initial enthalpy"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate m_init=66.3 "Initial mass flow rate"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.Pressure p_in_init=500000 "Initial inlet pressure"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.Pressure p_init=0 "If=0, take outlet pressure and inlet pressure";
  parameter Modelica.Units.SI.Velocity v_the_init=0 "Initial rotational velocity"
    annotation (dialog(group="Initialization"));
  parameter Modelica.Units.SI.Velocity v_r_init=0 "Initial radial velocity"
    annotation (dialog(group="Initialization"));
  Medium.ThermodynamicState statein;
  Medium.ThermodynamicState stateout;
  Modelica.Units.SI.Power Mech_Q;
  Modelica.Units.SI.Torque tau2;
//  Modelica.SIunits.Power Mech_Q2;

  BaseClasses.FluidFlow Inlet(redeclare replaceable package Medium =
                       Medium) annotation (Placement(transformation(extent={{-112,
            -12},{-92,8}}), iconTransformation(extent={{-118,-22},{-78,18}})));
  BaseClasses.FluidFlow Outlet(redeclare replaceable package Medium =
                                   Medium) annotation (Placement(
        transformation(extent={{86,-10},{106,10}}), iconTransformation(extent=
           {{68,-30},{128,30}})));

  BaseClasses.Torque torque annotation (Placement(
        transformation(extent={{-44,36},{-24,56}}), iconTransformation(extent=
           {{-44,36},{-24,56}})));
initial equation
  for i in 1:nV loop
    h[i] = h_init;
    mdot[i+1] = m_init;
  //  p[i] = p_init;
    v_the[i] = v_the_init;
    v_r[i] = v_r_init;
    Ff[i] = 0;
  //  Fthe[i] = 0;
    Fr[i] = 0;
    Fz[i] = 0;
    defl[i] = alpha[i];
  end for;
     Fthe[1] = v_the_init*m_init*abs(v_the_init)/dz[1];
   Fthe[nV] = 0;
   if
     (p_init == 0) then
  p[1] = p_in_init;
  p[2] = 0.5*(p[1]+pout);
   else
     p[1] = p_init;
     p[2] = p_init;
   end if;
equation
    statein=Medium.setState_phX(Inlet.p,Inlet.h_outflow,Inlet.Xi_outflow);
  stateout = Medium.setState_phX(Outlet.p,Outlet.h_outflow,Outlet.Xi_outflow);
  torque.tau + tau2 = 0;
//  Mech_Q2 = tau2*(v_thein-v_the[1])/rave[1];
  sqrt(torque.w*torque.w+0.00001)*tau2 = mdot[1]*(hin-h[1])-Ff[1]*v_z[1];
  torque.w*rave[1] - Turb_speed=0;
  vturbexit = Turb_speed+v_z[2]*tan(defl[1]);
  tau = -rave[1]*Fthe[1];
  for i in 1:nV loop

    if
      (alpha[i]>0.0 or alpha[i]<0.0) then
     // der(defl[i]) = ((ksq*((mdot[1]-m_flow_nom)/m_flow_nom*abs((mdot[1]-m_flow_nom)/m_flow_nom)) + klin*(mdot[1]-m_flow_nom)/m_flow_nom
     //  + ktanh*(-1*tanh(2*(mdot[1]-m_flow_nom)/m_flow_nom)))*(maxangle-alpha[i])+alpha[i]-defl[i])/(5);
   //  der(defl[i]) = ((Mech_Q-mdot[1]*ref_Eperkg)/ref_Eperkg*(maxangle-alpha[i])+alpha[i]-defl[i])/1000;
   // der(defl[i]) = (atan((mdot[1]-m_flow_nom)/m_flow_nom)^2*(maxangle-alpha[i]) + alpha[i])/5;
    der(defl[i]) = (((0.073492*((mdot[1]-m_flow_nom)/m_flow_nom)^2-1.01591*(mdot[1]-m_flow_nom)/m_flow_nom)*(maxangle-alpha[i])+alpha[i])-defl[i])/10;
    der(Fthe[i]) = -mdot[i]*(v_the[i]-vturbexit)*abs(v_z[i+1])/dz[i];
    der(Fz[i]) = 0;
    else
      defl[i] = 0;
      der(Fthe[i]) = 0;
      der(Fz[i]) = 0;
    end if;
  end for;
  Mech_Q = mdot[3]*(hin-h[1]);
  der(Q[2]) = (h[1]-h[2])*mdot[2]/0.01;
    Q[1] = Fr[1]*abs(dv_r[1]) + Fthe[1]*abs(dv_the[1]) + q[1] + Fz[1]*abs(dv_z[1]);
   for i in 1:nV loop
    I[i] = states[i].d*2*pi*dz[i]*(ro[i]^4-ri[i]^4)/4;
    dr[i] = rave[i+1]-rave[i];
    Amid[i]*2 = A_flow[i+1]+A_flow[i];
    Vol[i] = Amid[i]*dz[i];
  //Q[i] = Fr[i]*abs(dv_r[i]) + Fthe[i]*abs(dv_the[i]) + q[i]+Fz[i]*abs(dv_z[i]);
    der(Fr[i]) = mdot[i+1]*(dr[i]/dz[i]*v_z[i+1]-v_r[i])*abs(dr[i]/dz[i]*v_z[i+1]-v_r[i])/dz[i];
    //der(Fr[i]) =0;
    der(Ff[i]) = (0.5*states[i].d*v_z[i+1]*abs(v_z[i])*0.00-Ff[i])/0.01;
    states[i] = Medium.setState_phX(p[i],h[i],Medium.X_default);
    q[i] =0;
    mom[i] = mdot[i]*v_z[i+1];
    m[i] =Vol[i]*states[i].d;
    v_the[i] = rave[i]*omega[i];
    f_fluid[i] = omega[i]/(2*pi);
    s[i] = Medium.specificEntropy(states[i]);
  end for;
  //5 conservation equations, for mass, energy, and a velocity equation for each of rotational, radial, and translational speeds
  //Node 1//
  der(m[1]) + mdot[2]-mdot[1] = 0;
  m[1]*der(Medium.specificInternalEnergy(states[1])) + hflow[2]-hflow[1] = -p[1]*Vol[1]*(v_z[2]-v_z[1])/dz[1] - v_z[2]*Ff[1]+Q[1];
  //m[1]*der(v_z[2]) + momdot[2]-momdot[1] + Amid[1]*((p[2]-p[1])+states[1].d*grav*dheight[1])/dz[1] = -Ff[1]+Fz[1];
  m[1]*der(v_z[2]) + momdot[2]-momdot[1] + A_flow[2]*p[2]-A_flow[1]*p[1] = -Ff[1]+Fz[1];
  m[1]*der(v_r[1]) + radmomdot[2] - radmomdot[1] = Fr[1];
  m[1]*der(v_the[1]) + rotmomdot[2]-rotmomdot[1] = Fthe[1];

  //Node 2//
  der(m[2])  + mdot[3]-mdot[2] = 0;
  m[2]*der(Medium.specificInternalEnergy(states[2]))  + hflow[3]-hflow[2] =-p[2]*Vol[2]*(v_z[3]-v_z[2])/dz[2] - v_z[3]*Ff[2]+Q[2];
  m[2]*der(v_z[3]) + momdot[3]-momdot[2]+A_flow[3]*pout-A_flow[2]*p[2]=-Ff[2]+Fz[2];// + Ff[2] = Fz[2];
  m[2]*der(v_r[2]) + radmomdot[3]-radmomdot[2] = Fr[2];
  m[2]*der(v_the[2]) + rotmomdot[3]-rotmomdot[2] = Fthe[2];

 //boundary conditions//

//  mtap = 0;

  for i in 1:nV+1 loop
    v_z[i]*A_flow[i]*rhoflow[i] = mdot[i];
    momdot[i] = abs(v_z[i])*mdot[i];
    rave[i] = 0.75*(ro[i]^4-ri[i]^4)/(ro[i]^3-ri[i]^3);
  end for;
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
  //semiLinear should take care of the donor directions.
  hflow[1] = semiLinear(mdot[1],hin,h[1]);
  radmomdot[1] = semiLinear(mdot[1],v_rin,v_r[1]);
  rotmomdot[1] = semiLinear(mdot[1],v_thein,v_the[1]);
  rhoflow[1] = semiLinear(v_z[1]/(sqrt(v_z[1]*v_z[1]+0.00001)),Medium.density(Medium.setState_phX(pin,hin,Medium.X_default)),-states[1].d);
  //interface-by-interface enthalpy flow calculations.
  hflow[2] = semiLinear(mdot[2],h[1],h[2]);
  radmomdot[2] = semiLinear(mdot[2],v_r[1],v_r[2]);
  rotmomdot[2] = semiLinear(mdot[2],v_the[1],v_the[2]);
  rhoflow[2] = semiLinear(v_z[2]/sqrt((v_z[2]*v_z[2]+0.00001)),states[1].d,-states[2].d);

  //min = mdot[1];
  hflow[3] = semiLinear(mdot[3],h[2],hout);
  radmomdot[3] = semiLinear(mdot[3],v_r[2],v_rout);
  rotmomdot[3] = semiLinear(mdot[3],v_the[2],v_theout);
  rhoflow[3] = semiLinear(v_z[3]/sqrt((v_z[3]*v_z[3]+0.00001)),states[2].d,-Medium.density(Medium.setState_phX(pout,hout,Medium.X_default)));
  //v_rin = 0;
 // v_thein = 0;
  //pout = 500000;
//  hin = 3000e3;
  //mdot[1] = 66.3;
  vnet[1]*vnet[1] = semiLinear(
      BaseClasses.NZer(v_z[1]),
      v_rin,
      v_r[1])^2 + semiLinear(
      BaseClasses.NZer(v_z[1]),
      v_thein,
      v_the[1])^2 + v_z[1]*v_z[1];
  vnet[2]*vnet[2] = semiLinear(
      BaseClasses.NZer(v_z[2]),
      v_r[1],
      v_r[2])^2 + semiLinear(
      BaseClasses.NZer(v_z[2]),
      v_the[1],
      v_the[2])^2 + v_z[2]*v_z[2];
  vnet[3]*vnet[3] = semiLinear(
      BaseClasses.NZer(v_z[3]),
      v_r[2],
      v_rout)^2 + semiLinear(
      BaseClasses.NZer(v_z[2]),
      v_the[2],
      v_theout)^2 + v_z[3]*v_z[3];
  hout = states[2].h;
  v_theout = v_the[2];
  v_rout = v_r[2];
  p[1] = pin;
  //mdot[3] + Outlet.m_flow = 0;

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
          points={{-32,-40},{-22,-22},{-28,-6},{100,-6},{100,-40},{-32,-40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-36},{-30,-36},{-22,-22},{-28,-6},{-42,-6},{-34,-20},{-40,
              -36}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-40},{-42,-40},{-34,-20},{-42,-6},{-100,-6},{-100,-40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,40},{-40,40},{-32,20},{-40,6},{-100,6},{-100,40}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-38,36},{-28,36},{-20,22},{-26,6},{-40,6},{-32,20},{-38,36}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,40},{-20,22},{-26,6},{100,6},{100,40},{-30,40}},
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
          extent={{-86,42},{-38,4}},
          lineColor={0,0,0},
          textString="1"),
        Text(
          extent={{16,40},{64,2}},
          lineColor={0,0,0},
          textString="2")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The rotor stage is similar to the stator stage in structure. 2 fluid nodes calculate fluid properties, and two fluid ports connect to other parts of the turbine. A torque port is also present on the rotor stage to account for the energy removed from the fluid and applied to the turbine. </p>
<p>The primary difference between the rotor stage and the stator stage is that there is a viscosity approximation that impacts the resulting angle of rotational deflection. Considering the no-slip condition, there are 2 physical phenomena that impact that actual resulting rotation of the fluid as it flows through the turbine stages. The first is a contact force between the fluid as it impinges upon the blades of the turbine. The second force is the internal viscous forces that propagates much of this contact force through the remainder of the fluid. This is not an instantaneous action and is impacted then by the speed of the fluid. As such, there is a quadratic correction equation introduced into the rotor stage. The coefficients thus far have been estimated by investigating the impact that reducing turbine velocity has on the relative rotational speed of the turbine and the fluid. The biggest takeaway from this is: the fluid speed should be kept at near-nominal values where possible to continue to maintain confidence in results. Future care could be taken to obtain a generalized equation for this change in angular deflection. </p>
</html>"));
end Rotor_Stage;
