within NHES.Media.Common;
record LiBrWData
  extends Modelica.Icons.Record;
  constant MolarMass[2] MW={0.086845,0.01801528};
  constant Real A[5](unit="J/g") = {5.506219979E+3,5.213228937E+2,7.774930356,
    -4.575233382E-2,-5.792935726E+2};
  constant Real B[5](unit="J/(g.K)") = {1.452749674E+2,-4.984840771E-1,8.83691918E-2,
    -4.870995781E-4,-2.905161205};
  constant Real C[5](unit="J/(g.K2)") = {2.648364473E-2,-2.311041091E-3,7.55973662E-6,
    -3.763934193E-8,1.176240649E-3};
  constant Real D[5](unit="J/(g.K3)") = {-8.526516950E-6,1.320154794E-6,2.791995438E-11,
    0,-8.511514931E-7};
  constant Real E[2](unit="J/(g.K4)") = {-3.840447174E-11,2.625469387E-11};
  constant Real F[2](unit="J.K/g") = {-5.159906276E+1,1.114573398};
  constant Real L[5](unit="J/g") = {-2.183429482E+3,-1.266985094E+2,-2.364551372,
    1.389414858E-2,1.583405426E+2};
  constant Real M[5](unit="J/(g.K)") = {-2.267095847E+1,2.983764494E-1,-1.259393234E-2,
    6.849632068E-5,2.767986853E-1};
  constant Real V[8](unit={"J/(g.kPa)","J/(g.kPa)","J/(g.kPa)","J/(g.kPa.K)","J/(g.kPa.K)",
        "J/(g.kPa.K)","J/(g.kPa.K2)","J/(g.kPa.K2)"}) = {1.176741611E-3,-1.002511661E-5,
    -1.695735875E-8,-1.497186905E-6,2.538176345E-8,5.815811591E-11,3.057997846E-9,
    -5.129589007E-11};
  constant Temperature T_0=220;
  constant Temperature T_norm=1;
  constant Real C_g2kg(unit="kg/g") = 1/1000;
  constant Real C_kpa2pa(unit="Pa/kPa") = 1000;

  constant Real muA1[:](unit="1") = {-494.122,16.3967,-0.14511};
  constant Modelica.Units.SI.Temperature muA2[:]={28606.4,-934.568,8.52755};
  constant Real muA3[:](unit="1") = {70.3848,-2.35014,0.0207809};
  constant Modelica.Units.SI.DynamicViscosity muC=1/1000;

  constant ThermalConductivity K1[:]={-0.3081,0.62979};
  constant ThermalConductivity K2[:]={-0.3191795,0.65388};
  constant ThermalConductivity K3[:]={-0.291897,0.59821};
  constant Temperature kT_0=313;
  constant Temperature kT_F=1/20;

  Temperature T_num "T_num/T_den";
  Temperature T_den "F_0 +F_1*x/T_den";
  Real x_per(unit="1", min=0);
  Real p_kpa(unit="kPa");
  Real x_po[5](unit="1");
  Real xT_po[8](unit={"1","1","1","K","K","K","K2","K2"});
  Real x_po_dgdX[4](unit="1");
  Real xT_po_dgdT[5](unit={"1","1","1","K","K"});
  Real xT_po_dgdX[5](unit={"1","1","K","K","K2"});
  Real xT_po_dudT[5](unit={"1","1","1","K","K"});
  Real V_dgdX[5](unit={"J/(g.kPa)","J/(g.kPa)","J/(g.kPa.K)","J/(g.kPa.K)","J/(g.kPa.K2)"});
  Real C_F(unit="1");

  Real mux_po[3](unit={"1","1","1"});
  Real muB(unit="1");

  Real kx_po[2](unit={"1","1"});
  Real kD12(unit="1");
  Real kD13(unit="1");

end LiBrWData;
