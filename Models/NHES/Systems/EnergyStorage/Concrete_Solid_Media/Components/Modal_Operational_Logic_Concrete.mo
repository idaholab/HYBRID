within NHES.Systems.EnergyStorage.Concrete_Solid_Media.Components;
block Modal_Operational_Logic_Concrete
  "Linear transfer function with evaluation threshold"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Power Q_nom=53.5e6;
  parameter Modelica.Units.SI.Time Ti_Charge=1;
  parameter Modelica.Units.SI.Time Ti_Discharge=1;
  parameter Modelica.Units.SI.Time Ti_Feed=1;
  Modelica.Blocks.Interfaces.RealInput Demand "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Power "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-142,-60},{-102,-20}})));
  Modelica.Blocks.Interfaces.RealOutput DFV_Demand
                                            "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-50},{138,-12}}),
        iconTransformation(extent={{100,-48},{138,-10}})));

  Modelica.Blocks.Interfaces.BooleanOutput
                                        Discharge
                                            "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-84},{138,-46}}),
        iconTransformation(extent={{100,-86},{138,-48}})));
  Modelica.Blocks.Interfaces.RealOutput DFV_Power
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{198,18},{236,56}}), iconTransformation(
        extent={{19,-19},{-19,19}},
        rotation=90,
        origin={-1,-119})));
initial equation
  DFV_Power = 0;

  DFV_Demand = 0;

equation
  if
    (Demand > Q_nom) then

    Discharge = true;

    Ti_Discharge*der(DFV_Demand) = Demand - DFV_Demand;
     Ti_Discharge*der(DFV_Power) = Power -DFV_Power;
  else
    Discharge = false;
    Ti_Discharge*der(DFV_Demand) = -DFV_Demand;
   Ti_Discharge*der(DFV_Power) = -DFV_Power;
  end if;

  annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
end Modal_Operational_Logic_Concrete;
