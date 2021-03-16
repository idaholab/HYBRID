within NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.Examples;
model RO_Desal_Test
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Electrical.Grid        grid(
    f_nominal=60,
    Q_nominal=1e11,
    droop=0.5,
    n=1)     annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.ROplant IP(capacity=
        dataCapacity.IP_capacity, redeclare CS_LooselyCoupled_stepInput CS(
      capacityScaler=IP.capacityScaler,
      W_IP_nom=IP.capacity_nom,
      NoPumps=IP.NoPumps,
      Power_RO_percent=IP.Power_RO_percent,
      Power_Pretreatment_percent=IP.Power_Pretreatment_percent))
    annotation (Placement(transformation(extent={{-30,-34},{34,34}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity
                            dataCapacity(
                SES_capacity(displayUnit="MW"), IP_capacity(displayUnit="MW")=
         49.8*1e6*1.5)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(grid.ports[1], IP.portElec_a)
    annotation (Line(points={{48,0},{34,0}},        color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=400,
      __Dymola_NumberOfIntervals=400,
      Tolerance=1e-08,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end RO_Desal_Test;
