within NHES.Systems.HeatTransport;
model TwoWayTransport
  extends BaseClasses.Partial_SubSystem_A(
  redeclare replaceable ControlSystems.CS_Dummy CS,
  redeclare replaceable ControlSystems.ED_Dummy ED,
  redeclare replaceable data.pipe_data_1 Supply_pipe_data(L=L_supply, D=D_s,
      ith=th_i_supply),
  redeclare replaceable data.pipe_data_1 Return_pipe_data(L=L_return, D=D_r,
      ith=th_i_return));

 //---------------------------------------------------------
 //   Supply Nominal
 parameter Modelica.Units.SI.MassFlowRate nominal_m_flow_supply=44 annotation(Dialog(group="Supply"));
 parameter Modelica.Units.SI.AbsolutePressure nominal_P_sink_supply=1e5
                                                        annotation(Dialog(group="Supply"));
 parameter Modelica.Units.SI.Thickness th_i_supply=0.1
    annotation (Dialog(group="Supply"));
 parameter Modelica.Units.SI.ThermalConductivity lambda_supply=0.08
    annotation (Dialog(group="Supply"));
 parameter Modelica.Units.SI.Temperature S_amb_T=300
    "Ambient External Temperature on Supply Side"
    annotation (Dialog(group="Supply"));
 parameter Modelica.Units.SI.CoefficientOfHeatTransfer S_alpha=20
    "External Convective Heat Transfer Coefficient on Supply Side"
    annotation (Dialog(group="Supply"));
 parameter Modelica.Units.SI.SpecificEnthalpy nominal_h_sink_supply=3e6
                                                        annotation(Dialog(group="Supply"));
 parameter Real K_supply=2.8 "Local Loss Coe"
                                             annotation(Dialog(group="Supply"));
 parameter Modelica.Units.SI.Length L_supply=500 "Supply Pipe Length"
    annotation (Dialog(group="Supply"));
 parameter Modelica.Units.SI.Length U_dist_s=125
    "Distance Between U Sections";
 parameter Modelica.Units.SI.Velocity v_supply=6
    annotation (Dialog(group="Supply"));
 //   Return Nominal
 parameter Modelica.Units.SI.MassFlowRate nominal_m_flow_return=44 annotation(Dialog(group="Return"));
 parameter Modelica.Units.SI.AbsolutePressure nominal_P_sink_return=1e5
                                                        annotation(Dialog(group="Return"));
 parameter Modelica.Units.SI.Thickness th_i_return=0.1
    annotation (Dialog(group="Return"));
 parameter Modelica.Units.SI.ThermalConductivity lambda_return=0.08
    annotation (Dialog(group="Return"));
 parameter Modelica.Units.SI.Temperature R_amb_T=300
    "Ambient External Temperature on Return Side"
    annotation (Dialog(group="Return"));
 parameter Modelica.Units.SI.CoefficientOfHeatTransfer R_alpha=20
    "External Convective Heat Transfer Coefficient on Return Side"
    annotation (Dialog(group="Return"));
 parameter Modelica.Units.SI.SpecificEnthalpy nominal_h_sink_return=3e6
                                                        annotation(Dialog(group="Return"));
 parameter Real K_return=2.8 "Local Loss Coe"
                                             annotation(Dialog(group="Return"));
 parameter Modelica.Units.SI.Length L_return=500 "Return Pipe Length"
    annotation (Dialog(group="Return"));
 parameter Modelica.Units.SI.Length U_dist_r=125
    "Distance Between U Sections";
 parameter Modelica.Units.SI.Velocity v_return=6
    annotation (Dialog(group="Return"));
 //  Supply Init
 parameter Modelica.Units.SI.AbsolutePressure S_p_a_start=
      nominal_P_sink_supply
    annotation (Dialog(tab="Initialization", group="Supply"));
 parameter Modelica.Units.SI.AbsolutePressure S_p_b_start=
      nominal_P_sink_supply
    annotation (Dialog(tab="Initialization", group="Supply"));
 parameter Boolean S_use_T_start=false;
 parameter Modelica.Units.SI.Temperature S_T_a_start=Medium.temperature_phX(
        nominal_P_sink_supply,
        nominal_h_sink_supply,
        Medium.X_default)
    annotation (Dialog(tab="Initialization", group="Supply"));
 parameter Modelica.Units.SI.Temperature S_T_b_start=Medium.temperature_phX(
        nominal_P_sink_supply,
        nominal_h_sink_supply,
        Medium.X_default)
    annotation (Dialog(tab="Initialization", group="Supply"));
 parameter Modelica.Units.SI.SpecificEnthalpy S_h_a_start=
      nominal_h_sink_supply
    annotation (Dialog(tab="Initialization", group="Supply"));
 parameter Modelica.Units.SI.SpecificEnthalpy S_h_b_start=
      nominal_h_sink_supply
    annotation (Dialog(tab="Initialization", group="Supply"));
 parameter Modelica.Units.SI.MassFlowRate S_m_flow_a_start=
      nominal_m_flow_supply
    annotation (Dialog(tab="Initialization", group="Supply"));
 parameter Modelica.Units.SI.MassFlowRate S_m_flow_b_start=-
      nominal_m_flow_supply
    annotation (Dialog(tab="Initialization", group="Supply"));

 //  Return Init
 parameter Modelica.Units.SI.AbsolutePressure R_p_a_start=
      nominal_P_sink_return
    annotation (Dialog(tab="Initialization", group="Return"));
 parameter Modelica.Units.SI.AbsolutePressure R_p_b_start=
      nominal_P_sink_return
    annotation (Dialog(tab="Initialization", group="Return"));
 parameter Boolean R_use_T_start=false;
 parameter Modelica.Units.SI.Temperature R_T_a_start=Medium.temperature_phX(
        nominal_P_sink_return,
        nominal_h_sink_return,
        Medium.X_default)
    annotation (Dialog(tab="Initialization", group="Return"));
 parameter Modelica.Units.SI.Temperature R_T_b_start=Medium.temperature_phX(
        nominal_P_sink_return,
        nominal_h_sink_return,
        Medium.X_default)
    annotation (Dialog(tab="Initialization", group="Return"));
 parameter Modelica.Units.SI.SpecificEnthalpy R_h_a_start=
      nominal_h_sink_return
    annotation (Dialog(tab="Initialization", group="Return"));
 parameter Modelica.Units.SI.SpecificEnthalpy R_h_b_start=
      nominal_h_sink_return
    annotation (Dialog(tab="Initialization", group="Return"));
 parameter Modelica.Units.SI.MassFlowRate R_m_flow_a_start=
      nominal_m_flow_return
    annotation (Dialog(tab="Initialization", group="Return"));
 parameter Modelica.Units.SI.MassFlowRate R_m_flow_b_start=-
      nominal_m_flow_return
    annotation (Dialog(tab="Initialization", group="Return"));

 final parameter Modelica.Units.SI.Diameter D_s(fixed=false)=0.51;
 final parameter Integer nU_s(fixed=false)=1;
 final parameter Integer nSp_s(fixed=false)=1;
 final parameter Real [:] Ks_s(fixed=false)=fill(0,Supply_pipe_data.nV);
 final parameter Integer i_s(fixed=false)=1;
 final parameter Integer j_s(fixed=false)=1;
 final parameter Integer g_s(fixed=false)=1;
 final parameter Modelica.Units.SI.ThermalResistance S_R_val(fixed=false)=10
    "Thermal resistance";

 final parameter Modelica.Units.SI.Diameter D_r(fixed=false)=0.51;
 final parameter Integer nU_r(fixed=false)=1;
 final parameter Integer nSp_r(fixed=false)=1;
 final parameter Real [:] Ks_r(fixed=false)=fill(0,Return_pipe_data.nV);
 final parameter Integer i_r(fixed=false)=1;
 final parameter Integer j_r(fixed=false)=1;
 final parameter Integer g_r(fixed=false)=1;
 final parameter Modelica.Units.SI.ThermalResistance R_R_val(fixed=false)=10
    "Thermal resistance";

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(
    redeclare package Medium = Medium,
    use_Ts_start=S_use_T_start,
    p_a_start=S_p_a_start,
    p_b_start=S_p_b_start,
    T_a_start=S_T_a_start,
    T_b_start=S_T_b_start,
    h_a_start=S_h_a_start,
    h_b_start=S_h_b_start,
    m_flow_a_start=S_m_flow_a_start,
    m_flow_b_start=S_m_flow_b_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=Supply_pipe_data.D,
        length=Supply_pipe_data.L,
        dheight=Supply_pipe_data.dH,
        nV=Supply_pipe_data.nV),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple
        (Ks_ab=Ks_s, Ks_ba=Ks_s),
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{-30,20},{30,80}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
        Medium,   precision=2)
    annotation (Placement(transformation(extent={{-50,30},{-30,10}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
        Medium,   precision=2)
    annotation (Placement(transformation(extent={{30,30},{50,10}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
        Medium,   precision=2)
    annotation (Placement(transformation(extent={{-80,34},{-60,14}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
        Medium,   precision=2)
    annotation (Placement(transformation(extent={{60,30},{80,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
    Supply_pipe_data.nV](T=S_amb_T)
    annotation (Placement(transformation(extent={{120,100},{100,120}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
    S_convection_constantArea_2DCyl(
    nNodes=Supply_pipe_data.nV,
    r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
        /2,
    length=Supply_pipe_data.L,
    alphas=S_alpha*ones(Supply_pipe_data.nV))
    annotation (Placement(transformation(extent={{80,100},{60,120}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance S_res[
    Supply_pipe_data.nV](R_val=S_R_val)
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Return(
    redeclare package Medium = Medium,
    use_Ts_start=R_use_T_start,
    p_a_start=R_p_a_start,
    p_b_start=R_p_b_start,
    T_a_start=R_T_a_start,
    T_b_start=R_T_b_start,
    h_a_start=R_h_a_start,
    h_b_start=R_h_b_start,
    m_flow_a_start=R_m_flow_a_start,
    m_flow_b_start=R_m_flow_b_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=Return_pipe_data.D,
        length=Return_pipe_data.L,
        dheight=Return_pipe_data.dH,
        nV=Return_pipe_data.nV),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple
        (Ks_ab=Ks_r, Ks_ba=Ks_r),
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{30,-90},{-30,-30}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_in(redeclare package Medium =
        Medium, precision=2)
    annotation (Placement(transformation(extent={{70,-74},{90,-94}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_out(redeclare package Medium =
        Medium, precision=2)
    annotation (Placement(transformation(extent={{-90,-74},{-70,-94}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_in(redeclare package Medium =
        Medium, precision=2)
    annotation (Placement(transformation(extent={{30,-74},{50,-94}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_out(redeclare package Medium =
        Medium, precision=2)
    annotation (Placement(transformation(extent={{-50,-74},{-30,-94}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance R_res[
    Return_pipe_data.nV](R_val=R_R_val)
    annotation (Placement(transformation(extent={{6,-28},{26,-8}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
    S_convection_constantArea_2DCyl1(
    nNodes=Return_pipe_data.nV,
    r_outer=(Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith)
        /2,
    length=Return_pipe_data.L,
    alphas=R_alpha*ones(Return_pipe_data.nV))
    annotation (Placement(transformation(extent={{76,-28},{56,-8}})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature R_boundary_conv[
    Return_pipe_data.nV](T=R_amb_T)
    annotation (Placement(transformation(extent={{116,-28},{96,-8}})));

initial algorithm
  nU_s:= integer( ceil(L_supply/U_dist_s));
  nSp_s:=integer(floor(Supply_pipe_data.nV/nU_s));
  i_s:=1;
  j_s:=1;
  g_s:=0;
  while i_s <Supply_pipe_data.nV+1 loop
    if j_s==nSp_s and g_s<nU_s then
      Ks_s[i_s]:=K_supply;
      j_s:=1;
      g_s:=g_s+1;
    else
      Ks_s[i_s]:=0;
      j_s:=j_s+1;
    end if;
    i_s:=i_s+1;
  end while;

  nU_r:= integer( ceil(L_return/U_dist_r));
  nSp_r:=integer(floor(Return_pipe_data.nV/nU_r));
  i_r:=1;
  j_r:=1;
  g_r:=0;
  while i_r <Return_pipe_data.nV+1 loop
    if j_r==nSp_r and g_r<nU_r then
      Ks_r[i_r]:=K_return;
      j_r:=1;
      g_r:=g_r+1;
    else
      Ks_r[i_r]:=0;
      j_r:=j_r+1;
    end if;
    i_r:=i_r+1;
  end while;

initial equation
  assert(Supply_pipe_data.nV>nU_s,"Not Enough Nodes (supply)",AssertionLevel.error);
  assert(Return_pipe_data.nV>nU_r,"Not Enough Nodes (return)",AssertionLevel.error);
  nominal_m_flow_supply=v_supply*Modelica.Constants.pi*(D_s^2)*0.25
                                          *Medium.density( Medium.setState_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default));
  S_R_val=(D_s+2*th_i_supply)*ln((D_s+2*th_i_supply)/D_s)/lambda_supply;
  nominal_m_flow_return=v_return*Modelica.Constants.pi*(D_r^2)*0.25
                                          *Medium.density(Medium.setState_phX(nominal_P_sink_return,nominal_h_sink_return,Medium.X_default));
  R_R_val=(D_r+2*th_i_return)*ln((D_r+2*th_i_return)/D_r)/lambda_return;

equation

  connect(S_convection_constantArea_2DCyl.port_a,S_boundary_conv. port)
    annotation (Line(points={{81,110},{100,110}},
                                                color={127,0,0}));
  connect(Supply.port_a,sensor_T_S_in. port) annotation (Line(points={{-30,50},{
          -70,50},{-70,34}},                   color={0,127,255}));
  connect(Supply.port_a,sensor_p_S_in. port)
    annotation (Line(points={{-30,50},{-40,50},{-40,30}}, color={0,127,255}));
  connect(Supply.port_b,sensor_p_S_out. port)
    annotation (Line(points={{30,50},{40,50},{40,30}}, color={0,127,255}));
  connect(Supply.port_b,sensor_T_S_out. port) annotation (Line(points={{30,50},{
          70,50},{70,30}},                 color={0,127,255}));
  connect(S_res.port_b, S_convection_constantArea_2DCyl.port_b)
    annotation (Line(points={{27,80},{59,80},{59,110}}, color={191,0,0}));
  connect(S_res.port_a, Supply.heatPorts[:, 1])
    annotation (Line(points={{13,80},{0,80},{0,65}}, color={191,0,0}));
  connect(Supply.port_b, port_b_supply) annotation (Line(points={{30,50},{80,50},
          {80,60},{100,60}}, color={0,127,255}));
  connect(port_a_supply, Supply.port_a) annotation (Line(points={{-100,60},{-80,
          60},{-80,50},{-30,50}}, color={0,127,255}));
  connect(Return.port_a, sensor_T_R_in.port)
    annotation (Line(points={{30,-60},{40,-60},{40,-74}},  color={0,127,255}));
  connect(Return.port_a, sensor_p_R_in.port)
    annotation (Line(points={{30,-60},{80,-60},{80,-74}},  color={0,127,255}));
  connect(Return.port_b, sensor_p_R_out.port) annotation (Line(points={{-30,-60},
          {-80,-60},{-80,-74}},  color={0,127,255}));
  connect(Return.port_b, sensor_T_R_out.port) annotation (Line(points={{-30,-60},
          {-40,-60},{-40,-74}},  color={0,127,255}));
  connect(R_res.port_b, S_convection_constantArea_2DCyl1.port_b) annotation (
      Line(points={{23,-18},{55,-18}},                   color={191,0,0}));
  connect(R_res.port_a, Return.heatPorts[:, 1])
    annotation (Line(points={{9,-18},{0,-18},{0,-45}}, color={191,0,0}));
  connect(S_convection_constantArea_2DCyl1.port_a, R_boundary_conv.port)
    annotation (Line(points={{77,-18},{96,-18}}, color={127,0,0}));
  connect(Return.port_a, port_a_return) annotation (Line(points={{30,-60},{100,-60}},
                               color={0,127,255}));
  connect(Return.port_b, port_b_return) annotation (Line(points={{-30,-60},{-100,
          -60}},            color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model for simulating losses from transporting heat transfer fluids. </p>
<p>Diameters are calculated using nominal exit conditions to obtain a desired fluid velocity.&nbsp; They can also be set directly in the data package. </p>
<p>Heat transfer is done with a convective heat boundary to a constant ambient temperature.&nbsp; A single resistance is used, this value is calculated using insulation thickness and conductivity parameters. </p>
<p><br>This model is set up to add U bends in the form of local loss coefficients for every set distance. </p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented November 2023</p>
</html>"));
end TwoWayTransport;
