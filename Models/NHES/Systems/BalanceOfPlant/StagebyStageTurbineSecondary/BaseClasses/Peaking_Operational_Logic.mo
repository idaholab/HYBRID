within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.BaseClasses;
block Peaking_Operational_Logic
  "Linear transfer function with evaluation threshold"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Power Q_nom=53.5e6;
  parameter Modelica.Units.SI.Time Ti_Charge=1;
  parameter Modelica.Units.SI.Time Ti_Discharge=1;
  parameter Modelica.Units.SI.Time Ti_Feed=1;
  Modelica.Blocks.Interfaces.RealInput Demand "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput TBV_Demand
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{100,26},{138,64}}),  iconTransformation(extent={{100,26},{
            138,64}})));
  Modelica.Blocks.Interfaces.RealInput Power "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-142,-60},{-102,-20}})));
  Modelica.Blocks.Interfaces.RealOutput DFV_Demand
                                            "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-50},{138,-12}}),
        iconTransformation(extent={{100,-48},{138,-10}})));

  Modelica.Blocks.Interfaces.BooleanOutput
                                        Charge
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{100,-8},{138,30}}),  iconTransformation(extent={{100,-12},{138,
            26}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        Discharge
                                            "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-84},{138,-46}}),
        iconTransformation(extent={{100,-86},{138,-48}})));
  Modelica.Blocks.Interfaces.RealOutput TBV_Power
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{100,64},{138,102}}),iconTransformation(
        extent={{-19,-19},{19,19}},
        rotation=90,
        origin={-1,119})));
  Modelica.Blocks.Interfaces.RealOutput DFV_Power
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{198,18},{236,56}}), iconTransformation(
        extent={{19,-19},{-19,19}},
        rotation=90,
        origin={-1,-119})));
  Modelica.Blocks.Interfaces.RealOutput FCV_Power
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{-28,-22},{10,16}}), iconTransformation(extent={{-100,28},{-138,
            66}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        Nominal
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{-28,-56},{10,-18}}), iconTransformation(extent={{-100,66},{-138,
            104}})));
  Modelica.Blocks.Interfaces.RealOutput FCV_Demand
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{-28,16},{10,54}}),  iconTransformation(
        extent={{-19,-19},{19,19}},
        rotation=90,
        origin={-81,119})));
initial equation
  DFV_Power = 0;
  TBV_Power = 0;
  DFV_Demand = 0;
  TBV_Demand = 0;
  FCV_Power =0;
  FCV_Demand = 0;
equation
  if
    (Demand > Q_nom) then
    Charge = false;
    Discharge = true;
    Nominal = false;
    Ti_Discharge*der(DFV_Demand) = Demand - DFV_Demand;
    Ti_Charge*der(TBV_Demand) = -TBV_Demand;
    Ti_Charge*der(TBV_Power) = -TBV_Power;
    Ti_Discharge*der(DFV_Power) = Power -DFV_Power;
    Ti_Feed*der(FCV_Demand) = -FCV_Demand;
    Ti_Feed*der(FCV_Power) = -FCV_Power;
  elseif
        (Demand < Q_nom) then
    Charge = true;
    Discharge = false;
    Nominal = false;
    Ti_Discharge*der(DFV_Demand) = -DFV_Demand;
    Ti_Charge*der(TBV_Demand) = Demand-TBV_Demand;
    Ti_Discharge*der(DFV_Power) = -DFV_Power;
    Ti_Charge*der(TBV_Power) =  Power-TBV_Power;
    Ti_Feed*der(FCV_Demand) = -FCV_Demand;
    Ti_Feed*der(FCV_Power) = -FCV_Power;
  else
    Charge = false;
    Discharge = false;
    Nominal = true;
    Ti_Discharge*der(DFV_Demand) = -DFV_Demand;
    Ti_Charge*der(TBV_Demand) = -TBV_Demand;
    Ti_Discharge*der(DFV_Power) = -DFV_Power;
    Ti_Charge*der(TBV_Power) = -TBV_Power;
    Ti_Feed*der(FCV_Demand) = Demand - FCV_Demand;
    Ti_Feed*der(FCV_Power) = Power - FCV_Power;

  end if;

  annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
end Peaking_Operational_Logic;
