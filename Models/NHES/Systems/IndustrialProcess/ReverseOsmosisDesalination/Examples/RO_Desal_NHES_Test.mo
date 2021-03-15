within NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.Examples;
model RO_Desal_NHES_Test
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Electrical.Grid        grid(
    f_nominal=60,
    Q_nominal=1e11,
    droop=0.5,
    n=1)     annotation (Placement(transformation(extent={{48,-34},{68,-14}})));
  NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.ROplant IP(capacity=
        dataCapacity.IP_capacity, redeclare
      NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.CS_LooselyCoupled
      CS(
      capacityScaler=IP.capacityScaler,
      NoPumps=IP.NoPumps,
      Power_RO_percent=IP.Power_RO_percent,
      Power_Pretreatment_percent=IP.Power_Pretreatment_percent,
      delayStart=delayStart.k,
      W_IP_nom=IP.capacity_nom,
      W_totalSetpoint=SC.W_totalSetpoint_IP))
    annotation (Placement(transformation(extent={{-32,-58},{32,10}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity
                            dataCapacity(
                SES_capacity(displayUnit="MW"), IP_capacity(displayUnit="MW")=
         49.8*1e6*1.5)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  NHES.Systems.SupervisoryControl.InputSetpointData SC(
      W_nominal_IP=49.8e6, delayStart=delayStart.k)
    annotation (Placement(transformation(extent={{-32,26},{32,90}})));
  Modelica.Blocks.Sources.Constant delayStart(k=7200)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
equation
  connect(grid.ports[1], IP.portElec_a)
    annotation (Line(points={{48,-24},{48,-24},{32,-24}},
                                                    color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=18000,
      __Dymola_NumberOfIntervals=3600,
      Tolerance=1e-08,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end RO_Desal_NHES_Test;
