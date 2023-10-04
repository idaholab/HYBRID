within NHES.ExperimentalSystems.MAGNET_TEDS;
package Magnet_TEDS

  model MAGNET_COPY_1
    extends TRANSFORM.Icons.Example;

  protected
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1)
      annotation (Placement(transformation(extent={{56,2},{36,22}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_cw(
      redeclare package Medium = Medium_cw,
      p_start=data.p_hx_cw,
      T_start=data.T_hx_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-24,2},{-4,22}})));
    TRANSFORM.HeatExchangers.Simple_HX lmtd_HX(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_hx,
      p_a_start_1=data.p_rp_hx,
      p_b_start_1=data.p_hx_co,
      T_a_start_1=data.T_rp_hx,
      T_b_start_1=data.T_hx_co,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_cw_hx,
      p_b_start_2=data.p_hx_cw,
      T_a_start_2=data.T_cw_hx,
      T_b_start_2=data.T_hx_cw,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow)
             annotation (Placement(transformation(extent={{-54,0},{-34,-20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
      redeclare package Medium = Medium_cw,
      p_start=data.p_cw_hx,
      T_start=data.T_cw_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-88,4},{-68,24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,
      m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1)
      annotation (Placement(transformation(extent={{-170,4},{-150,24}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_2(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{0,-36},{-20,-16}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
      redeclare package Medium = Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-66,-36},{-86,-16}})));
    TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
      redeclare package Medium = Medium,
      dp_nominal(displayUnit="Pa") = 1e4,
      m_flow_nominal=1,
      opening_nominal=0.5)
      annotation (Placement(transformation(extent={{-168,-36},{-148,-16}})));
    Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
      annotation (Placement(transformation(extent={{-276,-20},{-256,0}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_hx(
    redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.d_rp_hx))
      annotation (Placement(transformation(extent={{58,-36},{38,-16}})));
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_rp,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{-54,58},{-34,78}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_co_rp_1(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{26,42},{6,62}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_1(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{4,78},{24,98}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_vc_pipe_rp(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-110,76},{-90,96}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-90,44},{-110,64}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.d_vc_rp))
      annotation (Placement(transformation(extent={{-146,76},{-126,96}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.d_rp_vc))
      annotation (Placement(transformation(extent={{-126,44},{-146,64}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_vc_pipe(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-190,76},{-170,96}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-166,44},{-186,64}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=combiTimeTable1.y[1])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-220,60})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-220,78})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      T_a_start=data.T_hx_co,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_hx_co, length=data.d_hx_co))
      annotation (Placement(transformation(extent={{-114,-100},{-94,-80}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(redeclare package Medium =
          Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
                  redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01)) "12022.6"
                    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-64,-90})));
    TRANSFORM.Fluid.Machines.Pump_Controlled co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      p_b_start=data.p_co_rp,
      T_a_start=data.T_hx_co,
      T_b_start=data.T_co_rp,
      m_flow_start=data.m_flow,
      redeclare model EfficiencyChar =
          TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant
          (eta_constant=0.7027),
          controlType="m_flow",
          use_port=true)
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_co_rp_2(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=2)
      annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_co_rp,
      T_a_start=data.T_co_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_co_rp, length=data.d_co_rp))
      annotation (Placement(transformation(extent={{52,-100},{72,-80}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_ps,
      nPorts=1)
      annotation (Placement(transformation(extent={{-252,-50},{-232,-30}})));
  protected
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-292,36},{-272,56}})));
  public
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,182.455699; 60.037,
          190.247786; 120.102,187.619049; 180.084,187.825319; 240.044,187.39156; 300.005,
          188.465638; 360.053,187.693754; 420.031,184.677147; 480.073,188.004943;
          540.034,192.38221; 600.1,187.487949; 660.04,192.953911; 720.053,190.158352;
          780.104,189.409212; 840.009,188.522193; 900.102,193.002981; 960.017,189.070942;
          1020.048,181.88782; 1080.101,190.324869; 1140.049,186.956355; 1200.034,183.385201;
          1260.061,192.661804; 1320.034,191.419506; 1380.071,185.545999; 1440.045,
          183.357896; 1500.036,184.655624; 1560.072,193.607786; 1620.051,190.175811;
          1680.043,190.011206; 1740.005,187.347068; 1800.046,187.428664; 1860.05,189.590136;
          1920.049,188.497377; 1980.001,189.555924; 2040.038,190.850504; 2100.029,
          193.158688; 2160.022,188.472738; 2220.024,187.715342; 2280.022,191.882997;
          2340.009,190.56601; 2400.054,186.785084; 2460.095,186.192984; 2520.051,190.720352;
          2580.027,193.389084; 2640.006,190.65493; 2700.069,192.587484; 2760.052,193.875672;
          2820.005,191.468207; 2880.091,189.776698; 2940.004,193.511815; 3000.104,
          191.106214; 3060.098,188.553547; 3120.006,192.357538; 3180.088,196.764873;
          3240.023,190.671105; 3300.085,194.242837; 3360,191.077832; 3420.08,193.371319;
          3480.011,162.604959; 3540.045,161.341716; 3600.004,161.288599; 3660.056,
          157.92688; 3720.046,162.332593; 3780.006,160.065833; 3840.06,160.552469;
          3900.017,159.109908; 3960.022,160.794397; 4020.025,161.016361; 4080.071,
          160.949912; 4140.062,163.425704; 4200.044,163.351272; 4260.064,163.823934;
          4320.004,164.608813; 4380.049,164.997421; 4440.066,164.292629; 4500.078,
          162.827372; 4560.066,166.120409; 4620.067,163.150029; 4680.066,157.907975;
          4740.042,162.395444; 4800.06,162.480718; 4860.063,163.86009; 4920.016,163.699613;
          4980.064,162.393548; 5040.008,158.209109; 5100.052,161.050397; 5160.084,
          159.549016; 5220.067,163.663216; 5280.06,165.09781; 5340.057,160.534865;
          5400.037,162.233312; 5460.098,156.595004; 5520.065,157.252509; 5580.075,
          159.415379; 5640.084,155.767416; 5700.07,155.338523; 5760.079,154.940004;
          5820.01,152.684055; 5880.016,154.859501; 5940.03,156.267142; 6000.077,154.685917;
          6060.054,153.208742; 6120.051,151.134729; 6180.064,148.661377; 6240.028,
          149.709049; 6300.007,147.797649; 6360.029,148.183752; 6420.027,144.453856;
          6480.06,145.624195; 6540.037,145.137109; 6600.102,144.931144; 6660.008,143.294215;
          6720.087,141.248792; 6780.045,141.147938; 6840.093,144.305409; 6900.03,142.860102;
          6960.032,139.777319; 7020.073,141.641207; 7080.016,145.323511; 7140.014,
          141.662249; 7200.001,144.573086; 7260.097,148.124531; 7320.05,148.001157;
          7380.005,142.374831; 7440.073,143.501449; 7500.025,145.833614; 7560.028,
          148.885557; 7620.033,144.176655; 7680.087,143.775711; 7740.006,143.321167;
          7800.018,142.015215; 7860.076,142.409991; 7920.068,144.32666; 7980.034,141.819417;
          8040.079,141.303018; 8100.045,144.342513; 8160.033,142.562855; 8220.024,
          142.412658; 8280.023,143.545716; 8340.102,146.145847; 8400.029,144.188107;
          8460.068,141.618383; 8520.075,144.473918; 8580.089,142.326677; 8640.018,
          142.51544; 8700.062,143.623088; 8760.035,138.316689; 8820.051,141.839398;
          8880.026,143.196781; 8940.084,144.367377; 9000.083,138.154011; 9060.067,
          139.905865; 9120.004,144.115233; 9180.009,141.655486; 9240.017,142.398941;
          9300.034,145.10476; 9360.029,143.924543; 9420.037,145.778745; 9480.03,141.92909;
          9540.085,142.363941; 9600.001,138.554923; 9660.002,143.080572; 9720.008,
          143.784095; 9780.021,146.536431; 9840.026,140.11122; 9900.107,142.411806;
          9960.082,143.365081; 10020.102,143.122928; 10080.057,142.209905; 10140.046,
          143.445231; 10200.023,142.423612; 10260.022,142.739877; 10320.031,144.496132;
          10380.067,140.014317; 10440.067,141.35787; 10500.014,142.97983; 10560.005,
          142.221277; 10620.033,140.139489; 10680.079,143.983395; 10740.041,143.507376;
          10800.087,141.204814; 10860,144.98651; 10920.101,142.166441; 10980.009,143.480664;
          11040.052,144.039885; 11100.055,142.492101; 11160.013,141.572782; 11220.056,
          142.305909; 11280.088,144.657621; 11340.092,141.370881; 11400.08,140.036675;
          11460.084,142.067658; 11520.065,141.114448; 11580.049,142.247796; 11640.019,
          143.112503; 11700.041,145.811014; 11760.021,141.968008; 11820.093,143.948556;
          11880.074,141.756662; 11940.02,143.557667; 12000.03,141.063643; 12060.016,
          145.820105; 12120.007,141.316382; 12180.093,140.651134; 12240.046,141.30191;
          12300.093,142.106031; 12360.065,143.955173; 12420.094,140.987942; 12480.049,
          141.25814; 12540.058,145.24063; 12600.025,140.19916; 12660.036,136.943211;
          12720.045,145.042069; 12780.012,141.623218; 12840.059,144.136355; 12900.102,
          141.146749; 12960.007,143.156257; 13020.063,139.706855; 13080.096,138.661383;
          13140.097,146.916414; 13200.069,143.155132; 13260.095,139.129162; 13320.07,
          145.052365; 13380.047,141.746286; 13440.045,143.241354; 13500.019,141.869306;
          13560.1,140.762542; 13620.087,141.572429; 13680.02,149.612564; 13740.054,
          143.703592; 13800.07,141.872358; 13860.082,143.899968; 13920.035,141.530442;
          13980.006,146.1648; 14040.067,143.716586; 14100.06,142.383376; 14160.1,140.844716;
          14220.062,142.143697; 14280.075,141.333488; 14340.095,141.116472; 14400.045,
          139.671341; 14460.078,140.398733; 14520.031,140.850289; 14580.023,141.56904;
          14640.075,142.778892; 14700.04,146.553376; 14760.064,143.619394; 14820.07,
          143.007456; 14880.007,140.679821; 14940.071,142.865531; 15000.09,147.051641;
          15060.084,141.439739; 15120.028,142.368198; 15180.081,144.921442; 15240.094,
          143.609419; 15300.085,138.558601; 15360.016,140.670875; 15420.034,142.890845;
          15480.101,141.841824; 15540.005,143.133015; 15600.092,141.534827; 15660.037,
          136.551551; 15720.058,141.510445; 15780.026,138.86677; 15840.049,143.759504;
          15900.057,142.396692; 15960.04,141.695481; 16020.1,139.686664; 16080.085,
          139.693346; 16140.048,141.999763; 16200,141.666489; 16260.014,143.339799;
          16320.025,145.573294; 16380.073,143.25112; 16440.033,139.154026; 16500.008,
          142.149447; 16560.089,142.076171; 16620.078,145.833598; 16680.043,147.362701;
          16740.083,139.708204; 16800.008,146.003423; 16860.093,141.071498; 16920.024,
          142.468217; 16980.057,140.000134; 17040.081,141.137224; 17100.028,140.778684;
          17160.039,142.404691; 17220.018,141.409767; 17280.081,140.421991; 17340.028,
          141.040915; 17400.09,141.215013; 17460.039,140.660852; 17520.06,148.016721;
          17580.086,139.072045; 17640.061,140.447851; 17700.01,140.885176; 17760.103,
          141.809218; 17820.062,141.446678; 17880.037,143.974143; 17940.06,140.23318;
          18000.035,141.627715; 18060.076,138.608587; 18120.057,140.938856; 18180.013,
          141.129016; 18240.098,139.981261; 18300.063,142.331383; 18360.074,140.522107;
          18420.076,143.362383; 18480.001,141.406523; 18540.093,137.229729; 18600.009,
          142.11554; 18660.02,140.716845; 18720.11,139.915293; 18780.009,144.073712;
          18840.035,142.957889; 18900.045,141.65425; 18960.088,141.544159; 19020.04,
          138.75782; 19080.096,141.339993; 19140.036,142.535116; 19200.098,136.467755;
          19260.102,139.157271; 19320.039,139.775231; 19380.001,141.013272; 19440.041,
          139.908483; 19500.014,145.163805; 19560.093,144.150843; 19620.098,138.613309;
          19680.043,137.549928; 19740.024,141.423693; 19800.035,138.763041; 19860.04,
          141.985195; 19920.075,141.828749; 19980.01,140.541012; 20040.035,142.198854;
          20100.081,139.484441; 20160.06,141.222129; 20220.062,139.542442; 20280.08,
          137.21614; 20340.004,137.13297; 20400.033,141.195594; 20460.004,140.844314;
          20520.061,141.406828; 20580.004,141.443931; 20640.004,141.266332; 20700.046,
          138.2659; 20760.021,140.868231; 20820.036,140.668096; 20880.103,137.682875;
          20940.092,141.129418; 21000.048,139.080156; 21060.047,140.363412; 21120.035,
          142.513384; 21180.101,146.267309; 21240.01,146.879599; 21300.008,147.264385;
          21360.08,140.608521; 21420.031,142.827801; 21480.065,142.084877; 21540.076,
          142.42448; 21600.08,144.603668; 21660.001,140.520741; 21720.063,138.988586;
          21780.02,140.523938; 21840.036,138.937347; 21900.053,142.477918; 21960.031,
          142.239556; 22020.078,138.432882; 22080.041,141.407149; 22140.048,139.610562;
          22200.015,60.620945; 22260.008,0.359107709; 22320.011,0.36631335; 22380,
          0.372674163; 22440.038,0.376002758; 22500.024,0.378556214; 22560.076,0.367821882;
          22620.068,0.385496149; 22680.07,0.375378934; 22740.058,0.400215429; 22800.056,
          0.397247172; 22860.055,0.396712132; 22920.051,0.424031105; 22980.045,0.390241007;
          23040.071,0.386443173; 23100.087,0.373643789; 23160.079,0.41048675; 23220.041,
          0.398235413; 23280.084,0.397760947; 23340.042,0.414736068; 23400.087,0.395051212;
          23460.074,0.402803587; 23520.088,0.380015032; 23580.024,0.406718439; 23640.083,
          0.376855771; 23700.095,0.375760727; 23760.045,0.394258294; 23820.002,0.392281333;
          23880.048,0.40185136; 23940.087,0.388508679; 24000.02,0.403922308; 24060.026,
          0.400158101; 24120.061,0.377688403; 24180.063,0.391165239; 24240.075,0.394399798;
          24300.08,0.384381773; 24360.079,0.396421461; 24420.091,0.40606378; 24480.044,
          0.384352679; 24540.039,0.389738092; 24600.042,0.401792529; 24660.051,0.387731823;
          24720.075,0.39283308; 24780.02,0.40151341; 24840,0.404452789; 24900.072,
          0.421731803; 24960.03,0.410876372; 25020.025,0.432632389; 25080.103,0.399680365;
          25140.052,0.425391163; 25200.085,0.424968534; 25260.082,0.391468034; 25320.068,
          0.401814463; 25380.045,0.407646346; 25440.045,0.41249667; 25500.089,0.3725281;
          25560.05,0.387408622; 25620.051,0.412701564; 25680.089,0.407242405; 25740.057,
          0.402300218; 25800.052,0.42430261; 25860.045,0.410890691; 25920.051,0.411447211;
          25980.028,0.418983643; 26040.019,0.395548901; 26100.084,0.419910237; 26160.049,
          0.412733498; 26220.009,0.414347091; 26280,0.391881282; 26340.102,0.437172114;
          26400.093,0.425923816; 26460.056,0.409444642; 26520.061,0.446905794; 26580.027,
          0.421109482; 26640.083,0.411588071; 26700.052,0.410582455; 26760.096,0.391657295;
          26820.007,0.423594347; 26880.039,0.430840131; 26940.053,0.410316558; 27000.048,
          0.417996212; 27060.081,0.429811483; 27120.038,0.414206636; 27180.053,0.418611133;
          27240.046,0.427571036; 27300.008,0.409958607; 27360.01,0.414530695; 27420.1,
          0.439597049; 27480.054,0.428450971; 27540.046,0.423465395; 27600.083,0.440175288;
          27660.094,0.440791522; 27720.016,0.431341519; 27780.046,0.422245768; 27840.01,
          0.422610425; 27900.042,0.398405987; 27960.009,0.399982706; 28020.064,0.414218784;
          28080.059,0.405964781; 28140.049,0.408010335; 28200.073,0.415299293; 28260.069,
          0.414813299; 28320.07,0.416833458; 28380.048,0.441357588; 28440.04,0.395236535;
          28500.062,0.43975137; 28560.06,0.433535092; 28620.081,0.415009959; 28680.099,
          0.432886519; 28740.003,0.414807667; 28800.047,0.422435888; 28860.082,0.4107094;
          28920.076,0.441941912; 28980.052,0.447019088; 29040.076,0.424959178; 29100.008,
          0.415654404; 29160.088,0.435363365; 29220.009,0.436551966; 29280.015,0.434151971;
          29340.055,0.425354432; 29400.055,0.432191072; 29460.085,0.453880454; 29520.075,
          0.42137903; 29580.033,0.445345567; 29640.1,0.446320371; 29700.1,0.424629462;
          29760.013,0.452655839; 29820.054,0.447614248; 29880.075,0.457611223; 29940.074,
          0.438700169; 30000.075,0.436047093; 30060.055,0.447083313; 30120.026,0.451644327;
          30180.017,0.43358977; 30240.075,0.434839589; 30300.065,0.429019878; 30360.038,
          0.449897654; 30420.095,0.42718879; 30480.079,0.463275325; 30540.024,0.433198646;
          30600.012,0.456880407; 30660.103,0.445061435; 30720.077,0.419292475; 30780.057,
          0.450615274; 30840.101,0.451189168; 30900.04,0.4496856; 30960.054,0.43747424;
          31020.103,0.440779994; 31080.062,0.442930369; 31140.011,0.460309025; 31200.075,
          0.459229804; 31260.015,0.456060352; 31320.02,0.480734483; 31380.022,0.452235811;
          31440.088,0.432227516; 31500.012,0.440204357; 31560.021,0.44552941; 31620.026,
          0.436882946; 31680.071,0.43157701; 31740.055,0.434433047; 31800.009,0.465922315;
          31860.041,0.446027553; 31920.034,0.432749334; 31980.1,0.447291501; 32040.025,
          0.465279613; 32100.061,0.459370259; 32160.089,0.449034235; 32220.06,0.434322783;
          32280.099,0.433303682; 32340.091,0.443416124; 32400.035,0.437281255; 32460.056,
          0.442646237; 32520.046,0.444723915; 32580.057,0.459098705; 32640.097,0.431929734;
          32700.041,0.473980564; 32760.015,0.461051775; 32820.088,0.479211392; 32880.04,
          0.45325033; 32940.053,0.452569203; 33000,0.461500228; 33060.07,0.448284945;
          33120.05,0.480665676; 33180.014,0.410840284; 33240.06,0.457042532; 33300.013,
          0.446819588; 33360.062,0.45391172; 33420.045,0.46824503; 33480.041,0.443282233;
          33540.056,0.478411959; 33600.057,0.47040865; 33660.054,0.477117223; 33720.04,
          0.48400291; 33780.015,0.500944403; 33840.072,0.486701809; 33900.096,0.446779229;
          33960.072,0.459353528; 34020.036,0.467593855; 34080.072,0.488006545; 34140.038,
          0.459449018; 34200.067,0.457376138; 34260.095,0.461152707; 34320.032,0.434405266;
          34380.079,0.455723476; 34440.046,0.45102616; 34500.081,0.474069729; 34560.081,
          0.499240069; 34620.009,0.47145379; 34680.039,0.474814246; 34740.003,0.476507505;
          34800.099,0.499429355; 34860.023,0.488435641; 34920.025,0.454969198; 34980.097,
          0.46863551; 35040.029,0.432289378; 35100.067,0.479807196; 35160.073,0.471625247;
          35220.076,0.465848925; 35280.056,0.481875327; 35340.025,0.477898184; 35400.048,
          0.465450425; 35460.038,0.483651069; 35520.092,0.467287815; 35580.097,0.459943055;
          35640.096,0.468630092; 35700.015,0.472241051; 35760.034,0.468898161; 35820.068,
          0.451679912; 35880.02,0.487939861; 35940.003,0.452294404; 36000.057,0.490737521;
          36060.051,0.471011424; 36120.037,0.476826815; 36180.089,0.487530073; 36240.041,
          0.46548255; 36300.013,0.471488945; 36360.08,0.483766535; 36420.064,0.484379285;
          36480.013,0.461600491; 36540.1,0.446860399; 36600.091,0.474997875; 36660.013,
          0.468430616; 36720.081,0.455747342; 36780.083,0.492615053; 36840.049,0.46666096;
          36900.094,0.496216705], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
      annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  protected
    Modelica.Blocks.Math.Gain gain(k=1/3600)
      annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  public
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(table=[0,0; 60.037,4.6;
          120.102,15.5; 180.084,12.5; 240.044,11.2; 300.005,12.3; 360.053,12.3; 420.031,
          12.3; 480.073,12.7; 540.034,12.5; 600.1,12.9; 660.04,13.1; 720.053,13.1;
          780.104,14.9; 840.009,14.9; 900.102,13.1; 960.017,13.4; 1020.048,11.8; 1080.101,
          15.5; 1140.049,13.6; 1200.034,13.6; 1260.061,13.8; 1320.034,13.8; 1380.071,
          14; 1440.045,14; 1500.036,14; 1560.072,13.8; 1620.051,14; 1680.043,14.4;
          1740.005,14.8; 1800.046,13.1; 1860.05,13.1; 1920.049,12.9; 1980.001,14.8;
          2040.038,14.8; 2100.029,10.6; 2160.022,2.1; 2220.024,2.1; 2280.022,2.8;
          2340.009,2.4; 2400.054,2.7; 2460.095,2.6; 2520.051,2.6; 2580.027,2.3; 2640.006,
          2.4; 2700.069,2.2; 2760.052,2.3; 2820.005,13.8; 2880.091,16.2; 2940.004,
          16.6; 3000.104,15.5; 3060.098,15.7; 3120.006,15.9; 3180.088,16.4; 3240.023,
          17.9; 3300.085,16.4; 3360,16.4; 3420.08,16.6; 3480.011,16.4; 3540.045,7.2;
          3600.004,2.9; 3660.056,2.4; 3720.046,3.7; 3780.006,3.3; 3840.06,3.1; 3900.017,
          3.4; 3960.022,1.3; 4020.025,3.2; 4080.071,3; 4140.062,3.1; 4200.044,3.1;
          4260.064,3.1; 4320.004,5.1; 4380.049,5.1; 4440.066,3.9; 4500.078,5.6; 4560.066,
          5.4; 4620.067,5.9; 4680.066,5.8; 4740.042,5.8; 4800.06,5.9; 4860.063,6;
          4920.016,5.8; 4980.064,5.6; 5040.008,5.9; 5100.052,6; 5160.084,4.1; 5220.067,
          6.1; 5280.06,6.1; 5340.057,5.9; 5400.037,6.4; 5460.098,6.2; 5520.065,6.2;
          5580.075,6.3; 5640.084,6.3; 5700.07,4.4; 5760.079,6.2; 5820.01,6.5; 5880.016,
          6.3; 5940.03,6.3; 6000.077,6.3; 6060.054,4.6; 6120.051,6.6; 6180.064,6.5;
          6240.028,6.5; 6300.007,6.5; 6360.029,6.4; 6420.027,6.6; 6480.06,6.7; 6540.037,
          6.8; 6600.102,5.1; 6660.008,6.6; 6720.087,4.9; 6780.045,5; 6840.093,6.9;
          6900.03,6.8; 6960.032,6.8; 7020.073,5.1; 7080.016,6.9; 7140.014,6.9; 7200.001,
          7; 7260.097,7; 7320.05,7; 7380.005,6.9; 7440.073,7.1; 7500.025,7.1; 7560.028,
          7.1; 7620.033,7.1; 7680.087,7.1; 7740.006,6.9; 7800.018,7.4; 7860.076,5.5;
          7920.068,7.3; 7980.034,7.1; 8040.079,5.6; 8100.045,7.3; 8160.033,7.1; 8220.024,
          7.3; 8280.023,5.4; 8340.102,5.6; 8400.029,7.4; 8460.068,7.6; 8520.075,7.6;
          8580.089,7.7; 8640.018,7.7; 8700.062,7.5; 8760.035,7.9; 8820.051,6.5; 8880.026,
          6.6; 8940.084,5.7; 9000.083,5.1; 9060.067,4.9; 9120.004,4.8; 9180.009,4.9;
          9240.017,4.7; 9300.034,4.8; 9360.029,4.8; 9420.037,4.9; 9480.03,4.8; 9540.085,
          4.8; 9600.001,4.8; 9660.002,0; 9720.008,0; 9780.021,0; 9840.026,0; 9900.107,
          0; 9960.082,0; 10020.102,0; 10080.057,0; 10140.046,0; 10200.023,0; 10260.022,
          0; 10320.031,0; 10380.067,0; 10440.067,0; 10500.014,0; 10560.005,0; 10620.033,
          0; 10680.079,0; 10740.041,0; 10800.087,0; 10860,0; 10920.101,0; 10980.009,
          0; 11040.052,0; 11100.055,0; 11160.013,0; 11220.056,0; 11280.088,0; 11340.092,
          0; 11400.08,0; 11460.084,0; 11520.065,0; 11580.049,0; 11640.019,0; 11700.041,
          0; 11760.021,0; 11820.093,0; 11880.074,0; 11940.02,0; 12000.03,0; 12060.016,
          0; 12120.007,0; 12180.093,0; 12240.046,0; 12300.093,0; 12360.065,0; 12420.094,
          0; 12480.049,0; 12540.058,0; 12600.025,0.7; 12660.036,3.6; 12720.045,3.5;
          12780.012,4; 12840.059,2.1; 12900.102,1.9; 12960.007,3.4; 13020.063,3.4;
          13080.096,3.4; 13140.097,3.3; 13200.069,3.4; 13260.095,3.2; 13320.07,3.3;
          13380.047,3.3; 13440.045,3.2; 13500.019,5.2; 13560.1,3.3; 13620.087,3.1;
          13680.02,3.4; 13740.054,5.1; 13800.07,3.2; 13860.082,3.2; 13920.035,3.2;
          13980.006,3.4; 14040.067,3.2; 14100.06,3.2; 14160.1,3.2; 14220.062,3.2;
          14280.075,3.2; 14340.095,3.2; 14400.045,3.2; 14460.078,3.2; 14520.031,3.2;
          14580.023,3.2; 14640.075,3.3; 14700.04,3.3; 14760.064,3; 14820.07,3; 14880.007,
          2.9; 14940.071,3.1; 15000.09,3.1; 15060.084,29.2; 15120.028,2.1; 15180.081,
          0; 15240.094,0; 15300.085,0; 15360.016,0; 15420.034,0; 15480.101,0; 15540.005,
          0; 15600.092,0; 15660.037,0; 15720.058,0; 15780.026,0; 15840.049,0; 15900.057,
          0; 15960.04,0; 16020.1,0; 16080.085,0; 16140.048,0; 16200,0; 16260.014,0;
          16320.025,0; 16380.073,0; 16440.033,0; 16500.008,0; 16560.089,0; 16620.078,
          1.3; 16680.043,3; 16740.083,2.4; 16800.008,3.6; 16860.093,2.1; 16920.024,
          3.8; 16980.057,3.7; 17040.081,0; 17100.028,0; 17160.039,0; 17220.018,0;
          17280.081,0; 17340.028,0; 17400.09,0; 17460.039,0; 17520.06,0; 17580.086,
          0; 17640.061,33.8; 17700.01,7.4; 17760.103,0; 17820.062,13.9; 17880.037,
          16.7; 17940.06,17.9; 18000.035,18.7; 18060.076,18.7; 18120.057,19.2; 18180.013,
          7.4; 18240.098,3.1; 18300.063,3.5; 18360.074,0.9; 18420.076,6.4; 18480.001,
          6.6; 18540.093,5.3; 18600.009,7.1; 18660.02,7.1; 18720.11,7.1; 18780.009,
          5.4; 18840.035,7.2; 18900.045,7.2; 18960.088,7.2; 19020.04,7.4; 19080.096,
          7.4; 19140.036,7.4; 19200.098,7.5; 19260.102,7.5; 19320.039,5.6; 19380.001,
          7.6; 19440.041,7.4; 19500.014,5.9; 19560.093,7.8; 19620.098,7.9; 19680.043,
          7.9; 19740.024,7.9; 19800.035,7.9; 19860.04,8; 19920.075,6.4; 19980.01,8.2;
          20040.035,8.2; 20100.081,6.3; 20160.06,8; 20220.062,8.3; 20280.08,8.3; 20340.004,
          6.6; 20400.033,6.8; 20460.004,0; 20520.061,0], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
      annotation (Placement(transformation(extent={{-258,16},{-238,36}})));
    NHES.ExperimentalSystems.MAGNET.Data.Data_base data
      annotation (Placement(transformation(extent={{-290,70},{-270,90}})));
    NHES.ExperimentalSystems.MAGNET.Data.Summary summary(
      Ts={sensor_cw_hx.T,sensor_rp_hx_2.T,sensor_hx_co.T,sensor_co_rp_1.T,
          sensor_rp_hx_1.T,sensor_vc_pipe_rp.T,sensor_rp_pipe_vc.T,sensor_vc_pipe.T},
      ps={sensor_cw_hx.p,sensor_rp_hx_2.p,sensor_hx_co.p,sensor_co_rp_1.p,
          sensor_rp_hx_1.p,sensor_vc_pipe_rp.p,sensor_rp_pipe_vc.p,sensor_vc_pipe.p},
      m_flows={sensor_co_rp_2.m_flow},
      Q_flows={vc.Q_gen})
      annotation (Placement(transformation(extent={{-322,8},{-302,28}})));

    TRANSFORM.Fluid.Pipes.GenericPipe_withWall pipe
      annotation (Placement(transformation(extent={{-306,-68},{-286,-48}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 pipe_ins_co_rp(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_co_rp, length=data.d_co_rp),
      redeclare package Medium = Medium,
      redeclare package Material = TRANSFORM.Media.Solids.SS304,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{-260,-92},{-240,-72}})));
  protected
    package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

  equation
    connect(sensor_hx_cw.port_b, boundary.ports[1])
      annotation (Line(points={{-4,12},{36,12}}, color={0,127,255}));
    connect(lmtd_HX.port_a2, sensor_hx_cw.port_a) annotation (Line(points={{-34,-6},
            {-28,-6},{-28,12},{-24,12}}, color={0,127,255}));
    connect(sensor_cw_hx.port_b, lmtd_HX.port_b2) annotation (Line(points={{-68,
            14},{-60,14},{-60,-6},{-54,-6}}, color={0,127,255}));
    connect(boundary1.ports[1], sensor_cw_hx.port_a)
      annotation (Line(points={{-150,14},{-88,14}}, color={0,127,255}));
    connect(sensor_rp_hx_2.port_b, lmtd_HX.port_b1) annotation (Line(points={{-20,
            -26},{-28,-26},{-28,-14},{-34,-14}}, color={0,127,255}));
    connect(lmtd_HX.port_a1, sensor_hx_co.port_a) annotation (Line(points={{-54,-14},
            {-60,-14},{-60,-26},{-66,-26}}, color={0,127,255}));
    connect(sensor_hx_co.port_b, valve_ps.port_b)
      annotation (Line(points={{-86,-26},{-148,-26}}, color={0,127,255}));
    connect(opening_valve_tank.y, valve_ps.opening) annotation (Line(points={{-255,
            -10},{-158,-10},{-158,-18}}, color={0,0,127}));
    connect(pipe_rp_hx.port_b, sensor_rp_hx_2.port_a)
      annotation (Line(points={{38,-26},{0,-26}}, color={0,127,255}));
    connect(sensor_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{6,52},{-26,
            52},{-26,64},{-34,64}}, color={0,127,255}));
    connect(sensor_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{-90,
            86},{-60,86},{-60,72},{-54,72}}, color={0,127,255}));
    connect(pipe_vc_rp.port_b, sensor_vc_pipe_rp.port_a)
      annotation (Line(points={{-126,86},{-110,86}}, color={0,127,255}));
    connect(rp.port_b1, sensor_rp_hx_1.port_a) annotation (Line(points={{-34,72},
            {-4,72},{-4,88},{4,88}}, color={0,127,255}));
    connect(sensor_rp_hx_1.port_b, pipe_rp_hx.port_a) annotation (Line(points={{
            24,88},{64,88},{64,-26},{58,-26}}, color={0,127,255}));
    connect(rp.port_b2, sensor_rp_pipe_vc.port_a) annotation (Line(points={{-54,
            64},{-84,64},{-84,54},{-90,54}}, color={0,127,255}));
    connect(pipe_rp_vc.port_a, sensor_rp_pipe_vc.port_b)
      annotation (Line(points={{-126,54},{-110,54}}, color={0,127,255}));
    connect(sensor_vc_pipe.port_b, pipe_vc_rp.port_a)
      annotation (Line(points={{-170,86},{-146,86}}, color={0,127,255}));
    connect(pipe_rp_vc.port_b, sensor_pipe_vc.port_a)
      annotation (Line(points={{-146,54},{-166,54}}, color={0,127,255}));
    connect(sensor_pipe_vc.port_b, vc.port_a)
      annotation (Line(points={{-186,54},{-220,54}}, color={0,127,255}));
    connect(vc.port_b, resistance.port_a)
      annotation (Line(points={{-220,66},{-220,71}}, color={0,127,255}));
    connect(sensor_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{-190,
            86},{-205,86},{-205,85},{-220,85}}, color={0,127,255}));
    connect(pipe_hx_co.port_a, valve_ps.port_b) annotation (Line(points={{-114,-90},
            {-124,-90},{-124,-26},{-148,-26}}, color={0,127,255}));
    connect(pipe_hx_co.port_b, volume_co.port_a)
      annotation (Line(points={{-94,-90},{-70,-90}}, color={0,127,255}));
    connect(volume_co.port_b, co.port_a)
      annotation (Line(points={{-58,-90},{-40,-90}}, color={0,127,255}));
    connect(sensor_co_rp_2.port_a, co.port_b)
      annotation (Line(points={{0,-90},{-20,-90}}, color={0,127,255}));
    connect(sensor_co_rp_2.port_b, pipe_co_rp.port_a)
      annotation (Line(points={{20,-90},{52,-90}}, color={0,127,255}));
    connect(pipe_co_rp.port_b, sensor_co_rp_1.port_a) annotation (Line(points={{
            72,-90},{94,-90},{94,52},{26,52}}, color={0,127,255}));
    connect(ps.ports[1], valve_ps.port_a) annotation (Line(points={{-232,-40},{-192,
            -40},{-192,-26},{-168,-26}}, color={0,127,255}));
    connect(combiTimeTable.y[1], gain.u)
      annotation (Line(points={{-69,-60},{-62,-60}}, color={0,0,127}));
    connect(gain.y, co.inputSignal)
      annotation (Line(points={{-39,-60},{-30,-60},{-30,-83}}, color={0,0,127}));
    annotation (experiment(
        StopTime=40000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end MAGNET_COPY_1;

  model Magnet_1a
    extends TRANSFORM.Icons.Example;

    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    NHES.ExperimentalSystems.MAGNET.Data.Data_base data
      annotation (Placement(transformation(extent={{120,100},{140,120}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{100,98},{120,118}})));
    TRANSFORM.HeatExchangers.LMTD_HX_UA rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      p_start_1=data.p_vc_rp,
      p_start_2=data.p_co_rp,
      T_start_1=data.T_vc_rp,
      T_start_2=data.T_co_rp,
      m_flow_start_1=data.m_flow,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow,
      Q_flow0=data.Q_flow_rp)
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    TRANSFORM.HeatExchangers.LMTD_HX_UA hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      p_start_1=data.p_rp_hx,
      p_start_2=data.p_cw_hx,
      T_start_1=data.T_rp_hx,
      T_start_2=data.T_cw_hx,
      m_flow_start_1=data.m_flow,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow,
      Q_flow0=data.Q_flow_hx)
      annotation (Placement(transformation(extent={{-40,-30},{-60,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1) annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={20,-20})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-118,-20})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{50,70},{70,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT5(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-80,-60})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{10,30},{-10,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={0,80})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{70,30},{50,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
      redeclare package Medium = Medium,
      p=data.p_rp_hx,
      T=data.T_rp_hx,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={100,80})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_vc_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-38,80})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_hx_co,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-120,-60})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_rp_hx,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={18,-60})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary6(
      redeclare package Medium = Medium,
      p=data.p_rp_vc,
      T=data.T_rp_vc,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-40,40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary7(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_co_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={98,40})));
  equation
    connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{40,64},{46,64},
            {46,80},{50,80}}, color={0,127,255}));
    connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{20,56},{14,56},
            {14,40},{10,40}}, color={0,127,255}));
    connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{10,80},{14,80},
            {14,64},{20,64}}, color={0,127,255}));
    connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{50,40},{46,40},
            {46,56},{40,56}}, color={0,127,255}));
    connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-70,-60},{-66,
            -60},{-66,-44},{-60,-44}}, color={0,127,255}));
    connect(boundary1.ports[1], sensor_pT9.port_a)
      annotation (Line(points={{-108,-20},{-90,-20}}, color={0,127,255}));
    connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-70,-20},{-66,
            -20},{-66,-36},{-60,-36}}, color={0,127,255}));
    connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{-40,-36},{-34,
            -36},{-34,-20},{-30,-20}}, color={0,127,255}));
    connect(sensor_pT4.port_b, boundary.ports[1])
      annotation (Line(points={{-10,-20},{10,-20}}, color={0,127,255}));
    connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{-40,-44},{-34,
            -44},{-34,-60},{-30,-60}}, color={0,127,255}));
    connect(boundary4.ports[1], sensor_pT5.port_b)
      annotation (Line(points={{-110,-60},{-90,-60}}, color={0,127,255}));
    connect(boundary5.ports[1], sensor_pT10.port_a)
      annotation (Line(points={{8,-60},{-10,-60}}, color={0,127,255}));
    connect(boundary3.ports[1], sensor_pT7.port_a)
      annotation (Line(points={{-28,80},{-10,80}}, color={0,127,255}));
    connect(sensor_pT3.port_b, boundary2.ports[1])
      annotation (Line(points={{70,80},{90,80}}, color={0,127,255}));
    connect(sensor_pT8.port_a, boundary7.ports[1])
      annotation (Line(points={{70,40},{88,40}}, color={0,127,255}));
    connect(sensor_pT6.port_b, boundary6.ports[1])
      annotation (Line(points={{-10,40},{-30,40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
              {140,120}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
      experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
  end Magnet_1a;

  model Magnet_1b
    extends TRANSFORM.Icons.Example;

    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    NHES.ExperimentalSystems.MAGNET.Data.Data_base data
      annotation (Placement(transformation(extent={{120,100},{140,120}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{100,98},{120,118}})));
    TRANSFORM.HeatExchangers.LMTD_HX_UA rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      p_start_1=data.p_vc_rp,
      p_start_2=data.p_co_rp,
      T_start_1=data.T_vc_rp,
      T_start_2=data.T_co_rp,
      m_flow_start_1=data.m_flow,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow,
      Q_flow0=data.Q_flow_rp)
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    TRANSFORM.HeatExchangers.LMTD_HX_UA hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      p_start_1=data.p_rp_hx,
      p_start_2=data.p_cw_hx,
      T_start_1=data.T_rp_hx,
      T_start_2=data.T_cw_hx,
      m_flow_start_1=data.m_flow,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow,
      Q_flow0=data.Q_flow_hx)
      annotation (Placement(transformation(extent={{-40,-30},{-60,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1) annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={20,-20})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-118,-20})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{50,70},{70,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT5(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-80,-60})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{10,30},{-10,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={0,80})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{70,30},{50,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_hx(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.d_rp_hx))
      annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.d_rp_vc))
      annotation (Placement(transformation(extent={{-30,30},{-50,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.d_vc_rp))
      annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=data.Q_vc) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-92,52})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow) annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-92,70})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      T_a_start=data.T_hx_co,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_hx_co, length=data.d_hx_co))
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_hx_co,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={0,-90})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_co_rp,
      T_a_start=data.T_co_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_co_rp, length=data.d_co_rp)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={100,-30})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_co_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={130,-60})));
  equation
    connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{40,64},{46,64},
            {46,80},{50,80}}, color={0,127,255}));
    connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{20,56},{14,56},
            {14,40},{10,40}}, color={0,127,255}));
    connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{10,80},{14,80},
            {14,64},{20,64}}, color={0,127,255}));
    connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{50,40},{46,40},
            {46,56},{40,56}}, color={0,127,255}));
    connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-70,-60},{-66,
            -60},{-66,-44},{-60,-44}}, color={0,127,255}));
    connect(boundary1.ports[1], sensor_pT9.port_a)
      annotation (Line(points={{-108,-20},{-90,-20}}, color={0,127,255}));
    connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-70,-20},{-66,
            -20},{-66,-36},{-60,-36}}, color={0,127,255}));
    connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{-40,-36},{-34,
            -36},{-34,-20},{-30,-20}}, color={0,127,255}));
    connect(sensor_pT4.port_b, boundary.ports[1])
      annotation (Line(points={{-10,-20},{10,-20}}, color={0,127,255}));
    connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{-40,-44},{-34,
            -44},{-34,-60},{-30,-60}}, color={0,127,255}));
    connect(sensor_pT3.port_b, pipe_rp_hx.port_a) annotation (Line(points={{70,80},
            {80,80},{80,-40},{60,-40}}, color={0,127,255}));
    connect(pipe_rp_hx.port_b, sensor_pT10.port_a) annotation (Line(points={{40,
            -40},{0,-40},{0,-60},{-10,-60}}, color={0,127,255}));
    connect(sensor_pT1.port_b, pipe_vc_rp.port_a)
      annotation (Line(points={{-60,80},{-50,80}}, color={0,127,255}));
    connect(pipe_rp_vc.port_b, sensor_pT2.port_a)
      annotation (Line(points={{-50,40},{-60,40}}, color={0,127,255}));
    connect(sensor_pT2.port_b, vc.port_a)
      annotation (Line(points={{-80,40},{-92,40},{-92,46}}, color={0,127,255}));
    connect(pipe_vc_rp.port_b, sensor_pT7.port_a)
      annotation (Line(points={{-30,80},{-10,80}}, color={0,127,255}));
    connect(pipe_rp_vc.port_a, sensor_pT6.port_b)
      annotation (Line(points={{-30,40},{-10,40}}, color={0,127,255}));
    connect(vc.port_b, resistance.port_a)
      annotation (Line(points={{-92,58},{-92,63}}, color={0,127,255}));
    connect(resistance.port_b, sensor_pT1.port_a)
      annotation (Line(points={{-92,77},{-92,80},{-80,80}}, color={0,127,255}));
    connect(pipe_hx_co.port_a, sensor_pT5.port_b) annotation (Line(points={{-60,
            -90},{-100,-90},{-100,-60},{-90,-60}}, color={0,127,255}));
    connect(pipe_hx_co.port_b, boundary4.ports[1])
      annotation (Line(points={{-40,-90},{-10,-90}}, color={0,127,255}));
    connect(pipe_co_rp.port_b, sensor_pT8.port_a)
      annotation (Line(points={{100,-20},{100,40},{70,40}}, color={0,127,255}));
    connect(boundary2.ports[1], pipe_co_rp.port_a) annotation (Line(points={{120,
            -60},{100,-60},{100,-40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
              {140,120}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
      experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
  end Magnet_1b;

  model Magnet_1c
    extends TRANSFORM.Icons.Example;

    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    NHES.ExperimentalSystems.MAGNET.Data.Data_base data
      annotation (Placement(transformation(extent={{120,100},{140,120}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{100,98},{120,118}})));
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=1,
      V_2=1,
      UA=47.9299,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    TRANSFORM.HeatExchangers.Simple_HX  hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      nV=10,
      V_1=1,
      V_2=1,
      UA=317.208,
      p_a_start_1=data.p_rp_hx,
      p_b_start_1=data.p_hx_co,
      T_a_start_1=data.T_rp_hx,
      T_b_start_1=data.T_hx_co,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_cw_hx,
      p_b_start_2=data.p_hx_cw,
      T_a_start_2=data.T_cw_hx,
      T_b_start_2=data.T_hx_cw,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow)
      annotation (Placement(transformation(extent={{-40,-30},{-60,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1) annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={20,-20})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-118,-20})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{50,70},{70,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT5(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-80,-60})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{10,30},{-10,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={0,80})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{70,30},{50,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_hx(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.d_rp_hx))
      annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.d_rp_vc))
      annotation (Placement(transformation(extent={{-30,30},{-50,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.d_vc_rp))
      annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=data.Q_vc) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-92,52})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow) annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-92,70})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      T_a_start=data.T_hx_co,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_hx_co, length=data.d_hx_co))
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_co_rp,
      T_a_start=data.T_co_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_co_rp, length=data.d_co_rp)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={100,-30})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
          Medium, m_flow_nominal=data.m_flow)
      annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      Q_gen=12022.6)
      annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
      redeclare package Medium = Medium,
      use_p_in=false,
      p=data.p_hx_co,
      T=data.T_ps,
      nPorts=1)
      annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));
    TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
      redeclare package Medium = Medium,
      showName=false,
      dp_nominal(displayUnit="Pa") = 1e4,
      m_flow_nominal=1,
      opening_nominal=0.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-150,-40})));
    Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
      annotation (Placement(transformation(extent={{-220,-30},{-200,-10}})));
  equation
    connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{40,64},{46,64},
            {46,80},{50,80}}, color={0,127,255}));
    connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{20,56},{14,56},
            {14,40},{10,40}}, color={0,127,255}));
    connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{10,80},{14,80},
            {14,64},{20,64}}, color={0,127,255}));
    connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{50,40},{46,40},
            {46,56},{40,56}}, color={0,127,255}));
    connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-70,-60},{-66,
            -60},{-66,-44},{-60,-44}}, color={0,127,255}));
    connect(boundary1.ports[1], sensor_pT9.port_a)
      annotation (Line(points={{-108,-20},{-90,-20}}, color={0,127,255}));
    connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-70,-20},{-66,
            -20},{-66,-36},{-60,-36}}, color={0,127,255}));
    connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{-40,-36},{-34,
            -36},{-34,-20},{-30,-20}}, color={0,127,255}));
    connect(sensor_pT4.port_b, boundary.ports[1])
      annotation (Line(points={{-10,-20},{10,-20}}, color={0,127,255}));
    connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{-40,-44},{-34,
            -44},{-34,-60},{-30,-60}}, color={0,127,255}));
    connect(sensor_pT3.port_b, pipe_rp_hx.port_a) annotation (Line(points={{70,80},
            {80,80},{80,-40},{60,-40}}, color={0,127,255}));
    connect(pipe_rp_hx.port_b, sensor_pT10.port_a) annotation (Line(points={{40,
            -40},{0,-40},{0,-60},{-10,-60}}, color={0,127,255}));
    connect(sensor_pT1.port_b, pipe_vc_rp.port_a)
      annotation (Line(points={{-60,80},{-50,80}}, color={0,127,255}));
    connect(pipe_rp_vc.port_b, sensor_pT2.port_a)
      annotation (Line(points={{-50,40},{-60,40}}, color={0,127,255}));
    connect(sensor_pT2.port_b, vc.port_a)
      annotation (Line(points={{-80,40},{-92,40},{-92,46}}, color={0,127,255}));
    connect(pipe_vc_rp.port_b, sensor_pT7.port_a)
      annotation (Line(points={{-30,80},{-10,80}}, color={0,127,255}));
    connect(pipe_rp_vc.port_a, sensor_pT6.port_b)
      annotation (Line(points={{-30,40},{-10,40}}, color={0,127,255}));
    connect(vc.port_b, resistance.port_a)
      annotation (Line(points={{-92,58},{-92,63}}, color={0,127,255}));
    connect(resistance.port_b, sensor_pT1.port_a)
      annotation (Line(points={{-92,77},{-92,80},{-80,80}}, color={0,127,255}));
    connect(pipe_hx_co.port_a, sensor_pT5.port_b) annotation (Line(points={{-60,
            -90},{-100,-90},{-100,-60},{-90,-60}}, color={0,127,255}));
    connect(pipe_co_rp.port_b, sensor_pT8.port_a)
      annotation (Line(points={{100,-20},{100,40},{70,40}}, color={0,127,255}));
    connect(pump.port_b, pipe_co_rp.port_a) annotation (Line(points={{80,-90},{
            100,-90},{100,-40}}, color={0,127,255}));
    connect(pipe_hx_co.port_b, volume1.port_a)
      annotation (Line(points={{-40,-90},{14,-90}}, color={0,127,255}));
    connect(volume1.port_b, pump.port_a)
      annotation (Line(points={{26,-90},{60,-90}}, color={0,127,255}));
    connect(ps.ports[1], valve_ps.port_a)
      annotation (Line(points={{-170,-40},{-160,-40}}, color={0,127,255}));
    connect(opening_valve_tank.y, valve_ps.opening) annotation (Line(
        points={{-199,-20},{-150,-20},{-150,-32}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(valve_ps.port_b, sensor_pT5.port_b) annotation (Line(points={{-140,
            -40},{-100,-40},{-100,-60},{-90,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,
              -120},{140,120}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-240,-120},{140,
              120}})),
      experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
  end Magnet_1c;

  model MAGNET_Insulated_pipes
    extends TRANSFORM.Icons.Example;

  protected
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1)
      annotation (Placement(transformation(extent={{56,2},{36,22}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_cw(
      redeclare package Medium = Medium_cw,
      p_start=data.p_hx_cw,
      T_start=data.T_hx_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-24,2},{-4,22}})));
    TRANSFORM.HeatExchangers.Simple_HX hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_hx,
      p_a_start_1=data.p_rp_hx,
      p_b_start_1=data.p_hx_co,
      T_a_start_1=data.T_rp_hx,
      T_b_start_1=data.T_hx_co,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_cw_hx,
      p_b_start_2=data.p_hx_cw,
      T_a_start_2=data.T_cw_hx,
      T_b_start_2=data.T_hx_cw,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow)
      annotation (Placement(transformation(extent={{-54,0},{-34,-20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
      redeclare package Medium = Medium_cw,
      p_start=data.p_cw_hx,
      T_start=data.T_cw_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-88,4},{-68,24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,
      m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1)
      annotation (Placement(transformation(extent={{-170,4},{-150,24}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_2(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{0,-36},{-20,-16}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
      redeclare package Medium = Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-66,-36},{-86,-16}})));
    TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
      redeclare package Medium = Medium,
      dp_nominal(displayUnit="Pa") = 1e4,
      m_flow_nominal=1,
      opening_nominal=0.5)
      annotation (Placement(transformation(extent={{-168,-36},{-148,-16}})));
    Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
      annotation (Placement(transformation(extent={{-208,-16},{-188,4}})));
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_rp,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{-54,58},{-34,78}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_co_rp_1(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{26,42},{6,62}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_1(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{4,78},{24,98}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_vc_pipe_rp(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-110,80},{-90,100}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-90,40},{-110,60}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_vc_pipe(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-190,80},{-170,100}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-164,40},{-184,60}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=combiTimeTable1.y[1])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-236,60})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-236,78})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(redeclare package Medium =
          Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
                  redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      Q_gen=0)      "12022.6"
                    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-64,-90})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_co_rp_2(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=2)
      annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_ps,
      nPorts=1)
      annotation (Placement(transformation(extent={{-238,-36},{-218,-16}})));
  protected
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-292,54},{-272,74}})));
  protected
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(table=[0,0; 60.037,4.6;
          120.102,15.5; 180.084,12.5; 240.044,11.2; 300.005,12.3; 360.053,12.3; 420.031,
          12.3; 480.073,12.7; 540.034,12.5; 600.1,12.9; 660.04,13.1; 720.053,13.1;
          780.104,14.9; 840.009,14.9; 900.102,13.1; 960.017,13.4; 1020.048,11.8; 1080.101,
          15.5; 1140.049,13.6; 1200.034,13.6; 1260.061,13.8; 1320.034,13.8; 1380.071,
          14; 1440.045,14; 1500.036,14; 1560.072,13.8; 1620.051,14; 1680.043,14.4;
          1740.005,14.8; 1800.046,13.1; 1860.05,13.1; 1920.049,12.9; 1980.001,14.8;
          2040.038,14.8; 2100.029,10.6; 2160.022,2.1; 2220.024,2.1; 2280.022,2.8;
          2340.009,2.4; 2400.054,2.7; 2460.095,2.6; 2520.051,2.6; 2580.027,2.3; 2640.006,
          2.4; 2700.069,2.2; 2760.052,2.3; 2820.005,13.8; 2880.091,16.2; 2940.004,
          16.6; 3000.104,15.5; 3060.098,15.7; 3120.006,15.9; 3180.088,16.4; 3240.023,
          17.9; 3300.085,16.4; 3360,16.4; 3420.08,16.6; 3480.011,16.4; 3540.045,7.2;
          3600.004,2.9; 3660.056,2.4; 3720.046,3.7; 3780.006,3.3; 3840.06,3.1; 3900.017,
          3.4; 3960.022,1.3; 4020.025,3.2; 4080.071,3; 4140.062,3.1; 4200.044,3.1;
          4260.064,3.1; 4320.004,5.1; 4380.049,5.1; 4440.066,3.9; 4500.078,5.6; 4560.066,
          5.4; 4620.067,5.9; 4680.066,5.8; 4740.042,5.8; 4800.06,5.9; 4860.063,6;
          4920.016,5.8; 4980.064,5.6; 5040.008,5.9; 5100.052,6; 5160.084,4.1; 5220.067,
          6.1; 5280.06,6.1; 5340.057,5.9; 5400.037,6.4; 5460.098,6.2; 5520.065,6.2;
          5580.075,6.3; 5640.084,6.3; 5700.07,4.4; 5760.079,6.2; 5820.01,6.5; 5880.016,
          6.3; 5940.03,6.3; 6000.077,6.3; 6060.054,4.6; 6120.051,6.6; 6180.064,6.5;
          6240.028,6.5; 6300.007,6.5; 6360.029,6.4; 6420.027,6.6; 6480.06,6.7; 6540.037,
          6.8; 6600.102,5.1; 6660.008,6.6; 6720.087,4.9; 6780.045,5; 6840.093,6.9;
          6900.03,6.8; 6960.032,6.8; 7020.073,5.1; 7080.016,6.9; 7140.014,6.9; 7200.001,
          7; 7260.097,7; 7320.05,7; 7380.005,6.9; 7440.073,7.1; 7500.025,7.1; 7560.028,
          7.1; 7620.033,7.1; 7680.087,7.1; 7740.006,6.9; 7800.018,7.4; 7860.076,5.5;
          7920.068,7.3; 7980.034,7.1; 8040.079,5.6; 8100.045,7.3; 8160.033,7.1; 8220.024,
          7.3; 8280.023,5.4; 8340.102,5.6; 8400.029,7.4; 8460.068,7.6; 8520.075,7.6;
          8580.089,7.7; 8640.018,7.7; 8700.062,7.5; 8760.035,7.9; 8820.051,6.5; 8880.026,
          6.6; 8940.084,5.7; 9000.083,5.1; 9060.067,4.9; 9120.004,4.8; 9180.009,4.9;
          9240.017,4.7; 9300.034,4.8; 9360.029,4.8; 9420.037,4.9; 9480.03,4.8; 9540.085,
          4.8; 9600.001,4.8; 9660.002,0; 9720.008,0; 9780.021,0; 9840.026,0; 9900.107,
          0; 9960.082,0; 10020.102,0; 10080.057,0; 10140.046,0; 10200.023,0; 10260.022,
          0; 10320.031,0; 10380.067,0; 10440.067,0; 10500.014,0; 10560.005,0; 10620.033,
          0; 10680.079,0; 10740.041,0; 10800.087,0; 10860,0; 10920.101,0; 10980.009,
          0; 11040.052,0; 11100.055,0; 11160.013,0; 11220.056,0; 11280.088,0; 11340.092,
          0; 11400.08,0; 11460.084,0; 11520.065,0; 11580.049,0; 11640.019,0; 11700.041,
          0; 11760.021,0; 11820.093,0; 11880.074,0; 11940.02,0; 12000.03,0; 12060.016,
          0; 12120.007,0; 12180.093,0; 12240.046,0; 12300.093,0; 12360.065,0; 12420.094,
          0; 12480.049,0; 12540.058,0; 12600.025,0.7; 12660.036,3.6; 12720.045,3.5;
          12780.012,4; 12840.059,2.1; 12900.102,1.9; 12960.007,3.4; 13020.063,3.4;
          13080.096,3.4; 13140.097,3.3; 13200.069,3.4; 13260.095,3.2; 13320.07,3.3;
          13380.047,3.3; 13440.045,3.2; 13500.019,5.2; 13560.1,3.3; 13620.087,3.1;
          13680.02,3.4; 13740.054,5.1; 13800.07,3.2; 13860.082,3.2; 13920.035,3.2;
          13980.006,3.4; 14040.067,3.2; 14100.06,3.2; 14160.1,3.2; 14220.062,3.2;
          14280.075,3.2; 14340.095,3.2; 14400.045,3.2; 14460.078,3.2; 14520.031,3.2;
          14580.023,3.2; 14640.075,3.3; 14700.04,3.3; 14760.064,3; 14820.07,3; 14880.007,
          2.9; 14940.071,3.1; 15000.09,3.1; 15060.084,29.2; 15120.028,2.1; 15180.081,
          0; 15240.094,0; 15300.085,0; 15360.016,0; 15420.034,0; 15480.101,0; 15540.005,
          0; 15600.092,0; 15660.037,0; 15720.058,0; 15780.026,0; 15840.049,0; 15900.057,
          0; 15960.04,0; 16020.1,0; 16080.085,0; 16140.048,0; 16200,0; 16260.014,0;
          16320.025,0; 16380.073,0; 16440.033,0; 16500.008,0; 16560.089,0; 16620.078,
          1.3; 16680.043,3; 16740.083,2.4; 16800.008,3.6; 16860.093,2.1; 16920.024,
          3.8; 16980.057,3.7; 17040.081,0; 17100.028,0; 17160.039,0; 17220.018,0;
          17280.081,0; 17340.028,0; 17400.09,0; 17460.039,0; 17520.06,0; 17580.086,
          0; 17640.061,33.8; 17700.01,7.4; 17760.103,0; 17820.062,13.9; 17880.037,
          16.7; 17940.06,17.9; 18000.035,18.7; 18060.076,18.7; 18120.057,19.2; 18180.013,
          7.4; 18240.098,3.1; 18300.063,3.5; 18360.074,0.9; 18420.076,6.4; 18480.001,
          6.6; 18540.093,5.3; 18600.009,7.1; 18660.02,7.1; 18720.11,7.1; 18780.009,
          5.4; 18840.035,7.2; 18900.045,7.2; 18960.088,7.2; 19020.04,7.4; 19080.096,
          7.4; 19140.036,7.4; 19200.098,7.5; 19260.102,7.5; 19320.039,5.6; 19380.001,
          7.6; 19440.041,7.4; 19500.014,5.9; 19560.093,7.8; 19620.098,7.9; 19680.043,
          7.9; 19740.024,7.9; 19800.035,7.9; 19860.04,8; 19920.075,6.4; 19980.01,8.2;
          20040.035,8.2; 20100.081,6.3; 20160.06,8; 20220.062,8.3; 20280.08,8.3; 20340.004,
          6.6; 20400.033,6.8; 20460.004,0; 20520.061,0], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
      annotation (Placement(transformation(extent={{-238,18},{-218,38}})));
  public
    NHES.ExperimentalSystems.MAGNET.Data.Summary summary(
      Ts={sensor_cw_hx.T,sensor_rp_hx_2.T,sensor_hx_co.T,sensor_co_rp_1.T,
          sensor_rp_hx_1.T,sensor_vc_pipe_rp.T,sensor_rp_pipe_vc.T,sensor_vc_pipe.T},
      ps={sensor_cw_hx.p,sensor_rp_hx_2.p,sensor_hx_co.p,sensor_co_rp_1.p,
          sensor_rp_hx_1.p,sensor_vc_pipe_rp.p,sensor_rp_pipe_vc.p,sensor_vc_pipe.p},
      m_flows={sensor_co_rp_2.m_flow},
      Q_flows={vc.Q_gen})
      annotation (Placement(transformation(extent={{-290,28},{-270,48}})));

  protected
    NHES.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-292,84},{-272,104}})));
  protected
    package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      T_a_start=data.T_hx_co,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_hx_co, length=data.length_hx_co))
      annotation (Placement(transformation(extent={{-118,-100},{-98,-80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_co_rp,
      T_a_start=data.T_co_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_co_rp, length=data.length_co_rp))
      annotation (Placement(transformation(extent={{48,-100},{68,-80}})));
  protected
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,182.455699;
          60.037,190.247786; 120.102,187.619049; 180.084,187.825319; 240.044,
          187.39156; 300.005,188.465638; 360.053,187.693754; 420.031,184.677147;
          480.073,188.004943; 540.034,192.38221; 600.1,187.487949; 660.04,
          192.953911; 720.053,190.158352; 780.104,189.409212; 840.009,188.522193;
          900.102,193.002981; 960.017,189.070942; 1020.048,181.88782; 1080.101,
          190.324869; 1140.049,186.956355; 1200.034,183.385201; 1260.061,
          192.661804; 1320.034,191.419506; 1380.071,185.545999; 1440.045,
          183.357896; 1500.036,184.655624; 1560.072,193.607786; 1620.051,
          190.175811; 1680.043,190.011206; 1740.005,187.347068; 1800.046,
          187.428664; 1860.05,189.590136; 1920.049,188.497377; 1980.001,
          189.555924; 2040.038,190.850504; 2100.029,193.158688; 2160.022,
          188.472738; 2220.024,187.715342; 2280.022,191.882997; 2340.009,
          190.56601; 2400.054,186.785084; 2460.095,186.192984; 2520.051,
          190.720352; 2580.027,193.389084; 2640.006,190.65493; 2700.069,
          192.587484; 2760.052,193.875672; 2820.005,191.468207; 2880.091,
          189.776698; 2940.004,193.511815; 3000.104,191.106214; 3060.098,
          188.553547; 3120.006,192.357538; 3180.088,196.764873; 3240.023,
          190.671105; 3300.085,194.242837; 3360,191.077832; 3420.08,193.371319;
          3480.011,162.604959; 3540.045,161.341716; 3600.004,161.288599; 3660.056,
          157.92688; 3720.046,162.332593; 3780.006,160.065833; 3840.06,160.552469;
          3900.017,159.109908; 3960.022,160.794397; 4020.025,161.016361; 4080.071,
          160.949912; 4140.062,163.425704; 4200.044,163.351272; 4260.064,
          163.823934; 4320.004,164.608813; 4380.049,164.997421; 4440.066,
          164.292629; 4500.078,162.827372; 4560.066,166.120409; 4620.067,
          163.150029; 4680.066,157.907975; 4740.042,162.395444; 4800.06,
          162.480718; 4860.063,163.86009; 4920.016,163.699613; 4980.064,
          162.393548; 5040.008,158.209109; 5100.052,161.050397; 5160.084,
          159.549016; 5220.067,163.663216; 5280.06,165.09781; 5340.057,160.534865;
          5400.037,162.233312; 5460.098,156.595004; 5520.065,157.252509; 5580.075,
          159.415379; 5640.084,155.767416; 5700.07,155.338523; 5760.079,
          154.940004; 5820.01,152.684055; 5880.016,154.859501; 5940.03,156.267142;
          6000.077,154.685917; 6060.054,153.208742; 6120.051,151.134729; 6180.064,
          148.661377; 6240.028,149.709049; 6300.007,147.797649; 6360.029,
          148.183752; 6420.027,144.453856; 6480.06,145.624195; 6540.037,
          145.137109; 6600.102,144.931144; 6660.008,143.294215; 6720.087,
          141.248792; 6780.045,141.147938; 6840.093,144.305409; 6900.03,
          142.860102; 6960.032,139.777319; 7020.073,141.641207; 7080.016,
          145.323511; 7140.014,141.662249; 7200.001,144.573086; 7260.097,
          148.124531; 7320.05,148.001157; 7380.005,142.374831; 7440.073,
          143.501449; 7500.025,145.833614; 7560.028,148.885557; 7620.033,
          144.176655; 7680.087,143.775711; 7740.006,143.321167; 7800.018,
          142.015215; 7860.076,142.409991; 7920.068,144.32666; 7980.034,
          141.819417; 8040.079,141.303018; 8100.045,144.342513; 8160.033,
          142.562855; 8220.024,142.412658; 8280.023,143.545716; 8340.102,
          146.145847; 8400.029,144.188107; 8460.068,141.618383; 8520.075,
          144.473918; 8580.089,142.326677; 8640.018,142.51544; 8700.062,
          143.623088; 8760.035,138.316689; 8820.051,141.839398; 8880.026,
          143.196781; 8940.084,144.367377; 9000.083,138.154011; 9060.067,
          139.905865; 9120.004,144.115233; 9180.009,141.655486; 9240.017,
          142.398941; 9300.034,145.10476; 9360.029,143.924543; 9420.037,
          145.778745; 9480.03,141.92909; 9540.085,142.363941; 9600.001,138.554923;
          9660.002,143.080572; 9720.008,143.784095; 9780.021,146.536431; 9840.026,
          140.11122; 9900.107,142.411806; 9960.082,143.365081; 10020.102,
          143.122928; 10080.057,142.209905; 10140.046,143.445231; 10200.023,
          142.423612; 10260.022,142.739877; 10320.031,144.496132; 10380.067,
          140.014317; 10440.067,141.35787; 10500.014,142.97983; 10560.005,
          142.221277; 10620.033,140.139489; 10680.079,143.983395; 10740.041,
          143.507376; 10800.087,141.204814; 10860,144.98651; 10920.101,142.166441;
          10980.009,143.480664; 11040.052,144.039885; 11100.055,142.492101;
          11160.013,141.572782; 11220.056,142.305909; 11280.088,144.657621;
          11340.092,141.370881; 11400.08,140.036675; 11460.084,142.067658;
          11520.065,141.114448; 11580.049,142.247796; 11640.019,143.112503;
          11700.041,145.811014; 11760.021,141.968008; 11820.093,143.948556;
          11880.074,141.756662; 11940.02,143.557667; 12000.03,141.063643;
          12060.016,145.820105; 12120.007,141.316382; 12180.093,140.651134;
          12240.046,141.30191; 12300.093,142.106031; 12360.065,143.955173;
          12420.094,140.987942; 12480.049,141.25814; 12540.058,145.24063;
          12600.025,140.19916; 12660.036,136.943211; 12720.045,145.042069;
          12780.012,141.623218; 12840.059,144.136355; 12900.102,141.146749;
          12960.007,143.156257; 13020.063,139.706855; 13080.096,138.661383;
          13140.097,146.916414; 13200.069,143.155132; 13260.095,139.129162;
          13320.07,145.052365; 13380.047,141.746286; 13440.045,143.241354;
          13500.019,141.869306; 13560.1,140.762542; 13620.087,141.572429;
          13680.02,149.612564; 13740.054,143.703592; 13800.07,141.872358;
          13860.082,143.899968; 13920.035,141.530442; 13980.006,146.1648;
          14040.067,143.716586; 14100.06,142.383376; 14160.1,140.844716;
          14220.062,142.143697; 14280.075,141.333488; 14340.095,141.116472;
          14400.045,139.671341; 14460.078,140.398733; 14520.031,140.850289;
          14580.023,141.56904; 14640.075,142.778892; 14700.04,146.553376;
          14760.064,143.619394; 14820.07,143.007456; 14880.007,140.679821;
          14940.071,142.865531; 15000.09,147.051641; 15060.084,141.439739;
          15120.028,142.368198; 15180.081,144.921442; 15240.094,143.609419;
          15300.085,138.558601; 15360.016,140.670875; 15420.034,142.890845;
          15480.101,141.841824; 15540.005,143.133015; 15600.092,141.534827;
          15660.037,136.551551; 15720.058,141.510445; 15780.026,138.86677;
          15840.049,143.759504; 15900.057,142.396692; 15960.04,141.695481;
          16020.1,139.686664; 16080.085,139.693346; 16140.048,141.999763; 16200,
          141.666489; 16260.014,143.339799; 16320.025,145.573294; 16380.073,
          143.25112; 16440.033,139.154026; 16500.008,142.149447; 16560.089,
          142.076171; 16620.078,145.833598; 16680.043,147.362701; 16740.083,
          139.708204; 16800.008,146.003423; 16860.093,141.071498; 16920.024,
          142.468217; 16980.057,140.000134; 17040.081,141.137224; 17100.028,
          140.778684; 17160.039,142.404691; 17220.018,141.409767; 17280.081,
          140.421991; 17340.028,141.040915; 17400.09,141.215013; 17460.039,
          140.660852; 17520.06,148.016721; 17580.086,139.072045; 17640.061,
          140.447851; 17700.01,140.885176; 17760.103,141.809218; 17820.062,
          141.446678; 17880.037,143.974143; 17940.06,140.23318; 18000.035,
          141.627715; 18060.076,138.608587; 18120.057,140.938856; 18180.013,
          141.129016; 18240.098,139.981261; 18300.063,142.331383; 18360.074,
          140.522107; 18420.076,143.362383; 18480.001,141.406523; 18540.093,
          137.229729; 18600.009,142.11554; 18660.02,140.716845; 18720.11,
          139.915293; 18780.009,144.073712; 18840.035,142.957889; 18900.045,
          141.65425; 18960.088,141.544159; 19020.04,138.75782; 19080.096,
          141.339993; 19140.036,142.535116; 19200.098,136.467755; 19260.102,
          139.157271; 19320.039,139.775231; 19380.001,141.013272; 19440.041,
          139.908483; 19500.014,145.163805; 19560.093,144.150843; 19620.098,
          138.613309; 19680.043,137.549928; 19740.024,141.423693; 19800.035,
          138.763041; 19860.04,141.985195; 19920.075,141.828749; 19980.01,
          140.541012; 20040.035,142.198854; 20100.081,139.484441; 20160.06,
          141.222129; 20220.062,139.542442; 20280.08,137.21614; 20340.004,
          137.13297; 20400.033,141.195594; 20460.004,140.844314; 20520.061,
          141.406828; 20580.004,141.443931; 20640.004,141.266332; 20700.046,
          138.2659; 20760.021,140.868231; 20820.036,140.668096; 20880.103,
          137.682875; 20940.092,141.129418; 21000.048,139.080156; 21060.047,
          140.363412; 21120.035,142.513384; 21180.101,146.267309; 21240.01,
          146.879599; 21300.008,147.264385; 21360.08,140.608521; 21420.031,
          142.827801; 21480.065,142.084877; 21540.076,142.42448; 21600.08,
          144.603668; 21660.001,140.520741; 21720.063,138.988586; 21780.02,
          140.523938; 21840.036,138.937347; 21900.053,142.477918; 21960.031,
          142.239556; 22020.078,138.432882; 22080.041,141.407149; 22140.048,
          139.610562; 22200.015,60.620945; 22260.008,0.359107709; 22320.011,
          0.36631335; 22380,0.372674163; 22440.038,0.376002758; 22500.024,
          0.378556214; 22560.076,0.367821882; 22620.068,0.385496149; 22680.07,
          0.375378934; 22740.058,0.400215429; 22800.056,0.397247172; 22860.055,
          0.396712132; 22920.051,0.424031105; 22980.045,0.390241007; 23040.071,
          0.386443173; 23100.087,0.373643789; 23160.079,0.41048675; 23220.041,
          0.398235413; 23280.084,0.397760947; 23340.042,0.414736068; 23400.087,
          0.395051212; 23460.074,0.402803587; 23520.088,0.380015032; 23580.024,
          0.406718439; 23640.083,0.376855771; 23700.095,0.375760727; 23760.045,
          0.394258294; 23820.002,0.392281333; 23880.048,0.40185136; 23940.087,
          0.388508679; 24000.02,0.403922308; 24060.026,0.400158101; 24120.061,
          0.377688403; 24180.063,0.391165239; 24240.075,0.394399798; 24300.08,
          0.384381773; 24360.079,0.396421461; 24420.091,0.40606378; 24480.044,
          0.384352679; 24540.039,0.389738092; 24600.042,0.401792529; 24660.051,
          0.387731823; 24720.075,0.39283308; 24780.02,0.40151341; 24840,
          0.404452789; 24900.072,0.421731803; 24960.03,0.410876372; 25020.025,
          0.432632389; 25080.103,0.399680365; 25140.052,0.425391163; 25200.085,
          0.424968534; 25260.082,0.391468034; 25320.068,0.401814463; 25380.045,
          0.407646346; 25440.045,0.41249667; 25500.089,0.3725281; 25560.05,
          0.387408622; 25620.051,0.412701564; 25680.089,0.407242405; 25740.057,
          0.402300218; 25800.052,0.42430261; 25860.045,0.410890691; 25920.051,
          0.411447211; 25980.028,0.418983643; 26040.019,0.395548901; 26100.084,
          0.419910237; 26160.049,0.412733498; 26220.009,0.414347091; 26280,
          0.391881282; 26340.102,0.437172114; 26400.093,0.425923816; 26460.056,
          0.409444642; 26520.061,0.446905794; 26580.027,0.421109482; 26640.083,
          0.411588071; 26700.052,0.410582455; 26760.096,0.391657295; 26820.007,
          0.423594347; 26880.039,0.430840131; 26940.053,0.410316558; 27000.048,
          0.417996212; 27060.081,0.429811483; 27120.038,0.414206636; 27180.053,
          0.418611133; 27240.046,0.427571036; 27300.008,0.409958607; 27360.01,
          0.414530695; 27420.1,0.439597049; 27480.054,0.428450971; 27540.046,
          0.423465395; 27600.083,0.440175288; 27660.094,0.440791522; 27720.016,
          0.431341519; 27780.046,0.422245768; 27840.01,0.422610425; 27900.042,
          0.398405987; 27960.009,0.399982706; 28020.064,0.414218784; 28080.059,
          0.405964781; 28140.049,0.408010335; 28200.073,0.415299293; 28260.069,
          0.414813299; 28320.07,0.416833458; 28380.048,0.441357588; 28440.04,
          0.395236535; 28500.062,0.43975137; 28560.06,0.433535092; 28620.081,
          0.415009959; 28680.099,0.432886519; 28740.003,0.414807667; 28800.047,
          0.422435888; 28860.082,0.4107094; 28920.076,0.441941912; 28980.052,
          0.447019088; 29040.076,0.424959178; 29100.008,0.415654404; 29160.088,
          0.435363365; 29220.009,0.436551966; 29280.015,0.434151971; 29340.055,
          0.425354432; 29400.055,0.432191072; 29460.085,0.453880454; 29520.075,
          0.42137903; 29580.033,0.445345567; 29640.1,0.446320371; 29700.1,
          0.424629462; 29760.013,0.452655839; 29820.054,0.447614248; 29880.075,
          0.457611223; 29940.074,0.438700169; 30000.075,0.436047093; 30060.055,
          0.447083313; 30120.026,0.451644327; 30180.017,0.43358977; 30240.075,
          0.434839589; 30300.065,0.429019878; 30360.038,0.449897654; 30420.095,
          0.42718879; 30480.079,0.463275325; 30540.024,0.433198646; 30600.012,
          0.456880407; 30660.103,0.445061435; 30720.077,0.419292475; 30780.057,
          0.450615274; 30840.101,0.451189168; 30900.04,0.4496856; 30960.054,
          0.43747424; 31020.103,0.440779994; 31080.062,0.442930369; 31140.011,
          0.460309025; 31200.075,0.459229804; 31260.015,0.456060352; 31320.02,
          0.480734483; 31380.022,0.452235811; 31440.088,0.432227516; 31500.012,
          0.440204357; 31560.021,0.44552941; 31620.026,0.436882946; 31680.071,
          0.43157701; 31740.055,0.434433047; 31800.009,0.465922315; 31860.041,
          0.446027553; 31920.034,0.432749334; 31980.1,0.447291501; 32040.025,
          0.465279613; 32100.061,0.459370259; 32160.089,0.449034235; 32220.06,
          0.434322783; 32280.099,0.433303682; 32340.091,0.443416124; 32400.035,
          0.437281255; 32460.056,0.442646237; 32520.046,0.444723915; 32580.057,
          0.459098705; 32640.097,0.431929734; 32700.041,0.473980564; 32760.015,
          0.461051775; 32820.088,0.479211392; 32880.04,0.45325033; 32940.053,
          0.452569203; 33000,0.461500228; 33060.07,0.448284945; 33120.05,
          0.480665676; 33180.014,0.410840284; 33240.06,0.457042532; 33300.013,
          0.446819588; 33360.062,0.45391172; 33420.045,0.46824503; 33480.041,
          0.443282233; 33540.056,0.478411959; 33600.057,0.47040865; 33660.054,
          0.477117223; 33720.04,0.48400291; 33780.015,0.500944403; 33840.072,
          0.486701809; 33900.096,0.446779229; 33960.072,0.459353528; 34020.036,
          0.467593855; 34080.072,0.488006545; 34140.038,0.459449018; 34200.067,
          0.457376138; 34260.095,0.461152707; 34320.032,0.434405266; 34380.079,
          0.455723476; 34440.046,0.45102616; 34500.081,0.474069729; 34560.081,
          0.499240069; 34620.009,0.47145379; 34680.039,0.474814246; 34740.003,
          0.476507505; 34800.099,0.499429355; 34860.023,0.488435641; 34920.025,
          0.454969198; 34980.097,0.46863551; 35040.029,0.432289378; 35100.067,
          0.479807196; 35160.073,0.471625247; 35220.076,0.465848925; 35280.056,
          0.481875327; 35340.025,0.477898184; 35400.048,0.465450425; 35460.038,
          0.483651069; 35520.092,0.467287815; 35580.097,0.459943055; 35640.096,
          0.468630092; 35700.015,0.472241051; 35760.034,0.468898161; 35820.068,
          0.451679912; 35880.02,0.487939861; 35940.003,0.452294404; 36000.057,
          0.490737521; 36060.051,0.471011424; 36120.037,0.476826815; 36180.089,
          0.487530073; 36240.041,0.46548255; 36300.013,0.471488945; 36360.08,
          0.483766535; 36420.064,0.484379285; 36480.013,0.461600491; 36540.1,
          0.446860399; 36600.091,0.474997875; 36660.013,0.468430616; 36720.081,
          0.455747342; 36780.083,0.492615053; 36840.049,0.46666096; 36900.094,
          0.496216705], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
      annotation (Placement(transformation(extent={{-104,-66},{-84,-46}})));
  protected
    Modelica.Blocks.Math.Gain gain(k=1/3600)
      annotation (Placement(transformation(extent={{-74,-66},{-54,-46}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      p_b_start=data.p_co_rp,
      T_a_start=data.T_hx_co,
      T_b_start=data.T_co_rp,
      m_flow_start=data.m_flow,
      redeclare model EfficiencyChar =
          TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant
          (eta_constant=0.7027),
      controlType="m_flow",
      use_port=true)
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_vc_rp(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS316,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{152,60},{172,80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_vc(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS316,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{192,38},{172,58}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_hx(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_rp_hx, length=data.length_rp_hx),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS316,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{204,60},{184,80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_vc_rp(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material_wall = TRANSFORM.Media.Solids.SS316)
      annotation (Placement(transformation(extent={{-152,80},{-132,100}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_vc(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{-128,40},{-148,60}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_hx(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.length_rp_hx),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{46,-36},{26,-16}})));
  equation
    connect(sensor_hx_cw.port_b, boundary.ports[1])
      annotation (Line(points={{-4,12},{36,12}}, color={0,127,255}));
    connect(hx.port_a2, sensor_hx_cw.port_a) annotation (Line(points={{-34,-6},{-28,
            -6},{-28,12},{-24,12}}, color={0,127,255}));
    connect(sensor_cw_hx.port_b, hx.port_b2) annotation (Line(points={{-68,14},{-60,
            14},{-60,-6},{-54,-6}}, color={0,127,255}));
    connect(boundary1.ports[1], sensor_cw_hx.port_a)
      annotation (Line(points={{-150,14},{-88,14}}, color={0,127,255}));
    connect(sensor_rp_hx_2.port_b, hx.port_b1) annotation (Line(points={{-20,-26},
            {-28,-26},{-28,-14},{-34,-14}}, color={0,127,255}));
    connect(hx.port_a1, sensor_hx_co.port_a) annotation (Line(points={{-54,-14},{
            -60,-14},{-60,-26},{-66,-26}}, color={0,127,255}));
    connect(sensor_hx_co.port_b, valve_ps.port_b)
      annotation (Line(points={{-86,-26},{-148,-26}}, color={0,127,255}));
    connect(opening_valve_tank.y, valve_ps.opening) annotation (Line(points={{-187,-6},
            {-158,-6},{-158,-18}},       color={0,0,127}));
    connect(sensor_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{6,52},{-26,
            52},{-26,64},{-34,64}}, color={0,127,255}));
    connect(sensor_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{-90,90},
            {-60,90},{-60,72},{-54,72}},     color={0,127,255}));
    connect(rp.port_b1, sensor_rp_hx_1.port_a) annotation (Line(points={{-34,72},
            {-4,72},{-4,88},{4,88}}, color={0,127,255}));
    connect(rp.port_b2, sensor_rp_pipe_vc.port_a) annotation (Line(points={{-54,64},
            {-84,64},{-84,50},{-90,50}},     color={0,127,255}));
    connect(sensor_pipe_vc.port_b, vc.port_a)
      annotation (Line(points={{-184,50},{-236,50},{-236,54}},
                                                     color={0,127,255}));
    connect(vc.port_b, resistance.port_a)
      annotation (Line(points={{-236,66},{-236,71}}, color={0,127,255}));
    connect(sensor_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{-190,90},
            {-237,90},{-237,85},{-236,85}},          color={0,127,255}));
    connect(ps.ports[1], valve_ps.port_a) annotation (Line(points={{-218,-26},{
            -168,-26}},                  color={0,127,255}));
    connect(pipe_hx_co.port_b, volume_co.port_a)
      annotation (Line(points={{-98,-90},{-70,-90}}, color={0,127,255}));
    connect(pipe_hx_co.port_a, valve_ps.port_b) annotation (Line(points={{-118,
            -90},{-136,-90},{-136,-26},{-148,-26}}, color={0,127,255}));
    connect(sensor_co_rp_2.port_b, pipe_co_rp.port_a)
      annotation (Line(points={{20,-90},{48,-90}}, color={0,127,255}));
    connect(pipe_co_rp.port_b, sensor_co_rp_1.port_a) annotation (Line(points={{
            68,-90},{82,-90},{82,52},{26,52}}, color={0,127,255}));
    connect(combiTimeTable.y[1],gain. u)
      annotation (Line(points={{-83,-56},{-76,-56}}, color={0,0,127}));
    connect(gain.y, co.inputSignal)
      annotation (Line(points={{-53,-56},{-30,-56},{-30,-83}}, color={0,0,127}));
    connect(volume_co.port_b, co.port_a)
      annotation (Line(points={{-58,-90},{-40,-90}}, color={0,127,255}));
    connect(co.port_b, sensor_co_rp_2.port_a)
      annotation (Line(points={{-20,-90},{0,-90}}, color={0,127,255}));
    connect(pipe_ins_vc_rp.port_a, sensor_vc_pipe.port_b)
      annotation (Line(points={{-152,90},{-170,90}}, color={0,127,255}));
    connect(sensor_pipe_vc.port_a, pipe_ins_rp_vc.port_b)
      annotation (Line(points={{-164,50},{-148,50}}, color={0,127,255}));
    connect(sensor_rp_pipe_vc.port_b, pipe_ins_rp_vc.port_a)
      annotation (Line(points={{-110,50},{-128,50}}, color={0,127,255}));
    connect(sensor_vc_pipe_rp.port_a, pipe_ins_vc_rp.port_b)
      annotation (Line(points={{-110,90},{-132,90}}, color={0,127,255}));
    connect(sensor_rp_hx_2.port_a, pipe_ins_rp_hx.port_b)
      annotation (Line(points={{0,-26},{26,-26}}, color={0,127,255}));
    connect(pipe_ins_rp_hx.port_a, sensor_rp_hx_1.port_b) annotation (Line(points=
           {{46,-26},{68,-26},{68,88},{24,88}}, color={0,127,255}));
    annotation (experiment(
        StopTime=40000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"),
      Diagram(coordinateSystem(extent={{-300,-120},{100,120}})),
      Icon(coordinateSystem(extent={{-300,-120},{100,120}})));
  end MAGNET_Insulated_pipes;

  model Magnet_PID
    extends TRANSFORM.Icons.Example;

    package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    NHES.ExperimentalSystems.MAGNET.Data.Data_base data
      annotation (Placement(transformation(extent={{120,100},{140,120}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{100,98},{120,118}})));
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=0.1,
      V_2=0.1,
      UA=PID.y,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));
    TRANSFORM.HeatExchangers.Simple_HX  hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      nV=10,
      V_1=0.1,
      V_2=0.1,
      UA=PID1.y,
      p_a_start_1=data.p_rp_hx,
      p_b_start_1=data.p_hx_co,
      T_a_start_1=data.T_rp_hx,
      T_b_start_1=data.T_hx_co,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_cw_hx,
      p_b_start_2=data.p_hx_cw,
      T_a_start_2=data.T_cw_hx,
      T_b_start_2=data.T_hx_cw,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow)
      annotation (Placement(transformation(extent={{0,-30},{-20,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1) annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={60,-20})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-78,-20})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{10,30},{30,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT5(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-40,-60})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-40,40})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{30,-10},{10,10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_vc_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-78,40})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary6(
      redeclare package Medium = Medium,
      p=data.p_rp_vc,
      T=data.T_rp_vc,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-80,0})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
      redeclare package Medium = Medium,
      p=data.p_rp_hx,
      T=data.T_rp_hx,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={60,40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary7(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_co_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={58,0})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_rp_hx,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={58,-60})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_hx_co,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-80,-60})));
    TRANSFORM.HeatExchangers.LMTD_HX_UA rp1(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      p_start_1=data.p_vc_rp,
      p_start_2=data.p_co_rp,
      T_start_1=data.T_vc_rp,
      T_start_2=data.T_co_rp,
      m_flow_start_1=data.m_flow,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow,
      Q_flow0=data.Q_flow_rp)
      annotation (Placement(transformation(extent={{-180,10},{-160,30}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-150,30},{-130,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-190,-10},{-210,10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT11(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-200,40})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT12(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-130,-10},{-150,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary8(
      redeclare package Medium = Medium,
      p=data.p_rp_hx,
      T=data.T_rp_hx,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-100,40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary9(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_vc_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-238,40})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary10(
      redeclare package Medium = Medium,
      p=data.p_rp_vc,
      T=data.T_rp_vc,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-240,0})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary11(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_co_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-102,0})));
    TRANSFORM.HeatExchangers.LMTD_HX_UA hx1(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      p_start_1=data.p_rp_hx,
      p_start_2=data.p_cw_hx,
      T_start_1=data.T_rp_hx,
      T_start_2=data.T_cw_hx,
      m_flow_start_1=data.m_flow,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow,
      Q_flow0=data.Q_flow_hx)
      annotation (Placement(transformation(extent={{-160,-30},{-180,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary12(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-100,-20})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary13(
      redeclare package Medium = Medium_cw,
      m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
      nPorts=1)   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-238,-20})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT13(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-200,-60})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT14(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-150,-30},{-130,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT15(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-210,-30},{-190,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT16(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-130,-70},{-150,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary14(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_hx_co,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-240,-60})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary15(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_rp_hx,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-102,-60})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold2(
      val=rp.port_a2.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-20,-2},{0,10}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot2(
      val=rp.port_a1.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-20,-10},{0,2}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot14(
      val=rp.Q_flow/1e3,
      precision=1,
      unitLabel="kW")
      annotation (Placement(transformation(extent={{-20,26},{0,38}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot1(
      val=rp1.port_a1.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-180,-10},{-160,2}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold1(
      val=rp1.port_a2.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-180,-2},{-160,10}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot1(
      val=rp1.Q_flow/1e3,
      precision=1,
      unitLabel="kW")
      annotation (Placement(transformation(extent={{-180,26},{-160,38}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot3(
      val=hx1.port_a1.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-180,-66},{-160,-54}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold3(
      val=hx1.port_a2.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-180,-58},{-160,-46}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot2(
      val=hx1.Q_flow/1e3,
      precision=1,
      unitLabel="kW")
      annotation (Placement(transformation(extent={{-180,-30},{-160,-18}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot4(
      val=hx.port_a1.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-20,-66},{0,-54}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold4(
      val=hx.port_a2.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-20,-58},{0,-46}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot3(
      val=hx.Q_flow/1e3,
      precision=1,
      unitLabel="kW")
      annotation (Placement(transformation(extent={{-20,-30},{0,-18}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot4(val=rp1.UA
          /1e3, precision=4)
      annotation (Placement(transformation(extent={{-148,14},{-128,26}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot5(val=hx1.UA
          /1e3, precision=4)
      annotation (Placement(transformation(extent={{-148,-46},{-128,-34}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yb=1017.56006,
      k_s=1/data.Q_flow_rp,
      k_m=1/data.Q_flow_rp,
      yMin=0) annotation (Placement(transformation(extent={{138,20},{158,40}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=data.Q_flow_rp)
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=rp.Q_flow)
      annotation (Placement(transformation(extent={{100,-2},{120,18}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=100,
      yb=2037.7781,
      k_s=1/data.Q_flow_hx,
      k_m=1/data.Q_flow_hx,
      yMin=0) annotation (Placement(transformation(extent={{140,-44},{160,-24}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data.Q_flow_hx)
      annotation (Placement(transformation(extent={{102,-44},{122,-24}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=hx.Q_flow)
      annotation (Placement(transformation(extent={{102,-66},{122,-46}})));
  equation
    connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{0,24},{6,24},
            {6,40},{10,40}},  color={0,127,255}));
    connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{-20,16},{-26,
            16},{-26,0},{-30,0}},
                              color={0,127,255}));
    connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{-30,40},{-26,
            40},{-26,24},{-20,24}},
                              color={0,127,255}));
    connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{10,0},{6,0},
            {6,16},{0,16}},   color={0,127,255}));
    connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-30,-60},{
            -26,-60},{-26,-44},{-20,-44}},
                                       color={0,127,255}));
    connect(boundary1.ports[1], sensor_pT9.port_a)
      annotation (Line(points={{-68,-20},{-50,-20}},  color={0,127,255}));
    connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-30,-20},{
            -26,-20},{-26,-36},{-20,-36}},
                                       color={0,127,255}));
    connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{0,-36},{6,
            -36},{6,-20},{10,-20}},    color={0,127,255}));
    connect(sensor_pT4.port_b, boundary.ports[1])
      annotation (Line(points={{30,-20},{50,-20}},  color={0,127,255}));
    connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{0,-44},{6,
            -44},{6,-60},{10,-60}},    color={0,127,255}));
    connect(sensor_pT6.port_b,boundary6. ports[1])
      annotation (Line(points={{-50,0},{-70,0}},   color={0,127,255}));
    connect(boundary3.ports[1], sensor_pT7.port_a)
      annotation (Line(points={{-68,40},{-50,40}}, color={0,127,255}));
    connect(sensor_pT3.port_b, boundary2.ports[1])
      annotation (Line(points={{30,40},{50,40}}, color={0,127,255}));
    connect(sensor_pT8.port_a, boundary7.ports[1])
      annotation (Line(points={{30,0},{48,0}}, color={0,127,255}));
    connect(boundary5.ports[1], sensor_pT10.port_a)
      annotation (Line(points={{48,-60},{30,-60}}, color={0,127,255}));
    connect(boundary4.ports[1], sensor_pT5.port_b)
      annotation (Line(points={{-70,-60},{-50,-60}}, color={0,127,255}));
    connect(rp1.port_b1, sensor_pT1.port_a) annotation (Line(points={{-160,24},{
            -154,24},{-154,40},{-150,40}}, color={0,127,255}));
    connect(rp1.port_b2, sensor_pT2.port_a) annotation (Line(points={{-180,16},{
            -186,16},{-186,0},{-190,0}}, color={0,127,255}));
    connect(sensor_pT11.port_b, rp1.port_a1) annotation (Line(points={{-190,40},{
            -186,40},{-186,24},{-180,24}}, color={0,127,255}));
    connect(sensor_pT12.port_b, rp1.port_a2) annotation (Line(points={{-150,0},{
            -154,0},{-154,16},{-160,16}}, color={0,127,255}));
    connect(boundary9.ports[1], sensor_pT11.port_a)
      annotation (Line(points={{-228,40},{-210,40}}, color={0,127,255}));
    connect(sensor_pT1.port_b,boundary8. ports[1])
      annotation (Line(points={{-130,40},{-110,40}},
                                                 color={0,127,255}));
    connect(sensor_pT12.port_a, boundary11.ports[1])
      annotation (Line(points={{-130,0},{-112,0}}, color={0,127,255}));
    connect(sensor_pT2.port_b, boundary10.ports[1])
      annotation (Line(points={{-210,0},{-230,0}}, color={0,127,255}));
    connect(sensor_pT13.port_a, hx1.port_b1) annotation (Line(points={{-190,-60},
            {-186,-60},{-186,-44},{-180,-44}}, color={0,127,255}));
    connect(boundary13.ports[1], sensor_pT15.port_a)
      annotation (Line(points={{-228,-20},{-210,-20}}, color={0,127,255}));
    connect(sensor_pT15.port_b, hx1.port_a2) annotation (Line(points={{-190,-20},
            {-186,-20},{-186,-36},{-180,-36}}, color={0,127,255}));
    connect(hx1.port_b2, sensor_pT14.port_a) annotation (Line(points={{-160,-36},
            {-154,-36},{-154,-20},{-150,-20}}, color={0,127,255}));
    connect(sensor_pT14.port_b, boundary12.ports[1])
      annotation (Line(points={{-130,-20},{-110,-20}}, color={0,127,255}));
    connect(hx1.port_a1, sensor_pT16.port_b) annotation (Line(points={{-160,-44},
            {-154,-44},{-154,-60},{-150,-60}}, color={0,127,255}));
    connect(boundary14.ports[1], sensor_pT13.port_b)
      annotation (Line(points={{-230,-60},{-210,-60}}, color={0,127,255}));
    connect(boundary15.ports[1], sensor_pT16.port_a)
      annotation (Line(points={{-112,-60},{-130,-60}}, color={0,127,255}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{121,8},{148,8},{148,18}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{121,30},{136,30}}, color={0,0,127}));
    connect(realExpression3.y, PID1.u_m)
      annotation (Line(points={{123,-56},{150,-56},{150,-46}}, color={0,0,127}));
    connect(realExpression2.y, PID1.u_s)
      annotation (Line(points={{123,-34},{138,-34}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
              {140,120}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
      experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
  end Magnet_PID;

  model Magnet_PID_1
    extends TRANSFORM.Icons.Example;

    package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{100,98},{120,118}})));
  protected
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=0.1,
      V_2=0.1,
      UA=PID.y,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{10,30},{30,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-40,40})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{30,-10},{10,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
      redeclare package Medium = Medium,
      p=data.p_rp_hx,
      T=data.T_rp_hx,
      nPorts=1)                                                       annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={60,40})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary7(
      redeclare package Medium = Medium,
      m_flow=data.m_flow,
      T=data.T_co_rp,
      nPorts=1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={58,0})));
  public
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold2(
      val=rp.port_a2.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-20,-2},{0,10}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot2(
      val=rp.port_a1.m_flow,
      precision=1,
      unitLabel="kg/s")
      annotation (Placement(transformation(extent={{-20,-10},{0,2}})));
    TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot14(
      val=rp.Q_flow/1e3,
      precision=1,
      unitLabel="kW")
      annotation (Placement(transformation(extent={{-20,26},{0,38}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yb=1017.56006,
      k_s=1/data.Q_flow_rp,
      k_m=1/data.Q_flow_rp,
      yMin=0) annotation (Placement(transformation(extent={{138,20},{158,40}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=data.Q_flow_rp)
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=rp.Q_flow)
      annotation (Placement(transformation(extent={{100,-2},{120,18}})));
  protected
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=data.Q_vc) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-162,12})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-150,30},{-130,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-130,-10},{-150,10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow) annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-162,30})));
  public
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.d_vc_rp))
      annotation (Placement(transformation(extent={{-288,56},{-268,76}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.d_rp_vc))
      annotation (Placement(transformation(extent={{-246,-32},{-266,-12}})));
  protected
    NHES.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-168,98},{-148,118}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_vc_rp(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS304,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_vc(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS304,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{-84,-10},{-104,10}})));
  equation
    connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{0,24},{6,24},
            {6,40},{10,40}},  color={0,127,255}));
    connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{-20,16},{-26,
            16},{-26,0},{-30,0}},
                              color={0,127,255}));
    connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{-30,40},{-26,
            40},{-26,24},{-20,24}},
                              color={0,127,255}));
    connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{10,0},{6,0},
            {6,16},{0,16}},   color={0,127,255}));
    connect(sensor_pT3.port_b, boundary2.ports[1])
      annotation (Line(points={{30,40},{50,40}}, color={0,127,255}));
    connect(sensor_pT8.port_a, boundary7.ports[1])
      annotation (Line(points={{30,0},{48,0}}, color={0,127,255}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{121,8},{148,8},{148,18}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{121,30},{136,30}}, color={0,0,127}));
    connect(sensor_pT2.port_b, vc.port_a)
      annotation (Line(points={{-150,0},{-162,0},{-162,6}}, color={0,127,255}));
    connect(vc.port_b, resistance.port_a)
      annotation (Line(points={{-162,18},{-162,23}}, color={0,127,255}));
    connect(resistance.port_b, sensor_pT1.port_a) annotation (Line(points={{-162,
            37},{-162,40},{-150,40}}, color={0,127,255}));
    connect(sensor_pT1.port_b, ins_vc_rp.port_a)
      annotation (Line(points={{-130,40},{-110,40}}, color={0,127,255}));
    connect(ins_vc_rp.port_b, sensor_pT7.port_a)
      annotation (Line(points={{-90,40},{-50,40}}, color={0,127,255}));
    connect(sensor_pT2.port_a, ins_rp_vc.port_b)
      annotation (Line(points={{-130,0},{-104,0}}, color={0,127,255}));
    connect(ins_rp_vc.port_a, sensor_pT6.port_b)
      annotation (Line(points={{-84,0},{-50,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
              {140,120}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
      experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
  end Magnet_PID_1;

  model MAGNET_PID_3
    extends TRANSFORM.Icons.Example;

    package Medium =  Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{100,98},{120,118}})));
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=1,
      V_2=1,
      UA=PID1.y,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    TRANSFORM.HeatExchangers.Simple_HX  hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      nV=10,
      V_1=1,
      V_2=1,
      UA=PID2.y,
      p_a_start_1=data.p_rp_hx,
      p_b_start_1=data.p_hx_co,
      T_a_start_1=data.T_rp_hx,
      T_b_start_1=data.T_hx_co,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_cw_hx,
      p_b_start_2=data.p_hx_cw,
      T_a_start_2=data.T_cw_hx,
      T_b_start_2=data.T_hx_cw,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow)
      annotation (Placement(transformation(extent={{-40,-30},{-60,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1) annotation (
       Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={20,-20})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-118,-20})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{50,70},{70,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT5(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-80,-60})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{10,30},{-10,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                             annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={0,80})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{70,30},{50,50}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
      redeclare package Medium = Medium_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=data.Q_vc) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-92,52})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
      redeclare package Medium = Medium,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow) annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-92,70})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      T_a_start=data.T_hx_co,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_hx_co, length=data.length_hx_co))
      annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_co_rp,
      T_a_start=data.T_co_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_co_rp, length=data.length_co_rp))
                                                         annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={100,-30})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
          Medium, m_flow_nominal=data.m_flow)
      annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      Q_gen=PID.y)
      annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e3,
      yb=data.Q_flow_co,
      k_s=1/data.T_co_rp,
      k_m=1/data.T_co_rp,
      yMin=0)
      annotation (Placement(transformation(extent={{-174,-88},{-154,-68}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=data.T_co_rp)
      annotation (Placement(transformation(extent={{-212,-88},{-192,-68}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=sensor_pT8.T)
      annotation (Placement(transformation(extent={{-212,-110},{-192,-90}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT tank(
      redeclare package Medium = Medium,
      use_p_in=false,
      p=data.p_hx_co,
      T=data.T_ps,
      nPorts=1)
      annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));
    TRANSFORM.Fluid.Valves.ValveIncompressible valve_tank(
      redeclare package Medium = Medium,
      showName=false,
      dp_nominal(displayUnit="Pa") = 1e4,
      m_flow_nominal=1,
      opening_nominal=0.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-150,-40})));
    Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
      annotation (Placement(transformation(extent={{-220,-30},{-200,-10}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yb=1017.56006,
      k_s=1/data.Q_flow_rp,
      k_m=1/data.Q_flow_rp,
      yMin=0) annotation (Placement(transformation(extent={{178,36},{198,56}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data.Q_flow_rp)
      annotation (Placement(transformation(extent={{140,36},{160,56}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=rp.Q_flow)
      annotation (Placement(transformation(extent={{140,14},{160,34}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=10,
      yb=2037.7781,
      k_s=1/data.Q_flow_hx,
      k_m=1/data.Q_flow_hx,
      yMin=0) annotation (Placement(transformation(extent={{180,-28},{200,-8}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=data.Q_flow_hx)
      annotation (Placement(transformation(extent={{142,-28},{162,-8}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=hx.Q_flow)
      annotation (Placement(transformation(extent={{142,-50},{162,-30}})));
    NHES.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-210,86},{-190,106}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.d_vc_rp))
      annotation (Placement(transformation(extent={{-308,58},{-288,78}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.d_rp_vc))
      annotation (Placement(transformation(extent={{-310,36},{-330,56}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_hx(
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.d_rp_hx))
      annotation (Placement(transformation(extent={{-330,66},{-350,86}})));
  protected
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_vc_rp(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS304,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_vc(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS304,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{-24,30},{-44,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_hx(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_rp_hx, length=data.length_rp_hx),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS304,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{42,-70},{22,-50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_vc(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{-162,2},{-182,22}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_vc_rp(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material_wall = TRANSFORM.Media.Solids.SS316)
      annotation (Placement(transformation(extent={{-192,54},{-172,74}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_hx(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.length_rp_hx),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{-174,32},{-194,52}})));
  equation
    connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{40,64},{46,64},
            {46,80},{50,80}}, color={0,127,255}));
    connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{20,56},{14,56},
            {14,40},{10,40}}, color={0,127,255}));
    connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{10,80},{14,80},
            {14,64},{20,64}}, color={0,127,255}));
    connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{50,40},{46,40},
            {46,56},{40,56}}, color={0,127,255}));
    connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-70,-60},{-66,
            -60},{-66,-44},{-60,-44}}, color={0,127,255}));
    connect(boundary1.ports[1], sensor_pT9.port_a)
      annotation (Line(points={{-108,-20},{-90,-20}}, color={0,127,255}));
    connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-70,-20},{-66,
            -20},{-66,-36},{-60,-36}}, color={0,127,255}));
    connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{-40,-36},{-34,
            -36},{-34,-20},{-30,-20}}, color={0,127,255}));
    connect(sensor_pT4.port_b, boundary.ports[1])
      annotation (Line(points={{-10,-20},{10,-20}}, color={0,127,255}));
    connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{-40,-44},{-34,
            -44},{-34,-60},{-30,-60}}, color={0,127,255}));
    connect(sensor_pT2.port_b, vc.port_a)
      annotation (Line(points={{-80,40},{-92,40},{-92,46}}, color={0,127,255}));
    connect(vc.port_b, resistance.port_a)
      annotation (Line(points={{-92,58},{-92,63}}, color={0,127,255}));
    connect(resistance.port_b, sensor_pT1.port_a)
      annotation (Line(points={{-92,77},{-92,80},{-80,80}}, color={0,127,255}));
    connect(pipe_hx_co.port_a, sensor_pT5.port_b) annotation (Line(points={{-60,
            -90},{-100,-90},{-100,-60},{-90,-60}}, color={0,127,255}));
    connect(pipe_co_rp.port_b, sensor_pT8.port_a)
      annotation (Line(points={{100,-20},{100,40},{70,40}}, color={0,127,255}));
    connect(pump.port_b, pipe_co_rp.port_a) annotation (Line(points={{80,-90},{
            100,-90},{100,-40}}, color={0,127,255}));
    connect(pipe_hx_co.port_b, volume1.port_a)
      annotation (Line(points={{-40,-90},{14,-90}}, color={0,127,255}));
    connect(volume1.port_b, pump.port_a)
      annotation (Line(points={{26,-90},{60,-90}}, color={0,127,255}));
    connect(realExpression1.y, PID.u_m) annotation (Line(points={{-191,-100},{
            -164,-100},{-164,-90}}, color={0,0,127}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-191,-78},{-176,-78}}, color={0,0,127}));
    connect(tank.ports[1],valve_tank. port_a)
      annotation (Line(points={{-170,-40},{-160,-40}},   color={0,127,255}));
    connect(opening_valve_tank.y,valve_tank. opening) annotation (Line(points={{-199,
            -20},{-150,-20},{-150,-32}},    color={0,0,127},
        pattern=LinePattern.Dash));
    connect(valve_tank.port_b, sensor_pT5.port_b) annotation (Line(points={{-140,
            -40},{-100,-40},{-100,-60},{-90,-60}}, color={0,127,255}));
    connect(realExpression3.y, PID1.u_m)
      annotation (Line(points={{161,24},{188,24},{188,34}}, color={0,0,127}));
    connect(realExpression2.y, PID1.u_s)
      annotation (Line(points={{161,46},{176,46}}, color={0,0,127}));
    connect(realExpression5.y, PID2.u_m)
      annotation (Line(points={{163,-40},{190,-40},{190,-30}}, color={0,0,127}));
    connect(realExpression4.y, PID2.u_s)
      annotation (Line(points={{163,-18},{178,-18}}, color={0,0,127}));
    connect(sensor_pT2.port_a, ins_rp_vc.port_b)
      annotation (Line(points={{-60,40},{-44,40}}, color={0,127,255}));
    connect(ins_rp_vc.port_a, sensor_pT6.port_b)
      annotation (Line(points={{-24,40},{-10,40}}, color={0,127,255}));
    connect(sensor_pT1.port_b, ins_vc_rp.port_a)
      annotation (Line(points={{-60,80},{-46,80}}, color={0,127,255}));
    connect(ins_vc_rp.port_b, sensor_pT7.port_a)
      annotation (Line(points={{-26,80},{-10,80}}, color={0,127,255}));
    connect(sensor_pT10.port_a, ins_rp_hx.port_b)
      annotation (Line(points={{-10,-60},{22,-60}}, color={0,127,255}));
    connect(ins_rp_hx.port_a, sensor_pT3.port_b) annotation (Line(points={{42,
            -60},{88,-60},{88,80},{70,80}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
              {140,120}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
      experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
  end MAGNET_PID_3;

  model MAGNET_TEDS_Boundaries_1
    extends TRANSFORM.Icons.Example;

  protected
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{190,-76},{210,-56}})));

  public
    TRANSFORM.HeatExchangers.Simple_HX MAGNET_TEDS_simpleHX(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      nV=10,
      V_1=1,
      V_2=1,
      UA=PID1.y,
      p_a_start_1=data.p_vc_rp + 100,
      p_b_start_1=data.p_vc_rp,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=773.15,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_TEDS_in,
      p_b_start_2=data.p_TEDS_out,
      T_a_start_2=data.T_cold_side,
      T_b_start_2=data.T_hot_side,
      m_flow_start_2=boundary_TEDS_in.m_flow)
      annotation (Placement(transformation(extent={{-30,-50},{-10,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort TM_HX_exit_Temp(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        precision=3)
      annotation (Placement(transformation(extent={{-78,-46},{-58,-26}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1,
      yb=0,
      k_s=1/data.Q_MAGNET_TEDS,
      k_m=1/data.Q_MAGNET_TEDS,
      yMin=0,
      strict=false)
              annotation (Placement(transformation(extent={{288,-150},{308,-130}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data.Q_MAGNET_TEDS)
      annotation (Placement(transformation(extent={{248,-150},{268,-130}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=
          MAGNET_TEDS_simpleHX.Q_flow)
      annotation (Placement(transformation(extent={{266,-178},{286,-158}})));
  protected
    inner TRANSFORM.Fluid.System system(
      p_ambient=18000,
      T_ambient=498.15,
      m_flow_start=0.84)
      annotation (Placement(transformation(extent={{190,-110},{210,-90}})));
  protected
    NHES.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{188,-136},{208,-116}})));
  protected
    package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

  protected
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_TEDS_out(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      p=data.p_TEDS_out,
      T=data.T_hot_side,
      nPorts=1)
      annotation (Placement(transformation(extent={{-162,-46},{-142,-26}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_TEDS_in(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=false,
      m_flow=data.TEDS_nominal_flow_rate,
      T=data.T_cold_side,
      nPorts=1)
      annotation (Placement(transformation(extent={{76,-42},{56,-22}})));
  protected
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,
      nPorts=1)
      annotation (Placement(transformation(extent={{172,-250},{152,-230}})));
  public
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_cw(
      redeclare package Medium = Medium_cw,
      p_start=data.p_hx_cw,
      T_start=data.T_hx_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{92,-250},{112,-230}})));
  protected
    TRANSFORM.HeatExchangers.Simple_HX hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_hx,
      p_a_start_1=data.p_rp_hx,
      p_b_start_1=data.p_hx_co,
      T_a_start_1=data.T_rp_hx,
      T_b_start_1=data.T_hx_co,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_cw_hx,
      p_b_start_2=data.p_hx_cw,
      T_a_start_2=data.T_cw_hx,
      T_b_start_2=data.T_hx_cw,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow)
      annotation (Placement(transformation(extent={{62,-252},{82,-272}})));
  public
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
      redeclare package Medium = Medium_cw,
      p_start=data.p_cw_hx,
      T_start=data.T_cw_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{28,-248},{48,-228}})));
  protected
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,
      use_m_flow_in=true,
      m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
      nPorts=1)
      annotation (Placement(transformation(extent={{-54,-248},{-34,-228}})));
  public
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_2(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{116,-288},{96,-268}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
      redeclare package Medium = Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{50,-288},{30,-268}})));
  protected
    TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
      redeclare package Medium = Medium,
      dp_nominal(displayUnit="Pa") = 1e4,
      m_flow_nominal=1,
      opening_nominal=0.5)
      annotation (Placement(transformation(extent={{-52,-288},{-32,-268}})));
    Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
      annotation (Placement(transformation(extent={{-86,-268},{-66,-248}})));
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_rp,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{62,-194},{82,-174}})));
  public
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_co_rp_1(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{142,-210},{122,-190}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_hx_1(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{120,-174},{140,-154}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe_rp(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{34,-172},{54,-152}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{26,-212},{6,-192}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=3,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-102,-172},{-82,-152}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=3,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-48,-212},{-68,-192}})));
  protected
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=data.Q_vc)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-120,-192})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-120,-174})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(
      redeclare package Medium = Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      Q_gen=0) "12022.6"
                    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={52,-342})));
  public
    TRANSFORM.Fluid.Sensors.MassFlowRate mflow_MAGNET(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=2)
      annotation (Placement(transformation(extent={{116,-352},{136,-332}})));
  protected
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_ps,
      nPorts=1)
      annotation (Placement(transformation(extent={{-122,-288},{-102,-268}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      T_a_start=data.T_hx_co,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_hx_co, length=data.length_hx_co))
      annotation (Placement(transformation(extent={{-2,-352},{18,-332}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_co_rp,
      T_a_start=data.T_co_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_co_rp, length=data.length_co_rp))
      annotation (Placement(transformation(extent={{164,-352},{184,-332}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      p_b_start=data.p_co_rp,
      T_a_start=data.T_hx_co,
      T_b_start=data.T_co_rp,
      m_flow_start=data.m_flow,
      redeclare model EfficiencyChar =
          TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant
          (eta_constant=0.7027),
      controlType="m_flow",
      use_port=true)
      annotation (Placement(transformation(extent={{76,-352},{96,-332}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_vc_TEDS(
      ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp/2),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material_wall = TRANSFORM.Media.Solids.SS316)
      annotation (Placement(transformation(extent={{-74,-172},{-54,-152}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_vc(
      ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{-12,-212},{-32,-192}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_hx(
      ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.length_rp_hx),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{162,-288},{142,-268}})));
    Modelica.Blocks.Sources.Constant opening_valve_tank2(k=1)
      annotation (Placement(transformation(extent={{54,-112},{42,-100}})));
  public
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort T_vc_TEDS(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-42,-116})));
  protected
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_TEDS_rp(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-138})));
  public
    TRANSFORM.Fluid.Sensors.MassFlowRate m_flow_vc_TEDS(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      precision=2)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-42,-90})));
  protected
    Modelica.Blocks.Sources.Constant opening_valve_tank1(k=1)
      annotation (Placement(transformation(extent={{-70,-150},{-58,-138}})));
    Modelica.Blocks.Sources.Constant opening_valve_tank3(k=0)
      annotation (Placement(transformation(extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-20,-120})));
    Modelica.Blocks.Sources.RealExpression Tout_vc(y=pT_vc_pipe.T)
      annotation (Placement(transformation(extent={{-10,-336},{10,-316}})));
    Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-12,-314},{0,-302}})));
    Modelica.Blocks.Sources.RealExpression Tin_vc(y=pT_pipe_vc.T)
      annotation (Placement(transformation(extent={{-140,-262},{-120,-242}})));
    Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
      annotation (Placement(transformation(extent={{-144,-234},{-132,-222}})));
    Modelica.Blocks.Sources.Constant opening_valve_tank4(k=data.m_flow)
      annotation (Placement(transformation(extent={{290,-322},{270,-302}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_vc_rp(
      ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp/2),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material_wall = TRANSFORM.Media.Solids.SS316,
      pipe(flowModel(dps_fg(start={-128.03918155874314}))))
      annotation (Placement(transformation(extent={{6,-172},{26,-152}})));
    Modelica.Blocks.Sources.Constant Tin_vc_design1(k=265 + 273.15)
      annotation (Placement(transformation(extent={{-154,-216},{-142,-204}})));
  public
    TRANSFORM.Fluid.Sensors.MassFlowRate TEDS_flow_rate(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      p_start=data.p_TEDS_out,
      T_start=data.T_hot_side,
      precision=2)
      annotation (Placement(transformation(extent={{-96,-46},{-116,-26}})));
    TRANSFORM.Fluid.Valves.ValveLinear valve_vc_TEDS(
      redeclare package Medium = Medium,
      dp_nominal=3000,
      m_flow_nominal=1) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-42,-144})));
    TRANSFORM.Fluid.Valves.ValveLinear valve_TEDS_rp(
      redeclare package Medium = Medium,
      dp_nominal=3000,
      m_flow_nominal=1) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={0,-106})));
    TRANSFORM.Fluid.Valves.ValveLinear valve_vc_rp(
      redeclare package Medium = Medium,
      dp_nominal=3000,
      m_flow_nominal=1) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-20,-162})));
  public
    TRANSFORM.Controls.LimPID N2_mf_control(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=false,
      k=-0.025,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=10,
      yMin=0.001,
      Nd=1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=0.689)
      annotation (Placement(transformation(extent={{50,-318},{70,-298}})));
  public
    TRANSFORM.Controls.LimPID cw_mf_control(
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      with_FF=false,
      k=-0.001,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=5,
      yMin=0.001,
      Nd=1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=0.689)
      annotation (Placement(transformation(extent={{-112,-238},{-92,-218}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=1,
      k_m=1,
      yMin=0,
      y_start=300)
              annotation (Placement(transformation(extent={{284,-34},{304,-14}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=data.T_vc_rp)
      annotation (Placement(transformation(extent={{246,-34},{266,-14}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=pT_vc_pipe.T)
      annotation (Placement(transformation(extent={{246,-56},{266,-36}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=10,
      yb=2037.7781,
      k_s=1/data.Q_flow_hx,
      k_m=1/data.Q_flow_hx,
      yMin=0) annotation (Placement(transformation(extent={{286,-98},{306,-78}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=data.T_hx_co)
      annotation (Placement(transformation(extent={{248,-98},{268,-78}})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=sensor_hx_co.T)
      annotation (Placement(transformation(extent={{248,-120},{268,-100}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate mflow_cw(
      redeclare package Medium = Medium_cw,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=3)
      annotation (Placement(transformation(extent={{-10,-248},{10,-228}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort TM_HX_Tin(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        precision=3)
      annotation (Placement(transformation(extent={{26,-66},{46,-46}})));
  equation
    connect(MAGNET_TEDS_simpleHX.port_b2, TM_HX_exit_Temp.port_b) annotation (
       Line(points={{-30,-56},{-52,-56},{-52,-36},{-58,-36}},
                                                          color={0,127,255}));
    connect(realExpression2.y, PID1.u_s)
      annotation (Line(points={{269,-140},{286,-140}},
                                                     color={0,0,127}));
    connect(realExpression3.y, PID1.u_m) annotation (Line(points={{287,-168},{
            298,-168},{298,-152}},
                                 color={0,0,127}));
    connect(sensor_hx_cw.port_b,boundary. ports[1])
      annotation (Line(points={{112,-240},{152,-240}},
                                                 color={0,127,255}));
    connect(hx.port_a2,sensor_hx_cw. port_a) annotation (Line(points={{82,-258},
            {88,-258},{88,-240},{92,-240}},
                                    color={0,127,255}));
    connect(sensor_cw_hx.port_b,hx. port_b2) annotation (Line(points={{48,-238},
            {56,-238},{56,-258},{62,-258}},
                                    color={0,127,255}));
    connect(sensor_rp_hx_2.port_b,hx. port_b1) annotation (Line(points={{96,-278},
            {88,-278},{88,-266},{82,-266}}, color={0,127,255}));
    connect(hx.port_a1,sensor_hx_co. port_a) annotation (Line(points={{62,-266},
            {56,-266},{56,-278},{50,-278}},color={0,127,255}));
    connect(sensor_hx_co.port_b,valve_ps. port_b)
      annotation (Line(points={{30,-278},{-32,-278}}, color={0,127,255}));
    connect(opening_valve_tank.y,valve_ps. opening) annotation (Line(points={{-65,
            -258},{-4,-258},{-4,-270},{-42,-270}},
                                         color={0,0,127}));
    connect(pT_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{122,-200},
            {90,-200},{90,-188},{82,-188}}, color={0,127,255}));
    connect(pT_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{54,-162},
            {56,-162},{56,-180},{62,-180}},       color={0,127,255}));
    connect(rp.port_b1, pT_rp_hx_1.port_a) annotation (Line(points={{82,-180},
            {112,-180},{112,-164},{120,-164}}, color={0,127,255}));
    connect(rp.port_b2, pT_rp_pipe_vc.port_a) annotation (Line(points={{62,
            -188},{32,-188},{32,-202},{26,-202}}, color={0,127,255}));
    connect(pT_pipe_vc.port_b, vc.port_a) annotation (Line(points={{-68,-202},
            {-120,-202},{-120,-198}}, color={0,127,255}));
    connect(vc.port_b,resistance. port_a)
      annotation (Line(points={{-120,-186},{-120,-181}},
                                                     color={0,127,255}));
    connect(pT_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{
            -102,-162},{-120,-162},{-120,-167}}, color={0,127,255}));
    connect(ps.ports[1],valve_ps. port_a) annotation (Line(points={{-102,-278},
            {-52,-278}},                 color={0,127,255}));
    connect(pipe_hx_co.port_b,volume_co. port_a)
      annotation (Line(points={{18,-342},{46,-342}}, color={0,127,255}));
    connect(pipe_hx_co.port_a,valve_ps. port_b) annotation (Line(points={{-2,-342},
            {-20,-342},{-20,-278},{-32,-278}},      color={0,127,255}));
    connect(mflow_MAGNET.port_b, pipe_co_rp.port_a)
      annotation (Line(points={{136,-342},{164,-342}}, color={0,127,255}));
    connect(pipe_co_rp.port_b, pT_co_rp_1.port_a) annotation (Line(points={{
            184,-342},{198,-342},{198,-200},{142,-200}}, color={0,127,255}));
    connect(volume_co.port_b,co. port_a)
      annotation (Line(points={{58,-342},{76,-342}}, color={0,127,255}));
    connect(co.port_b, mflow_MAGNET.port_a)
      annotation (Line(points={{96,-342},{116,-342}}, color={0,127,255}));
    connect(pipe_vc_TEDS.port_a, pT_vc_pipe.port_b)
      annotation (Line(points={{-74,-162},{-82,-162}}, color={0,127,255}));
    connect(pT_pipe_vc.port_a, pipe_ins_rp_vc.port_b)
      annotation (Line(points={{-48,-202},{-32,-202}}, color={0,127,255}));
    connect(pT_rp_pipe_vc.port_b, pipe_ins_rp_vc.port_a)
      annotation (Line(points={{6,-202},{-12,-202}}, color={0,127,255}));
    connect(sensor_rp_hx_2.port_a,pipe_ins_rp_hx. port_b)
      annotation (Line(points={{116,-278},{142,-278}},
                                                  color={0,127,255}));
    connect(pipe_ins_rp_hx.port_a, pT_rp_hx_1.port_b) annotation (Line(points=
           {{162,-278},{184,-278},{184,-164},{140,-164}}, color={0,127,255}));
    connect(T_vc_TEDS.port_b, m_flow_vc_TEDS.port_a)
      annotation (Line(points={{-42,-106},{-42,-100}},
                                                     color={0,127,255}));
    connect(T_vc_TEDS.port_a, valve_vc_TEDS.port_b) annotation (Line(points={{-42,
            -126},{-42,-138}},                           color={0,127,255}));
    connect(valve_vc_TEDS.port_a, pipe_vc_TEDS.port_b) annotation (Line(points=
            {{-42,-150},{-42,-162},{-54,-162}}, color={0,127,255}));
    connect(opening_valve_tank1.y, valve_vc_TEDS.opening) annotation (Line(
          points={{-57.4,-144},{-46.8,-144}},                         color={
            0,0,127}));
    connect(opening_valve_tank2.y, valve_TEDS_rp.opening) annotation (Line(
          points={{41.4,-106},{4.8,-106}},         color={0,0,127}));
    connect(MAGNET_TEDS_simpleHX.port_b1, valve_TEDS_rp.port_a) annotation (
        Line(points={{-10,-64},{0,-64},{0,-100},{4.44089e-16,-100}},
                                                            color={0,127,255}));
    connect(valve_TEDS_rp.port_b, pT_TEDS_rp.port_a) annotation (Line(points={{
            -4.44089e-16,-112},{-4.44089e-16,-128},{1.77636e-15,-128}},
                                                      color={0,127,255}));
    connect(opening_valve_tank3.y, valve_vc_rp.opening) annotation (Line(
          points={{-20,-124.4},{-20,-157.2}},                       color={0,
            0,127}));
    connect(m_flow_vc_TEDS.port_b, MAGNET_TEDS_simpleHX.port_a1) annotation (
        Line(points={{-42,-80},{-42,-64},{-30,-64}}, color={0,127,255}));
    connect(TM_HX_exit_Temp.port_a, TEDS_flow_rate.port_a)
      annotation (Line(points={{-78,-36},{-96,-36}},
                                                 color={0,127,255}));
    connect(TEDS_flow_rate.port_b, boundary_TEDS_out.ports[1])
      annotation (Line(points={{-116,-36},{-142,-36}},
                                                   color={0,127,255}));
    connect(Tout_vc_design.y,N2_mf_control. u_s)
      annotation (Line(points={{0.6,-308},{48,-308}},   color={0,0,127}));
    connect(Tout_vc.y,N2_mf_control. u_m) annotation (Line(points={{11,-326},{
            48,-326},{48,-320},{60,-320}},
                                       color={0,0,127}));
    connect(Tin_vc.y,cw_mf_control. u_m)
      annotation (Line(points={{-119,-252},{-102,-252},{-102,-240}},
                                                             color={0,0,127}));
    connect(realExpression4.y,PID2. u_m)
      annotation (Line(points={{267,-46},{294,-46},{294,-36}},
                                                            color={0,0,127}));
    connect(realExpression1.y,PID2. u_s)
      annotation (Line(points={{267,-24},{282,-24}},
                                                   color={0,0,127}));
    connect(realExpression6.y,PID3. u_m)
      annotation (Line(points={{269,-110},{296,-110},{296,-100}},
                                                               color={0,0,127}));
    connect(realExpression5.y,PID3. u_s)
      annotation (Line(points={{269,-88},{284,-88}}, color={0,0,127}));
    connect(valve_vc_rp.port_a, pipe_vc_TEDS.port_b)
      annotation (Line(points={{-26,-162},{-54,-162}}, color={0,127,255}));
    connect(pipe_vc_rp.port_b, pT_vc_pipe_rp.port_a)
      annotation (Line(points={{26,-162},{34,-162}}, color={0,127,255}));
    connect(pipe_vc_rp.port_a, valve_vc_rp.port_b)
      annotation (Line(points={{6,-162},{-14,-162}}, color={0,127,255}));
    connect(pT_TEDS_rp.port_b, valve_vc_rp.port_b) annotation (Line(points={{0,
            -148},{0,-162},{-14,-162}}, color={0,127,255}));
    connect(mflow_cw.port_a, boundary1.ports[1])
      annotation (Line(points={{-10,-238},{-34,-238}}, color={0,127,255}));
    connect(mflow_cw.port_b, sensor_cw_hx.port_a)
      annotation (Line(points={{10,-238},{28,-238}}, color={0,127,255}));
    connect(boundary_TEDS_in.ports[1], TM_HX_Tin.port_b) annotation (Line(
          points={{56,-32},{46,-32},{46,-56}}, color={0,127,255}));
    connect(TM_HX_Tin.port_a, MAGNET_TEDS_simpleHX.port_a2)
      annotation (Line(points={{26,-56},{-10,-56}}, color={0,127,255}));
    connect(N2_mf_control.y, co.inputSignal) annotation (Line(points={{71,-308},
            {86,-308},{86,-335}}, color={0,0,127}));
    connect(cw_mf_control.y, boundary1.m_flow_in) annotation (Line(points={{-91,
            -228},{-88,-228},{-88,-230},{-54,-230}}, color={0,0,127}));
    connect(Tin_vc_design1.y, cw_mf_control.u_s) annotation (Line(points={{
            -141.4,-210},{-122,-210},{-122,-228},{-114,-228}}, color={0,0,127}));
    annotation (experiment(
        StopTime=40000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"),
      Diagram(coordinateSystem(extent={{-180,-360},{220,0}})),
      Icon(coordinateSystem(extent={{-180,-360},{220,0}})));
  end MAGNET_TEDS_Boundaries_1;

  package MAGNET_TEDS_ControlSystem
    "Control System for the integration of MAGNET and TEDS"
    extends Systems.SupervisoryControl;
    model MAGNET_ControlSystem_1
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
        annotation (Placement(transformation(extent={{-48,-242},{0,-196}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
        annotation (Placement(transformation(extent={{16,-242},{64,-196}})));

    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
    Real Error2_MAGNET "Valve 2, vaccuum chamber to recuperator in MAGNET";
    Real Error3_MAGNET "Valve 3, TEDS to MAGNET";

    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    SI.MassFlowRate m_MAGNET_needed; // mass flow needed from MAGNET as calculated based on Tin on TEDS side
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
    SI.Power Heat_needed;
    SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(430);

    Medium.BaseProperties mediums;

      Modelica.Blocks.Sources.Constant delayStart(k=20)
        annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,45})));
      Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,29})));
      Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,13})));
      Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-3})));
      Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-19})));
      Modelica.Blocks.Math.Gain mf_vc_rp(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-35})));
      Modelica.Blocks.Math.Gain Heater_flowrate_sensor(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-181})));
      Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-133})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{32,84},{46,98}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{-12,96},{-2,106}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{148,68},{160,80}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve2(y=Error2_MAGNET)
        annotation (Placement(transformation(extent={{-42,-4},{-22,16}})));
      Modelica.Blocks.Continuous.LimPID PIDV8(
        yMax=1,
        k=0.007*10,
        Ti=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{26,16},{40,30}})));
      Modelica.Blocks.Sources.Constant const8(k=0)
        annotation (Placement(transformation(extent={{-6,18},{4,28}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder7(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{148,-2},{160,10}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve3(y=Error3_MAGNET)
        annotation (Placement(transformation(extent={{-40,-52},{-20,-32}})));
      Modelica.Blocks.Continuous.LimPID PIDV9(
        yMax=1,
        k=-0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMin=0)
        annotation (Placement(transformation(extent={{32,-28},{46,-14}})));
      Modelica.Blocks.Sources.Constant const9(k=0)
        annotation (Placement(transformation(extent={{-4,-26},{6,-16}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{148,-44},{160,-32}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{-4,66},{16,86}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{122,-8},{138,8}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual1
        annotation (Placement(transformation(extent={{88,-6},{100,6}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS(y=
            Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{48,-4},{70,18}})));
      Modelica.Blocks.Sources.Constant const6(k=0.01)
        annotation (Placement(transformation(extent={{58,-10},{68,0}})));
      Modelica.Blocks.Sources.Constant const10(k=1)
        annotation (Placement(transformation(extent={{76,-18},{86,-8}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{120,-40},{136,-24}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{82,-36},{94,-24}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=
            Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{46,-44},{68,-22}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{64,-56},{74,-46}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{96,-56},{106,-46}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{118,54},{134,70}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual3
        annotation (Placement(transformation(extent={{84,56},{96,68}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=
            Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{44,58},{66,80}})));
      Modelica.Blocks.Sources.Constant const13(k=0.01)
        annotation (Placement(transformation(extent={{54,52},{64,62}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{80,36},{90,46}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-34,-100},{-14,-80}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{-8,-146},{12,-126}})));
      MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-112,122},{-92,142}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{-72,-96},{-60,-84}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{-78,-142},{-66,-130}})));
    equation
      //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
      mediums.p = 1e5;
      mediums.T = 275+273;

    algorithm

    //Heat_needed := (Heater_flowrate_sensor.y)*Cp*(T_hot_design-Tin_TEDside.y+273.15);
    Heat_needed := (Medium.specificEnthalpy_pT(1e5,T_hot_design) - Medium.specificEnthalpy_pT(1e5,Tin_TEDside.y))*(Heater_flowrate_sensor.y);

    if Heat_needed >250e3 then
      m_MAGNET_needed := 0.938;
    else
      //m_MAGNET_needed := Heat_needed/abs(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MAGNET) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));
      m_MAGNET_needed := Heat_needed/abs(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));
      //m_MAGNET_needed := Heat_needed/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MAGNET) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MAGNET));
    end if;

    if Heater_flowrate_sensor.y>0.001 then
      m_MAGNET_needed := m_MAGNET_needed;
    else
      m_MAGNET_needed:= 1e-8;
    end if;

    Error1_MAGNET := ((m_MAGNET_needed) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

    m_MAGNET_left := mflow_inside_MAGNET.y-(m_MAGNET_needed);

    if Heater_flowrate_sensor.y>0.001 then
      Error2_MAGNET := ((mf_vc_rp.y) - m_MAGNET_left)/mflow_inside_MAGNET.y;
    else
      Error2_MAGNET:= 1;
    end if;

    //if m_MAGNET_needed >0.001 then
    if Heater_flowrate_sensor.y >0.001 then
      Error3_MAGNET :=1;
    else
      Error3_MAGNET:=-1;
    end if;

    equation
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,45},{-151,45}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,30},{-152,30},{-152,29},{-151,29}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,13},{-151,13}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-3},{-151,-3}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-19},{-151,-19}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mf_vc_rp, mf_vc_rp.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-35},{-151,-35}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
         Line(
          points={{-24,-219},{-180,-219},{-180,-181},{-145,-181}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
        annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-133},{-145,-133}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{17,76},{39,76},{39,82.6}}, color={0,0,127}));
      connect(const8.y,PIDV8. u_s)
        annotation (Line(points={{4.5,23},{10,23},{10,24},{14,24},{14,23},{24.6,
              23}},                                        color={0,0,127}));
      connect(MAGNET_valve2.y,PIDV8. u_m) annotation (Line(points={{-21,6},{-21,
              8},{33,8},{33,14.6}},   color={0,0,127}));
      connect(const9.y,PIDV9. u_s)
        annotation (Line(points={{6.5,-21},{30.6,-21}},    color={0,0,127}));
      connect(MAGNET_valve3.y,PIDV9. u_m) annotation (Line(points={{-19,-42},{
              39,-42},{39,-29.4}},
                            color={0,0,127}));
      connect(greaterEqual1.y, switch1.u2)
        annotation (Line(points={{100.6,0},{120.4,0}}, color={255,0,255}));
      connect(mflow_TEDS.y, greaterEqual1.u1) annotation (Line(points={{71.1,7},
              {80,7},{80,0},{86.8,0}}, color={0,0,127}));
      connect(switch1.u1, PIDV8.y) annotation (Line(points={{120.4,6.4},{120.4,
              6},{106,6},{106,23},{40.7,23}}, color={0,0,127}));
      connect(switch1.y, firstOrder7.u) annotation (Line(points={{138.8,0},{142,
              0},{142,4},{146.8,4}}, color={0,0,127}));
      connect(const6.y, greaterEqual1.u2) annotation (Line(points={{68.5,-5},{
              77.65,-5},{77.65,-4.8},{86.8,-4.8}}, color={0,0,127}));
      connect(const10.y, switch1.u3) annotation (Line(points={{86.5,-13},{112,
              -13},{112,-6.4},{120.4,-6.4}}, color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{94.6,-30},
              {94.6,-32},{118.4,-32}}, color={255,0,255}));
      connect(mflow_TEDS1.y, greaterEqual2.u1) annotation (Line(points={{69.1,
              -33},{69.1,-30},{80.8,-30}}, color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{106.5,-51},{112,
              -51},{112,-38.4},{118.4,-38.4}}, color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{136.8,-32},{
              140,-32},{140,-38},{146.8,-38}}, color={0,0,127}));
      connect(PIDV9.y, switch2.u1) annotation (Line(points={{46.7,-21},{112,-21},
              {112,-25.6},{118.4,-25.6}}, color={0,0,127}));
      connect(const11.y, greaterEqual2.u2) annotation (Line(points={{74.5,-51},
              {78,-51},{78,-40},{74,-40},{74,-34.8},{80.8,-34.8}}, color={0,0,
              127}));
      connect(greaterEqual3.y, switch3.u2)
        annotation (Line(points={{96.6,62},{116.4,62}}, color={255,0,255}));
      connect(mflow_TEDS2.y, greaterEqual3.u1) annotation (Line(points={{67.1,
              69},{76,69},{76,62},{82.8,62}}, color={0,0,127}));
      connect(const13.y, greaterEqual3.u2) annotation (Line(points={{64.5,57},{
              73.65,57},{73.65,57.2},{82.8,57.2}}, color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{90.5,41},{110,41},
              {110,55.6},{116.4,55.6}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{46.7,91},{88,91},{
              88,76},{116.4,76},{116.4,68.4}}, color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{134.8,62},{
              140,62},{140,74},{146.8,74}}, color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve_opening, firstOrder6.y) annotation (
          Line(
          points={{40,-219},{40,-220},{178,-220},{178,74},{160.6,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve2_opening, firstOrder7.y) annotation (
          Line(
          points={{40,-219},{40,-220},{178,-220},{178,4},{160.6,4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve3_opening, firstOrder8.y) annotation (
          Line(
          points={{40,-219},{40,-220},{178,-220},{178,-38},{160.6,-38}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y, PIDV7.u_s) annotation (Line(points={{-1.5,101},{22,101},
              {22,91},{30.6,91}}, color={0,0,127}));
      connect(Tin_vc_design.y,cw_mf_control. u_s)
        annotation (Line(points={{-59.4,-90},{-36,-90}},     color={0,0,127}));
      connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
          points={{-24,-219},{-24,-102}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{40,-219},{40,-90},{-13,-90}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{-65.4,-136},{-10,-136}},color={0,0,127}));
      connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
          points={{-24,-219},{-24,-156},{2,-156},{2,-148}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (
          Line(
          points={{40,-219},{40,-136},{13,-136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
                {180,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-220},{180,140}})));
    end MAGNET_ControlSystem_1;

    model MAGNET_ControlSystem_GT
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
        annotation (Placement(transformation(extent={{-48,-242},{0,-196}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
        annotation (Placement(transformation(extent={{16,-242},{64,-196}})));

    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
    SI.Power Heat_needed_GT; // Heat needed to produce electricity
    SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity


    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    //SI.MassFlowRate m_MAGNET_needed; // mass flow needed from MAGNET as calculated based on Tin on TEDS side
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(430);

    Medium.BaseProperties mediums;

      Modelica.Blocks.Sources.Constant delayStart(k=20)
        annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,45})));
      Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,29})));
      Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,13})));
      Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-3})));
      Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-19})));
      Modelica.Blocks.Math.Gain Heater_flowrate_sensor(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-181})));
      Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-133})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{32,84},{46,98}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{-12,96},{-2,106}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{148,68},{160,80}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{148,4},{160,16}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{-4,66},{16,86}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{120,8},{136,24}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{82,12},{94,24}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=
            Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{46,4},{68,26}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{64,-8},{74,2}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{96,-8},{106,2}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{118,54},{134,70}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual3
        annotation (Placement(transformation(extent={{84,56},{96,68}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=
            Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{44,58},{66,80}})));
      Modelica.Blocks.Sources.Constant const13(k=0.01)
        annotation (Placement(transformation(extent={{54,52},{64,62}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{80,36},{90,46}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-34,-100},{-14,-80}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{-8,-146},{12,-126}})));
      MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-112,122},{-92,142}})));
      Modelica.Blocks.Continuous.LimPID PIDV1(
        yMax=1,
        k=0.00007*1,
        Ti=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{40,-48},{54,-34}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{76,-46},{88,-34}})));
      Modelica.Blocks.Sources.Constant const2(k=data.T_hot_side)
        annotation (Placement(transformation(extent={{82,-100},{92,-90}})));
      Modelica.Blocks.Continuous.LimPID PIDV2(
        yMax=1,
        k=-0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMin=0)
        annotation (Placement(transformation(extent={{102,-102},{116,-88}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{130,-102},{142,-90}})));
      Modelica.Blocks.Sources.Constant const3(k=1)
        annotation (Placement(transformation(extent={{-14,34},{-4,44}})));
      Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-143,-51})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=-(1 - 0.4)*data.GT_demand,
        duration=3000,
        offset=data.GT_demand,
        startTime=15000)
        annotation (Placement(transformation(extent={{-72,-52},{-54,-34}})));
      Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
            18000,1], startTime=0)
        annotation (Placement(transformation(extent={{-32,-48},{-18,-34}})));
      Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
        annotation (Placement(transformation(extent={{0,-46},{10,-36}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{-72,-96},{-60,-84}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{-78,-142},{-66,-130}})));
    equation
      //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
      mediums.p = 1e5;
      mediums.T = 275+273;
      Heat_needed_GT = GT_demand.y/data.eta_mech;

    algorithm
      m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

      m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

      Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;


    equation
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,45},{-151,45}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,30},{-152,30},{-152,29},{-151,29}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,13},{-151,13}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-3},{-151,-3}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-19},{-151,-19}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
         Line(
          points={{-24,-219},{-180,-219},{-180,-181},{-145,-181}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
        annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-133},{-145,-133}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{17,76},{39,76},{39,82.6}}, color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{94.6,18},{94.6,
              16},{118.4,16}},         color={255,0,255}));
      connect(mflow_TEDS1.y, greaterEqual2.u1) annotation (Line(points={{69.1,15},{69.1,
              18},{80.8,18}},              color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{106.5,-3},{112,-3},{112,
              9.6},{118.4,9.6}},               color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{136.8,16},{140,16},
              {140,10},{146.8,10}},            color={0,0,127}));
      connect(const11.y, greaterEqual2.u2) annotation (Line(points={{74.5,-3},{78,-3},
              {78,8},{74,8},{74,13.2},{80.8,13.2}},                color={0,0,
              127}));
      connect(greaterEqual3.y, switch3.u2)
        annotation (Line(points={{96.6,62},{116.4,62}}, color={255,0,255}));
      connect(mflow_TEDS2.y, greaterEqual3.u1) annotation (Line(points={{67.1,
              69},{76,69},{76,62},{82.8,62}}, color={0,0,127}));
      connect(const13.y, greaterEqual3.u2) annotation (Line(points={{64.5,57},{
              73.65,57},{73.65,57.2},{82.8,57.2}}, color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{90.5,41},{110,41},
              {110,55.6},{116.4,55.6}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{46.7,91},{88,91},{
              88,76},{116.4,76},{116.4,68.4}}, color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{134.8,62},{
              140,62},{140,74},{146.8,74}}, color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve_opening, firstOrder6.y) annotation (
          Line(
          points={{40,-219},{40,-220},{178,-220},{178,74},{160.6,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve3_opening, firstOrder8.y) annotation (
          Line(
          points={{40,-219},{40,-220},{178,-220},{178,10},{160.6,10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y, PIDV7.u_s) annotation (Line(points={{-1.5,101},{22,101},
              {22,91},{30.6,91}}, color={0,0,127}));
      connect(Tin_vc_design.y,cw_mf_control. u_s)
        annotation (Line(points={{-59.4,-90},{-36,-90}},     color={0,0,127}));
      connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
          points={{-24,-219},{-24,-102}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{40,-219},{40,-90},{-13,-90}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{-65.4,-136},{-10,-136}},color={0,0,127}));
      connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
          points={{-24,-219},{-24,-156},{2,-156},{2,-148}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (
          Line(
          points={{40,-219},{40,-136},{13,-136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.GT_Power, PIDV1.u_m) annotation (Line(
          points={{-24,-219},{-24,-172},{47,-172},{47,-49.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(firstOrder1.u, PIDV1.y) annotation (Line(points={{74.8,-40},{64.75,-40},
              {64.75,-41},{54.7,-41}}, color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve2_opening, firstOrder1.y) annotation (Line(
          points={{40,-219},{44,-219},{44,-220},{178,-220},{178,-40},{88.6,-40}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PIDV2.u_s, const2.y)
        annotation (Line(points={{100.6,-95},{92.5,-95}}, color={0,0,127}));
      connect(actuatorSubBus.Tout_TEDSide, PIDV2.u_m) annotation (Line(
          points={{-24,-219},{42,-219},{42,-220},{108,-220},{108,-103.4},{109,-103.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(firstOrder2.u, PIDV2.y) annotation (Line(points={{128.8,-96},{128.8,-95},
              {116.7,-95}}, color={0,0,127}));
      connect(sensorSubBus.Pump_Flow, firstOrder2.y) annotation (Line(
          points={{40,-219},{40,-220},{178,-220},{178,-96},{142.6,-96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const3.y, switch2.u1) annotation (Line(points={{-3.5,39},{74,39},{74,28},
              {110,28},{110,22.4},{118.4,22.4}}, color={0,0,127}));
      connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-51},{-149,-51}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(P_GT_demand.y[1], GT_demand.u)
        annotation (Line(points={{-17.3,-41},{-1,-41}}, color={0,0,127}));
      connect(GT_demand.y, PIDV1.u_s)
        annotation (Line(points={{10.5,-41},{38.6,-41}}, color={0,0,127}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
                {180,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-220},{180,140}})));
    end MAGNET_ControlSystem_GT;

    model MAGNET_ControlSystem_GT_newHX
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
        annotation (Placement(transformation(extent={{-48,-242},{0,-196}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
        annotation (Placement(transformation(extent={{16,-242},{64,-196}})));

    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
    SI.Power Heat_needed_GT; // Heat needed to produce electricity
    SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity

    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    //SI.MassFlowRate m_MAGNET_needed; // mass flow needed from MAGNET as calculated based on Tin on TEDS side
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(430);

    Medium.BaseProperties mediums;

      Modelica.Blocks.Sources.Constant delayStart(k=20)
        annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,45})));
      Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,29})));
      Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,13})));
      Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-3})));
      Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-19})));
      Modelica.Blocks.Math.Gain Heater_flowrate_sensor(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-181})));
      Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-133})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{32,84},{46,98}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{-12,96},{-2,106}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{148,68},{160,80}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{148,4},{160,16}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{-4,66},{16,86}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{120,8},{136,24}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{82,12},{94,24}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=
            Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{46,4},{68,26}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{64,-8},{74,2}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{96,-8},{106,2}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{118,54},{134,70}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual3
        annotation (Placement(transformation(extent={{84,56},{96,68}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=
            Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{44,58},{66,80}})));
      Modelica.Blocks.Sources.Constant const13(k=0.01)
        annotation (Placement(transformation(extent={{54,52},{64,62}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{80,36},{90,46}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-34,-100},{-14,-80}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{-8,-146},{12,-126}})));
      MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-112,122},{-92,142}})));
      Modelica.Blocks.Continuous.LimPID PIDV1(
        yMax=1,
        k=0.00007*1,
        Ti=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{40,-48},{54,-34}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{76,-46},{88,-34}})));
      Modelica.Blocks.Sources.Constant const2(k=data.T_hot_side)
        annotation (Placement(transformation(extent={{82,-100},{92,-90}})));
      Modelica.Blocks.Continuous.LimPID PIDV2(
        yMax=1,
        k=-0.0007*1,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{102,-102},{116,-88}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{130,-102},{142,-90}})));
      Modelica.Blocks.Sources.Constant const3(k=1)
        annotation (Placement(transformation(extent={{-14,34},{-4,44}})));
      Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-143,-51})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=-(1 - 0.4)*data.GT_demand,
        duration=3000,
        offset=data.GT_demand,
        startTime=15000)
        annotation (Placement(transformation(extent={{-72,-52},{-54,-34}})));
      Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
            18000,1], startTime=0)
        annotation (Placement(transformation(extent={{-32,-48},{-18,-34}})));
      Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
        annotation (Placement(transformation(extent={{0,-46},{10,-36}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{-72,-96},{-60,-84}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{-78,-142},{-66,-130}})));
    equation
      //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
      mediums.p = 1e5;
      mediums.T = 275+273;
      Heat_needed_GT = GT_demand.y/data.eta_mech;

    algorithm
      m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

      m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

      Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

    equation
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,45},{-151,45}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,30},{-152,30},{-152,29},{-151,29}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,13},{-151,13}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-3},{-151,-3}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-19},{-151,-19}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
         Line(
          points={{-24,-219},{-180,-219},{-180,-181},{-145,-181}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
        annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-133},{-145,-133}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{17,76},{39,76},{39,82.6}}, color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{94.6,18},{94.6,
              16},{118.4,16}},         color={255,0,255}));
      connect(mflow_TEDS1.y, greaterEqual2.u1) annotation (Line(points={{69.1,15},{69.1,
              18},{80.8,18}},              color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{106.5,-3},{112,-3},{112,
              9.6},{118.4,9.6}},               color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{136.8,16},{140,16},
              {140,10},{146.8,10}},            color={0,0,127}));
      connect(const11.y, greaterEqual2.u2) annotation (Line(points={{74.5,-3},{78,-3},
              {78,8},{74,8},{74,13.2},{80.8,13.2}},                color={0,0,
              127}));
      connect(greaterEqual3.y, switch3.u2)
        annotation (Line(points={{96.6,62},{116.4,62}}, color={255,0,255}));
      connect(mflow_TEDS2.y, greaterEqual3.u1) annotation (Line(points={{67.1,
              69},{76,69},{76,62},{82.8,62}}, color={0,0,127}));
      connect(const13.y, greaterEqual3.u2) annotation (Line(points={{64.5,57},{
              73.65,57},{73.65,57.2},{82.8,57.2}}, color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{90.5,41},{110,41},
              {110,55.6},{116.4,55.6}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{46.7,91},{88,91},{
              88,76},{116.4,76},{116.4,68.4}}, color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{134.8,62},{
              140,62},{140,74},{146.8,74}}, color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve_opening, firstOrder6.y) annotation (
          Line(
          points={{40,-219},{40,-220},{178,-220},{178,74},{160.6,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve3_opening, firstOrder8.y) annotation (
          Line(
          points={{40,-219},{40,-220},{178,-220},{178,10},{160.6,10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y, PIDV7.u_s) annotation (Line(points={{-1.5,101},{22,101},
              {22,91},{30.6,91}}, color={0,0,127}));
      connect(Tin_vc_design.y,cw_mf_control. u_s)
        annotation (Line(points={{-59.4,-90},{-36,-90}},     color={0,0,127}));
      connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
          points={{-24,-219},{-24,-102}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{40,-219},{40,-90},{-13,-90}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{-65.4,-136},{-10,-136}},color={0,0,127}));
      connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
          points={{-24,-219},{-24,-156},{2,-156},{2,-148}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (
          Line(
          points={{40,-219},{40,-136},{13,-136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.GT_Power, PIDV1.u_m) annotation (Line(
          points={{-24,-219},{-24,-172},{47,-172},{47,-49.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(firstOrder1.u, PIDV1.y) annotation (Line(points={{74.8,-40},{64.75,-40},
              {64.75,-41},{54.7,-41}}, color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve2_opening, firstOrder1.y) annotation (Line(
          points={{40,-219},{44,-219},{44,-220},{178,-220},{178,-40},{88.6,-40}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PIDV2.u_s, const2.y)
        annotation (Line(points={{100.6,-95},{92.5,-95}}, color={0,0,127}));
      connect(actuatorSubBus.Tout_TEDSide, PIDV2.u_m) annotation (Line(
          points={{-24,-219},{42,-219},{42,-220},{108,-220},{108,-103.4},{109,-103.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(firstOrder2.u, PIDV2.y) annotation (Line(points={{128.8,-96},{128.8,-95},
              {116.7,-95}}, color={0,0,127}));
      connect(sensorSubBus.Pump_Flow, firstOrder2.y) annotation (Line(
          points={{40,-219},{40,-220},{178,-220},{178,-96},{142.6,-96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const3.y, switch2.u1) annotation (Line(points={{-3.5,39},{74,39},{74,28},
              {110,28},{110,22.4},{118.4,22.4}}, color={0,0,127}));
      connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
          points={{-24,-219},{-180,-219},{-180,-51},{-149,-51}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(P_GT_demand.y[1], GT_demand.u)
        annotation (Line(points={{-17.3,-41},{-1,-41}}, color={0,0,127}));
      connect(GT_demand.y, PIDV1.u_s)
        annotation (Line(points={{10.5,-41},{38.6,-41}}, color={0,0,127}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
                {180,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-220},{180,140}})));
    end MAGNET_ControlSystem_GT_newHX;

    model Control_System_Therminol_4_element_all_modes_MAGNET_GT
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
        annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
        annotation (Placement(transformation(extent={{16,-418},{64,-372}})));
      Modelica.Blocks.Continuous.LimPID PIDV1(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.03*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0)
        annotation (Placement(transformation(extent={{70,122},{84,136}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{50,108},{60,118}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{96,122},{110,136}})));
      Modelica.Blocks.Continuous.LimPID PIDV2(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{70,90},{84,104}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{50,74},{60,84}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{98,90},{112,104}})));
      Modelica.Blocks.Continuous.LimPID PIDV3(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.03*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{64,56},{78,70}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{50,40},{60,50}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{98,58},{110,70}})));
      Modelica.Blocks.Continuous.LimPID PIDV4(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{66,24},{80,38}})));
      Modelica.Blocks.Sources.Constant const3(k=0)
        annotation (Placement(transformation(extent={{50,8},{60,18}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{100,26},{112,38}})));
      Modelica.Blocks.Continuous.LimPID PIDV5(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMin=0.0)
        annotation (Placement(transformation(extent={{68,-6},{82,8}})));
      Modelica.Blocks.Sources.Constant const4(k=0)
        annotation (Placement(transformation(extent={{44,-18},{54,-8}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{102,-4},{114,8}})));
      Modelica.Blocks.Continuous.LimPID PIDV6(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{62,-36},{76,-22}})));
      Modelica.Blocks.Sources.Constant const5(k=0)
        annotation (Placement(transformation(extent={{36,-48},{46,-38}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
        annotation (Placement(transformation(extent={{96,-34},{108,-22}})));
      Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
        annotation (Placement(transformation(extent={{26,118},{48,140}})));
      Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
        annotation (Placement(transformation(extent={{22,86},{44,108}})));
      Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
        annotation (Placement(transformation(extent={{18,52},{40,74}})));
      Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
        annotation (Placement(transformation(extent={{10,20},{32,42}})));
      Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
        annotation (Placement(transformation(extent={{8,-40},{30,-18}})));
      Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
        annotation (Placement(transformation(extent={{12,-10},{34,12}})));

    Real Error1 "Valve 1";
    Real Error2 "Valve 2";
    Real Error3 "Valve 3";
    Real Error4 "Valve 4";
    Real Error5 "Valve 5";
    Real Error6 "Valve 6";
    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";

    Integer storage_button "0 equals discharge or stationary, 1 is charging";

    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
    SI.MassFlowRate m_tes_demand;
    SI.MassFlowRate m_heater_demand;
    SI.Power Q_TES_demanded;
    SI.Power Q_TES_discharge;
    SI.Power Heat_needed_GT;
    SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
    SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

    Medium.BaseProperties mediums;

      Modelica.Blocks.Sources.Constant delayStart(k=20)
        annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
      TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
        "Used in the Coded Section"
        annotation (Placement(transformation(extent={{-170,-2},{-146,20}})));
      TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-14},{-146,6}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-28},{-146,-8}})));
      Modelica.Blocks.Sources.Pulse Heater_Load(
        amplitude=0,
        width=50,
        period(displayUnit="h") = 7200,
        offset=200e3)
                  annotation (Placement(transformation(extent={{-34,96},{-20,110}})));
      Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
            Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
             else BOP_total_demand.y - Heater_Total_Demand.y)
        annotation (Placement(transformation(extent={{-70,90},{-48,112}})));
      TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-44},{-146,-24}})));
      Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
            BOP_total_demand.y, Heater_Total_Demand.y))
        annotation (Placement(transformation(extent={{-40,114},{-18,136}})));
      Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1;
            1800,100,1; 3600,0,4; 4800,0,2; 7200,0,4; 9600,100,5; 10800,140,5;
            12000,140,0.0; 14400,100,0.0; 18000,100,0], startTime=0)
        annotation (Placement(transformation(extent={{-120,120},{-106,134}})));
      Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
        annotation (Placement(transformation(extent={{-96,122},{-86,132}})));
      Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
            18000,1], startTime=0)
        annotation (Placement(transformation(extent={{-80,120},{-66,134}})));
      Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
        annotation (Placement(transformation(extent={{-56,122},{-46,132}})));
      Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-57})));
      Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-73})));
      Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-89})));
      Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-105})));
      Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-121})));
      Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-137})));
      Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-155})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{-24,-56},{-10,-42}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{-58,-54},{-48,-44}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{92,-72},{104,-60}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{92,-148},{104,-136}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{64,-144},{80,-128}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-10,-148},{12,-126}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{8,-160},{18,-150}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{40,-160},{50,-150}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{62,-86},{78,-70}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-12,-82},{10,-60}})));
      Modelica.Blocks.Sources.Constant const13(k=0.01)
        annotation (Placement(transformation(extent={{-2,-88},{8,-78}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{24,-104},{34,-94}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-32,-312},{-12,-292}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{-6,-266},{14,-246}})));
      ExperimentalSystems.MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
      Modelica.Blocks.Sources.Constant const15(k=1)
        annotation (Placement(transformation(extent={{36,-122},{46,-112}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual1
        annotation (Placement(transformation(extent={{32,-86},{42,-76}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{32,-146},{42,-136}})));
      Modelica.Blocks.Continuous.LimPID PIDV8(
        yMax=1,
        k=0.00007*1,
        Ti=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{34,-198},{48,-184}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder7(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{70,-196},{82,-184}})));
      Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1; 3600,
            1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1; 18000,1],
          startTime=0)
        annotation (Placement(transformation(extent={{-38,-198},{-24,-184}})));
      Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
        annotation (Placement(transformation(extent={{-6,-196},{4,-186}})));
      Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
        annotation (Placement(transformation(extent={{82,-272},{92,-262}})));
      Modelica.Blocks.Continuous.LimPID PIDV9(
        yMax=1,
        k=-0.0007*1,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{102,-274},{116,-260}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder9(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{130,-274},{142,-262}})));
      Modelica.Blocks.Sources.RealExpression Load_TES1(y=if BOP_total_demand.y <
            GT_demand.y then -1*(GT_demand.y - BOP_total_demand.y) else
            BOP_total_demand.y - GT_demand.y)
        annotation (Placement(transformation(extent={{-110,90},{-88,112}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{-70,-308},{-58,-296}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{-76,-262},{-64,-250}})));
    initial equation
      Q_TES_discharge = 0.0;
      //storage_button=0;
    equation
      //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
      mediums.p = 1e5;
      mediums.T = 275+273;

    //Error1 = pulse.y;
    algorithm

    Q_TES_demanded := m_MAGNET_left*(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));
    //Load_TES1.y;//BOP_total_demand.y - Heat_needed_GT;//Load_TES.y;

    m_tes_demand :=Q_TES_demanded/(Cp*(T_hot_design - T_cold_design));

    m_heater_demand :=GT_demand.y/(Cp*(T_hot_design - T_cold_design));

    Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - T_cold_design);

    m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

      Heat_needed_GT :=GT_demand.y/data.eta_mech;

      m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

      m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

      Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

    //Valve 2 Used for HeaterBOPDemand

    Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                             // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
    //Valve 3 used for TES discharge

    if Q_TES_demanded > 0 and delay(storage_button,15) == 0 then
      Error3 :=(m_tes_demand - Discharge_mass_flow_sensor.y)/m_tes_max;
      else
      Error3 :=-1;
    end if;

    //Valve 1 used for TES Charge
    if Q_TES_demanded < 0 then // charging
      Error1 :=(abs(m_tes_demand) - Charge_mass_flow_sensor.y)/m_tes_max;
      //storage_button :=1;
    else
      Error1 :=-1;
      //storage_button :=0;
    end if;

      //Designation of the TEDS valve control algorithms.

     //Interlock System for the valves.
      if m_tes_demand < -0.001 then
        Error4 :=1;
        storage_button :=1;
      else
        Error4 :=-1;
        storage_button :=0;
      end if;

      if m_tes_demand > 0.001 then
        Error5 :=1;
      else
        Error5 :=-1;
      end if;

    // Main Heater Mass Flow Control
      if m_heater_demand > 0.001 then
        Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
      else
        Error6 :=-1;
      end if;

    //Mode Determination System

    equation
      connect(PIDV1.y,firstOrder. u) annotation (Line(points={{84.7,129},{94.6,129}},
                                     color={0,0,127}));
      connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{84.7,97},{96.6,97}},
                                         color={0,0,127}));
      connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{78.7,63},{92.35,
              63},{92.35,64},{96.8,64}}, color={0,0,127}));
      connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{80.7,31},{94.35,
              31},{94.35,32},{98.8,32}},    color={0,0,127}));
      connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{82.7,1},{96.35,1},
              {96.35,2},{100.8,2}},         color={0,0,127}));
      connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-29},{90.35,
              -29},{90.35,-28},{94.8,-28}}, color={0,0,127}));
      connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,129},{110.7,129}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,97},{112.7,97}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,32},{112.6,32}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,2},{114.6,2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-28},{108.6,-28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,64},{110.6,64}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,9},{-172.4,9}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-4},{-172.4,-4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
         Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-18},{-172.4,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-34},{-172.4,-34}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(BOP_relative_demand.y[1],BOP_total_demand. u) annotation (Line(points={{-105.3,
              127},{-97,127}},                                      color={0,0,127}));
      connect(Heater_Demand.y[1],Heater_Total_Demand. u) annotation (Line(points={{-65.3,
              127},{-57,127}},             color={0,0,127}));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-57},{-151,-57}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-73},{-151,-73}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-89},{-151,-89}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-105},{-151,-105}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-121},{-151,-121}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-155},{-151,-155}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-142},{104.6,-142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-66},{104.6,-66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,PIDV7. u_s)
        annotation (Line(points={{-47.5,-49},{-25.4,-49}},
                                                       color={0,0,127}));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{-39,-64},{-17,-64},{-17,-57.4}},
                                                             color={0,0,127}));
      connect(Valve1.y, PIDV1.u_s)
        annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
      connect(const.y, PIDV1.u_m) annotation (Line(points={{60.5,113},{77,113},{
              77,120.6}},
            color={0,0,127}));
      connect(Valve2.y, PIDV2.u_s)
        annotation (Line(points={{45.1,97},{68.6,97}}, color={0,0,127}));
      connect(const1.y, PIDV2.u_m) annotation (Line(points={{60.5,79},{60.5,78},{
              77,78},{77,88.6}},
                              color={0,0,127}));
      connect(Valve3.y, PIDV3.u_s)
        annotation (Line(points={{41.1,63},{62.6,63}}, color={0,0,127}));
      connect(const2.y, PIDV3.u_m) annotation (Line(points={{60.5,45},{60.5,44},{
              71,44},{71,54.6}},
                              color={0,0,127}));
      connect(Valve4.y, PIDV4.u_s)
        annotation (Line(points={{33.1,31},{64.6,31}}, color={0,0,127}));
      connect(const3.y, PIDV4.u_m) annotation (Line(points={{60.5,13},{60.5,16},{
              73,16},{73,22.6}},
                         color={0,0,127}));
      connect(Valve5.y, PIDV5.u_s)
        annotation (Line(points={{35.1,1},{66.6,1}},     color={0,0,127}));
      connect(const4.y, PIDV5.u_m) annotation (Line(points={{54.5,-13},{68,-13},{
              68,-7.4},{75,-7.4}},color={0,0,127}));
      connect(const5.y, PIDV6.u_m) annotation (Line(points={{46.5,-43},{46.5,
              -37.4},{69,-37.4}},
                           color={0,0,127}));
      connect(Valve6.y, PIDV6.u_s)
        annotation (Line(points={{31.1,-29},{60.6,-29}}, color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{50.5,-155},{56,-155},
              {56,-142.4},{62.4,-142.4}},       color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{80.8,-136},{84,-136},
              {84,-142},{90.8,-142}},       color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{34.5,-99},{54,-99},
              {54,-84.4},{60.4,-84.4}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{-9.3,-49},{32,-49},{
              32,-64},{60.4,-64},{60.4,-71.6}}, color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{78.8,-78},{84,
              -78},{84,-66},{90.8,-66}}, color={0,0,127}));
      connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
          points={{-22,-395},{-22,-314}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{40,-395},{40,-302},{-11,-302}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{-63.4,-256},{-8,-256}}, color={0,0,127}));
      connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
          points={{-22,-395},{-22,-396},{4,-396},{4,-268}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
          points={{40,-395},{40,-256},{15,-256}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const15.y, switch2.u1) annotation (Line(points={{46.5,-117},{62.4,-117},
              {62.4,-129.6}},       color={0,0,127}));
      connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{31,-81},
              {16,-81},{16,-71},{11.1,-71}}, color={0,0,127}));
      connect(greaterEqual1.u2, const13.y) annotation (Line(points={{31,-85},{16,
              -85},{16,-83},{8.5,-83}}, color={0,0,127}));
      connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{42.5,-81},{
              42.5,-78},{60.4,-78}}, color={255,0,255}));
      connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{31,-141},{18,
              -141},{18,-137},{13.1,-137}},     color={0,0,127}));
      connect(greaterEqual2.u2, const11.y) annotation (Line(points={{31,-145},{22,-145},
              {22,-155},{18.5,-155}},       color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{42.5,-141},{54,
              -141},{54,-136},{62.4,-136}},    color={255,0,255}));
      connect(cw_mf_control.u_s, Tin_vc_design.y)
        annotation (Line(points={{-34,-302},{-57.4,-302}}, color={0,0,127}));
      connect(actuatorSubBus.GT_Power,PIDV8. u_m) annotation (Line(
          points={{-22,-395},{-22,-322},{41,-322},{41,-199.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{68.8,-190},{58.75,-190},
              {58.75,-191},{48.7,-191}},
                                       color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
          points={{40,-395},{44,-395},{44,-398},{178,-398},{178,-190},{82.6,-190}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(P_GT_demand.y[1], GT_demand.u)
        annotation (Line(points={{-23.3,-191},{-7,-191}}, color={0,0,127}));
      connect(GT_demand.y, PIDV8.u_s)
        annotation (Line(points={{4.5,-191},{32.6,-191}}, color={0,0,127}));
      connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
          points={{-22,-395},{-100,-395},{-100,-394},{-178,-394},{-178,-137},{-151,-137}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(PIDV9.u_s,const6. y)
        annotation (Line(points={{100.6,-267},{92.5,-267}},
                                                          color={0,0,127}));
      connect(actuatorSubBus.Tout_TEDSide,PIDV9. u_m) annotation (Line(
          points={{-22,-395},{42,-395},{42,-392},{108,-392},{108,-275.4},{109,-275.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(firstOrder9.u,PIDV9. y) annotation (Line(points={{128.8,-268},{128.8,-267},
              {116.7,-267}},color={0,0,127}));
      connect(sensorSubBus.Pump_Flow,firstOrder9. y) annotation (Line(
          points={{40,-395},{40,-392},{178,-392},{178,-268},{142.6,-268}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                -400},{180,140}})),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-400},{180,140}})));
    end Control_System_Therminol_4_element_all_modes_MAGNET_GT;

    model Control_System_Therminol_4_element_all_modes_MAGNET_GT_SS
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
        annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
        annotation (Placement(transformation(extent={{16,-418},{64,-372}})));
      Modelica.Blocks.Continuous.LimPID PIDV1(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.003*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0)
        annotation (Placement(transformation(extent={{70,122},{84,136}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{50,108},{60,118}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{96,122},{110,136}})));
      Modelica.Blocks.Continuous.LimPID PIDV2(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{70,90},{84,104}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{50,74},{60,84}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{98,90},{112,104}})));
      Modelica.Blocks.Continuous.LimPID PIDV3(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.0005*0.007*3600,
        Ti=4.25,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{64,56},{78,70}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{50,40},{60,50}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{98,58},{110,70}})));
      Modelica.Blocks.Continuous.LimPID PIDV4(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{66,24},{80,38}})));
      Modelica.Blocks.Sources.Constant const3(k=0)
        annotation (Placement(transformation(extent={{50,8},{60,18}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder3(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{100,26},{112,38}})));
      Modelica.Blocks.Continuous.LimPID PIDV5(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMin=0.0)
        annotation (Placement(transformation(extent={{68,-6},{82,8}})));
      Modelica.Blocks.Sources.Constant const4(k=0)
        annotation (Placement(transformation(extent={{44,-18},{54,-8}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder4(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{102,-4},{114,8}})));
      Modelica.Blocks.Continuous.LimPID PIDV6(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{62,-36},{76,-22}})));
      Modelica.Blocks.Sources.Constant const5(k=0)
        annotation (Placement(transformation(extent={{36,-48},{46,-38}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
        annotation (Placement(transformation(extent={{96,-34},{108,-22}})));
      Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
        annotation (Placement(transformation(extent={{26,118},{48,140}})));
      Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
        annotation (Placement(transformation(extent={{22,86},{44,108}})));
      Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
        annotation (Placement(transformation(extent={{18,52},{40,74}})));
      Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
        annotation (Placement(transformation(extent={{10,20},{32,42}})));
      Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
        annotation (Placement(transformation(extent={{8,-40},{30,-18}})));
      Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
        annotation (Placement(transformation(extent={{12,-10},{34,12}})));

    Real Error1 "Valve 1";
    Real Error2 "Valve 2";
    Real Error3 "Valve 3";
    Real Error4 "Valve 4";
    Real Error5 "Valve 5";
    Real Error6 "Valve 6";
    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
    //Real Error_TSP "Error between Tout TEDS side and T_hot design";

    Integer storage_button "0 equals discharge or stationary, 1 is charging";

    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
    SI.MassFlowRate m_tes_discharged;
    SI.MassFlowRate m_tes_charged;
    SI.Power Q_TES_discharge;
    SI.Power Heat_needed_GT;
    SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
    SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

    Medium.BaseProperties mediums;

      Modelica.Blocks.Sources.Constant delayStart(k=20)
        annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
      TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
        "Used in the Coded Section"
        annotation (Placement(transformation(extent={{-170,-2},{-146,20}})));
      TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-14},{-146,6}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-28},{-146,-8}})));
      Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
            Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
             else BOP_total_demand.y - Heater_Total_Demand.y)
        annotation (Placement(transformation(extent={{-66,38},{-44,60}})));
      TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-148,-254},{-124,-234}})));
      Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1; 1800,
            100,1; 3600,100,4; 4800,100,2; 7200,100,4; 9600,100,5; 10800,100,5; 12000,
            100,0.0; 14400,100,0.0; 18000,100,0],       startTime=0)
        annotation (Placement(transformation(extent={{-120,120},{-106,134}})));
      Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
        annotation (Placement(transformation(extent={{-96,122},{-86,132}})));
      Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
            18000,1], startTime=0)
        annotation (Placement(transformation(extent={{-80,120},{-66,134}})));
      Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
        annotation (Placement(transformation(extent={{-56,122},{-46,132}})));
      Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-57})));
      Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-73})));
      Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-89})));
      Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-105})));
      Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-121})));
      Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-137})));
      Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-155})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{-24,-56},{-10,-42}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{-58,-54},{-48,-44}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{92,-72},{104,-60}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{92,-148},{104,-136}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{64,-144},{80,-128}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-10,-148},{12,-126}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{8,-160},{18,-150}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{40,-160},{50,-150}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{62,-86},{78,-70}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-12,-82},{10,-60}})));
      Modelica.Blocks.Sources.Constant const13(k=0.01)
        annotation (Placement(transformation(extent={{-2,-88},{8,-78}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{24,-104},{34,-94}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-32,-312},{-12,-292}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{-6,-266},{14,-246}})));
      ExperimentalSystems.MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
      Modelica.Blocks.Sources.Constant const15(k=1)
        annotation (Placement(transformation(extent={{36,-122},{46,-112}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual1
        annotation (Placement(transformation(extent={{32,-86},{42,-76}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{32,-146},{42,-136}})));
      Modelica.Blocks.Continuous.LimPID PIDV8(
        yMax=1,
        k=0.00007*1,
        Ti=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{34,-198},{48,-184}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder7(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{70,-196},{82,-184}})));
      Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0.4; 12000,0.4; 14400,
            1; 18000,1],
          startTime=0)
        annotation (Placement(transformation(extent={{-38,-198},{-24,-184}})));
      Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
        annotation (Placement(transformation(extent={{-6,-196},{4,-186}})));
      Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
        annotation (Placement(transformation(extent={{82,-272},{92,-262}})));
      Modelica.Blocks.Sources.Constant SS_BOP_demand(k=100)
        annotation (Placement(transformation(extent={{-138,82},{-118,102}})));
      Modelica.Blocks.Sources.Constant SS_heater_demand(k=1)
        annotation (Placement(transformation(extent={{-90,82},{-70,102}})));
      Modelica.Blocks.Sources.Constant SS_GT_demand(k=1)
        annotation (Placement(transformation(extent={{-54,-230},{-34,-210}})));
      TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.125,
        Ti=1,
        k_s=1,
        k_m=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=19376)
        annotation (Placement(transformation(extent={{104,-274},{116,-262}})));
      Modelica.Blocks.Math.Gain Tout_TEDS_side(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-195})));
      Modelica.Blocks.Sources.Constant TES_Discharge_load(k=0)
        annotation (Placement(transformation(extent={{-116,46},{-96,66}})));
      Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
            BOP_total_demand.y, Heater_Total_Demand.y))
        annotation (Placement(transformation(extent={{-36,116},{-14,138}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{-70,-308},{-58,-296}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{-76,-262},{-64,-250}})));
    initial equation
      Q_TES_discharge = 0.0;
      //storage_button=0;
    equation
      //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
      mediums.p = 1e5;
      mediums.T = 275+273;

    //Error1 = pulse.y;
    algorithm

    m_tes_discharged := TES_Discharge_load.y/(Cp*(T_hot_design - T_cold_design)) "amount of TES flow rate needed for discharge";

    if HX_heat.y > Heater_BOP_Demand.y then
      m_tes_charged:= (HX_heat.y-Heater_BOP_Demand.y)/(Cp*(T_hot_design - T_cold_design));
    else
      m_tes_charged:= 0;
    end if;

    //m_tes_charged := HX_heat.y/(Cp*(T_hot_design - T_cold_design));

    Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - Tout_TEDS_side.y);

    m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

    Heat_needed_GT :=GT_demand.y/data.eta_mech;

    m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

    m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

    Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

    //Valve 2 Used for HeaterBOPDemand

    Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                             // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
    //Valve 3 used for TES discharge

    if TES_Discharge_load.y > 0 and delay(storage_button,15) == 0 then
      Error3 :=(m_tes_discharged - Discharge_mass_flow_sensor.y)/m_tes_max;
      else
      Error3 :=-1;
    end if;

    //Valve 1 used for TES Charge
    if m_tes_charged > 0.001 then // charging
      Error1 :=(m_tes_charged - Charge_mass_flow_sensor.y)/m_tes_max;
      //storage_button :=1;
    else
      Error1 :=-1;
      //storage_button :=0;
    end if;

      //Designation of the TEDS valve control algorithms.

     //Interlock System for the valves.
      if m_tes_charged > 0.001 then
        Error4 :=1;
        storage_button :=1;
      else
        Error4 :=-1;
        storage_button :=0;
      end if;

      if m_tes_discharged > 0.001 then
        Error5 :=1;
      else
        Error5 :=-1;
      end if;

    // Main Heater Mass Flow Control
      if m_tes_charged > 0.001 or m_bop_heater_demand > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
        Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
      else
        Error6 :=-1;
      end if;

    //Mode Determination System

    equation
      connect(PIDV1.y,firstOrder. u) annotation (Line(points={{84.7,129},{94.6,129}},
                                     color={0,0,127}));
      connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{84.7,97},{96.6,97}},
                                         color={0,0,127}));
      connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{78.7,63},{92.35,
              63},{92.35,64},{96.8,64}}, color={0,0,127}));
      connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{80.7,31},{94.35,
              31},{94.35,32},{98.8,32}},    color={0,0,127}));
      connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{82.7,1},{96.35,1},
              {96.35,2},{100.8,2}},         color={0,0,127}));
      connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-29},{90.35,
              -29},{90.35,-28},{94.8,-28}}, color={0,0,127}));
      connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,129},{110.7,129}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,97},{112.7,97}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,32},{112.6,32}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,2},{114.6,2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-28},{108.6,-28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,64},{110.6,64}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,9},{-172.4,9}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-4},{-172.4,-4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
         Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-18},{-172.4,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-244},{-150.4,-244}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-57},{-151,-57}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-73},{-151,-73}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-89},{-151,-89}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-105},{-151,-105}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-121},{-151,-121}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-155},{-151,-155}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-142},{104.6,-142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-66},{104.6,-66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,PIDV7. u_s)
        annotation (Line(points={{-47.5,-49},{-25.4,-49}},
                                                       color={0,0,127}));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{-39,-64},{-17,-64},{-17,-57.4}},
                                                             color={0,0,127}));
      connect(Valve1.y, PIDV1.u_s)
        annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
      connect(const.y, PIDV1.u_m) annotation (Line(points={{60.5,113},{77,113},{
              77,120.6}},
            color={0,0,127}));
      connect(Valve2.y, PIDV2.u_s)
        annotation (Line(points={{45.1,97},{68.6,97}}, color={0,0,127}));
      connect(const1.y, PIDV2.u_m) annotation (Line(points={{60.5,79},{60.5,78},{
              77,78},{77,88.6}},
                              color={0,0,127}));
      connect(Valve3.y, PIDV3.u_s)
        annotation (Line(points={{41.1,63},{62.6,63}}, color={0,0,127}));
      connect(const2.y, PIDV3.u_m) annotation (Line(points={{60.5,45},{60.5,44},{
              71,44},{71,54.6}},
                              color={0,0,127}));
      connect(Valve4.y, PIDV4.u_s)
        annotation (Line(points={{33.1,31},{64.6,31}}, color={0,0,127}));
      connect(const3.y, PIDV4.u_m) annotation (Line(points={{60.5,13},{60.5,16},{
              73,16},{73,22.6}},
                         color={0,0,127}));
      connect(Valve5.y, PIDV5.u_s)
        annotation (Line(points={{35.1,1},{66.6,1}},     color={0,0,127}));
      connect(const4.y, PIDV5.u_m) annotation (Line(points={{54.5,-13},{68,-13},{
              68,-7.4},{75,-7.4}},color={0,0,127}));
      connect(const5.y, PIDV6.u_m) annotation (Line(points={{46.5,-43},{46.5,
              -37.4},{69,-37.4}},
                           color={0,0,127}));
      connect(Valve6.y, PIDV6.u_s)
        annotation (Line(points={{31.1,-29},{60.6,-29}}, color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{50.5,-155},{56,-155},
              {56,-142.4},{62.4,-142.4}},       color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{80.8,-136},{84,-136},
              {84,-142},{90.8,-142}},       color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{34.5,-99},{54,-99},
              {54,-84.4},{60.4,-84.4}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{-9.3,-49},{32,-49},{
              32,-64},{60.4,-64},{60.4,-71.6}}, color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{78.8,-78},{84,
              -78},{84,-66},{90.8,-66}}, color={0,0,127}));
      connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
          points={{-22,-395},{-22,-314}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{40,-395},{40,-302},{-11,-302}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{-63.4,-256},{-8,-256}}, color={0,0,127}));
      connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
          points={{-22,-395},{-22,-396},{4,-396},{4,-268}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
          points={{40,-395},{40,-256},{15,-256}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const15.y, switch2.u1) annotation (Line(points={{46.5,-117},{62.4,-117},
              {62.4,-129.6}},       color={0,0,127}));
      connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{31,-81},
              {16,-81},{16,-71},{11.1,-71}}, color={0,0,127}));
      connect(greaterEqual1.u2, const13.y) annotation (Line(points={{31,-85},{16,
              -85},{16,-83},{8.5,-83}}, color={0,0,127}));
      connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{42.5,-81},{
              42.5,-78},{60.4,-78}}, color={255,0,255}));
      connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{31,-141},{18,
              -141},{18,-137},{13.1,-137}},     color={0,0,127}));
      connect(greaterEqual2.u2, const11.y) annotation (Line(points={{31,-145},{22,-145},
              {22,-155},{18.5,-155}},       color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{42.5,-141},{54,
              -141},{54,-136},{62.4,-136}},    color={255,0,255}));
      connect(cw_mf_control.u_s, Tin_vc_design.y)
        annotation (Line(points={{-34,-302},{-57.4,-302}}, color={0,0,127}));
      connect(actuatorSubBus.GT_Power,PIDV8. u_m) annotation (Line(
          points={{-22,-395},{-22,-322},{41,-322},{41,-199.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{68.8,-190},{58.75,-190},
              {58.75,-191},{48.7,-191}},
                                       color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
          points={{40,-395},{44,-395},{44,-398},{178,-398},{178,-190},{82.6,-190}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(GT_demand.y, PIDV8.u_s)
        annotation (Line(points={{4.5,-191},{32.6,-191}}, color={0,0,127}));
      connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-137},{-151,-137}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(SS_BOP_demand.y, BOP_total_demand.u)
        annotation (Line(points={{-117,92},{-97,92},{-97,127}}, color={0,0,127}));
      connect(SS_heater_demand.y, Heater_Total_Demand.u)
        annotation (Line(points={{-69,92},{-57,92},{-57,127}}, color={0,0,127}));
      connect(SS_GT_demand.y, GT_demand.u) annotation (Line(points={{-33,-220},{-12,
              -220},{-12,-191},{-7,-191}}, color={0,0,127}));
      connect(const6.y, Chromolox_Heater_Control1.u_s) annotation (Line(points={{92.5,
              -267},{92.5,-268},{102.8,-268}}, color={0,0,127}));
      connect(sensorSubBus.Pump_Flow, Chromolox_Heater_Control1.y) annotation (Line(
          points={{40,-395},{178,-395},{178,-268},{116.6,-268}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-195},{-145,-195}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tout_TEDSide, Chromolox_Heater_Control1.u_m)
        annotation (Line(
          points={{-22,-395},{40,-395},{40,-314},{110,-314},{110,-275.2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                -400},{180,140}})),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-400},{180,140}})));
    end Control_System_Therminol_4_element_all_modes_MAGNET_GT_SS;

    model Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
        annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
        annotation (Placement(transformation(extent={{16,-418},{64,-372}})));
      Modelica.Blocks.Continuous.LimPID PIDV1(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.03*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0)
        annotation (Placement(transformation(extent={{70,122},{84,136}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{50,108},{60,118}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{96,122},{110,136}})));
      Modelica.Blocks.Continuous.LimPID PIDV2(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{70,90},{84,104}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{50,74},{60,84}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{98,90},{112,104}})));
      Modelica.Blocks.Continuous.LimPID PIDV3(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.0005*0.007*3600,
        Ti=4.25,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{64,56},{78,70}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{50,40},{60,50}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{98,58},{110,70}})));
      Modelica.Blocks.Continuous.LimPID PIDV4(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{66,24},{80,38}})));
      Modelica.Blocks.Sources.Constant const3(k=0)
        annotation (Placement(transformation(extent={{50,8},{60,18}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{100,26},{112,38}})));
      Modelica.Blocks.Continuous.LimPID PIDV5(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMin=0.0)
        annotation (Placement(transformation(extent={{68,-6},{82,8}})));
      Modelica.Blocks.Sources.Constant const4(k=0)
        annotation (Placement(transformation(extent={{44,-18},{54,-8}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{102,-4},{114,8}})));
      Modelica.Blocks.Continuous.LimPID PIDV6(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{62,-36},{76,-22}})));
      Modelica.Blocks.Sources.Constant const5(k=0)
        annotation (Placement(transformation(extent={{36,-48},{46,-38}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
        annotation (Placement(transformation(extent={{96,-34},{108,-22}})));
      Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
        annotation (Placement(transformation(extent={{26,118},{48,140}})));
      Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
        annotation (Placement(transformation(extent={{22,86},{44,108}})));
      Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
        annotation (Placement(transformation(extent={{18,52},{40,74}})));
      Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
        annotation (Placement(transformation(extent={{10,20},{32,42}})));
      Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
        annotation (Placement(transformation(extent={{8,-40},{30,-18}})));
      Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
        annotation (Placement(transformation(extent={{12,-10},{34,12}})));

    Real Error1 "Valve 1";
    Real Error2 "Valve 2";
    Real Error3 "Valve 3";
    Real Error4 "Valve 4";
    Real Error5 "Valve 5";
    Real Error6 "Valve 6";
    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
    //Real Error_TSP "Error between Tout TEDS side and T_hot design";

    Integer storage_button "0 equals discharge or stationary, 1 is charging";

    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
    SI.MassFlowRate m_tes_demand;
    SI.MassFlowRate m_tes_charged;
    SI.MassFlowRate m_heater_demand;
    SI.Power Q_TES_charge;
    SI.Power Q_TES_discharge;
    SI.Power Heat_needed_GT;
    SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
    SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

    Medium.BaseProperties mediums;

      Modelica.Blocks.Sources.Constant delayStart(k=20)
        annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
      TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
        "Used in the Coded Section"
        annotation (Placement(transformation(extent={{-170,-2},{-146,20}})));
      TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-14},{-146,6}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-28},{-146,-8}})));
      Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
            Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
             else BOP_total_demand.y - Heater_Total_Demand.y)
        annotation (Placement(transformation(extent={{-66,38},{-44,60}})));
      TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-148,-254},{-124,-234}})));
      Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
            BOP_total_demand.y, TES_Discharge_load.y))
        annotation (Placement(transformation(extent={{-40,114},{-18,136}})));
      Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1; 1800,
            100,1; 3600,100,4; 4800,100,2; 7200,100,4; 9600,100,5; 10800,100,5; 12000,
            100,0.0; 14400,100,0.0; 18000,100,0],       startTime=0)
        annotation (Placement(transformation(extent={{-120,120},{-106,134}})));
      Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
        annotation (Placement(transformation(extent={{-96,122},{-86,132}})));
      Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
            18000,1], startTime=0)
        annotation (Placement(transformation(extent={{-80,120},{-66,134}})));
      Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
        annotation (Placement(transformation(extent={{-56,122},{-46,132}})));
      Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-57})));
      Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-73})));
      Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-89})));
      Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-105})));
      Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-121})));
      Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-137})));
      Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-145,-155})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{-24,-56},{-10,-42}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{-58,-54},{-48,-44}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{92,-72},{104,-60}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{92,-148},{104,-136}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{64,-144},{80,-128}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-10,-148},{12,-126}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{8,-160},{18,-150}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{40,-160},{50,-150}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{62,-86},{78,-70}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-12,-82},{10,-60}})));
      Modelica.Blocks.Sources.Constant const13(k=0.01)
        annotation (Placement(transformation(extent={{-2,-88},{8,-78}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{24,-104},{34,-94}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-32,-312},{-12,-292}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{-6,-266},{14,-246}})));
      ExperimentalSystems.MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
      Modelica.Blocks.Sources.Constant const15(k=1)
        annotation (Placement(transformation(extent={{36,-122},{46,-112}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual1
        annotation (Placement(transformation(extent={{32,-86},{42,-76}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{32,-146},{42,-136}})));
      Modelica.Blocks.Continuous.LimPID PIDV8(
        yMax=1,
        k=0.00007*1,
        Ti=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{34,-198},{48,-184}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder7(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{70,-196},{82,-184}})));
      Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,1; 12000,1; 14400,1;
            18000,1; 20000,0.4; 30000,0.4; 36000,1; 40000,1],
          startTime=0)
        annotation (Placement(transformation(extent={{-38,-198},{-24,-184}})));
      Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
        annotation (Placement(transformation(extent={{-6,-196},{4,-186}})));
      Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
        annotation (Placement(transformation(extent={{82,-272},{92,-262}})));
      Modelica.Blocks.Sources.Constant SS_BOP_demand(k=100)
        annotation (Placement(transformation(extent={{-138,82},{-118,102}})));
      Modelica.Blocks.Sources.Constant SS_heater_demand(k=1)
        annotation (Placement(transformation(extent={{-90,82},{-70,102}})));
      Modelica.Blocks.Sources.Constant SS_GT_demand(k=1)
        annotation (Placement(transformation(extent={{-54,-230},{-34,-210}})));
      TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.125,
        Ti=1,
        k_s=1,
        k_m=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=19376)
        annotation (Placement(transformation(extent={{104,-274},{116,-262}})));
      Modelica.Blocks.Math.Gain Tout_TEDS_side(k=1) annotation (Placement(
            transformation(
            extent={{-5,-5},{5,5}},
            rotation=0,
            origin={-139,-195})));
      Modelica.Blocks.Sources.Constant TES_Discharge_load(k=0)
        annotation (Placement(transformation(extent={{-116,46},{-96,66}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{-70,-308},{-58,-296}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{-76,-262},{-64,-250}})));
    initial equation
      Q_TES_discharge = 0.0;
      //storage_button=0;
    equation
      //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
      mediums.p = 1e5;
      mediums.T = 275+273;

    //Error1 = pulse.y;
    algorithm

    //  Error_TSP := (Tout_TEDS_side.y - T_hot_design)/T_hot_design;

    Q_TES_charge := m_MAGNET_left*(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

    m_tes_demand := TES_Discharge_load.y/(Cp*(T_hot_design - T_cold_design)) "amount of TES flow rate needed for discharge";

    m_tes_charged := HX_heat.y/(Cp*(T_hot_design - T_cold_design));

    m_heater_demand :=GT_demand.y/(Cp*(T_hot_design - T_cold_design));

    Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - T_cold_design);

    m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

    Heat_needed_GT :=GT_demand.y/data.eta_mech;

    m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

    m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

    Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

    //Valve 2 Used for HeaterBOPDemand

    Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                             // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
    //Valve 3 used for TES discharge

    if TES_Discharge_load.y > 0 and delay(storage_button,15) == 0 then
      Error3 :=(m_tes_demand - Discharge_mass_flow_sensor.y)/m_tes_max;
      else
      Error3 :=-1;
    end if;

    //Valve 1 used for TES Charge
    if Q_TES_charge > 0 then // charging
      Error1 :=(abs(m_tes_charged) - Charge_mass_flow_sensor.y)/m_tes_max;
      //storage_button :=1;
    else
      Error1 :=-1;
      //storage_button :=0;
    end if;

      //Designation of the TEDS valve control algorithms.

     //Interlock System for the valves.
      if m_tes_charged > 0.001 then
        Error4 :=1;
        storage_button :=1;
      else
        Error4 :=-1;
        storage_button :=0;
      end if;

      if m_tes_demand > 0.001 then
        Error5 :=1;
      else
        Error5 :=-1;
      end if;

    // Main Heater Mass Flow Control
      if m_tes_charged > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
        Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
      else
        Error6 :=-1;
      end if;

    //Mode Determination System

    equation
      connect(PIDV1.y,firstOrder. u) annotation (Line(points={{84.7,129},{94.6,129}},
                                     color={0,0,127}));
      connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{84.7,97},{96.6,97}},
                                         color={0,0,127}));
      connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{78.7,63},{92.35,
              63},{92.35,64},{96.8,64}}, color={0,0,127}));
      connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{80.7,31},{94.35,
              31},{94.35,32},{98.8,32}},    color={0,0,127}));
      connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{82.7,1},{96.35,1},
              {96.35,2},{100.8,2}},         color={0,0,127}));
      connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-29},{90.35,
              -29},{90.35,-28},{94.8,-28}}, color={0,0,127}));
      connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,129},{110.7,129}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,97},{112.7,97}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,32},{112.6,32}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,2},{114.6,2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-28},{108.6,-28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,64},{110.6,64}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,9},{-172.4,9}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-4},{-172.4,-4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
         Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-18},{-172.4,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-244},{-150.4,-244}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-57},{-151,-57}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-73},{-151,-73}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-89},{-151,-89}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-105},{-151,-105}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-121},{-151,-121}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
        annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-155},{-151,-155}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-142},{104.6,-142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
          points={{40,-395},{40,-398},{178,-398},{178,-66},{104.6,-66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,PIDV7. u_s)
        annotation (Line(points={{-47.5,-49},{-25.4,-49}},
                                                       color={0,0,127}));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{-39,-64},{-17,-64},{-17,-57.4}},
                                                             color={0,0,127}));
      connect(Valve1.y, PIDV1.u_s)
        annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
      connect(const.y, PIDV1.u_m) annotation (Line(points={{60.5,113},{77,113},{
              77,120.6}},
            color={0,0,127}));
      connect(Valve2.y, PIDV2.u_s)
        annotation (Line(points={{45.1,97},{68.6,97}}, color={0,0,127}));
      connect(const1.y, PIDV2.u_m) annotation (Line(points={{60.5,79},{60.5,78},{
              77,78},{77,88.6}},
                              color={0,0,127}));
      connect(Valve3.y, PIDV3.u_s)
        annotation (Line(points={{41.1,63},{62.6,63}}, color={0,0,127}));
      connect(const2.y, PIDV3.u_m) annotation (Line(points={{60.5,45},{60.5,44},{
              71,44},{71,54.6}},
                              color={0,0,127}));
      connect(Valve4.y, PIDV4.u_s)
        annotation (Line(points={{33.1,31},{64.6,31}}, color={0,0,127}));
      connect(const3.y, PIDV4.u_m) annotation (Line(points={{60.5,13},{60.5,16},{
              73,16},{73,22.6}},
                         color={0,0,127}));
      connect(Valve5.y, PIDV5.u_s)
        annotation (Line(points={{35.1,1},{66.6,1}},     color={0,0,127}));
      connect(const4.y, PIDV5.u_m) annotation (Line(points={{54.5,-13},{68,-13},{
              68,-7.4},{75,-7.4}},color={0,0,127}));
      connect(const5.y, PIDV6.u_m) annotation (Line(points={{46.5,-43},{46.5,
              -37.4},{69,-37.4}},
                           color={0,0,127}));
      connect(Valve6.y, PIDV6.u_s)
        annotation (Line(points={{31.1,-29},{60.6,-29}}, color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{50.5,-155},{56,-155},
              {56,-142.4},{62.4,-142.4}},       color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{80.8,-136},{84,-136},
              {84,-142},{90.8,-142}},       color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{34.5,-99},{54,-99},
              {54,-84.4},{60.4,-84.4}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{-9.3,-49},{32,-49},{
              32,-64},{60.4,-64},{60.4,-71.6}}, color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{78.8,-78},{84,
              -78},{84,-66},{90.8,-66}}, color={0,0,127}));
      connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
          points={{-22,-395},{-22,-314}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{40,-395},{40,-302},{-11,-302}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{-63.4,-256},{-8,-256}}, color={0,0,127}));
      connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
          points={{-22,-395},{-22,-396},{4,-396},{4,-268}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
          points={{40,-395},{40,-256},{15,-256}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const15.y, switch2.u1) annotation (Line(points={{46.5,-117},{62.4,-117},
              {62.4,-129.6}},       color={0,0,127}));
      connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{31,-81},
              {16,-81},{16,-71},{11.1,-71}}, color={0,0,127}));
      connect(greaterEqual1.u2, const13.y) annotation (Line(points={{31,-85},{16,
              -85},{16,-83},{8.5,-83}}, color={0,0,127}));
      connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{42.5,-81},{
              42.5,-78},{60.4,-78}}, color={255,0,255}));
      connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{31,-141},{18,
              -141},{18,-137},{13.1,-137}},     color={0,0,127}));
      connect(greaterEqual2.u2, const11.y) annotation (Line(points={{31,-145},{22,-145},
              {22,-155},{18.5,-155}},       color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{42.5,-141},{54,
              -141},{54,-136},{62.4,-136}},    color={255,0,255}));
      connect(cw_mf_control.u_s, Tin_vc_design.y)
        annotation (Line(points={{-34,-302},{-57.4,-302}}, color={0,0,127}));
      connect(actuatorSubBus.GT_Power,PIDV8. u_m) annotation (Line(
          points={{-22,-395},{-22,-322},{41,-322},{41,-199.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{68.8,-190},{58.75,-190},
              {58.75,-191},{48.7,-191}},
                                       color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
          points={{40,-395},{44,-395},{44,-398},{178,-398},{178,-190},{82.6,-190}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(GT_demand.y, PIDV8.u_s)
        annotation (Line(points={{4.5,-191},{32.6,-191}}, color={0,0,127}));
      connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-137},{-151,-137}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(SS_BOP_demand.y, BOP_total_demand.u)
        annotation (Line(points={{-117,92},{-97,92},{-97,127}}, color={0,0,127}));
      connect(SS_heater_demand.y, Heater_Total_Demand.u)
        annotation (Line(points={{-69,92},{-57,92},{-57,127}}, color={0,0,127}));
      connect(const6.y, Chromolox_Heater_Control1.u_s) annotation (Line(points={{92.5,
              -267},{92.5,-268},{102.8,-268}}, color={0,0,127}));
      connect(sensorSubBus.Pump_Flow, Chromolox_Heater_Control1.y) annotation (Line(
          points={{40,-395},{178,-395},{178,-268},{116.6,-268}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
          points={{-22,-395},{-22,-398},{-178,-398},{-178,-195},{-145,-195}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tout_TEDSide, Chromolox_Heater_Control1.u_m)
        annotation (Line(
          points={{-22,-395},{40,-395},{40,-314},{110,-314},{110,-275.2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(P_GT_demand.y[1], GT_demand.u)
        annotation (Line(points={{-23.3,-191},{-7,-191}}, color={0,0,127}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                -400},{180,140}})),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-400},{180,140}})));
    end Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0;

    model Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
        annotation (Placement(transformation(extent={{-88,-238},{-40,-192}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
        annotation (Placement(transformation(extent={{46,-238},{94,-192}})));
      Modelica.Blocks.Continuous.LimPID PIDV1(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.005*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0)
        annotation (Placement(transformation(extent={{134,122},{148,136}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{118,114},{128,124}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{160,122},{174,136}})));
      Modelica.Blocks.Continuous.LimPID PIDV2(
        yMax=1,
        k=0.0007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{52,98},{66,112}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{32,90},{42,100}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{80,98},{94,112}})));
      Modelica.Blocks.Continuous.LimPID PIDV3(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.03*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{136,74},{150,88}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{118,66},{128,76}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{158,74},{172,88}})));
      Modelica.Blocks.Continuous.LimPID PIDV4(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{46,52},{60,66}})));
      Modelica.Blocks.Sources.Constant const3(k=0)
        annotation (Placement(transformation(extent={{30,42},{40,52}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder3(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{80,52},{94,66}})));
      Modelica.Blocks.Continuous.LimPID PIDV5(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMin=0.0)
        annotation (Placement(transformation(extent={{136,30},{150,44}})));
      Modelica.Blocks.Sources.Constant const4(k=0)
        annotation (Placement(transformation(extent={{120,22},{130,32}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder4(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{158,30},{172,44}})));
      Modelica.Blocks.Continuous.LimPID PIDV6(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{46,8},{60,22}})));
      Modelica.Blocks.Sources.Constant const5(k=0)
        annotation (Placement(transformation(extent={{30,0},{40,10}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
        annotation (Placement(transformation(extent={{80,10},{92,22}})));
      Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
        annotation (Placement(transformation(extent={{90,118},{112,140}})));
      Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
        annotation (Placement(transformation(extent={{4,94},{26,116}})));
      Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
        annotation (Placement(transformation(extent={{90,70},{112,92}})));
      Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
        annotation (Placement(transformation(extent={{4,48},{26,70}})));
      Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
        annotation (Placement(transformation(extent={{4,4},{26,26}})));
      Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
        annotation (Placement(transformation(extent={{90,26},{112,48}})));

    Real Error1 "Valve 1";
    Real Error2 "Valve 2";
    Real Error3 "Valve 3";
    Real Error4 "Valve 4";
    Real Error5 "Valve 5";
    Real Error6 "Valve 6";
    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
    //Real Error_TSP "Error between Tout TEDS side and T_hot design";

    Integer storage_button "0 equals discharge or stationary, 1 is charging";

    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
    SI.MassFlowRate m_bop_heater_demand_graph;
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
    SI.MassFlowRate m_tes_discharged;
    SI.MassFlowRate m_tes_charged;
    //SI.Power Q_TES_discharge;
    SI.Power Heat_needed_GT;
    SI.Power Heat_demand;
    SI.Power TES_Load;
    SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
    SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

    Medium.BaseProperties mediums;

      Modelica.Blocks.Sources.Constant delayStart(k=20)
        annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
      TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
        "Used in the Coded Section"
        annotation (Placement(transformation(extent={{-170,54},{-146,76}})));
      TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,38},{-146,58}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,22},{-146,42}})));
      TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,6},{-146,26}})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{102,-12},{116,2}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{68,-10},{78,0}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{158,-28},{170,-16}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{38,-74},{50,-62}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{66,-30},{86,-10}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{10,-70},{26,-54}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-64,-74},{-42,-52}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{-46,-86},{-36,-76}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{-14,-86},{-4,-76}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{128,-42},{144,-26}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{54,-44},{76,-22}})));
      Modelica.Blocks.Sources.Constant const13(k=0.01)
        annotation (Placement(transformation(extent={{60,-52},{70,-42}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{100,-62},{110,-52}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{46,-180},{62,-164}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{152,-152},{168,-136}})));
      ExperimentalSystems.MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
      Modelica.Blocks.Sources.Constant const15(k=1)
        annotation (Placement(transformation(extent={{-18,-48},{-8,-38}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual1
        annotation (Placement(transformation(extent={{98,-42},{108,-32}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{-22,-72},{-12,-62}})));
      Modelica.Blocks.Continuous.LimPID PIDV8(
        yMax=1,
        k=0.00007*1,
        Ti=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{120,-100},{134,-86}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder7(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{156,-98},{168,-86}})));
      Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0.4; 12000,0.4; 14400,
            1; 18000,1],
          startTime=0)
        annotation (Placement(transformation(extent={{-76,50},{-62,64}})));
      Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
        annotation (Placement(transformation(extent={{94,-98},{104,-88}})));
      Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
        annotation (Placement(transformation(extent={{-12,-130},{-2,-120}})));
      Modelica.Blocks.Sources.Constant SS_GT_demand(k=1)
        annotation (Placement(transformation(extent={{66,-100},{80,-86}})));
      TRANSFORM.Controls.LimPID TEDS_pump_Control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.125,
        Ti=1,
        k_s=1,
        k_m=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=19376)
        annotation (Placement(transformation(extent={{10,-132},{22,-120}})));
      Modelica.Blocks.Sources.Constant TES_Discharge_load(k=0)
        annotation (Placement(transformation(extent={{-116,46},{-96,66}})));
      Modelica.Blocks.Sources.CombiTimeTable BOP_heater_demand(table=[0.0,1;
            1800,1; 3600,1; 4800,1; 7200,1; 9000,1; 9999.9,1; 10000,0.1; 12200,
            0.1; 14400,0.1; 18000,0.3; 22000,0.3; 24500,0.5; 30000,0.5; 33000,0;
            40000,0],          startTime=0)
        annotation (Placement(transformation(extent={{-36,120},{-22,134}})));
      Modelica.Blocks.Math.Gain Heater_BOP_Demand(k=100000)
        annotation (Placement(transformation(extent={{-12,122},{-2,132}})));
      TRANSFORM.Blocks.RealExpression mflow_inside_MAGNET
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-10},{-146,10}})));
      TRANSFORM.Blocks.RealExpression Tout_TEDS_side "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-26},{-146,-6}})));
      TRANSFORM.Blocks.RealExpression Tin_MT_HX "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-42},{-146,-22}})));
      TRANSFORM.Blocks.RealExpression Tout_MT_HX "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-58},{-146,-38}})));
      TRANSFORM.Blocks.RealExpression mf_MT_HX "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-74},{-146,-54}})));
      TRANSFORM.Blocks.RealExpression HX_heat "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-90},{-146,-70}})));
      TRANSFORM.Blocks.RealExpression Tin_TEDside "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-106},{-146,-86}})));
      TRANSFORM.Blocks.RealExpression mf_vc_GT "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-122},{-146,-102}})));
      TRANSFORM.Blocks.RealExpression GT_Power_sensor "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-138},{-146,-118}})));
      TRANSFORM.Blocks.RealExpression Tout_vc "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-154},{-146,-134}})));
      Modelica.Blocks.Sources.RealExpression GT_Power_generated(y=GT_Power_sensor.y)
        annotation (Placement(transformation(extent={{88,-124},{110,-102}})));
      Modelica.Blocks.Sources.RealExpression T_TEDSide_out(y=Tout_TEDS_side.y)
        annotation (Placement(transformation(extent={{-24,-154},{-2,-132}})));
      Modelica.Blocks.Sources.RealExpression T_vc_out(y=Tout_vc.y)
        annotation (Placement(transformation(extent={{84,-168},{106,-146}})));
      TRANSFORM.Blocks.RealExpression Tin_vc "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-170},{-146,-150}})));
      Modelica.Blocks.Sources.RealExpression T_vc_in(y=Tin_vc.y)
        annotation (Placement(transformation(extent={{-16,-196},{6,-174}})));
      Modelica.Blocks.Sources.CombiTimeTable P_GT_demand1(table=[0.0,1; 1800,1;
            3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0.4; 12000,0.4; 14400,
            1; 18000,1], startTime=0)
        annotation (Placement(transformation(extent={{32,-110},{46,-96}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{10,-178},{22,-166}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{126,-150},{138,-138}})));
    initial equation
    //  Q_TES_discharge = 0.0;
      //storage_button=0;
    equation
      //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
      mediums.p = 1e5;
      mediums.T = 275+273;

      if clock.y <1e4 then
        Heat_demand = HX_heat.y;
      else
        Heat_demand = Heater_BOP_Demand.y;
      end if;

      TES_Load = -(Heat_demand - HX_heat.y);

       if clock.y <1e4 then
        m_bop_heater_demand_graph = Heat_demand/(Cp*(T_hot_design - T_cold_design));
      else
        m_bop_heater_demand_graph = Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));
      end if;

    //Error1 = pulse.y;
    algorithm

    if clock.y >1e4 then
      m_tes_discharged:= (Heater_BOP_Demand.y - HX_heat.y)/(Cp*(T_hot_design - T_cold_design))
                                                                                              "amount of TES flow rate needed for discharge";
    else
      m_tes_discharged := 0;
    end if;

    if HX_heat.y > Heater_BOP_Demand.y then
      m_tes_charged:= (HX_heat.y-Heater_BOP_Demand.y)/(Cp*(T_hot_design - T_cold_design));
    else
      m_tes_charged:= 0;
    end if;

    m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

    Heat_needed_GT :=GT_demand.y/data.eta_mech;

    m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

    m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

    Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

    //Valve 2 Used for HeaterBOPDemand

    Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                             // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
    //Valve 3 used for TES discharge

    if m_tes_discharged > 0 and delay(storage_button,15) == 0 then
      Error3 :=(m_tes_discharged - Discharge_mass_flow_sensor.y)/m_tes_max;
      else
      Error3 :=-1;
    end if;

    //Valve 1 used for TES Charge
    if m_tes_charged > 0.001 then // charging
      Error1 :=(m_tes_charged - Charge_mass_flow_sensor.y)/m_tes_max;
    else
      Error1 :=-1;
      //storage_button :=0;
    end if;

      //Designation of the TEDS valve control algorithms.

     //Interlock System for the valves.
      if m_tes_charged > 0.001 then
        Error4 :=1;
        storage_button :=1;
      else
        Error4 :=-1;
        storage_button :=0;
      end if;

      if m_tes_discharged > 0.001 then
        Error5 :=1;
      else
        Error5 :=-1;
      end if;

    // Main Heater Mass Flow Control
      if m_tes_charged > 0.001 or m_bop_heater_demand > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
        Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
      else
        Error6 :=-1;
      end if;

    //Mode Determination System

    equation
      connect(PIDV1.y,firstOrder. u) annotation (Line(points={{148.7,129},{158.6,129}},
                                     color={0,0,127}));
      connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{66.7,105},{78.6,105}},
                                         color={0,0,127}));
      connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{150.7,81},{156.6,81}},
                                         color={0,0,127}));
      connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{60.7,59},{78.6,59}},
                                            color={0,0,127}));
      connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{150.7,37},{156.6,37}},
                                            color={0,0,127}));
      connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{60.7,15},{74.35,15},
              {74.35,16},{78.8,16}},        color={0,0,127}));
      connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
          points={{70,-215},{180,-215},{180,129},{174.7,129}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,105},{94.7,105}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,59},{94.7,59}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
          points={{70,-215},{180,-215},{180,37},{172.7,37}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
          points={{70,-215},{180,-215},{180,16},{92.6,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
          points={{70,-215},{180,-215},{180,81},{172.7,81}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
        annotation (Line(
          points={{-64,-215},{-180,-215},{-180,65},{-172.4,65}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
        annotation (Line(
          points={{-64,-215},{-180,-215},{-180,48},{-172.4,48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,-68},{50.6,-68}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,-22},{170.6,-22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{87,-20},{109,-20},{109,-13.4}},
                                                             color={0,0,127}));
      connect(Valve1.y, PIDV1.u_s)
        annotation (Line(points={{113.1,129},{132.6,129}},
                                                         color={0,0,127}));
      connect(const.y, PIDV1.u_m) annotation (Line(points={{128.5,119},{141,119},{141,
              120.6}},
            color={0,0,127}));
      connect(Valve2.y, PIDV2.u_s)
        annotation (Line(points={{27.1,105},{50.6,105}},
                                                       color={0,0,127}));
      connect(const1.y, PIDV2.u_m) annotation (Line(points={{42.5,95},{42.5,94},{59,
              94},{59,96.6}}, color={0,0,127}));
      connect(Valve3.y, PIDV3.u_s)
        annotation (Line(points={{113.1,81},{134.6,81}},
                                                       color={0,0,127}));
      connect(const2.y, PIDV3.u_m) annotation (Line(points={{128.5,71},{128.5,70},{143,
              70},{143,72.6}},color={0,0,127}));
      connect(Valve4.y, PIDV4.u_s)
        annotation (Line(points={{27.1,59},{44.6,59}}, color={0,0,127}));
      connect(const3.y, PIDV4.u_m) annotation (Line(points={{40.5,47},{40.5,48},{53,
              48},{53,50.6}},
                         color={0,0,127}));
      connect(Valve5.y, PIDV5.u_s)
        annotation (Line(points={{113.1,37},{134.6,37}}, color={0,0,127}));
      connect(const4.y, PIDV5.u_m) annotation (Line(points={{130.5,27},{142.75,27},{
              142.75,28.6},{143,28.6}},
                                  color={0,0,127}));
      connect(const5.y, PIDV6.u_m) annotation (Line(points={{40.5,5},{46.75,5},{46.75,
              6.6},{53,6.6}},
                           color={0,0,127}));
      connect(Valve6.y, PIDV6.u_s)
        annotation (Line(points={{27.1,15},{44.6,15}},   color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{-3.5,-81},{2,-81},{2,
              -68.4},{8.4,-68.4}},              color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{26.8,-62},{30,-62},
              {30,-68},{36.8,-68}},         color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{110.5,-57},{120,-57},
              {120,-40.4},{126.4,-40.4}},
                                        color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{144.8,-34},{150,-34},
              {150,-22},{156.8,-22}},    color={0,0,127}));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{138.6,-144},{150.4,-144}},
                                                          color={0,0,127}));
      connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
          points={{70,-215},{180,-215},{180,-144},{168.8,-144}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const15.y, switch2.u1) annotation (Line(points={{-7.5,-43},{8.4,-43},{
              8.4,-55.6}},          color={0,0,127}));
      connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{97,-37},{82,
              -37},{82,-33},{77.1,-33}},     color={0,0,127}));
      connect(greaterEqual1.u2, const13.y) annotation (Line(points={{97,-41},{86,-41},
              {86,-47},{70.5,-47}},     color={0,0,127}));
      connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{108.5,-37},{108.5,
              -34},{126.4,-34}},     color={255,0,255}));
      connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{-23,-67},{-36,
              -67},{-36,-63},{-40.9,-63}},      color={0,0,127}));
      connect(greaterEqual2.u2, const11.y) annotation (Line(points={{-23,-71},{-32,-71},
              {-32,-81},{-35.5,-81}},       color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{-11.5,-67},{0,-67},
              {0,-62},{8.4,-62}},              color={255,0,255}));
      connect(cw_mf_control.u_s, Tin_vc_design.y)
        annotation (Line(points={{44.4,-172},{22.6,-172}}, color={0,0,127}));
      connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{154.8,-92},{144.75,-92},
              {144.75,-93},{134.7,-93}},
                                       color={0,0,127}));
      connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
          points={{70,-215},{180,-215},{180,-92},{168.6,-92}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(GT_demand.y, PIDV8.u_s)
        annotation (Line(points={{104.5,-93},{118.6,-93}},color={0,0,127}));

      connect(const6.y, TEDS_pump_Control.u_s) annotation (Line(points={{-1.5,-125},
              {-1.5,-126},{8.8,-126}}, color={0,0,127}));
      connect(BOP_heater_demand.y[1], Heater_BOP_Demand.u)
        annotation (Line(points={{-21.3,127},{-13,127}},
                                                       color={0,0,127}));
      connect(const7.y, PIDV7.u_s) annotation (Line(points={{78.5,-5},{89.55,-5},{89.55,
              -5},{100.6,-5}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{116.7,-5},{126.4,-5},{126.4,
              -27.6}}, color={0,0,127}));
      connect(GT_Power_generated.y, PIDV8.u_m) annotation (Line(points={{111.1,-113},
              {127,-113},{127,-101.4}}, color={0,0,127}));
      connect(T_TEDSide_out.y, TEDS_pump_Control.u_m) annotation (Line(points={{-0.9,
              -143},{16,-143},{16,-133.2}}, color={0,0,127}));
      connect(T_vc_out.y, N2_mf_control.u_m) annotation (Line(points={{107.1,-157},{
              160,-157},{160,-153.6}}, color={0,0,127}));
      connect(T_vc_in.y, cw_mf_control.u_m) annotation (Line(points={{7.1,-185},{54,
              -185},{54,-181.6}}, color={0,0,127}));
      connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
        annotation (Line(
          points={{-64,-215},{-180,-215},{-180,16},{-172.4,16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
         Line(
          points={{-64,-215},{-180,-215},{-180,32},{-172.4,32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
        annotation (Line(
          points={{-64,-215},{-180,-215},{-180,0},{-172.4,0}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-16},{-172.4,-16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-32},{-172.4,-32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-48},{-172.4,-48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-64},{-172.4,-64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-80},{-172.4,-80}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-96},{-172.4,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-112},{-172.4,-112}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.GT_Power, GT_Power_sensor.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-128},{-172.4,-128}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tout_vc, Tout_vc.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-144},{-172.4,-144}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorSubBus.Tin_vc, Tin_vc.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-160},{-172.4,-160}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.Pump_Flow, TEDS_pump_Control.y) annotation (Line(
          points={{70,-215},{180,-215},{180,-126},{22.6,-126}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{70,-215},{180,-215},{180,-172},{62.8,-172}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(SS_GT_demand.y, GT_demand.u)
        annotation (Line(points={{80.7,-93},{93,-93}}, color={0,0,127}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
                {180,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-220},{180,140}})));
    end Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1;

    model Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_bypass
      "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

      replaceable package Medium =
          TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
        TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
          choicesAllMatching=true);

      package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;

       input Real TEDS_Heat_Load_Demand
       annotation(Dialog(tab="General"));
       input Real Gas_Turbine_Elec_Demand
       annotation(Dialog(tab="General"));
       input Real Delay_Start = 1e4
       annotation(Dialog(tab="General"));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput sensorBus
        annotation (Placement(transformation(extent={{-88,-238},{-40,-192}})));
      Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput actuatorBus
        annotation (Placement(transformation(extent={{46,-238},{94,-192}})));
      Modelica.Blocks.Continuous.LimPID PIDV1(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.005*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0)
        annotation (Placement(transformation(extent={{134,182},{148,196}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{118,174},{128,184}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{160,182},{174,196}})));
      Modelica.Blocks.Continuous.LimPID PIDV2(
        yMax=1,
        k=0.0007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{52,158},{66,172}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{32,150},{42,160}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{80,158},{94,172}})));
      Modelica.Blocks.Continuous.LimPID PIDV3(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.03*0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{136,134},{150,148}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{118,126},{128,136}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{158,134},{172,148}})));
      Modelica.Blocks.Continuous.LimPID PIDV4(
        yMax=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        yMin=0.0) annotation (Placement(transformation(extent={{46,112},{60,126}})));
      Modelica.Blocks.Sources.Constant const3(k=0)
        annotation (Placement(transformation(extent={{30,102},{40,112}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder3(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{80,112},{94,126}})));
      Modelica.Blocks.Continuous.LimPID PIDV5(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        yMin=0.0)
        annotation (Placement(transformation(extent={{136,90},{150,104}})));
      Modelica.Blocks.Sources.Constant const4(k=0)
        annotation (Placement(transformation(extent={{120,82},{130,92}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder4(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0)
        annotation (Placement(transformation(extent={{158,90},{172,104}})));
      Modelica.Blocks.Continuous.LimPID PIDV6(
        yMax=1,
        k=0.007*3600,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0.0)
        annotation (Placement(transformation(extent={{46,68},{60,82}})));
      Modelica.Blocks.Sources.Constant const5(k=0)
        annotation (Placement(transformation(extent={{30,60},{40,70}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
        annotation (Placement(transformation(extent={{80,70},{92,82}})));
      Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
        annotation (Placement(transformation(extent={{90,178},{112,200}})));
      Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
        annotation (Placement(transformation(extent={{4,154},{26,176}})));
      Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
        annotation (Placement(transformation(extent={{90,130},{112,152}})));
      Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
        annotation (Placement(transformation(extent={{4,108},{26,130}})));
      Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
        annotation (Placement(transformation(extent={{4,64},{26,86}})));
      Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
        annotation (Placement(transformation(extent={{90,86},{112,108}})));

    Real Error1 "Valve 1";
    Real Error2 "Valve 2";
    Real Error3 "Valve 3";
    Real Error4 "Valve 4";
    Real Error5 "Valve 5";
    Real Error6 "Valve 6";
    Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
    //Real Error_TSP "Error between Tout TEDS side and T_hot design";

    Integer storage_button "0 equals discharge or stationary, 1 is charging";

    parameter SI.Power Q_TES_max = 175e3;
    parameter SI.Power Heater_max = 175e3;
    parameter SI.Temperature T_hot_design = 325;
    parameter SI.Temperature T_cold_design = 225;

    parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
    parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

    SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
    SI.MassFlowRate m_bop_heater_demand_graph;
    SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
    SI.MassFlowRate m_tes_discharged;
    SI.MassFlowRate m_tes_charged;
    //SI.Power Q_TES_discharge;
    SI.Power Heat_needed_GT;
    SI.Power Heat_demand;
    SI.Power TES_Load;
    SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
    SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

    parameter SI.Pressure p_atm = 1e5;
    parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
    parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
    parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

    Medium.BaseProperties mediums;

      TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
        "Used in the Coded Section"
        annotation (Placement(transformation(extent={{-170,54},{-146,76}})));
      TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,38},{-146,58}})));
      Modelica.Blocks.Sources.ContinuousClock clock
        annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

      TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,22},{-146,42}})));
      TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,6},{-146,26}})));
      Modelica.Blocks.Continuous.LimPID PIDV7(
        yMax=1,
        k=-0.007*36,
        Ti=3.5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{102,-12},{116,2}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{68,-10},{78,0}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder6(
        T=2,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{158,-28},{170,-16}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder8(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{38,-74},{50,-62}})));
      Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
        annotation (Placement(transformation(extent={{66,-30},{86,-10}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{10,-70},{26,-54}})));
      Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
        annotation (Placement(transformation(extent={{-78,-46},{-56,-24}})));
      Modelica.Blocks.Sources.Constant const11(k=0.01)
        annotation (Placement(transformation(extent={{-60,-58},{-50,-48}})));
      Modelica.Blocks.Sources.Constant const12(k=0)
        annotation (Placement(transformation(extent={{-18,-80},{-8,-70}})));
      Modelica.Blocks.Logical.Switch switch3
        annotation (Placement(transformation(extent={{128,-42},{144,-26}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{100,-62},{110,-52}})));
    public
      TRANSFORM.Controls.LimPID cw_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        with_FF=false,
        k=-0.001,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689,
        reset=TRANSFORM.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{46,-180},{62,-164}})));
    public
      TRANSFORM.Controls.LimPID N2_mf_control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=false,
        k=-0.00025,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=10,
        yMin=0.001,
        Nd=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=0.689)
        annotation (Placement(transformation(extent={{152,-152},{168,-136}})));
      ExperimentalSystems.MAGNET.Data.Data_base_An data
        annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
      Modelica.Blocks.Sources.Constant const15(k=1)
        annotation (Placement(transformation(extent={{-18,-60},{-8,-50}})));
      Modelica.Blocks.Logical.GreaterEqual greaterEqual2
        annotation (Placement(transformation(extent={{-36,-44},{-26,-34}})));
      Modelica.Blocks.Continuous.LimPID PIDV8(
        yMax=1,
        k=0.00007*1,
        Ti=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0)
        annotation (Placement(transformation(extent={{120,-100},{134,-86}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder7(
        T=5,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=1)
        annotation (Placement(transformation(extent={{156,-98},{168,-86}})));
      Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
        annotation (Placement(transformation(extent={{-12,-130},{-2,-120}})));
      TRANSFORM.Controls.LimPID TEDS_pump_Control(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.125,
        Ti=1,
        k_s=1,
        k_m=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=19376)
        annotation (Placement(transformation(extent={{10,-132},{22,-120}})));
      TRANSFORM.Blocks.RealExpression mflow_inside_MAGNET
        "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-10},{-146,10}})));
      TRANSFORM.Blocks.RealExpression Tout_TEDS_side "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-26},{-146,-6}})));
      TRANSFORM.Blocks.RealExpression Tin_MT_HX "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-42},{-146,-22}})));
      TRANSFORM.Blocks.RealExpression Tout_MT_HX "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-58},{-146,-38}})));
      TRANSFORM.Blocks.RealExpression mf_MT_HX "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-74},{-146,-54}})));
      TRANSFORM.Blocks.RealExpression HX_heat "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-90},{-146,-70}})));
      TRANSFORM.Blocks.RealExpression Tin_TEDside "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-106},{-146,-86}})));
      TRANSFORM.Blocks.RealExpression mf_vc_GT "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-122},{-146,-102}})));
      TRANSFORM.Blocks.RealExpression GT_Power_sensor "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-138},{-146,-118}})));
      TRANSFORM.Blocks.RealExpression Tout_vc "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-154},{-146,-134}})));
      Modelica.Blocks.Sources.RealExpression GT_Power_generated(y=GT_Power_sensor.y)
        annotation (Placement(transformation(extent={{88,-124},{110,-102}})));
      Modelica.Blocks.Sources.RealExpression T_TEDSide_out(y=Tout_TEDS_side.y)
        annotation (Placement(transformation(extent={{-24,-154},{-2,-132}})));
      Modelica.Blocks.Sources.RealExpression T_vc_out(y=Tout_vc.y)
        annotation (Placement(transformation(extent={{84,-168},{106,-146}})));
      TRANSFORM.Blocks.RealExpression Tin_vc "Used in the Code section. "
        annotation (Placement(transformation(extent={{-170,-170},{-146,-150}})));
      Modelica.Blocks.Sources.RealExpression T_vc_in(y=Tin_vc.y)
        annotation (Placement(transformation(extent={{-16,-196},{6,-174}})));
      Modelica.Blocks.Sources.RealExpression GT_Power_Setpoint(y=
            Gas_Turbine_Elec_Demand)
        annotation (Placement(transformation(extent={{66,-104},{88,-82}})));
      TRANSFORM.Controls.LimPID PV012(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.0004,
        Ti=5,
        yMax=0.999,
        yMin=0.001,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.5)
        annotation (Placement(transformation(extent={{46,32},{60,46}})));
      Modelica.Blocks.Sources.RealExpression Valve7(y=T_cold_design)
        annotation (Placement(transformation(extent={{2,28},{24,50}})));
      Modelica.Blocks.Sources.RealExpression PV008(y=1)
        annotation (Placement(transformation(extent={{138,14},{158,34}})));
      Modelica.Blocks.Sources.RealExpression PV_009(y=1 - PV012.y)
        annotation (Placement(transformation(extent={{138,-4},{160,18}})));
    protected
      Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
        annotation (Placement(transformation(extent={{10,-178},{22,-166}})));
      Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
        annotation (Placement(transformation(extent={{126,-150},{138,-138}})));
    initial equation
      // Q_TES_discharge = 0.0;
      // storage_button=0;
    equation
      // Values do not matter here because the fluid is constant cp by definition
      // according to the linear fluid model. But this lets us change the fluid
      // easier.
      mediums.p = 1e5;
      mediums.T = 275+273;

      if clock.y < Delay_Start then // during the stablization period, Heat Load Demand is bypassed
        Heat_demand = HX_heat.y;
      else
        Heat_demand = TEDS_Heat_Load_Demand;
      end if;

      // TES charging/discharging power demand. Negative value means discharging
      TES_Load = -(Heat_demand - HX_heat.y);

      // variables that were never used again
      m_bop_heater_demand_graph = Heat_demand/(Cp*(T_hot_design - T_cold_design));

    algorithm

    //   if clock.y < Delay_Start then
    //     m_tes_discharged := 0;
    //   else
    //     m_tes_discharged:= (TEDS_Heat_Load_Demand - HX_heat.y)/(Cp*(T_hot_design - T_cold_design))
    //     "amount of TES flow rate needed for discharge";
    //   end if;

      // Theoretical value for discharge flowrate: m=Q/(c*deltaT). Value can be +/-
      m_tes_discharged := -1*TES_Load/(Cp*(T_hot_design - T_cold_design));

      // Theoretical value for charging flowrate: m=Q/(c*deltaT). Value can be + or 0
      // ??? QUESTION MARK ??? : Why the definition is different from m_tes_discharged
      if HX_heat.y > TEDS_Heat_Load_Demand then
        m_tes_charged:= (HX_heat.y-TEDS_Heat_Load_Demand)/(Cp*(T_hot_design - T_cold_design));
      else
        m_tes_charged:= 0;
      end if;

      // Theoretical value for Glycol_HX hot side flowrate: m=Q/(c*deltaT)
      m_bop_heater_demand :=TEDS_Heat_Load_Demand/(Cp*(T_hot_design - T_cold_design));

      // ?? QUESTION MARK ??? : data.eta_mech = 0.98? Such a high heat to mechanical efficiency?!
      Heat_needed_GT :=Gas_Turbine_Elec_Demand/data.eta_mech;

      // "m_MAGNET_GT" is never used again.
      // Plus, the Tin_MT_HX.y and Tout_MT_HX.y are the inlet/outlet temperature of "MAGNET_TEDS_simpleHX1".
      // The temperature should be measured from the inlet/outlet of turbine-compressor combination.
      m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

      // the nitrogen flow rate in "MAGNET_TEDS_simpleHX1"
      m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

    Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

    //Valve 2 Used for HeaterBOPDemand

    Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

    // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
    // Valve 3 used for TES discharge

    if m_tes_discharged > 0 and delay(storage_button,15) == 0 then
      Error3 :=(m_tes_discharged - Discharge_mass_flow_sensor.y)/m_tes_max;
      else
      Error3 :=-1;
    end if;

    //Valve 1 used for TES Charge
    if m_tes_charged > 0.001 then // charging
      Error1 :=(m_tes_charged - Charge_mass_flow_sensor.y)/m_tes_max;
    else
      Error1 :=-1;
      //storage_button :=0;
    end if;

      //Designation of the TEDS valve control algorithms.

     //Interlock System for the valves.
      if m_tes_charged > 0.001 then
        Error4 :=1;
        storage_button :=1;
      else
        Error4 :=-1;
        storage_button :=0;
      end if;

      if m_tes_discharged > 0.001 then
        Error5 :=1;
      else
        Error5 :=-1;
      end if;

    // Main Heater Mass Flow Control
      if m_tes_charged > 0.001 or m_bop_heater_demand > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
        Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
      else
        Error6 :=-1;
      end if;

    //Mode Determination System

    equation
      connect(PIDV1.y,firstOrder. u) annotation (Line(points={{148.7,189},{158.6,189}},
                                     color={0,0,127}));
      connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{66.7,165},{78.6,165}},
                                         color={0,0,127}));
      connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{150.7,141},{156.6,141}},
                                         color={0,0,127}));
      connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{60.7,119},{78.6,119}},
                                            color={0,0,127}));
      connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{150.7,97},{156.6,97}},
                                            color={0,0,127}));
      connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{60.7,75},{74.35,75},
              {74.35,76},{78.8,76}},        color={0,0,127}));
      connect(actuatorBus.Valve_1_Opening, firstOrder.y) annotation (Line(
          points={{70,-215},{180,-215},{180,189},{174.7,189}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,165},{94.7,165}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,119},{94.7,119}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
          points={{70,-215},{180,-215},{180,97},{172.7,97}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
          points={{70,-215},{180,-215},{180,76},{92.6,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
          points={{70,-215},{180,-215},{180,141},{172.7,141}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
        annotation (Line(
          points={{-64,-215},{-180,-215},{-180,65},{-172.4,65}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_flowrate, Charge_mass_flow_sensor.u) annotation (
          Line(
          points={{-64,-215},{-180,-215},{-180,48},{-172.4,48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorBus.MAGNET_valve3_opening, firstOrder8.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,-68},{50.6,-68}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.MAGNET_valve_opening, firstOrder6.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,-22},{170.6,-22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(MAGNET_valve.y,PIDV7. u_m)
        annotation (Line(points={{87,-20},{109,-20},{109,-13.4}},
                                                             color={0,0,127}));
      connect(Valve1.y, PIDV1.u_s)
        annotation (Line(points={{113.1,189},{132.6,189}},
                                                         color={0,0,127}));
      connect(const.y, PIDV1.u_m) annotation (Line(points={{128.5,179},{141,179},{141,
              180.6}},
            color={0,0,127}));
      connect(Valve2.y, PIDV2.u_s)
        annotation (Line(points={{27.1,165},{50.6,165}},
                                                       color={0,0,127}));
      connect(const1.y, PIDV2.u_m) annotation (Line(points={{42.5,155},{42.5,154},{59,
              154},{59,156.6}},
                              color={0,0,127}));
      connect(Valve3.y, PIDV3.u_s)
        annotation (Line(points={{113.1,141},{134.6,141}},
                                                       color={0,0,127}));
      connect(const2.y, PIDV3.u_m) annotation (Line(points={{128.5,131},{128.5,130},
              {143,130},{143,132.6}},
                              color={0,0,127}));
      connect(Valve4.y, PIDV4.u_s)
        annotation (Line(points={{27.1,119},{44.6,119}},
                                                       color={0,0,127}));
      connect(const3.y, PIDV4.u_m) annotation (Line(points={{40.5,107},{40.5,108},{53,
              108},{53,110.6}},
                         color={0,0,127}));
      connect(Valve5.y, PIDV5.u_s)
        annotation (Line(points={{113.1,97},{134.6,97}}, color={0,0,127}));
      connect(const4.y, PIDV5.u_m) annotation (Line(points={{130.5,87},{142.75,87},{
              142.75,88.6},{143,88.6}},
                                  color={0,0,127}));
      connect(const5.y, PIDV6.u_m) annotation (Line(points={{40.5,65},{46.75,65},{46.75,
              66.6},{53,66.6}},
                           color={0,0,127}));
      connect(Valve6.y, PIDV6.u_s)
        annotation (Line(points={{27.1,75},{44.6,75}},   color={0,0,127}));
      connect(const12.y, switch2.u3) annotation (Line(points={{-7.5,-75},{2,-75},
              {2,-68.4},{8.4,-68.4}},           color={0,0,127}));
      connect(switch2.y, firstOrder8.u) annotation (Line(points={{26.8,-62},{30,-62},
              {30,-68},{36.8,-68}},         color={0,0,127}));
      connect(const14.y, switch3.u3) annotation (Line(points={{110.5,-57},{120,-57},
              {120,-40.4},{126.4,-40.4}},
                                        color={0,0,127}));
      connect(switch3.y, firstOrder6.u) annotation (Line(points={{144.8,-34},{150,-34},
              {150,-22},{156.8,-22}},    color={0,0,127}));
      connect(Tout_vc_design.y,N2_mf_control. u_s)
        annotation (Line(points={{138.6,-144},{150.4,-144}},
                                                          color={0,0,127}));
      connect(actuatorBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
          points={{70,-215},{126,-215},{126,-214},{180,-214},{180,-144},{168.8,
              -144}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const15.y, switch2.u1) annotation (Line(points={{-7.5,-55},{4,-55},
              {4,-52},{8.4,-52},{8.4,-55.6}},
                                    color={0,0,127}));
      connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{-37,-39},
              {-50,-39},{-50,-35},{-54.9,-35}}, color={0,0,127}));
      connect(greaterEqual2.u2, const11.y) annotation (Line(points={{-37,-43},{
              -46,-43},{-46,-53},{-49.5,-53}},
                                            color={0,0,127}));
      connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{-25.5,-39},
              {6,-39},{6,-48},{0,-48},{0,-62},{8.4,-62}},
                                               color={255,0,255}));
      connect(cw_mf_control.u_s, Tin_vc_design.y)
        annotation (Line(points={{44.4,-172},{22.6,-172}}, color={0,0,127}));
      connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{154.8,-92},{144.75,-92},
              {144.75,-93},{134.7,-93}},
                                       color={0,0,127}));
      connect(actuatorBus.MAGNET_valve2_opening, firstOrder7.y) annotation (Line(
          points={{70,-215},{74,-215},{74,-216},{76,-216},{76,-214},{180,-214},
              {180,-92},{168.6,-92}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(const6.y, TEDS_pump_Control.u_s) annotation (Line(points={{-1.5,-125},
              {-1.5,-126},{8.8,-126}}, color={0,0,127}));
      connect(const7.y, PIDV7.u_s) annotation (Line(points={{78.5,-5},{89.55,-5},{89.55,
              -5},{100.6,-5}}, color={0,0,127}));
      connect(PIDV7.y, switch3.u1) annotation (Line(points={{116.7,-5},{126.4,-5},{126.4,
              -27.6}}, color={0,0,127}));
      connect(GT_Power_generated.y, PIDV8.u_m) annotation (Line(points={{111.1,-113},
              {127,-113},{127,-101.4}}, color={0,0,127}));
      connect(T_TEDSide_out.y, TEDS_pump_Control.u_m) annotation (Line(points={{-0.9,
              -143},{16,-143},{16,-133.2}}, color={0,0,127}));
      connect(T_vc_out.y, N2_mf_control.u_m) annotation (Line(points={{107.1,-157},{
              160,-157},{160,-153.6}}, color={0,0,127}));
      connect(T_vc_in.y, cw_mf_control.u_m) annotation (Line(points={{7.1,-185},{54,
              -185},{54,-181.6}}, color={0,0,127}));
      connect(sensorBus.heater_BOP_massflow, Heater_BOP_mass_flow.u) annotation (
          Line(
          points={{-64,-215},{-180,-215},{-180,16},{-172.4,16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,32},{-172.4,32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u) annotation (
          Line(
          points={{-64,-215},{-180,-215},{-180,0},{-172.4,0}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-16},{-172.4,-16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-32},{-172.4,-32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-48},{-172.4,-48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-64},{-172.4,-64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Heater_Input, HX_heat.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-80},{-172.4,-80}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-96},{-172.4,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-112},{-172.4,-112}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.GT_Power, GT_Power_sensor.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-128},{-172.4,-128}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Tout_vc, Tout_vc.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-144},{-172.4,-144}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Tin_vc, Tin_vc.u) annotation (Line(
          points={{-64,-215},{-180,-215},{-180,-160},{-172.4,-160}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Pump_Flow, TEDS_pump_Control.y) annotation (Line(
          points={{70,-215},{72,-215},{72,-214},{180,-214},{180,-126},{22.6,
              -126}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CW_control, cw_mf_control.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,-172},{62.8,-172}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(GT_Power_Setpoint.y, PIDV8.u_s) annotation (Line(points={{89.1,-93},{104.55,
              -93},{104.55,-93},{118.6,-93}}, color={0,0,127}));
      connect(switch3.u2, greaterEqual2.y) annotation (Line(points={{126.4,-34},
              {6,-34},{6,-39},{-25.5,-39}}, color={255,0,255}));
      connect(sensorBus.TC006, PV012.u_m) annotation (Line(
          points={{-64,-215},{-64,-52},{-84,-52},{-84,24},{53,24},{53,30.6}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Valve7.y, PV012.u_s)
        annotation (Line(points={{25.1,39},{44.6,39}}, color={0,0,127}));
      connect(actuatorBus.PV012, PV012.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,39},{60.7,39}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PV008, PV008.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,24},{159,24}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PV009, PV_009.y) annotation (Line(
          points={{70,-215},{70,-214},{180,-214},{180,7},{161.1,7}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
                {180,200}})), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-180,-220},{180,200}})));
    end Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_bypass;

  end MAGNET_TEDS_ControlSystem;

  model MAGNET_Insulated_pipes_dyn "MAGNET model with insulated pipes dynamic simulation"
    extends TRANSFORM.Icons.Example;

  protected
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium_cw,
      p=data.p_hx_cw,
      T=data.T_hx_cw,                                       nPorts=1)
      annotation (Placement(transformation(extent={{56,2},{36,22}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_cw(
      redeclare package Medium = Medium_cw,
      p_start=data.p_hx_cw,
      T_start=data.T_hx_cw,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-24,2},{-4,22}})));
    TRANSFORM.HeatExchangers.Simple_HX hx(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium_cw,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_hx,
      p_a_start_1=data.p_rp_hx,
      p_b_start_1=data.p_hx_co,
      T_a_start_1=data.T_rp_hx,
      T_b_start_1=data.T_hx_co,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_cw_hx,
      p_b_start_2=data.p_hx_cw,
      T_a_start_2=data.T_cw_hx,
      T_b_start_2=data.T_hx_cw,
      m_flow_start_2=data.m_flow_cw,
      R_1=-data.dp_hx_hot/data.m_flow)
      annotation (Placement(transformation(extent={{-54,0},{-34,-20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
      redeclare package Medium = Medium_cw,
      p_start=data.p_cw_hx,
      T_start=data.T_cw_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-88,4},{-68,24}})));
  public
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Medium_cw,
      use_m_flow_in=true,
      m_flow=data.m_flow_cw,
      T=data.T_cw_hx,
        nPorts=1)
      annotation (Placement(transformation(extent={{-170,4},{-150,24}})));
  protected
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_2(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{0,-36},{-20,-16}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
      redeclare package Medium = Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-66,-36},{-86,-16}})));
    TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
      redeclare package Medium = Medium,
      dp_nominal(displayUnit="Pa") = 1e4,
      m_flow_nominal=1,
      opening_nominal=0.5)
      annotation (Placement(transformation(extent={{-192,-84},{-172,-64}})));
    Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
      annotation (Placement(transformation(extent={{-232,-64},{-212,-44}})));
  public
    TRANSFORM.HeatExchangers.Simple_HX  rp(
      redeclare package Medium_1 = Medium,
      redeclare package Medium_2 = Medium,
      nV=10,
      V_1=1,
      V_2=1,
      UA=data.UA_rp_MAGNET,
      p_a_start_1=data.p_vc_rp,
      p_b_start_1=data.p_rp_hx,
      T_a_start_1=data.T_vc_rp,
      T_b_start_1=data.T_rp_hx,
      m_flow_start_1=data.m_flow,
      p_a_start_2=data.p_co_rp,
      p_b_start_2=data.p_rp_vc,
      T_a_start_2=data.T_co_rp,
      T_b_start_2=data.T_rp_vc,
      m_flow_start_2=data.m_flow,
      R_1=-data.dp_rp_hot/data.m_flow,
      R_2=-data.dp_rp_cold/data.m_flow)
      annotation (Placement(transformation(extent={{-54,58},{-34,78}})));
  protected
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_co_rp_1(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      precision2=1,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{26,42},{6,62}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_1(
      redeclare package Medium = Medium,
      p_start=data.p_rp_hx,
      T_start=data.T_rp_hx,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{4,78},{24,98}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_vc_pipe_rp(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-110,80},{-90,100}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      precision=1,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-90,40},{-110,60}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_vc_pipe(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-190,80},{-170,100}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pipe_vc(
      redeclare package Medium = Medium,
      p_start=data.p_rp_vc,
      T_start=data.T_rp_vc,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
      redeclare function iconUnit2 =
          TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
      annotation (Placement(transformation(extent={{-164,40},{-184,60}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume vc(
      redeclare package Medium = Medium,
      p_start=data.p_vc_rp,
      T_start=data.T_vc_rp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.1),
      Q_gen=combiTimeTable3.y[1]*data.Q_vc)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-236,60})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-236,78})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(redeclare package Medium =
          Medium,
      p_start=data.p_hx_co,
      T_start=data.T_hx_co,
                  redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      Q_gen=0)      "12022.6"
                    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-64,-90})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_co_rp_2(
      redeclare package Medium = Medium,
      p_start=data.p_co_rp,
      T_start=data.T_co_rp,
      precision=2)
      annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
      redeclare package Medium = Medium,
      p=data.p_hx_co,
      T=data.T_ps,
      nPorts=1)
      annotation (Placement(transformation(extent={{-262,-84},{-242,-64}})));
  protected
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showColors=true,
      val_min=data.T_hx_co,
      val_max=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-292,54},{-272,74}})));
  protected
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(table=[0,0; 60.037,4.6;
          120.102,15.5; 180.084,12.5; 240.044,11.2; 300.005,12.3; 360.053,12.3; 420.031,
          12.3; 480.073,12.7; 540.034,12.5; 600.1,12.9; 660.04,13.1; 720.053,13.1;
          780.104,14.9; 840.009,14.9; 900.102,13.1; 960.017,13.4; 1020.048,11.8; 1080.101,
          15.5; 1140.049,13.6; 1200.034,13.6; 1260.061,13.8; 1320.034,13.8; 1380.071,
          14; 1440.045,14; 1500.036,14; 1560.072,13.8; 1620.051,14; 1680.043,14.4;
          1740.005,14.8; 1800.046,13.1; 1860.05,13.1; 1920.049,12.9; 1980.001,14.8;
          2040.038,14.8; 2100.029,10.6; 2160.022,2.1; 2220.024,2.1; 2280.022,2.8;
          2340.009,2.4; 2400.054,2.7; 2460.095,2.6; 2520.051,2.6; 2580.027,2.3; 2640.006,
          2.4; 2700.069,2.2; 2760.052,2.3; 2820.005,13.8; 2880.091,16.2; 2940.004,
          16.6; 3000.104,15.5; 3060.098,15.7; 3120.006,15.9; 3180.088,16.4; 3240.023,
          17.9; 3300.085,16.4; 3360,16.4; 3420.08,16.6; 3480.011,16.4; 3540.045,7.2;
          3600.004,2.9; 3660.056,2.4; 3720.046,3.7; 3780.006,3.3; 3840.06,3.1; 3900.017,
          3.4; 3960.022,1.3; 4020.025,3.2; 4080.071,3; 4140.062,3.1; 4200.044,3.1;
          4260.064,3.1; 4320.004,5.1; 4380.049,5.1; 4440.066,3.9; 4500.078,5.6; 4560.066,
          5.4; 4620.067,5.9; 4680.066,5.8; 4740.042,5.8; 4800.06,5.9; 4860.063,6;
          4920.016,5.8; 4980.064,5.6; 5040.008,5.9; 5100.052,6; 5160.084,4.1; 5220.067,
          6.1; 5280.06,6.1; 5340.057,5.9; 5400.037,6.4; 5460.098,6.2; 5520.065,6.2;
          5580.075,6.3; 5640.084,6.3; 5700.07,4.4; 5760.079,6.2; 5820.01,6.5; 5880.016,
          6.3; 5940.03,6.3; 6000.077,6.3; 6060.054,4.6; 6120.051,6.6; 6180.064,6.5;
          6240.028,6.5; 6300.007,6.5; 6360.029,6.4; 6420.027,6.6; 6480.06,6.7; 6540.037,
          6.8; 6600.102,5.1; 6660.008,6.6; 6720.087,4.9; 6780.045,5; 6840.093,6.9;
          6900.03,6.8; 6960.032,6.8; 7020.073,5.1; 7080.016,6.9; 7140.014,6.9; 7200.001,
          7; 7260.097,7; 7320.05,7; 7380.005,6.9; 7440.073,7.1; 7500.025,7.1; 7560.028,
          7.1; 7620.033,7.1; 7680.087,7.1; 7740.006,6.9; 7800.018,7.4; 7860.076,5.5;
          7920.068,7.3; 7980.034,7.1; 8040.079,5.6; 8100.045,7.3; 8160.033,7.1; 8220.024,
          7.3; 8280.023,5.4; 8340.102,5.6; 8400.029,7.4; 8460.068,7.6; 8520.075,7.6;
          8580.089,7.7; 8640.018,7.7; 8700.062,7.5; 8760.035,7.9; 8820.051,6.5; 8880.026,
          6.6; 8940.084,5.7; 9000.083,5.1; 9060.067,4.9; 9120.004,4.8; 9180.009,4.9;
          9240.017,4.7; 9300.034,4.8; 9360.029,4.8; 9420.037,4.9; 9480.03,4.8; 9540.085,
          4.8; 9600.001,4.8; 9660.002,0; 9720.008,0; 9780.021,0; 9840.026,0; 9900.107,
          0; 9960.082,0; 10020.102,0; 10080.057,0; 10140.046,0; 10200.023,0; 10260.022,
          0; 10320.031,0; 10380.067,0; 10440.067,0; 10500.014,0; 10560.005,0; 10620.033,
          0; 10680.079,0; 10740.041,0; 10800.087,0; 10860,0; 10920.101,0; 10980.009,
          0; 11040.052,0; 11100.055,0; 11160.013,0; 11220.056,0; 11280.088,0; 11340.092,
          0; 11400.08,0; 11460.084,0; 11520.065,0; 11580.049,0; 11640.019,0; 11700.041,
          0; 11760.021,0; 11820.093,0; 11880.074,0; 11940.02,0; 12000.03,0; 12060.016,
          0; 12120.007,0; 12180.093,0; 12240.046,0; 12300.093,0; 12360.065,0; 12420.094,
          0; 12480.049,0; 12540.058,0; 12600.025,0.7; 12660.036,3.6; 12720.045,3.5;
          12780.012,4; 12840.059,2.1; 12900.102,1.9; 12960.007,3.4; 13020.063,3.4;
          13080.096,3.4; 13140.097,3.3; 13200.069,3.4; 13260.095,3.2; 13320.07,3.3;
          13380.047,3.3; 13440.045,3.2; 13500.019,5.2; 13560.1,3.3; 13620.087,3.1;
          13680.02,3.4; 13740.054,5.1; 13800.07,3.2; 13860.082,3.2; 13920.035,3.2;
          13980.006,3.4; 14040.067,3.2; 14100.06,3.2; 14160.1,3.2; 14220.062,3.2;
          14280.075,3.2; 14340.095,3.2; 14400.045,3.2; 14460.078,3.2; 14520.031,3.2;
          14580.023,3.2; 14640.075,3.3; 14700.04,3.3; 14760.064,3; 14820.07,3; 14880.007,
          2.9; 14940.071,3.1; 15000.09,3.1; 15060.084,29.2; 15120.028,2.1; 15180.081,
          0; 15240.094,0; 15300.085,0; 15360.016,0; 15420.034,0; 15480.101,0; 15540.005,
          0; 15600.092,0; 15660.037,0; 15720.058,0; 15780.026,0; 15840.049,0; 15900.057,
          0; 15960.04,0; 16020.1,0; 16080.085,0; 16140.048,0; 16200,0; 16260.014,0;
          16320.025,0; 16380.073,0; 16440.033,0; 16500.008,0; 16560.089,0; 16620.078,
          1.3; 16680.043,3; 16740.083,2.4; 16800.008,3.6; 16860.093,2.1; 16920.024,
          3.8; 16980.057,3.7; 17040.081,0; 17100.028,0; 17160.039,0; 17220.018,0;
          17280.081,0; 17340.028,0; 17400.09,0; 17460.039,0; 17520.06,0; 17580.086,
          0; 17640.061,33.8; 17700.01,7.4; 17760.103,0; 17820.062,13.9; 17880.037,
          16.7; 17940.06,17.9; 18000.035,18.7; 18060.076,18.7; 18120.057,19.2; 18180.013,
          7.4; 18240.098,3.1; 18300.063,3.5; 18360.074,0.9; 18420.076,6.4; 18480.001,
          6.6; 18540.093,5.3; 18600.009,7.1; 18660.02,7.1; 18720.11,7.1; 18780.009,
          5.4; 18840.035,7.2; 18900.045,7.2; 18960.088,7.2; 19020.04,7.4; 19080.096,
          7.4; 19140.036,7.4; 19200.098,7.5; 19260.102,7.5; 19320.039,5.6; 19380.001,
          7.6; 19440.041,7.4; 19500.014,5.9; 19560.093,7.8; 19620.098,7.9; 19680.043,
          7.9; 19740.024,7.9; 19800.035,7.9; 19860.04,8; 19920.075,6.4; 19980.01,8.2;
          20040.035,8.2; 20100.081,6.3; 20160.06,8; 20220.062,8.3; 20280.08,8.3; 20340.004,
          6.6; 20400.033,6.8; 20460.004,0; 20520.061,0], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
      annotation (Placement(transformation(extent={{-290,-2},{-270,18}})));
  public
    NHES.ExperimentalSystems.MAGNET.Data.Summary summary(
      Ts={sensor_cw_hx.T,sensor_rp_hx_2.T,sensor_hx_co.T,sensor_co_rp_1.T,
          sensor_rp_hx_1.T,sensor_vc_pipe_rp.T,sensor_rp_pipe_vc.T,sensor_vc_pipe.T},
      ps={sensor_cw_hx.p,sensor_rp_hx_2.p,sensor_hx_co.p,sensor_co_rp_1.p,
          sensor_rp_hx_1.p,sensor_vc_pipe_rp.p,sensor_rp_pipe_vc.p,sensor_vc_pipe.p},
      m_flows={sensor_co_rp_2.m_flow},
      Q_flows={vc.Q_gen})
      annotation (Placement(transformation(extent={{-290,28},{-270,48}})));

  public
    TRANSFORM.Controls.LimPID cw_mf_control(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=false,
      k=-0.0005,
      Ti=1,
      k_s=1,
      k_m=1,
      yMax=2,
      yMin=0.001,
      Nd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=data.m_flow_cw)
      annotation (Placement(transformation(extent={{-202,14},{-186,30}})));
  public
    TRANSFORM.Controls.LimPID N2_mf_control(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=false,
      k=-0.025,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=10,
      yMin=0.001,
      Nd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=data.m_flow)
      annotation (Placement(transformation(extent={{-70,-60},{-54,-44}})));
  protected
    NHES.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-292,84},{-272,104}})));
  protected
    package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
    package Medium_cw = Modelica.Media.Water.StandardWater;

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      T_a_start=data.T_hx_co,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_hx_co, length=data.length_hx_co))
      annotation (Placement(transformation(extent={{-118,-100},{-98,-80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
      redeclare package Medium = Medium,
      p_a_start=data.p_co_rp,
      T_a_start=data.T_co_rp,
      m_flow_a_start=data.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_co_rp, length=data.length_co_rp))
      annotation (Placement(transformation(extent={{48,-100},{68,-80}})));
  public
    TRANSFORM.Fluid.Machines.Pump_Controlled co(
      redeclare package Medium = Medium,
      p_a_start=data.p_hx_co,
      p_b_start=data.p_co_rp,
      T_a_start=data.T_hx_co,
      T_b_start=data.T_co_rp,
      m_flow_start=data.m_flow,
      redeclare model EfficiencyChar =
          TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant
          (eta_constant=0.7027),
      controlType="m_flow",
      use_port=true)
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  protected
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_vc_rp(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS316,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{152,60},{172,80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_vc(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS316,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{192,38},{172,58}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_hx(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
          (dimension=data.d_rp_hx, length=data.length_rp_hx),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow,
      redeclare package Material = TRANSFORM.Media.Solids.SS316,
      redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
      annotation (Placement(transformation(extent={{204,60},{184,80}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_vc_rp(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_vc_rp, length=data.length_vc_rp),
      redeclare package Medium = Medium,
      p_a_start=data.p_vc_rp,
      T_a_start=data.T_vc_rp,
      m_flow_a_start=data.m_flow,
      redeclare package Material_wall = TRANSFORM.Media.Solids.SS316)
      annotation (Placement(transformation(extent={{-152,80},{-132,100}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_vc(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_vc, length=data.length_rp_vc),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_vc,
      T_a_start=data.T_rp_vc,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{-128,40},{-148,60}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_hx(
      ths_wall=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      ths_insulation=fill(data.th_4in_sch40, pipe_ins_vc_rp.geometry.nV),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data.d_rp_hx, length=data.length_rp_hx),
      redeclare package Medium = Medium,
      p_a_start=data.p_rp_hx,
      T_a_start=data.T_rp_hx,
      m_flow_a_start=data.m_flow)
      annotation (Placement(transformation(extent={{46,-36},{26,-16}})));
  protected
    Modelica.Blocks.Sources.RealExpression Tin_vc(y=sensor_pipe_vc.T)
      annotation (Placement(transformation(extent={{-220,-12},{-200,8}})));
    Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
      annotation (Placement(transformation(extent={{-222,16},{-210,28}})));
  protected
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(table=[0,182.455699;
          60.037,190.247786; 120.102,187.619049; 180.084,187.825319; 240.044,
          187.39156; 300.005,188.465638; 360.053,187.693754; 420.031,184.677147;
          480.073,188.004943; 540.034,192.38221; 600.1,187.487949; 660.04,
          192.953911; 720.053,190.158352; 780.104,189.409212; 840.009,
          188.522193; 900.102,193.002981; 960.017,189.070942; 1020.048,
          181.88782; 1080.101,190.324869; 1140.049,186.956355; 1200.034,
          183.385201; 1260.061,192.661804; 1320.034,191.419506; 1380.071,
          185.545999; 1440.045,183.357896; 1500.036,184.655624; 1560.072,
          193.607786; 1620.051,190.175811; 1680.043,190.011206; 1740.005,
          187.347068; 1800.046,187.428664; 1860.05,189.590136; 1920.049,
          188.497377; 1980.001,189.555924; 2040.038,190.850504; 2100.029,
          193.158688; 2160.022,188.472738; 2220.024,187.715342; 2280.022,
          191.882997; 2340.009,190.56601; 2400.054,186.785084; 2460.095,
          186.192984; 2520.051,190.720352; 2580.027,193.389084; 2640.006,
          190.65493; 2700.069,192.587484; 2760.052,193.875672; 2820.005,
          191.468207; 2880.091,189.776698; 2940.004,193.511815; 3000.104,
          191.106214; 3060.098,188.553547; 3120.006,192.357538; 3180.088,
          196.764873; 3240.023,190.671105; 3300.085,194.242837; 3360,191.077832;
          3420.08,193.371319; 3480.011,162.604959; 3540.045,161.341716;
          3600.004,161.288599; 3660.056,157.92688; 3720.046,162.332593;
          3780.006,160.065833; 3840.06,160.552469; 3900.017,159.109908;
          3960.022,160.794397; 4020.025,161.016361; 4080.071,160.949912;
          4140.062,163.425704; 4200.044,163.351272; 4260.064,163.823934;
          4320.004,164.608813; 4380.049,164.997421; 4440.066,164.292629;
          4500.078,162.827372; 4560.066,166.120409; 4620.067,163.150029;
          4680.066,157.907975; 4740.042,162.395444; 4800.06,162.480718;
          4860.063,163.86009; 4920.016,163.699613; 4980.064,162.393548;
          5040.008,158.209109; 5100.052,161.050397; 5160.084,159.549016;
          5220.067,163.663216; 5280.06,165.09781; 5340.057,160.534865; 5400.037,
          162.233312; 5460.098,156.595004; 5520.065,157.252509; 5580.075,
          159.415379; 5640.084,155.767416; 5700.07,155.338523; 5760.079,
          154.940004; 5820.01,152.684055; 5880.016,154.859501; 5940.03,
          156.267142; 6000.077,154.685917; 6060.054,153.208742; 6120.051,
          151.134729; 6180.064,148.661377; 6240.028,149.709049; 6300.007,
          147.797649; 6360.029,148.183752; 6420.027,144.453856; 6480.06,
          145.624195; 6540.037,145.137109; 6600.102,144.931144; 6660.008,
          143.294215; 6720.087,141.248792; 6780.045,141.147938; 6840.093,
          144.305409; 6900.03,142.860102; 6960.032,139.777319; 7020.073,
          141.641207; 7080.016,145.323511; 7140.014,141.662249; 7200.001,
          144.573086; 7260.097,148.124531; 7320.05,148.001157; 7380.005,
          142.374831; 7440.073,143.501449; 7500.025,145.833614; 7560.028,
          148.885557; 7620.033,144.176655; 7680.087,143.775711; 7740.006,
          143.321167; 7800.018,142.015215; 7860.076,142.409991; 7920.068,
          144.32666; 7980.034,141.819417; 8040.079,141.303018; 8100.045,
          144.342513; 8160.033,142.562855; 8220.024,142.412658; 8280.023,
          143.545716; 8340.102,146.145847; 8400.029,144.188107; 8460.068,
          141.618383; 8520.075,144.473918; 8580.089,142.326677; 8640.018,
          142.51544; 8700.062,143.623088; 8760.035,138.316689; 8820.051,
          141.839398; 8880.026,143.196781; 8940.084,144.367377; 9000.083,
          138.154011; 9060.067,139.905865; 9120.004,144.115233; 9180.009,
          141.655486; 9240.017,142.398941; 9300.034,145.10476; 9360.029,
          143.924543; 9420.037,145.778745; 9480.03,141.92909; 9540.085,
          142.363941; 9600.001,138.554923; 9660.002,143.080572; 9720.008,
          143.784095; 9780.021,146.536431; 9840.026,140.11122; 9900.107,
          142.411806; 9960.082,143.365081; 10020.102,143.122928; 10080.057,
          142.209905; 10140.046,143.445231; 10200.023,142.423612; 10260.022,
          142.739877; 10320.031,144.496132; 10380.067,140.014317; 10440.067,
          141.35787; 10500.014,142.97983; 10560.005,142.221277; 10620.033,
          140.139489; 10680.079,143.983395; 10740.041,143.507376; 10800.087,
          141.204814; 10860,144.98651; 10920.101,142.166441; 10980.009,
          143.480664; 11040.052,144.039885; 11100.055,142.492101; 11160.013,
          141.572782; 11220.056,142.305909; 11280.088,144.657621; 11340.092,
          141.370881; 11400.08,140.036675; 11460.084,142.067658; 11520.065,
          141.114448; 11580.049,142.247796; 11640.019,143.112503; 11700.041,
          145.811014; 11760.021,141.968008; 11820.093,143.948556; 11880.074,
          141.756662; 11940.02,143.557667; 12000.03,141.063643; 12060.016,
          145.820105; 12120.007,141.316382; 12180.093,140.651134; 12240.046,
          141.30191; 12300.093,142.106031; 12360.065,143.955173; 12420.094,
          140.987942; 12480.049,141.25814; 12540.058,145.24063; 12600.025,
          140.19916; 12660.036,136.943211; 12720.045,145.042069; 12780.012,
          141.623218; 12840.059,144.136355; 12900.102,141.146749; 12960.007,
          143.156257; 13020.063,139.706855; 13080.096,138.661383; 13140.097,
          146.916414; 13200.069,143.155132; 13260.095,139.129162; 13320.07,
          145.052365; 13380.047,141.746286; 13440.045,143.241354; 13500.019,
          141.869306; 13560.1,140.762542; 13620.087,141.572429; 13680.02,
          149.612564; 13740.054,143.703592; 13800.07,141.872358; 13860.082,
          143.899968; 13920.035,141.530442; 13980.006,146.1648; 14040.067,
          143.716586; 14100.06,142.383376; 14160.1,140.844716; 14220.062,
          142.143697; 14280.075,141.333488; 14340.095,141.116472; 14400.045,
          139.671341; 14460.078,140.398733; 14520.031,140.850289; 14580.023,
          141.56904; 14640.075,142.778892; 14700.04,146.553376; 14760.064,
          143.619394; 14820.07,143.007456; 14880.007,140.679821; 14940.071,
          142.865531; 15000.09,147.051641; 15060.084,141.439739; 15120.028,
          142.368198; 15180.081,144.921442; 15240.094,143.609419; 15300.085,
          138.558601; 15360.016,140.670875; 15420.034,142.890845; 15480.101,
          141.841824; 15540.005,143.133015; 15600.092,141.534827; 15660.037,
          136.551551; 15720.058,141.510445; 15780.026,138.86677; 15840.049,
          143.759504; 15900.057,142.396692; 15960.04,141.695481; 16020.1,
          139.686664; 16080.085,139.693346; 16140.048,141.999763; 16200,
          141.666489; 16260.014,143.339799; 16320.025,145.573294; 16380.073,
          143.25112; 16440.033,139.154026; 16500.008,142.149447; 16560.089,
          142.076171; 16620.078,145.833598; 16680.043,147.362701; 16740.083,
          139.708204; 16800.008,146.003423; 16860.093,141.071498; 16920.024,
          142.468217; 16980.057,140.000134; 17040.081,141.137224; 17100.028,
          140.778684; 17160.039,142.404691; 17220.018,141.409767; 17280.081,
          140.421991; 17340.028,141.040915; 17400.09,141.215013; 17460.039,
          140.660852; 17520.06,148.016721; 17580.086,139.072045; 17640.061,
          140.447851; 17700.01,140.885176; 17760.103,141.809218; 17820.062,
          141.446678; 17880.037,143.974143; 17940.06,140.23318; 18000.035,
          141.627715; 18060.076,138.608587; 18120.057,140.938856; 18180.013,
          141.129016; 18240.098,139.981261; 18300.063,142.331383; 18360.074,
          140.522107; 18420.076,143.362383; 18480.001,141.406523; 18540.093,
          137.229729; 18600.009,142.11554; 18660.02,140.716845; 18720.11,
          139.915293; 18780.009,144.073712; 18840.035,142.957889; 18900.045,
          141.65425; 18960.088,141.544159; 19020.04,138.75782; 19080.096,
          141.339993; 19140.036,142.535116; 19200.098,136.467755; 19260.102,
          139.157271; 19320.039,139.775231; 19380.001,141.013272; 19440.041,
          139.908483; 19500.014,145.163805; 19560.093,144.150843; 19620.098,
          138.613309; 19680.043,137.549928; 19740.024,141.423693; 19800.035,
          138.763041; 19860.04,141.985195; 19920.075,141.828749; 19980.01,
          140.541012; 20040.035,142.198854; 20100.081,139.484441; 20160.06,
          141.222129; 20220.062,139.542442; 20280.08,137.21614; 20340.004,
          137.13297; 20400.033,141.195594; 20460.004,140.844314; 20520.061,
          141.406828; 20580.004,141.443931; 20640.004,141.266332; 20700.046,
          138.2659; 20760.021,140.868231; 20820.036,140.668096; 20880.103,
          137.682875; 20940.092,141.129418; 21000.048,139.080156; 21060.047,
          140.363412; 21120.035,142.513384; 21180.101,146.267309; 21240.01,
          146.879599; 21300.008,147.264385; 21360.08,140.608521; 21420.031,
          142.827801; 21480.065,142.084877; 21540.076,142.42448; 21600.08,
          144.603668; 21660.001,140.520741; 21720.063,138.988586; 21780.02,
          140.523938; 21840.036,138.937347; 21900.053,142.477918; 21960.031,
          142.239556; 22020.078,138.432882; 22080.041,141.407149; 22140.048,
          139.610562; 22200.015,60.620945; 22260.008,0.359107709; 22320.011,
          0.36631335; 22380,0.372674163; 22440.038,0.376002758; 22500.024,
          0.378556214; 22560.076,0.367821882; 22620.068,0.385496149; 22680.07,
          0.375378934; 22740.058,0.400215429; 22800.056,0.397247172; 22860.055,
          0.396712132; 22920.051,0.424031105; 22980.045,0.390241007; 23040.071,
          0.386443173; 23100.087,0.373643789; 23160.079,0.41048675; 23220.041,
          0.398235413; 23280.084,0.397760947; 23340.042,0.414736068; 23400.087,
          0.395051212; 23460.074,0.402803587; 23520.088,0.380015032; 23580.024,
          0.406718439; 23640.083,0.376855771; 23700.095,0.375760727; 23760.045,
          0.394258294; 23820.002,0.392281333; 23880.048,0.40185136; 23940.087,
          0.388508679; 24000.02,0.403922308; 24060.026,0.400158101; 24120.061,
          0.377688403; 24180.063,0.391165239; 24240.075,0.394399798; 24300.08,
          0.384381773; 24360.079,0.396421461; 24420.091,0.40606378; 24480.044,
          0.384352679; 24540.039,0.389738092; 24600.042,0.401792529; 24660.051,
          0.387731823; 24720.075,0.39283308; 24780.02,0.40151341; 24840,
          0.404452789; 24900.072,0.421731803; 24960.03,0.410876372; 25020.025,
          0.432632389; 25080.103,0.399680365; 25140.052,0.425391163; 25200.085,
          0.424968534; 25260.082,0.391468034; 25320.068,0.401814463; 25380.045,
          0.407646346; 25440.045,0.41249667; 25500.089,0.3725281; 25560.05,
          0.387408622; 25620.051,0.412701564; 25680.089,0.407242405; 25740.057,
          0.402300218; 25800.052,0.42430261; 25860.045,0.410890691; 25920.051,
          0.411447211; 25980.028,0.418983643; 26040.019,0.395548901; 26100.084,
          0.419910237; 26160.049,0.412733498; 26220.009,0.414347091; 26280,
          0.391881282; 26340.102,0.437172114; 26400.093,0.425923816; 26460.056,
          0.409444642; 26520.061,0.446905794; 26580.027,0.421109482; 26640.083,
          0.411588071; 26700.052,0.410582455; 26760.096,0.391657295; 26820.007,
          0.423594347; 26880.039,0.430840131; 26940.053,0.410316558; 27000.048,
          0.417996212; 27060.081,0.429811483; 27120.038,0.414206636; 27180.053,
          0.418611133; 27240.046,0.427571036; 27300.008,0.409958607; 27360.01,
          0.414530695; 27420.1,0.439597049; 27480.054,0.428450971; 27540.046,
          0.423465395; 27600.083,0.440175288; 27660.094,0.440791522; 27720.016,
          0.431341519; 27780.046,0.422245768; 27840.01,0.422610425; 27900.042,
          0.398405987; 27960.009,0.399982706; 28020.064,0.414218784; 28080.059,
          0.405964781; 28140.049,0.408010335; 28200.073,0.415299293; 28260.069,
          0.414813299; 28320.07,0.416833458; 28380.048,0.441357588; 28440.04,
          0.395236535; 28500.062,0.43975137; 28560.06,0.433535092; 28620.081,
          0.415009959; 28680.099,0.432886519; 28740.003,0.414807667; 28800.047,
          0.422435888; 28860.082,0.4107094; 28920.076,0.441941912; 28980.052,
          0.447019088; 29040.076,0.424959178; 29100.008,0.415654404; 29160.088,
          0.435363365; 29220.009,0.436551966; 29280.015,0.434151971; 29340.055,
          0.425354432; 29400.055,0.432191072; 29460.085,0.453880454; 29520.075,
          0.42137903; 29580.033,0.445345567; 29640.1,0.446320371; 29700.1,
          0.424629462; 29760.013,0.452655839; 29820.054,0.447614248; 29880.075,
          0.457611223; 29940.074,0.438700169; 30000.075,0.436047093; 30060.055,
          0.447083313; 30120.026,0.451644327; 30180.017,0.43358977; 30240.075,
          0.434839589; 30300.065,0.429019878; 30360.038,0.449897654; 30420.095,
          0.42718879; 30480.079,0.463275325; 30540.024,0.433198646; 30600.012,
          0.456880407; 30660.103,0.445061435; 30720.077,0.419292475; 30780.057,
          0.450615274; 30840.101,0.451189168; 30900.04,0.4496856; 30960.054,
          0.43747424; 31020.103,0.440779994; 31080.062,0.442930369; 31140.011,
          0.460309025; 31200.075,0.459229804; 31260.015,0.456060352; 31320.02,
          0.480734483; 31380.022,0.452235811; 31440.088,0.432227516; 31500.012,
          0.440204357; 31560.021,0.44552941; 31620.026,0.436882946; 31680.071,
          0.43157701; 31740.055,0.434433047; 31800.009,0.465922315; 31860.041,
          0.446027553; 31920.034,0.432749334; 31980.1,0.447291501; 32040.025,
          0.465279613; 32100.061,0.459370259; 32160.089,0.449034235; 32220.06,
          0.434322783; 32280.099,0.433303682; 32340.091,0.443416124; 32400.035,
          0.437281255; 32460.056,0.442646237; 32520.046,0.444723915; 32580.057,
          0.459098705; 32640.097,0.431929734; 32700.041,0.473980564; 32760.015,
          0.461051775; 32820.088,0.479211392; 32880.04,0.45325033; 32940.053,
          0.452569203; 33000,0.461500228; 33060.07,0.448284945; 33120.05,
          0.480665676; 33180.014,0.410840284; 33240.06,0.457042532; 33300.013,
          0.446819588; 33360.062,0.45391172; 33420.045,0.46824503; 33480.041,
          0.443282233; 33540.056,0.478411959; 33600.057,0.47040865; 33660.054,
          0.477117223; 33720.04,0.48400291; 33780.015,0.500944403; 33840.072,
          0.486701809; 33900.096,0.446779229; 33960.072,0.459353528; 34020.036,
          0.467593855; 34080.072,0.488006545; 34140.038,0.459449018; 34200.067,
          0.457376138; 34260.095,0.461152707; 34320.032,0.434405266; 34380.079,
          0.455723476; 34440.046,0.45102616; 34500.081,0.474069729; 34560.081,
          0.499240069; 34620.009,0.47145379; 34680.039,0.474814246; 34740.003,
          0.476507505; 34800.099,0.499429355; 34860.023,0.488435641; 34920.025,
          0.454969198; 34980.097,0.46863551; 35040.029,0.432289378; 35100.067,
          0.479807196; 35160.073,0.471625247; 35220.076,0.465848925; 35280.056,
          0.481875327; 35340.025,0.477898184; 35400.048,0.465450425; 35460.038,
          0.483651069; 35520.092,0.467287815; 35580.097,0.459943055; 35640.096,
          0.468630092; 35700.015,0.472241051; 35760.034,0.468898161; 35820.068,
          0.451679912; 35880.02,0.487939861; 35940.003,0.452294404; 36000.057,
          0.490737521; 36060.051,0.471011424; 36120.037,0.476826815; 36180.089,
          0.487530073; 36240.041,0.46548255; 36300.013,0.471488945; 36360.08,
          0.483766535; 36420.064,0.484379285; 36480.013,0.461600491; 36540.1,
          0.446860399; 36600.091,0.474997875; 36660.013,0.468430616; 36720.081,
          0.455747342; 36780.083,0.492615053; 36840.049,0.46666096; 36900.094,
          0.496216705], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
      annotation (Placement(transformation(extent={{158,-28},{178,-8}})));
  protected
    Modelica.Blocks.Math.Gain gain1(k=1/3600)
      annotation (Placement(transformation(extent={{188,-28},{208,-8}})));
  protected
    Modelica.Blocks.Sources.RealExpression Tout_vc(y=sensor_vc_pipe.T)
      annotation (Placement(transformation(extent={{-104,-80},{-84,-60}})));
    Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-106,-58},{-94,-46}})));
  protected
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable3(table=[0,1; 50000,1;
          150000,0.7; 250000,0.7; 350000,1; 400000,1], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
      annotation (Placement(transformation(extent={{-254,18},{-234,38}})));
  equation
    connect(sensor_hx_cw.port_b, boundary.ports[1])
      annotation (Line(points={{-4,12},{36,12}}, color={0,127,255}));
    connect(hx.port_a2, sensor_hx_cw.port_a) annotation (Line(points={{-34,-6},{-28,
            -6},{-28,12},{-24,12}}, color={0,127,255}));
    connect(sensor_cw_hx.port_b, hx.port_b2) annotation (Line(points={{-68,14},{-60,
            14},{-60,-6},{-54,-6}}, color={0,127,255}));
    connect(boundary1.ports[1], sensor_cw_hx.port_a)
      annotation (Line(points={{-150,14},{-88,14}}, color={0,127,255}));
    connect(sensor_rp_hx_2.port_b, hx.port_b1) annotation (Line(points={{-20,-26},
            {-28,-26},{-28,-14},{-34,-14}}, color={0,127,255}));
    connect(hx.port_a1, sensor_hx_co.port_a) annotation (Line(points={{-54,-14},{
            -60,-14},{-60,-26},{-66,-26}}, color={0,127,255}));
    connect(sensor_hx_co.port_b, valve_ps.port_b)
      annotation (Line(points={{-86,-26},{-142,-26},{-142,-74},{-172,-74}},
                                                      color={0,127,255}));
    connect(opening_valve_tank.y, valve_ps.opening) annotation (Line(points={{-211,
            -54},{-182,-54},{-182,-66}}, color={0,0,127}));
    connect(sensor_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{6,52},{-26,
            52},{-26,64},{-34,64}}, color={0,127,255}));
    connect(sensor_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{-90,90},
            {-60,90},{-60,72},{-54,72}},     color={0,127,255}));
    connect(rp.port_b1, sensor_rp_hx_1.port_a) annotation (Line(points={{-34,72},
            {-4,72},{-4,88},{4,88}}, color={0,127,255}));
    connect(rp.port_b2, sensor_rp_pipe_vc.port_a) annotation (Line(points={{-54,64},
            {-84,64},{-84,50},{-90,50}},     color={0,127,255}));
    connect(sensor_pipe_vc.port_b, vc.port_a)
      annotation (Line(points={{-184,50},{-236,50},{-236,54}},
                                                     color={0,127,255}));
    connect(vc.port_b, resistance.port_a)
      annotation (Line(points={{-236,66},{-236,71}}, color={0,127,255}));
    connect(sensor_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{-190,90},
            {-237,90},{-237,85},{-236,85}},          color={0,127,255}));
    connect(ps.ports[1], valve_ps.port_a) annotation (Line(points={{-242,-74},{
            -192,-74}},                  color={0,127,255}));
    connect(pipe_hx_co.port_b, volume_co.port_a)
      annotation (Line(points={{-98,-90},{-70,-90}}, color={0,127,255}));
    connect(pipe_hx_co.port_a, valve_ps.port_b) annotation (Line(points={{-118,
            -90},{-142,-90},{-142,-74},{-172,-74}}, color={0,127,255}));
    connect(sensor_co_rp_2.port_b, pipe_co_rp.port_a)
      annotation (Line(points={{20,-90},{48,-90}}, color={0,127,255}));
    connect(pipe_co_rp.port_b, sensor_co_rp_1.port_a) annotation (Line(points={{
            68,-90},{82,-90},{82,52},{26,52}}, color={0,127,255}));
    connect(volume_co.port_b, co.port_a)
      annotation (Line(points={{-58,-90},{-40,-90}}, color={0,127,255}));
    connect(co.port_b, sensor_co_rp_2.port_a)
      annotation (Line(points={{-20,-90},{0,-90}}, color={0,127,255}));
    connect(pipe_ins_vc_rp.port_a, sensor_vc_pipe.port_b)
      annotation (Line(points={{-152,90},{-170,90}}, color={0,127,255}));
    connect(sensor_pipe_vc.port_a, pipe_ins_rp_vc.port_b)
      annotation (Line(points={{-164,50},{-148,50}}, color={0,127,255}));
    connect(sensor_rp_pipe_vc.port_b, pipe_ins_rp_vc.port_a)
      annotation (Line(points={{-110,50},{-128,50}}, color={0,127,255}));
    connect(sensor_vc_pipe_rp.port_a, pipe_ins_vc_rp.port_b)
      annotation (Line(points={{-110,90},{-132,90}}, color={0,127,255}));
    connect(sensor_rp_hx_2.port_a, pipe_ins_rp_hx.port_b)
      annotation (Line(points={{0,-26},{26,-26}}, color={0,127,255}));
    connect(pipe_ins_rp_hx.port_a, sensor_rp_hx_1.port_b) annotation (Line(points=
           {{46,-26},{68,-26},{68,88},{24,88}}, color={0,127,255}));
    connect(Tin_vc_design.y, cw_mf_control.u_s)
      annotation (Line(points={{-209.4,22},{-203.6,22}}, color={0,0,127}));
    connect(Tin_vc.y,cw_mf_control. u_m)
      annotation (Line(points={{-199,-2},{-194,-2},{-194,12.4}},
                                                             color={0,0,127}));
    connect(combiTimeTable2.y[1], gain1.u)
      annotation (Line(points={{179,-18},{186,-18}}, color={0,0,127}));
    connect(Tout_vc_design.y,N2_mf_control. u_s)
      annotation (Line(points={{-93.4,-52},{-71.6,-52}},color={0,0,127}));
    connect(Tout_vc.y,N2_mf_control. u_m) annotation (Line(points={{-83,-70},{
            -62,-70},{-62,-61.6}},     color={0,0,127}));
    connect(N2_mf_control.y, co.inputSignal) annotation (Line(points={{-53.2,
            -52},{-30,-52},{-30,-83}}, color={0,0,127}));
    connect(cw_mf_control.y, boundary1.m_flow_in)
      annotation (Line(points={{-185.2,22},{-170,22}}, color={0,0,127}));
    annotation (experiment(
        StopTime=400000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"),
      Diagram(coordinateSystem(extent={{-300,-120},{100,120}})),
      Icon(coordinateSystem(extent={{-300,-120},{100,120}})));
  end MAGNET_Insulated_pipes_dyn;
annotation ();
end Magnet_TEDS;
