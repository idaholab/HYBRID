within NHES.ExperimentalSystems.MAGNET.Examples;
model DynamicModel_LowPower_HX "same as dynamic model low power but replaces heat exchangers (note rp is identical to hx as no info on rp is known"
  extends TRANSFORM.Icons.Example;

  Data.Summary summary(
    Ts={sensor_pT1.T,sensor_pT2.T,sensor_pT3.T,sensor_pT4.T,sensor_pT5.T,
        sensor_pT6.T,sensor_pT7.T,sensor_pT8.T},
    ps={sensor_pT1.p,sensor_pT2.p,sensor_pT3.p,sensor_pT4.p,sensor_pT5.p,
        sensor_pT6.p,sensor_pT7.p,sensor_pT8.p},
    m_flows={sensor_m_flow.m_flow,sensor_pT9.port_a.m_flow},
    Q_flows={vc.Q_gen,sum(rp.shell.heatPorts.Q_flow),sum(hx.shell.heatPorts.Q_flow),
        co.W})
    annotation (Placement(transformation(extent={{120,100},{140,120}})));

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 60.037,4.6; 120.102,15.5; 180.084,12.5; 240.044,11.2; 300.005,12.3;
        360.053,12.3; 420.031,12.3; 480.073,12.7; 540.034,12.5; 600.1,12.9; 660.04,
        13.1; 720.053,13.1; 780.104,14.9; 840.009,14.9; 900.102,13.1; 960.017,13.4;
        1020.048,11.8; 1080.101,15.5; 1140.049,13.6; 1200.034,13.6; 1260.061,13.8;
        1320.034,13.8; 1380.071,14; 1440.045,14; 1500.036,14; 1560.072,13.8; 1620.051,
        14; 1680.043,14.4; 1740.005,14.8; 1800.046,13.1; 1860.05,13.1; 1920.049,
        12.9; 1980.001,14.8; 2040.038,14.8; 2100.029,10.6; 2160.022,2.1; 2220.024,
        2.1; 2280.022,2.8; 2340.009,2.4; 2400.054,2.7; 2460.095,2.6; 2520.051,2.6;
        2580.027,2.3; 2640.006,2.4; 2700.069,2.2; 2760.052,2.3; 2820.005,13.8; 2880.091,
        16.2; 2940.004,16.6; 3000.104,15.5; 3060.098,15.7; 3120.006,15.9; 3180.088,
        16.4; 3240.023,17.9; 3300.085,16.4; 3360,16.4; 3420.08,16.6; 3480.011,16.4;
        3540.045,7.2; 3600.004,2.9; 3660.056,2.4; 3720.046,3.7; 3780.006,3.3; 3840.06,
        3.1; 3900.017,3.4; 3960.022,1.3; 4020.025,3.2; 4080.071,3; 4140.062,3.1;
        4200.044,3.1; 4260.064,3.1; 4320.004,5.1; 4380.049,5.1; 4440.066,3.9; 4500.078,
        5.6; 4560.066,5.4; 4620.067,5.9; 4680.066,5.8; 4740.042,5.8; 4800.06,5.9;
        4860.063,6; 4920.016,5.8; 4980.064,5.6; 5040.008,5.9; 5100.052,6; 5160.084,
        4.1; 5220.067,6.1; 5280.06,6.1; 5340.057,5.9; 5400.037,6.4; 5460.098,6.2;
        5520.065,6.2; 5580.075,6.3; 5640.084,6.3; 5700.07,4.4; 5760.079,6.2; 5820.01,
        6.5; 5880.016,6.3; 5940.03,6.3; 6000.077,6.3; 6060.054,4.6; 6120.051,6.6;
        6180.064,6.5; 6240.028,6.5; 6300.007,6.5; 6360.029,6.4; 6420.027,6.6; 6480.06,
        6.7; 6540.037,6.8; 6600.102,5.1; 6660.008,6.6; 6720.087,4.9; 6780.045,5;
        6840.093,6.9; 6900.03,6.8; 6960.032,6.8; 7020.073,5.1; 7080.016,6.9; 7140.014,
        6.9; 7200.001,7; 7260.097,7; 7320.05,7; 7380.005,6.9; 7440.073,7.1; 7500.025,
        7.1; 7560.028,7.1; 7620.033,7.1; 7680.087,7.1; 7740.006,6.9; 7800.018,7.4;
        7860.076,5.5; 7920.068,7.3; 7980.034,7.1; 8040.079,5.6; 8100.045,7.3; 8160.033,
        7.1; 8220.024,7.3; 8280.023,5.4; 8340.102,5.6; 8400.029,7.4; 8460.068,7.6;
        8520.075,7.6; 8580.089,7.7; 8640.018,7.7; 8700.062,7.5; 8760.035,7.9; 8820.051,
        6.5; 8880.026,6.6; 8940.084,5.7; 9000.083,5.1; 9060.067,4.9; 9120.004,4.8;
        9180.009,4.9; 9240.017,4.7; 9300.034,4.8; 9360.029,4.8; 9420.037,4.9; 9480.03,
        4.8; 9540.085,4.8; 9600.001,4.8; 9660.002,0; 9720.008,0; 9780.021,0; 9840.026,
        0; 9900.107,0; 9960.082,0; 10020.102,0; 10080.057,0; 10140.046,0; 10200.023,
        0; 10260.022,0; 10320.031,0; 10380.067,0; 10440.067,0; 10500.014,0; 10560.005,
        0; 10620.033,0; 10680.079,0; 10740.041,0; 10800.087,0; 10860,0; 10920.101,
        0; 10980.009,0; 11040.052,0; 11100.055,0; 11160.013,0; 11220.056,0; 11280.088,
        0; 11340.092,0; 11400.08,0; 11460.084,0; 11520.065,0; 11580.049,0; 11640.019,
        0; 11700.041,0; 11760.021,0; 11820.093,0; 11880.074,0; 11940.02,0; 12000.03,
        0; 12060.016,0; 12120.007,0; 12180.093,0; 12240.046,0; 12300.093,0; 12360.065,
        0; 12420.094,0; 12480.049,0; 12540.058,0; 12600.025,0.7; 12660.036,3.6;
        12720.045,3.5; 12780.012,4; 12840.059,2.1; 12900.102,1.9; 12960.007,3.4;
        13020.063,3.4; 13080.096,3.4; 13140.097,3.3; 13200.069,3.4; 13260.095,3.2;
        13320.07,3.3; 13380.047,3.3; 13440.045,3.2; 13500.019,5.2; 13560.1,3.3;
        13620.087,3.1; 13680.02,3.4; 13740.054,5.1; 13800.07,3.2; 13860.082,3.2;
        13920.035,3.2; 13980.006,3.4; 14040.067,3.2; 14100.06,3.2; 14160.1,3.2;
        14220.062,3.2; 14280.075,3.2; 14340.095,3.2; 14400.045,3.2; 14460.078,3.2;
        14520.031,3.2; 14580.023,3.2; 14640.075,3.3; 14700.04,3.3; 14760.064,3;
        14820.07,3; 14880.007,2.9; 14940.071,3.1; 15000.09,3.1; 15060.084,29.2;
        15120.028,2.1; 15180.081,0; 15240.094,0; 15300.085,0; 15360.016,0; 15420.034,
        0; 15480.101,0; 15540.005,0; 15600.092,0; 15660.037,0; 15720.058,0; 15780.026,
        0; 15840.049,0; 15900.057,0; 15960.04,0; 16020.1,0; 16080.085,0; 16140.048,
        0; 16200,0; 16260.014,0; 16320.025,0; 16380.073,0; 16440.033,0; 16500.008,
        0; 16560.089,0; 16620.078,1.3; 16680.043,3; 16740.083,2.4; 16800.008,3.6;
        16860.093,2.1; 16920.024,3.8; 16980.057,3.7; 17040.081,0; 17100.028,0; 17160.039,
        0; 17220.018,0; 17280.081,0; 17340.028,0; 17400.09,0; 17460.039,0; 17520.06,
        0; 17580.086,0; 17640.061,33.8; 17700.01,7.4; 17760.103,0; 17820.062,13.9;
        17880.037,16.7; 17940.06,17.9; 18000.035,18.7; 18060.076,18.7; 18120.057,
        19.2; 18180.013,7.4; 18240.098,3.1; 18300.063,3.5; 18360.074,0.9; 18420.076,
        6.4; 18480.001,6.6; 18540.093,5.3; 18600.009,7.1; 18660.02,7.1; 18720.11,
        7.1; 18780.009,5.4; 18840.035,7.2; 18900.045,7.2; 18960.088,7.2; 19020.04,
        7.4; 19080.096,7.4; 19140.036,7.4; 19200.098,7.5; 19260.102,7.5; 19320.039,
        5.6; 19380.001,7.6; 19440.041,7.4; 19500.014,5.9; 19560.093,7.8; 19620.098,
        7.9; 19680.043,7.9; 19740.024,7.9; 19800.035,7.9; 19860.04,8; 19920.075,
        6.4; 19980.01,8.2; 20040.035,8.2; 20100.081,6.3; 20160.06,8; 20220.062,8.3;
        20280.08,8.3; 20340.004,6.6; 20400.033,6.8; 20460.004,0; 20520.061,0],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    startTime=startTime.k)
    annotation (Placement(transformation(extent={{-180,70},{-160,90}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    table=[0,182.455699; 60.037,190.247786; 120.102,187.619049; 180.084,187.825319;
        240.044,187.39156; 300.005,188.465638; 360.053,187.693754; 420.031,184.677147;
        480.073,188.004943; 540.034,192.38221; 600.1,187.487949; 660.04,192.953911;
        720.053,190.158352; 780.104,189.409212; 840.009,188.522193; 900.102,193.002981;
        960.017,189.070942; 1020.048,181.88782; 1080.101,190.324869; 1140.049,186.956355;
        1200.034,183.385201; 1260.061,192.661804; 1320.034,191.419506; 1380.071,
        185.545999; 1440.045,183.357896; 1500.036,184.655624; 1560.072,193.607786;
        1620.051,190.175811; 1680.043,190.011206; 1740.005,187.347068; 1800.046,
        187.428664; 1860.05,189.590136; 1920.049,188.497377; 1980.001,189.555924;
        2040.038,190.850504; 2100.029,193.158688; 2160.022,188.472738; 2220.024,
        187.715342; 2280.022,191.882997; 2340.009,190.56601; 2400.054,186.785084;
        2460.095,186.192984; 2520.051,190.720352; 2580.027,193.389084; 2640.006,
        190.65493; 2700.069,192.587484; 2760.052,193.875672; 2820.005,191.468207;
        2880.091,189.776698; 2940.004,193.511815; 3000.104,191.106214; 3060.098,
        188.553547; 3120.006,192.357538; 3180.088,196.764873; 3240.023,190.671105;
        3300.085,194.242837; 3360,191.077832; 3420.08,193.371319; 3480.011,162.604959;
        3540.045,161.341716; 3600.004,161.288599; 3660.056,157.92688; 3720.046,162.332593;
        3780.006,160.065833; 3840.06,160.552469; 3900.017,159.109908; 3960.022,160.794397;
        4020.025,161.016361; 4080.071,160.949912; 4140.062,163.425704; 4200.044,
        163.351272; 4260.064,163.823934; 4320.004,164.608813; 4380.049,164.997421;
        4440.066,164.292629; 4500.078,162.827372; 4560.066,166.120409; 4620.067,
        163.150029; 4680.066,157.907975; 4740.042,162.395444; 4800.06,162.480718;
        4860.063,163.86009; 4920.016,163.699613; 4980.064,162.393548; 5040.008,158.209109;
        5100.052,161.050397; 5160.084,159.549016; 5220.067,163.663216; 5280.06,165.09781;
        5340.057,160.534865; 5400.037,162.233312; 5460.098,156.595004; 5520.065,
        157.252509; 5580.075,159.415379; 5640.084,155.767416; 5700.07,155.338523;
        5760.079,154.940004; 5820.01,152.684055; 5880.016,154.859501; 5940.03,156.267142;
        6000.077,154.685917; 6060.054,153.208742; 6120.051,151.134729; 6180.064,
        148.661377; 6240.028,149.709049; 6300.007,147.797649; 6360.029,148.183752;
        6420.027,144.453856; 6480.06,145.624195; 6540.037,145.137109; 6600.102,144.931144;
        6660.008,143.294215; 6720.087,141.248792; 6780.045,141.147938; 6840.093,
        144.305409; 6900.03,142.860102; 6960.032,139.777319; 7020.073,141.641207;
        7080.016,145.323511; 7140.014,141.662249; 7200.001,144.573086; 7260.097,
        148.124531; 7320.05,148.001157; 7380.005,142.374831; 7440.073,143.501449;
        7500.025,145.833614; 7560.028,148.885557; 7620.033,144.176655; 7680.087,
        143.775711; 7740.006,143.321167; 7800.018,142.015215; 7860.076,142.409991;
        7920.068,144.32666; 7980.034,141.819417; 8040.079,141.303018; 8100.045,144.342513;
        8160.033,142.562855; 8220.024,142.412658; 8280.023,143.545716; 8340.102,
        146.145847; 8400.029,144.188107; 8460.068,141.618383; 8520.075,144.473918;
        8580.089,142.326677; 8640.018,142.51544; 8700.062,143.623088; 8760.035,138.316689;
        8820.051,141.839398; 8880.026,143.196781; 8940.084,144.367377; 9000.083,
        138.154011; 9060.067,139.905865; 9120.004,144.115233; 9180.009,141.655486;
        9240.017,142.398941; 9300.034,145.10476; 9360.029,143.924543; 9420.037,145.778745;
        9480.03,141.92909; 9540.085,142.363941; 9600.001,138.554923; 9660.002,143.080572;
        9720.008,143.784095; 9780.021,146.536431; 9840.026,140.11122; 9900.107,142.411806;
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
        36900.094,0.496216705],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    startTime=startTime.k)
    annotation (Placement(transformation(extent={{168,-88},{148,-68}})));
  Modelica.Blocks.Math.Gain gain(k=1/3600)
    annotation (Placement(transformation(extent={{134,-88},{114,-68}})));
  Modelica.Blocks.Sources.RealExpression Q_flow(y=if time < 0.9*startTime.k
         then 0 else combiTimeTable.y[1])
    annotation (Placement(transformation(extent={{-140,58},{-120,78}})));
  Modelica.Blocks.Sources.RealExpression m_flow(y=if time < 1.01*startTime.k
         then easing.y else gain.y)
    annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
  Modelica.Blocks.Sources.Constant startTime(k=7500)
    annotation (Placement(transformation(extent={{-210,40},{-190,60}})));
  Modelica.Blocks.Sources.RealExpression m_flow1(y=if time < 0.95*startTime.k
         then data.m_flow_cw else 0.001*data.m_flow_cw)
    annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
  TRANSFORM.Blocks.Sources.Easing easing(
    pos=182.455699/3600,
    neg=data.m_flow,
    dt=startTime.k*0.5)
    annotation (Placement(transformation(extent={{94,-70},{74,-50}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX hx(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX
        (
        nV=10,
        nTubes=data_hx.nTubes,
        nR=3,
        dimension_shell=data_hx.d_shell,
        length_shell=data_hx.length_shell,
        dimension_tube=data_hx.d_tube,
        length_tube=data_hx.length_tube,
        th_wall=data_hx.th_tube),
    redeclare package Medium_shell = Medium,
    redeclare package Medium_tube = Medium,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (CF=40),
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (CF=40),
    p_a_start_shell=data.p_cw_hx,
    p_b_start_shell=data.p_hx_cw,
    T_a_start_shell=data.T_cw_hx,
    T_b_start_shell=data.T_hx_cw,
    m_flow_a_start_shell=data.m_flow_cw,
    p_a_start_tube=data.p_rp_hx,
    p_b_start_tube=data.p_hx_co,
    T_a_start_tube=data.T_rp_hx,
    T_b_start_tube=data.T_hx_co,
    m_flow_a_start_tube=data.m_flow)
    annotation (Placement(transformation(extent={{-40,-50},{-60,-30}})));
  Data.data_hx data_hx
    annotation (Placement(transformation(extent={{120,60},{140,80}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX rp(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX
        (
        nV=10,
        nTubes=data_hx.nTubes,
        nR=3,
        dimension_shell=data_hx.d_shell,
        length_shell=data_hx.length_shell,
        dimension_tube=data_hx.d_tube,
        length_tube=data_hx.length_tube,
        th_wall=data_hx.th_tube),
    redeclare package Medium_shell = Medium,
    redeclare package Medium_tube = Medium,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (CF=8.8),
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (CF=8.8),
    p_a_start_shell=data.p_co_rp,
    p_b_start_shell=data.p_rp_vc,
    T_a_start_shell=data.T_co_rp,
    T_b_start_shell=data.T_rp_vc,
    m_flow_a_start_shell=data.m_flow,
    p_a_start_tube=data.p_vc_rp,
    p_b_start_tube=data.p_rp_hx,
    T_a_start_tube=data.T_vc_rp,
    T_b_start_tube=data.T_rp_hx,
    m_flow_a_start_tube=data.m_flow)
    annotation (Placement(transformation(extent={{20,70},{40,50}})));
protected
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;

  Data.Data_base data
    annotation (Placement(transformation(extent={{120,80},{140,100}})));
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Medium,
    p=data.p_hx_cw,
    T=data.T_hx_cw,                                       nPorts=1) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,-20})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,                                         m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-20})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
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
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{10,30},{-10,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT5(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
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
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=1,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
    redeclare package Medium = Medium,
    p_start=data.p_hx_cw,
    T_start=data.T_hx_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
    redeclare package Medium = Medium,
    p_start=data.p_cw_hx,
    T_start=data.T_cw_hx,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
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
    Q_gen=Q_flow.y)
                  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-92,52})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
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
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=0) "12022.6"
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
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
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Medium, precision=2)
    annotation (Placement(transformation(extent={{50,-100},{70,-80}})));

equation
  connect(boundary1.ports[1], sensor_pT9.port_a)
    annotation (Line(points={{-100,-20},{-90,-20}}, color={0,127,255}));
  connect(sensor_pT10.port_b, boundary.ports[1])
    annotation (Line(points={{-10,-20},{10,-20}}, color={0,127,255}));
  connect(sensor_pT6.port_b, pipe_rp_hx.port_a) annotation (Line(points={{70,80},
          {80,80},{80,-40},{60,-40}}, color={0,127,255}));
  connect(pipe_rp_hx.port_b, sensor_pT7.port_a) annotation (Line(points={{40,-40},
          {0,-40},{0,-60},{-10,-60}}, color={0,127,255}));
  connect(sensor_pT4.port_b, pipe_vc_rp.port_a)
    annotation (Line(points={{-60,80},{-50,80}}, color={0,127,255}));
  connect(pipe_rp_vc.port_b, sensor_pT3.port_a)
    annotation (Line(points={{-50,40},{-60,40}}, color={0,127,255}));
  connect(sensor_pT3.port_b, vc.port_a)
    annotation (Line(points={{-80,40},{-92,40},{-92,46}}, color={0,127,255}));
  connect(pipe_vc_rp.port_b, sensor_pT5.port_a)
    annotation (Line(points={{-30,80},{-10,80}}, color={0,127,255}));
  connect(pipe_rp_vc.port_a, sensor_pT2.port_b)
    annotation (Line(points={{-30,40},{-10,40}}, color={0,127,255}));
  connect(vc.port_b, resistance.port_a)
    annotation (Line(points={{-92,58},{-92,63}}, color={0,127,255}));
  connect(resistance.port_b, sensor_pT4.port_a)
    annotation (Line(points={{-92,77},{-92,80},{-80,80}}, color={0,127,255}));
  connect(pipe_hx_co.port_a, sensor_pT8.port_b) annotation (Line(points={{-60,-90},
          {-100,-90},{-100,-60},{-90,-60}}, color={0,127,255}));
  connect(pipe_co_rp.port_b, sensor_pT1.port_a)
    annotation (Line(points={{100,-20},{100,40},{70,40}}, color={0,127,255}));
  connect(pipe_hx_co.port_b, volume_co.port_a)
    annotation (Line(points={{-40,-90},{-16,-90}}, color={0,127,255}));
  connect(volume_co.port_b, co.port_a)
    annotation (Line(points={{-4,-90},{10,-90}}, color={0,127,255}));
  connect(ps.ports[1], valve_ps.port_a)
    annotation (Line(points={{-170,-40},{-160,-40}}, color={0,127,255}));
  connect(opening_valve_tank.y, valve_ps.opening) annotation (Line(
      points={{-199,-20},{-150,-20},{-150,-32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(valve_ps.port_b, sensor_pT8.port_b) annotation (Line(points={{-140,-40},
          {-100,-40},{-100,-60},{-90,-60}}, color={0,127,255}));
  connect(co.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{30,-90},{50,-90}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, pipe_co_rp.port_a) annotation (Line(points={{70,
          -90},{100,-90},{100,-40}}, color={0,127,255}));
  connect(gain.u, combiTimeTable1.y[1])
    annotation (Line(points={{136,-78},{147,-78}},
                                                 color={0,0,127}));
  connect(m_flow.y, co.inputSignal)
    annotation (Line(points={{37,-66},{20,-66},{20,-83}}, color={0,0,127}));
  connect(m_flow1.y, boundary1.m_flow_in) annotation (Line(points={{-133,0},{-126,
          0},{-126,-12},{-120,-12}}, color={0,0,127}));
  connect(sensor_pT9.port_b, hx.port_a_shell) annotation (Line(points={{-70,-20},
          {-60,-20},{-60,-35.4}}, color={0,127,255}));
  connect(hx.port_b_tube, sensor_pT8.port_a) annotation (Line(points={{-60,-40},
          {-62,-40},{-62,-60},{-70,-60}}, color={0,127,255}));
  connect(hx.port_a_tube, sensor_pT7.port_b) annotation (Line(points={{-40,-40},
          {-38,-40},{-38,-60},{-30,-60}}, color={0,127,255}));
  connect(hx.port_b_shell, sensor_pT10.port_a) annotation (Line(points={{-40,-35.4},
          {-40,-20},{-30,-20}}, color={0,127,255}));
  connect(sensor_pT2.port_a, rp.port_b_shell) annotation (Line(points={{10,40},{
          14,40},{14,56},{20,56},{20,55.4}}, color={0,127,255}));
  connect(sensor_pT1.port_b, rp.port_a_shell) annotation (Line(points={{50,40},{
          46,40},{46,56},{40,56},{40,55.4}}, color={0,127,255}));
  connect(sensor_pT6.port_a, rp.port_b_tube) annotation (Line(points={{50,80},{46,
          80},{46,60},{40,60}}, color={0,127,255}));
  connect(sensor_pT5.port_b, rp.port_a_tube) annotation (Line(points={{10,80},{14,
          80},{14,60},{20,60}}, color={0,127,255}));
  annotation (                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-120},{140,
            120}})),
    experiment(
      StopTime=40000,
      __Dymola_NumberOfIntervals=4000,
      __Dymola_Algorithm="Esdirk45a"));
end DynamicModel_LowPower_HX;
