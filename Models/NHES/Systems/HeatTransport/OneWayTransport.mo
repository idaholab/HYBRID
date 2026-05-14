within NHES.Systems.HeatTransport;
model OneWayTransport
  extends BaseClasses.Partial_SubSystem_B(
    redeclare replaceable ControlSystems.CS_Dummy CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable data.pipe_data_1 Supply_pipe_data(L=L_supply, D=D_s,
      ith=th_i_supply));

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

 final parameter Modelica.Units.SI.Diameter D_s(fixed=false)=0.51;
 final parameter Integer nU_s(fixed=false)=1;
 final parameter Integer nSp_s(fixed=false)=1;
 final parameter Real [:] Ks_s(fixed=false)=fill(0,Supply_pipe_data.nV);
 final parameter Integer i_s(fixed=false)=1;
 final parameter Integer j_s(fixed=false)=1;
 final parameter Integer g_s(fixed=false)=1;
 final parameter Modelica.Units.SI.ThermalResistance S_R_val(fixed=false)=10
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

initial equation
  assert(Supply_pipe_data.nV>nU_s,"Not Enough Nodes (supply)",AssertionLevel.error);
  nominal_m_flow_supply=v_supply*Modelica.Constants.pi*(D_s^2)*0.25
                                          *Medium.density( Medium.setState_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default));
  S_R_val=(D_s+2*th_i_supply)*ln((D_s+2*th_i_supply)/D_s)/lambda_supply;

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
          {80,0},{100,0}},   color={0,127,255}));
  connect(port_a_supply, Supply.port_a) annotation (Line(points={{-100,0},{-80,0},
          {-80,50},{-30,50}},     color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model for simulating losses from transporting heat transfer fluids. </p>
<p>Diameter is calculated using nominal exit condition to obtain a desired fluid velocity.&nbsp; It can also be set directly in the data package. </p>
<p>Heat transfer is done with a convective heat boundary to a constant ambient temperature.&nbsp; A single resistance is used, this value is calculated using insulation thickness and conductivity parameters. </p>
<p><br>This model is set up to add U bends in the form of local loss coefficients for every set distance. </p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented November 2023</p>
</html>"));
end OneWayTransport;
