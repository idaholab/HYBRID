within NHES;
package VN_tests
  model Trial_Cooling

    Boolean toggleNoise = true;
    parameter SI.Area A_surface = 0.10;
    SI.Temperature T_lump;
    parameter SI.SpecificHeatCapacity cp = 1.2;
    parameter SI.Mass mass = 100;
    parameter SI.CoefficientOfHeatTransfer h = 0.100;
    parameter SI.Temperature Tstart = 90+273.15;

    SI.Temperature T_ambient=TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(25)+10*Modelica.Math.sin(time/(24*60*60)*2*Modelica.Constants.pi);
    SI.Temperature T_effective;

    Modelica.Blocks.Noise.UniformNoise uniformNoise(
      samplePeriod=24*60,
      y_min=0,
      y_max=20);

  initial equation
    T_lump = Tstart;

  equation
    der(T_lump)*cp*mass = h*A_surface*(T_effective-T_lump);

    if toggleNoise then
      T_effective = T_ambient + uniformNoise.y;
    else
      T_effective = T_ambient;
    end if;

    annotation (experiment(StopTime=172800, __Dymola_Algorithm="Dassl"));
  end Trial_Cooling;

  model Bateman_Equations
    parameter Integer n=4;

    parameter Real[n] lambdas(unit="1/s") = {0.01,0.05,0.05,0.01} "Decay constant for isotope i";
    parameter Real[n] sigmas(unit="m2") = {0.4,0.3,0.2,0.1} "Yield cross-section for isotope i generation";
    parameter Real phi = 1 "Flux";
    parameter Real[n] Ns_start = {500,100,300,200} "Initial number of atoms for isotope i";
    Real[n] Nbs(start=Ns_start) "Sources and sinks for isotope i";
    //Real[n] Ns(start=Ns_start) "Atoms of isotope i";

  equation

      der(Nbs[1])=phi*sigmas[1]-lambdas[1]*Nbs[1];

    for i in 2:n loop
      der(Nbs[i]) = phi*sigmas[i]-lambdas[i]*Nbs[i]+lambdas[i-1]*Nbs[i-1];
    end for;


    annotation (experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
  end Bateman_Equations;

  model AlienvsPredator

  parameter Real alpha=0.1 "Prey Population Growth";
  parameter Real Beta=0.02 "predation";
  parameter Real delta=0.02 "predator growth";
  parameter Real gamma=0.4 "predator death";
  Real x(start=xstart) "Prey (Aliens)";
  Real y(start=ystart) "Predator";

  parameter Real xstart=10;
  parameter Real ystart= 10;

  Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  equation
    der(x) = alpha*x-Beta*x*y+u;
    der(y) = delta*x*y - gamma*y;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AlienvsPredator;

  model Sums



    Modelica.Blocks.Sources.Sine sine(f=1)
      annotation (Placement(transformation(extent={{-76,46},{-56,66}})));
    Modelica.Blocks.Sources.Sine sine1(f=1/10)
      annotation (Placement(transformation(extent={{-78,-2},{-58,18}})));
    Modelica.Blocks.Sources.Sine sine2(f=1/100)
      annotation (Placement(transformation(extent={{-78,-56},{-58,-36}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=3)
      annotation (Placement(transformation(extent={{-22,2},{-10,14}})));
    AlienvsPredator alienvsPredator
      annotation (Placement(transformation(extent={{36,-2},{56,18}})));
  equation
    connect(sine2.y, multiSum.u[1]) annotation (Line(points={{-57,-46},{-26,-46},
            {-26,6.6},{-22,6.6}}, color={0,0,127}));
    connect(sine1.y, multiSum.u[2])
      annotation (Line(points={{-57,8},{-22,8}}, color={0,0,127}));
    connect(sine.y, multiSum.u[3]) annotation (Line(points={{-55,56},{-26,56},{
            -26,9.4},{-22,9.4}}, color={0,0,127}));
    connect(multiSum.y, alienvsPredator.u)
      annotation (Line(points={{-8.98,8},{34,8}}, color={0,0,127}));
  end Sums;

  model Logic

    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-18,-28},{2,-8}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{24,8},{44,28}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-68,-28},{-48,-8}})));
    Modelica.Blocks.Logical.Pre pre1
      annotation (Placement(transformation(extent={{-68,-62},{-48,-42}})));
    Modelica.Blocks.Sources.BooleanTable booleanTable(
      table={0,0,1,1,0,0,1,1,0,0,1,1},
      startTime=0,
      shiftTime=1)
      annotation (Placement(transformation(extent={{-100,8},{-80,28}})));
    Modelica.Blocks.Sources.BooleanTable booleanTable1(
      table={0,0,0,1,1,1,0,0,0,1,1,1},
      startTime=0,
      shiftTime=1)
      annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
  equation
    connect(booleanTable.y, or1.u1)
      annotation (Line(points={{-79,18},{22,18}}, color={255,0,255}));
    connect(booleanTable1.y, not1.u)
      annotation (Line(points={{-79,-18},{-70,-18}}, color={255,0,255}));
    connect(not1.y, and1.u1)
      annotation (Line(points={{-47,-18},{-20,-18}}, color={255,0,255}));
    connect(and1.y, or1.u2) annotation (Line(points={{3,-18},{14,-18},{14,10},{
            22,10}}, color={255,0,255}));
    connect(or1.y, pre1.u) annotation (Line(points={{45,18},{58,18},{58,-90},{
            -90,-90},{-90,-52},{-70,-52}}, color={255,0,255}));
    connect(pre1.y, and1.u2) annotation (Line(points={{-47,-52},{-28,-52},{-28,
            -26},{-20,-26}}, color={255,0,255}));
    annotation (experiment(StopTime=12, __Dymola_Algorithm="Dassl"));
  end Logic;
end VN_tests;
