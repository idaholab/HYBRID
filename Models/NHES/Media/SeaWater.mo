within NHES.Media;
partial package SeaWater "Salt Water media using IAPWS industrial fromulation"

  extends Modelica.Media.Interfaces.PartialMedium(
    final mediumName="SeaWater",
    final substanceNames={"Water","Salt"},
    final singleState=false,
    final reducedX=false,
    final fixedX=false,
    Temperature(
      min=273,
      max=380,
      start=323));

  // Provide medium constants here
  constant SpecificHeatCapacity cp_const=123456
    "Constant specific heat capacity at constant pressure";

  redeclare model extends BaseProperties(final standardOrderComponents=true)
    "Base properties of medium"

  equation
    d = density_pTX(p,T,X);
    h = specificEnthalpy_pTX(p,T,X);
    u = h - p/d;
    MM = 0.024;
    R_s = Modelica.Constants.R/MM;
    state.p = p;
    state.T = T;
    state.d = d;
    state.h = h;
    state.X = X;
  end BaseProperties;

  redeclare replaceable record ThermodynamicState
    "A selection of variables that uniquely defines the thermodynamic state"
    extends Modelica.Icons.Record;
    AbsolutePressure p "Absolute pressure of medium";
    Temperature T "Temperature of medium";
    Density d;
    SpecificEnthalpy h;
    MassFraction [2] X;
    annotation (Documentation(info="<html>

</html>"));
  end ThermodynamicState;

  redeclare function extends dynamicViscosity "Return dynamic viscosity"
  algorithm
    eta := (4.2844e-5)+(0.157
                            *((state.T-273.15+64.993)^2)-91.296)^(-1);
    annotation (Documentation(info="<html>

</html>"));
  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Return thermal conductivity"
  algorithm
    lambda := 0;
    annotation (Documentation(info="<html>

</html>"));
  end thermalConductivity;

  redeclare function extends specificEntropy "Return specific entropy"
  algorithm
    s := NHES.Media.SeaWater.IAPWS_Utilities.s_pTX(
        state.p,
        state.T,
        state.X);
    annotation (Documentation(info="<html>

</html>"));
  end specificEntropy;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  algorithm
    cp := IAPWS_Utilities.cp_pT(
          state.p,
          state.T,
          state.X);
    annotation (Documentation(info="<html>

</html>"));
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Return specific heat capacity at constant volume"
  algorithm
    cv := 0;
    annotation (Documentation(info="<html>

</html>"));
  end specificHeatCapacityCv;

  redeclare function extends isentropicExponent "Return isentropic exponent"
    extends Modelica.Icons.Function;
  algorithm
    gamma := 1;
    annotation (Documentation(info="<html>

</html>"));
  end isentropicExponent;

  redeclare function extends velocityOfSound "Return velocity of sound"
    extends Modelica.Icons.Function;
  algorithm
    a := 0;
    annotation (Documentation(info="<html>

</html>"));
  end velocityOfSound;

  replaceable function density_pTX
    "Return density from p, T, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fractions";
    output Density d "Density";
  algorithm
    d := IAPWS_Utilities.rho_pTX(
            p,
            T,
            X);
  end density_pTX;

  replaceable function specificEnthalpy_pTX
    "Return specific enthalpy from p, T, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := IAPWS_Utilities.h_pTX(
            p,
            T,
            X);
    annotation (inverse(T=temperature_phX(
                  p,
                  h,
                  X)));
  end specificEnthalpy_pTX;

  package IAPWS_Utilities
    record IAPWSBase "Intermediate property data record for  IAPWS"
      extends Modelica.Icons.Record;
      Modelica.Units.SI.Pressure p "Pressure";
      Modelica.Units.SI.Temperature T "Temperature";
      Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy";
      Modelica.Units.SI.SpecificHeatCapacity R_s "Gas constant";
      Modelica.Units.SI.SpecificHeatCapacity cp "Specific heat capacity";
      Modelica.Units.SI.SpecificHeatCapacity cv "Specific heat capacity";
      Modelica.Units.SI.Density rho "Density";
      Modelica.Units.SI.SpecificEntropy s "Specific entropy";
      Modelica.Media.Common.DerPressureByTemperature pt
        "Derivative of pressure w.r.t. temperature";
      Modelica.Media.Common.DerPressureByDensity pd
        "Derivative of pressure w.r.t. density";
      Real vt "Derivative of specific volume w.r.t. temperature";
      Real vp "Derivative of specific volume w.r.t. pressure";
      Real vx;
      Real gSs;
      Real gSps;
      Real x "Dryness fraction";
      Real dpT "dp/dT derivative of saturation curve";
      Modelica.Units.SI.SpecificEnergy mu;
      Modelica.Units.SI.OsmoticCoefficientOfSolvent theta;
      Real beta;
      Modelica.Units.SI.Molality b;
    end IAPWSBase;

    function h_props_pT
      "Specific enthalpy as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      input SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      output Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := aux.h;
      annotation (
        derivative(noDerivative=aux)=h_pT_der,
        Inline=false,
        LateInline=true);
    end h_props_pT;

    function sesWaterBaseProp_pT
      "Intermediate property record for seawater (p and T preferred states)"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      output SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";

    protected
      SeaWater.IAPWS_Utilities.GibbsDerivsBrine g
        "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
      Integer error "Error flag for inverse iterations";
      Modelica.Units.SI.SpecificVolume vint;
    algorithm

      aux.b := X[2]/(0.314038218
                            *(1-X[2]));
      aux.R_s := Modelica.Media.Water.IF97_Utilities.BaseIF97.data.RH2O;
      aux.p := p;
      aux.T := T;
      aux.vt := 0.0 "Initialized in case it is not needed";
      aux.vp := 0.0 "Initialized in case it is not needed";
      g := NHES.Media.SeaWater.IAPWS_Utilities.g1(
            p,
            T,
            X);
      aux.h := aux.R_s*aux.T*g.tau*g.gtau
        +(g.gS-aux.T*g.gSt);
      aux.s := aux.R_s*(g.tau*g.gtau - g.g)
        -g.gSt;
      vint:=((aux.R_s*T*g.pi*g.gpi)/p)+ g.gSp/100;

      aux.rho :=1/vint;
      aux.vt := aux.R_s/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi)
        -g.gSpp;
      aux.vp := aux.R_s*T/(p*p)*g.pi*g.pi*g.gpipi
        +g.gStp;
      aux.vx:=g.gSps;
      aux.cp := -aux.R_s*g.tau*g.tau*g.gtautau
        -aux.T*g.gStt;
        if g.gSpp>0 then
      aux.cv := aux.R_s*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
      - g.tau*g.gtaupi)/g.gpipi))
        +(aux.T*(((g.gStp^2)/g.gSpp)-g.gStt));
        else
           aux.cv := aux.R_s*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
      - g.tau*g.gtaupi)/g.gpipi));
        end if;
      aux.x := 0.0;
      aux.dpT := -aux.vt/aux.vp;
      aux.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      aux.pd := -g.R_s*g.T*g.gpi*g.gpi/(g.gpipi);
      //aux.mu:=aux.h-aux.T*aux.s-X[2]*g.gSs;
      if X[2]>-1e-10 and X[2]<1e-10 then
        aux.theta:=0;
        else
      aux.theta:=(g.gS-X[2]*g.gs)/(aux.b*aux.R_s*T);
      end if;
      aux.beta:=(g.gps/g.gpi);
      aux.gSs:=g.gSs;
      aux.gSps:=g.gSps;

    end sesWaterBaseProp_pT;

    function g1 "Gibbs function for region 1: g(p,T,S)"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature (K)";
      input Modelica.Units.SI.MassFraction X[:] "Concentration (kg/kg)";
      output NHES.Media.SeaWater.IAPWS_Utilities.GibbsDerivsBrine g
        "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";

    protected
      Real pi1 "Dimensionless pressure";
      Real pi2;
      Real tau1 "Dimensionless temperature";
      Real xil "square root of reduced sailinity";
      Real theta1 "reduced temperature w.r.t 0c";
      Real[45] o "Vector of auxiliary variables";
      Real pl "Auxiliary variable";
      Real [8,7,6] n "equal to index +1 to start from zero";
      Real [6] qk;
      Real [8] qi;
      Real [7] qj;
      Real [6] qkp;
      Real [8] qip;
      Real [7] qjp;
      Integer i;
      Integer j;
      Integer k;

    algorithm

      pl := min(p,  Modelica.Media.Water.IF97_Utilities.BaseIF97.data.PCRIT - 1);

      g.p := p;
      g.T := T;
      g.R_s := IAPWS_Utilities.data.RH2O;
      g.pi := p/IAPWS_Utilities.data.PSTAR1;
      g.tau := IAPWS_Utilities.data.TSTAR1/T;
      g.pi0:= (0.101325e6)/100e6;
      g.theta := T/40;
      g.xi:= sqrt(X[2]/IAPWS_Utilities.data.SSTAR);
      pi1 := 7.1000000000000 - g.pi;
      pi2 :=p/100e6-g.pi0;
      tau1 := -1.22200000000000 + g.tau;
      theta1:=g.theta - 273.15/40;

      o[1] := tau1*tau1;
      o[2] := o[1]*o[1];
      o[3] := o[2]*o[2];
      o[4] := o[3]*tau1;
      o[5] := 1/o[4];
      o[6] := o[1]*o[2];
      o[7] := o[1]*tau1;
      o[8] := 1/o[7];
      o[9] := o[1]*o[2]*o[3];
      o[10] := 1/o[2];
      o[11] := o[2]*tau1;
      o[12] := 1/o[11];
      o[13] := o[2]*o[3];
      o[14] := 1/o[3];
      o[15] := pi1*pi1;
      o[16] := o[15]*pi1;
      o[17] := o[15]*o[15];
      o[18] := o[17]*o[17];
      o[19] := o[17]*o[18]*pi1;
      o[20] := o[15]*o[17];
      o[21] := o[3]*o[3];
      o[22] := o[21]*o[21];
      o[23] := o[22]*o[3]*tau1;
      o[24] := 1/o[23];
      o[25] := o[22]*o[3];
      o[26] := 1/o[25];
      o[27] := o[1]*o[2]*o[22]*tau1;
      o[28] := 1/o[27];
      o[29] := o[1]*o[2]*o[22];
      o[30] := 1/o[29];
      o[31] := o[1]*o[2]*o[21]*o[3]*tau1;
      o[32] := 1/o[31];
      o[33] := o[2]*o[21]*o[3]*tau1;
      o[34] := 1/o[33];
      o[35] := o[1]*o[3]*tau1;
      o[36] := 1/o[35];
      o[37] := o[1]*o[3];
      o[38] := 1/o[37];
      o[39] := 1/o[6];
      o[40] := o[1]*o[22]*o[3];
      o[41] := 1/o[40];
      o[42] := 1/o[22];
      o[43] := o[1]*o[2]*o[21]*o[3];
      o[44] := 1/o[43];
      o[45] := 1/o[13];

    n[2,1,1]:=0.581281456626732e4;
      n[3,1,1]:=0.141627648484197e4;
      n[4,1,1]:=-0.243214662381794e4;
      n[5,1,1]:=0.202580115603697e4;
      n[6,1,1]:=-0.109166841042967e4;
      n[7,1,1]:=0.374601237877840e3;
      n[8,1,1]:=-0.485891069025409e2;
      n[2,2,1]:=0.851226734946706e3;
      n[3,2,1]:=0.168072408311545e3;
      n[4,2,1]:=-0.493407510141682e3;
      n[5,2,1]:=0.543835333000098e3;
      n[6,2,1]:=-0.196028306689776e3;
      n[7,2,1]:=0.367571622995805e2;
      n[3,3,1]:=0.880031352997204e3;
      n[4,3,1]:=-0.430664675978042e2;
      n[5,3,1]:=-0.685572509204491e2;
      n[3,4,1]:=-0.225267649263401e3;
      n[4,4,1]:=-0.100227370861875e2;
      n[5,4,1]:=0.493667694856254e2;
      n[3,5,1]:=0.914260447751259e2;
      n[4,5,1]:=0.875600661808945;
      n[5,5,1]:=-0.171397577419788e2;
      n[3,6,1]:=-0.216603240875311e2;
      n[5,6,1]:=0.249697009569508*10;
      n[3,7,1]:=0.213016970847183*10;
      n[3,1,2]:=-0.331049154044839e4;
      n[4,1,2]:=0.199459603073901e3;
      n[5,1,2]:=-0.547919133532887e2;
      n[6,1,2]:=0.360284195611086e2;
      n[3,2,2]:=0.729116529735046e3;
      n[4,2,2]:=-0.175292041186547e3;
      n[5,2,2]:=-0.226683558512829e2;
      n[3,3,2]:=-0.860764303783977e3;
      n[4,3,2]:=0.383058066002476e3;
      n[3,4,2]:=0.694244814133268e3;
      n[4,4,2]:=-0.460319931801257e3;
      n[3,5,2]:=-0.297728741987187e3;
      n[4,5,2]:=0.234565187611355e3;
      n[3,1,3]:=0.384794152978599e3;
      n[4,1,3]:=-0.522940909281335e2;
      n[5,1,3]:=-0.408193978912261*10;
      n[3,2,3]:=-0.343956902961561e3;
      n[4,2,3]:=0.831923927801819e2;
      n[3,3,3]:=0.337409530269367e3;
      n[4,3,3]:=-0.541917262517112e2;
      n[3,4,3]:=-0.204889641964903e3;
      n[3,5,3]:=0.747261411387560e2;
      n[3,1,4]:=-0.965324320107458e2;
      n[4,1,4]:=0.680444942726459e2;
      n[5,1,4]:=-0.301755111971161e2;
      n[3,2,4]:=0.124687671116248e3;
      n[4,2,4]:=-0.294830643494290e2;
      n[3,3,4]:=-0.178314556207638e3;
      n[4,3,4]:=0.256398487389914e2;
      n[3,4,4]:=0.113561697840594e3;
      n[3,5,4]:=-0.364872919001588e2;
      n[3,1,5]:=0.158408172766824e2;
      n[4,1,5]:=-0.341251932441282*10;
      n[3,2,5]:=-0.316569643860730e2;
      n[3,3,5]:=0.442040358308000e2;
      n[3,4,5]:=-0.111282734326413e2;
      n[3,1,6]:=-0.262480156590992*10;
      n[3,2,6]:=0.704658803315449*10;
      n[3,3,6]:=-0.792001547211682*10;

      if g.xi>-1e-10 and g.xi<1e-10 then
        g.gS:=0;
        g.gSt:=0;
        g.gSp:=0;
        g.gStt:=0;
        g.gStp:=0;
    //    g.gSpp:=0;
        g.gSs:=0;
        g.gSps:=0;
      else
      for k in 1:6 loop
        for j in 1:7 loop
          for i in 3:8 loop
            qi[i]:=n[i, j, k]*(g.xi^(i - 1));
          end for;
          qj[j]:=(n[2, j, k]*(g.xi^2)*log(g.xi) + sum(qi)) .* (theta1^(j - 1))*(pi2^(k - 1));
        end for;
        qk[k]:=sum(qj);
      end for;
      g.gS:=IAPWS_Utilities.data.gSTAR*sum(qk)/10;

       for k in 1:6 loop
        for j in 2:7 loop
          for i in 3:8 loop
            qi[i]:=n[i, j, k]*(g.xi^(i - 1));
          end for;
          qj[j]:=(j-1)*(n[2, j, k]*(g.xi^2)*log(g.xi) + sum(qi)) .* (theta1^(j - 2))*(pi2^(k - 1));
        end for;
        qk[k]:=sum(qj);
      end for;
      g.gSt:=IAPWS_Utilities.data.gSTAR*sum(qk)/40/10;

      for k in 2:6 loop
        for j in 1:7 loop
          for i in 3:8 loop
            qip[i]:=(k-1)*n[i, j, k]*(g.xi^(i - 1))* (theta1^(j - 1))*(pi2^(k - 2));
          end for;
          qjp[j]:=sum(qip);
        end for;
        qkp[k]:=sum(qjp);
      end for;
      g.gSp:=IAPWS_Utilities.data.gSTAR*sum(qkp)/100e5;

      for k in 1:6 loop
        for j in 3:7 loop
          for i in 3:8 loop
            qi[i]:=(j-1)*(j-2)*n[i, j, k]*(g.xi^(i - 1))* (theta1^(j - 3))*(pi2^(k - 1));
          end for;
          qj[j]:=sum(qi);
        end for;
        qk[k]:=sum(qj);
      end for;
      g.gStt:=IAPWS_Utilities.data.gSTAR*sum(qk)/(40^2)/10;

      for k in 2:6 loop
        for j in 2:7 loop
          for i in 3:8 loop
            qi[i]:=(j-1)*(k-1)*n[i, j, k]*(g.xi^(i - 1))* (theta1^(j - 2))*(pi2^(k - 2));
          end for;
          qj[j]:=sum(qi);
        end for;
        qk[k]:=sum(qj);
      end for;
      g.gStp:=IAPWS_Utilities.data.gSTAR*sum(qk)/(40*100e6)/10;

      for k in 3:6 loop
        for j in 1:7 loop
          for i in 3:8 loop
            qi[i]:=(k-1)*(k-2)*n[i, j, k]*(g.xi^(i - 1))* (theta1^(j - 1))*(pi2^(k - 3));
          end for;
          qj[j]:=sum(qi);
        end for;
        qk[k]:=sum(qj);
      end for;
      g.gSpp:=IAPWS_Utilities.data.gSTAR*sum(qk)/((100e6)^2)/10;

        for k in 1:6 loop
        for j in 1:7 loop
          for i in 3:8 loop
            qi[i]:=(i-1)*n[i, j, k]*(g.xi^(i - 3));
          end for;
          qj[j]:=(n[2, j, k]*(2*log(g.xi)+1) + sum(qi)) .* (theta1^(j - 1))*(pi2^(k - 1));
        end for;
        qk[k]:=sum(qj);
      end for;
      g.gSs:=IAPWS_Utilities.data.gSTAR*sum(qk)./(2*IAPWS_Utilities.data.SSTAR)/10;

      for k in 2:6 loop
        for j in 1:7 loop
          for i in 3:8 loop
            qi[i]:=(k-1)*(i-1)*n[i, j, k]*(g.xi^(i - 3))* (theta1^(j - 1))*(pi2^(k - 1));
          end for;
          qj[j]:=sum(qi);
        end for;
        qk[k]:=sum(qj);
      end for;
      g.gSps:=IAPWS_Utilities.data.gSTAR*sum(qk)/(100e6.*2.*IAPWS_Utilities.data.SSTAR)/10;
      end if;
      g.gps:=g.gSps;
      g.gs:=g.gSs;

      g.g := pi1*(pi1*(pi1*(o[10]*(-0.000031679644845054 + o[2]*(-2.82707979853120e-6
         - 8.5205128120103e-10*o[6])) + pi1*(o[12]*(-2.24252819080000e-6 + (-6.5171222895601e-7
         - 1.43417299379240e-13*o[13])*o[7]) + pi1*(-4.0516996860117e-7*o[14]
         + o[16]*((-1.27343017416410e-9 - 1.74248712306340e-10*o[11])*o[36]
         + o[19]*(-6.8762131295531e-19*o[34] + o[15]*(1.44783078285210e-20*o[
        32] + o[20]*(2.63357816627950e-23*o[30] + pi1*(-1.19476226400710e-23*
        o[28] + pi1*(1.82280945814040e-24*o[26] - 9.3537087292458e-26*o[24]*
        pi1))))))))) + o[8]*(-0.00047184321073267 + o[7]*(-0.000300017807930260
         + (0.000047661393906987 + o[1]*(-4.4141845330846e-6 -
        7.2694996297594e-16*o[9]))*tau1))) + o[5]*(0.000283190801238040 + o[1]
        *(-0.00060706301565874 + o[6]*(-0.0189900682184190 + tau1*(-0.032529748770505
         + (-0.0218417171754140 - 0.000052838357969930*o[1])*tau1))))) + (
        0.146329712131670 + tau1*(-0.84548187169114 + tau1*(-3.7563603672040
         + tau1*(3.3855169168385 + tau1*(-0.95791963387872 + tau1*(
        0.157720385132280 + (-0.0166164171995010 + 0.00081214629983568*tau1)*
        tau1))))))/o[1];

      g.gpi :=pi1*(pi1*(o[10]*(0.000095038934535162 + o[2]*(
        8.4812393955936e-6 + 2.55615384360309e-9*o[6])) + pi1*(o[12]*(
        8.9701127632000e-6 + (2.60684891582404e-6 + 5.7366919751696e-13*o[13])
        *o[7]) + pi1*(2.02584984300585e-6*o[14] + o[16]*((1.01874413933128e-8
         + 1.39398969845072e-9*o[11])*o[36] + o[19]*(1.44400475720615e-17*o[
        34] + o[15]*(-3.3300108005598e-19*o[32] + o[20]*(-7.6373766822106e-22
        *o[30] + pi1*(3.5842867920213e-22*o[28] + pi1*(-5.6507093202352e-23*o[
        26] + 2.99318679335866e-24*o[24]*pi1))))))))) + o[8]*(
        0.00094368642146534 + o[7]*(0.00060003561586052 + (-0.000095322787813974
         + o[1]*(8.8283690661692e-6 + 1.45389992595188e-15*o[9]))*tau1))) + o[
        5]*(-0.000283190801238040 + o[1]*(0.00060706301565874 + o[6]*(
        0.0189900682184190 + tau1*(0.032529748770505 + (0.0218417171754140 +
        0.000052838357969930*o[1])*tau1))));

      g.gpipi :=pi1*(o[10]*(-0.000190077869070324 + o[2]*(-0.0000169624787911872
         - 5.1123076872062e-9*o[6])) + pi1*(o[12]*(-0.0000269103382896000 + (
        -7.8205467474721e-6 - 1.72100759255088e-12*o[13])*o[7]) + pi1*(-8.1033993720234e-6
        *o[14] + o[16]*((-7.1312089753190e-8 - 9.7579278891550e-9*o[11])*o[36]
         + o[19]*(-2.88800951441230e-16*o[34] + o[15]*(7.3260237612316e-18*o[
        32] + o[20]*(2.13846547101895e-20*o[30] + pi1*(-1.03944316968618e-20*
        o[28] + pi1*(1.69521279607057e-21*o[26] - 9.2788790594118e-23*o[24]*
        pi1))))))))) + o[8]*(-0.00094368642146534 + o[7]*(-0.00060003561586052
         + (0.000095322787813974 + o[1]*(-8.8283690661692e-6 -
        1.45389992595188e-15*o[9]))*tau1));

      g.gtau :=pi1*(o[38]*(-0.00254871721114236 + o[1]*(0.0042494411096112
         + (0.0189900682184190 + (-0.0218417171754140 - 0.000158515073909790*
        o[1])*o[1])*o[6])) + pi1*(o[10]*(0.00141552963219801 + o[2]*(
        0.000047661393906987 + o[1]*(-0.0000132425535992538 -
        1.23581493705910e-14*o[9]))) + pi1*(o[12]*(0.000126718579380216 -
        5.1123076872062e-9*o[37]) + pi1*(o[39]*(0.0000112126409540000 + (
        1.30342445791202e-6 - 1.43417299379240e-12*o[13])*o[7]) + pi1*(
        3.2413597488094e-6*o[5] + o[16]*((1.40077319158051e-8 +
        1.04549227383804e-9*o[11])*o[45] + o[19]*(1.99410180757040e-17*o[44]
         + o[15]*(-4.4882754268415e-19*o[42] + o[20]*(-1.00075970318621e-21*o[
        28] + pi1*(4.6595728296277e-22*o[26] + pi1*(-7.2912378325616e-23*o[24]
         + 3.8350205789908e-24*o[41]*pi1))))))))))) + o[8]*(-0.292659424263340
         + tau1*(0.84548187169114 + o[1]*(3.3855169168385 + tau1*(-1.91583926775744
         + tau1*(0.47316115539684 + (-0.066465668798004 + 0.0040607314991784*
        tau1)*tau1)))));

      g.gtautau :=pi1*(o[36]*(0.0254871721114236 + o[1]*(-0.033995528876889
         + (-0.037980136436838 - 0.00031703014781958*o[2])*o[6])) + pi1*(o[12]
        *(-0.0056621185287920 + o[6]*(-0.0000264851071985076 -
        1.97730389929456e-13*o[9])) + pi1*((-0.00063359289690108 -
        2.55615384360309e-8*o[37])*o[39] + pi1*(pi1*(-0.0000291722377392842*o[
        38] + o[16]*(o[19]*(-5.9823054227112e-16*o[32] + o[15]*(o[20]*(
        3.9029628424262e-20*o[26] + pi1*(-1.86382913185108e-20*o[24] + pi1*(
        2.98940751135026e-21*o[41] - (1.61070864317613e-22*pi1)/(o[1]*o[22]*o[
        3]*tau1)))) + 1.43624813658928e-17/(o[22]*tau1))) + (-1.68092782989661e-7
         - 7.3184459168663e-9*o[11])/(o[2]*o[3]*tau1))) + (-0.000067275845724000
         + (-3.9102733737361e-6 - 1.29075569441316e-11*o[13])*o[7])/(o[1]*o[2]
        *tau1))))) + o[10]*(0.87797827279002 + tau1*(-1.69096374338228 + o[7]
        *(-1.91583926775744 + tau1*(0.94632231079368 + (-0.199397006394012 +
        0.0162429259967136*tau1)*tau1))));

      g.gtaupi :=o[38]*(0.00254871721114236 + o[1]*(-0.0042494411096112 + (-0.0189900682184190
         + (0.0218417171754140 + 0.000158515073909790*o[1])*o[1])*o[6])) +
        pi1*(o[10]*(-0.00283105926439602 + o[2]*(-0.000095322787813974 + o[1]
        *(0.0000264851071985076 + 2.47162987411820e-14*o[9]))) + pi1*(o[12]*(
        -0.00038015573814065 + 1.53369230616185e-8*o[37]) + pi1*(o[39]*(-0.000044850563816000
         + (-5.2136978316481e-6 + 5.7366919751696e-12*o[13])*o[7]) + pi1*(-0.0000162067987440468
        *o[5] + o[16]*((-1.12061855326441e-7 - 8.3639381907043e-9*o[11])*o[45]
         + o[19]*(-4.1876137958978e-16*o[44] + o[15]*(1.03230334817355e-17*o[
        42] + o[20]*(2.90220313924001e-20*o[28] + pi1*(-1.39787184888831e-20*
        o[26] + pi1*(2.26028372809410e-21*o[24] - 1.22720658527705e-22*o[41]*
        pi1))))))))));
    end g1;

    function gibbs "Gibbs function region 1: g(p,T,S)"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature (K)";
      input Modelica.Units.SI.MassFraction X[:] "Concentration (kg/kg)";
      output Real g "Dimensionless Gibbs function";
    protected
      NHES.Media.SeaWater.IAPWS_Utilities.GibbsDerivsBrine gibbs
        "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
    algorithm
      gibbs := SeaWater.IAPWS_Utilities.g1(
            p,
            T,
            X);
      g := gibbs.g;
    end gibbs;

    record GibbsDerivsBrine
      "Derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"

      extends Modelica.Icons.Record;
      Modelica.Units.SI.Pressure p "Pressure";
      Modelica.Units.SI.Temperature T "Temperature";
      Modelica.Units.SI.SpecificHeatCapacity R_s "Specific heat capacity";
      Real pi(unit="1") "Dimensionless pressure";
      Real tau(unit="1") "Dimensionless temperature";
      Real theta(unit="1");
      Real pi0(unit="1");
      Real xi(unit="1");
      Real g(unit="1") "Dimensionless Gibbs-function";
      Modelica.Units.SI.SpecificEnergy gS;
      Modelica.Units.SI.SpecificVolume gSp;
      Real gSpp(unit="1");
      Modelica.Units.SI.SpecificEntropy gSt;
      Real gStt(unit="J/(kg.K2)");
      Real gStp;
      Modelica.Units.SI.SpecificEnergy gSs;
      Real gSps(unit="1");
      Real gs;
      Real gps(unit="1");
      Real gpi(unit="1") "Derivative of g w.r.t. pi";
      Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
      Real gtau(unit="1") "Derivative of g w.r.t. tau";
      Real gtautau(unit="1") "2nd derivative of g w.r.t. tau";
      Real gtaupi(unit="1") "Mixed derivative of g w.r.t. pi and tau";
    end GibbsDerivsBrine;

    function h_pTX
      "Specific enthalpy as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      output Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := NHES.Media.SeaWater.IAPWS_Utilities.h_props_pT(
            p,
            T,
            X,
            NHES.Media.SeaWater.IAPWS_Utilities.sesWaterBaseProp_pT(
              p,
              T,
              X));
      annotation (Inline=true);
    end h_pTX;

    record data "Constant IF97 data and region limits"
      extends Modelica.Icons.Record;
      constant Modelica.Units.SI.SpecificHeatCapacity RH2O=461.526
        "Specific gas constant of water vapour";
      constant Modelica.Units.SI.MolarMass MH2O=0.01801528
        "Molar weight of water";
      constant Modelica.Units.SI.Temperature TSTAR1=1386.0
        "Normalization temperature for region 1 IF97";
      constant Modelica.Units.SI.Pressure PSTAR1=16.53e6
        "Normalization pressure for region 1 IF97";
      constant Modelica.Units.SI.Temperature TSTAR2=540.0
        "Normalization temperature for region 2 IF97";
      constant Modelica.Units.SI.Pressure PSTAR2=1.0e6
        "Normalization pressure for region 2 IF97";
      constant Modelica.Units.SI.Temperature TSTAR5=1000.0
        "Normalization temperature for region 5 IF97";
      constant Modelica.Units.SI.Pressure PSTAR5=1.0e6
        "Normalization pressure for region 5 IF97";
      constant Modelica.Units.SI.SpecificEnthalpy HSTAR1=2.5e6
        "Normalization specific enthalpy for region 1 IF97";
      constant Real IPSTAR=1.0e-6
        "Normalization pressure for inverse function in region 2 IF97";
      constant Real IHSTAR=5.0e-7
        "Normalization specific enthalpy for inverse function in region 2 IF97";
      constant Modelica.Units.SI.Temperature TLIMIT1=623.15
        "Temperature limit between regions 1 and 3";
      constant Modelica.Units.SI.Temperature TLIMIT2=1073.15
        "Temperature limit between regions 2 and 5";
      constant Modelica.Units.SI.Temperature TLIMIT5=2273.15
        "Upper temperature limit of 5";
      constant Modelica.Units.SI.Pressure PLIMIT1=100.0e6
        "Upper pressure limit for regions 1, 2 and 3";
      constant Modelica.Units.SI.Pressure PLIMIT4A=16.5292e6
        "Pressure limit between regions 1 and 2, important for two-phase (region 4)";
      constant Modelica.Units.SI.Pressure PLIMIT5=10.0e6
        "Upper limit of valid pressure in region 5";
      constant Modelica.Units.SI.Pressure PCRIT=22064000.0
        "The critical pressure";
      constant Modelica.Units.SI.Temperature TCRIT=647.096
        "The critical temperature";
      constant Modelica.Units.SI.Density DCRIT=322.0 "The critical density";
      constant Modelica.Units.SI.SpecificEntropy SCRIT=4412.02148223476
        "The calculated specific entropy at the critical point";
      constant Modelica.Units.SI.SpecificEnthalpy HCRIT=2087546.84511715
        "The calculated specific enthalpy at the critical point";
      constant Modelica.Units.SI.MassFraction SSTAR=(40/35)*0.03516504;
      constant Modelica.Units.SI.SpecificGibbsFreeEnergy gSTAR=10;
      constant Real[5] n=array(
              0.34805185628969e3,
              -0.11671859879975e1,
              0.10192970039326e-2,
              0.57254459862746e3,
              0.13918839778870e2)
        "Polynomial coefficients for boundary between regions 2 and 3";
      annotation (Documentation(info="<html>
 <h4>Record description</h4>
                           <p>Constants needed in the international steam properties IF97.
                           SCRIT and HCRIT are calculated from Helmholtz function for region 3.</p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <em>July, 2000</em>
       by Hubertus Tummescheit
       </li>
</ul>
 <address>Author: Hubertus Tummescheit,<br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</html>"));
    end data;

    function rho_pTX
      "Density as function or pressure temperature and MassFraction"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      output Modelica.Units.SI.Density rho "Density";
    algorithm
      rho := NHES.Media.SeaWater.IAPWS_Utilities.rho_props_pT(
            p,
            T,
            X,
            NHES.Media.SeaWater.IAPWS_Utilities.sesWaterBaseProp_pT(
              p,
              T,
              X));
      annotation (Inline=true);
    end rho_pTX;

    function rho_props_pT
      "Density as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      input IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      output Modelica.Units.SI.Density rho "Density";
    algorithm
      rho := aux.rho;
      annotation (derivative(noDerivative=aux) = rho_pT_der,
            Inline=false,
        LateInline=true);
    end rho_props_pT;

    function mu_pTX
      "Relative Chemical Potential as function or pressure temperature and MassFraction"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      output Modelica.Units.SI.SpecificEnergy mu "Chemical Potential";
    algorithm
      mu := NHES.Media.SeaWater.IAPWS_Utilities.mu_props_pT(
            p,
            T,
            X,
            NHES.Media.SeaWater.IAPWS_Utilities.sesWaterBaseProp_pT(
              p,
              T,
              X));
      annotation (Inline=true);
    end mu_pTX;

    function mu_props_pT
      "Relative Chemical Potential as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      input IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      output Modelica.Units.SI.SpecificEnergy mu "Chemical Potential";
    algorithm
      mu := aux.h-T*aux.s-X[2]*aux.gSs;
      annotation (
        Inline=false,
        LateInline=true);
    end mu_props_pT;

    function s_pTX "Temperature as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      output Modelica.Units.SI.SpecificEntropy s "Specific entropy";
    algorithm
      s := NHES.Media.SeaWater.IAPWS_Utilities.s_props_pT(
            p,
            T,
            X,
            NHES.Media.SeaWater.IAPWS_Utilities.sesWaterBaseProp_pT(
              p,
              T,
              X));
      annotation (Inline=true);
    end s_pTX;

    function s_props_pT
      "Specific entropy as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction x[:];
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux
        "Auxiliary record";
      output Modelica.Units.SI.SpecificEntropy s "Specific entropy";
    algorithm
      s := aux.s;
      annotation (derivative(noDerivative=aux) = s_pT_der,
      Inline=false, LateInline=true);
    end s_props_pT;

    function tph "Inverse function: T(p,h)"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy";
      input Modelica.Units.SI.MassFraction X[:];
      output Modelica.Units.SI.Temperature T "Temperature (K)";
    protected
      Real pi "Dimensionless pressure";
      Real eta1 "Dimensionless specific enthalpy";
      Real[3] o "Vector of auxiliary variables";
    algorithm
      assert(p > Modelica.Media.Water.IF97_Utilities.BaseIF97.triple.ptriple, "IF97 medium function tph1 called with too low pressure\n"
         + "p = " + String(p) + " Pa <= " + String(Modelica.Media.Water.IF97_Utilities.BaseIF97.triple.ptriple)
         + " Pa (triple point pressure)");
      pi := p/Modelica.Media.Water.IF97_Utilities.BaseIF97.data.PSTAR2;
      eta1 := h/Modelica.Media.Water.IF97_Utilities.BaseIF97.data.HSTAR1 + 1.0;
      o[1] := eta1*eta1;
      o[2] := o[1]*o[1];
      o[3] := o[2]*o[2];
      T := -238.724899245210 - 13.3917448726020*pi + eta1*(404.21188637945 +
        43.211039183559*pi + eta1*(113.497468817180 - 54.010067170506*pi +
        eta1*(30.5358922039160*pi + eta1*(-6.5964749423638*pi + o[1]*(-5.8457616048039
         + o[2]*(pi*(0.0093965400878363 + (-0.0000258586412820730 +
        6.6456186191635e-8*pi)*pi) + o[2]*o[3]*(-0.000152854824131400 + o[1]*
        o[3]*(-1.08667076953770e-6 + pi*(1.15736475053400e-7 + pi*(-4.0644363084799e-9
         + pi*(8.0670734103027e-11 + pi*(-9.3477771213947e-13 + (
        5.8265442020601e-15 - 1.50201859535030e-17*pi)*pi))))))))))));
    end tph;

    function waterBaseProp_phX "Intermediate property record for water"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy";
      input Modelica.Units.SI.MassFraction X[:];
      output NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux
        "Auxiliary record";
    protected
      NHES.Media.SeaWater.IAPWS_Utilities.GibbsDerivsBrine g
        "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";

    algorithm
      aux.p := max(p, 611.657);
      aux.h := max(h, 1e3);
      aux.R_s := Modelica.Media.Water.IF97_Utilities.BaseIF97.data.RH2O;
      aux.vt := 0.0 "Initialized in case it is not needed";
      aux.vp := 0.0 "Initialized in case it is not needed";
      aux.T := NHES.Media.SeaWater.IAPWS_Utilities.tph(
            aux.p,
            aux.h,
            X);
      aux.b := X[2]/(0.314038218*(1-X[2]));
      g := NHES.Media.SeaWater.IAPWS_Utilities.g1(
            p,
            aux.T,
            X);
      aux.h := aux.R_s*aux.T*g.tau*g.gtau
        +(g.gS-aux.T*g.gSt);
      aux.s := aux.R_s*(g.tau*g.gtau - g.g)
        -g.gSt;
      aux.rho := p/(aux.R_s*aux.T*g.pi*g.gpi)
        +(1/g.gSp);
      aux.vt := aux.R_s/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi)
        -g.gSpp;
      aux.vp := aux.R_s*aux.T/(p*p)*g.pi*g.pi*g.gpipi
        +g.gStp;
      aux.cp := -aux.R_s*g.tau*g.tau*g.gtautau
        -aux.T*g.gStt;
      aux.cv := aux.R_s*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
      - g.tau*g.gtaupi)/g.gpipi))
        +(aux.T*(((g.gStp^2)/g.gSpp)-g.gStt));
      aux.x := 0.0;
      aux.dpT := -aux.vt/aux.vp;
      aux.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      aux.pd := -g.R_s*g.T*g.gpi*g.gpi/(g.gpipi);
      aux.mu:=aux.h-aux.T*aux.s-X[2]*g.gSs;
      if X[2]>-1e-10 and X[2]<1e-10 then
        aux.theta:=0;
        else
      aux.theta:=(g.gS-X[2]*g.gs)/(aux.b*aux.R_s*aux.T);
      end if;
      aux.beta:=(g.gps/g.gpi);
    end waterBaseProp_phX;

    function rho_phX
      "Density as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy";
      input Modelica.Units.SI.MassFraction X[:];
      output Modelica.Units.SI.Density rho "Density";
    algorithm
      rho := NHES.Media.SeaWater.IAPWS_Utilities.rho_props_ph(
            p,
            h,
            X,
            NHES.Media.SeaWater.IAPWS_Utilities.waterBaseProp_phX(
              p,
              h,
              X));
      annotation (Inline=true);
    end rho_phX;

    function rho_props_ph
      "Density as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.SpecificEnthalpy h "Specific enthalpy";
      input Modelica.Units.SI.MassFraction X[:];
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase properties
        "Auxiliary record";
      output Modelica.Units.SI.Density rho "Density";
    algorithm
      rho := properties.rho;
      annotation (
        derivative(noDerivative=properties)=NCSU_INL.MEE_Stuff.rho_ph_der,
        Inline=false,
        LateInline=true);
    end rho_props_ph;

    function rho_pT_der "Derivative function of rho_pT"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:]
                                               "Massfraction";
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:]
                      "Derivative of massfraction";
      output Real rho_der "Derivative of density";

    algorithm
     rho_der := (-aux.rho*aux.rho*aux.vp)*p_der + (-aux.rho*aux.rho*aux.vt)*
          T_der;
          //+(-aux.rho*aux.rho*aux.vx)*X_der[2];
    end rho_pT_der;

    function h_pT_der "Derivative function of h_pT"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:];
      output Real h_der "Derivative of specific enthalpy";
    algorithm

        h_der := (1/aux.rho - aux.T*aux.vt)*p_der + aux.cp*T_der;

    end h_pT_der;

    function mu_pT_der "Derivative function of mu_pT"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:]
                                               "Massfraction";
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:]
                      "Derivative of massfraction";
      output Real mu_der "Derivative of density";

    algorithm
     mu_der  :=(1/aux.rho - aux.T*aux.vt-aux.T*aux.vp)*p_der + (2*aux.cp+aux.s)*T_der;

    //-X[2]*aux.gSps
    end mu_pT_der;

    function gs_props_pT
      "gibbs salt der as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      input IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      output Modelica.Units.SI.SpecificEnergy gs "Chemical Potential";
    algorithm
      gs := aux.gSs;
      annotation (derivative(noDerivative=aux) = gs_pT_der,
        Inline=false,
        LateInline=true);
    end gs_props_pT;

    function gs_pTX
      "Gibbs salt der as function or pressure temperature and MassFraction"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:];
      output Modelica.Units.SI.SpecificEnergy gs "Chemical Potential";
    algorithm
      gs := NHES.Media.SeaWater.IAPWS_Utilities.gs_props_pT(
            p,
            T,
            X,
            NHES.Media.SeaWater.IAPWS_Utilities.sesWaterBaseProp_pT(
              p,
              T,
              X));
      annotation (Inline=true);
    end gs_pTX;

    function gs_pT_der "Derivative function of gs_pT"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:]
      "Massfraction";
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:]
                         "Derivative of massfraction";
      output Real gs_der "Derivative of density";

    algorithm
     gs_der := aux.gSps*p_der;
    end gs_pT_der;

    function s_pT_der "Derivative function of s_pT"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Pressure p "Pressure";
      input Modelica.Units.SI.Temperature T "Temperature";
      input Modelica.Units.SI.MassFraction X[:]
      "Massfraction";
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:]
                         "Derivative of massfraction";
      output Real s_der "Derivative of density";

    algorithm
     s_der := (aux.cp/aux.T)*T_der+aux.vp*p_der;
    end s_pT_der;

    function cp_pT
      "Specific heat capacity at constant pressure as function of pressure and temperature"

      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:];
      output SI.SpecificHeatCapacity cp "Specific heat capacity";
    algorithm
      cp := NHES.Media.SeaWater.IAPWS_Utilities.cp_props_pT(
        p,
        T,
        X,
        NHES.Media.SeaWater.IAPWS_Utilities.sesWaterBaseProp_pT(
          p,
          T,
          X));
      annotation (Inline=true);
    end cp_pT;

    function cp_props_pT
      "Specific heat capacity at constant pressure as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:];
      input NHES.Media.SeaWater.IAPWS_Utilities.IAPWSBase aux "Auxiliary record";
      output SI.SpecificHeatCapacity cp "Specific heat capacity";
    algorithm
      cp := aux.cp;
      annotation (Inline=false, LateInline=true);
    end cp_props_pT;
  end IAPWS_Utilities;

  replaceable function mu_pTX
    "Relative Return Chemical Potential from p, T, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fractions";
    output Modelica.Units.SI.SpecificEnergy mu "Cehmical Potential";
  algorithm
    mu := IAPWS_Utilities.mu_pTX(
            p,
            T,
            X);
  end mu_pTX;

  redeclare function extends setState_pTX
    "Return thermodynamic state of water as function of p, T, and  Mass Fraction"

  algorithm
    state := NHES.Media.SeaWater.ThermodynamicState(
        d=NHES.Media.SeaWater.density_pTX(
          p,
          T,
          X),
        T=T,
        h=NHES.Media.SeaWater.specificEnthalpy_pTX(
          p,
          T,
          X),
        p=p,
        X=X);
    annotation (Inline=true);
  end setState_pTX;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := state.h;
    annotation (Inline=true);
  end specificEnthalpy;

  redeclare function extends density "Return density of ideal gas"
  algorithm
    d := state.d;
    annotation (Inline=true);
  end density;

  redeclare function extends temperature "Return temperature of ideal gas"
  algorithm
    T := state.T;
    annotation (Inline=true);
  end temperature;

  redeclare function extends pressure "Return pressure of ideal gas"
  algorithm
    p := state.p;
    annotation (Inline=true);
  end pressure;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := state.h - state.p/state.d;
    annotation (Inline=true);
  end specificInternalEnergy;

  redeclare function extends specificGibbsEnergy
    "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := state.h - state.T*NHES.Media.SeaWater.specificEntropy(state);
    annotation (Inline=true);
  end specificGibbsEnergy;

  replaceable function ChemicalPotenialWater
    "Return chemical potenial of water"
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output Modelica.Units.SI.SpecificEnergy muW "Cehmical Potential of Water";
  algorithm
    muW := NHES.Media.SeaWater.specificGibbsEnergy(state) - state.X[2]*
      NHES.Media.SeaWater.IAPWS_Utilities.mu_pTX(
        state.p,
        state.T,
        state.X);
    annotation (Documentation(info="<html>

</html>"));
  end ChemicalPotenialWater;

  redeclare function extends setState_phX
    "Return thermodynamic state of water as function of p, h, and Mass Fraction"

  algorithm
    state := NHES.Media.SeaWater.ThermodynamicState(
        d=NHES.Media.SeaWater.density_phX(
          p,
          h,
          X),
        T=NHES.Media.SeaWater.temperature_phX(
          p,
          h,
          X),
        h=h,
        p=p,
        X=X);
    annotation (Inline=true);
  end setState_phX;

  redeclare function temperature_phX
    "Compute temperature from pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input Modelica.Units.SI.AbsolutePressure p;
    input Modelica.Units.SI.SpecificEnthalpy h;
    input Modelica.Units.SI.MassFraction X[:];

    output Temperature T "Temperature";

  algorithm
    T := NHES.Media.SeaWater.IAPWS_Utilities.tph(
        p,
        h,
        X);
    annotation (Inline=true);
  end temperature_phX;

  redeclare function density_phX
    "Computes density as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[:];
    output Density d "Density";
  algorithm
    d := NHES.Media.SeaWater.IAPWS_Utilities.rho_phX(
        p,
        h,
        X);
    annotation (Inline=true);
  end density_phX;

  replaceable function gs_pTX
    "Relative Return Chemical Potential from p, T, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fractions";
    output Modelica.Units.SI.SpecificEnergy gs "Cehmical Potential";
  algorithm
    gs := IAPWS_Utilities.gs_pTX(
            p,
            T,
            X);
  end gs_pTX;
  annotation (Documentation(info="<html>
<p>Salt Water Media using IAPWS industrial formulation.</p>
<p>Thermodynamic Properties are determined from a Gibbs Equation Of State.</p>
</html>"));

end SeaWater;
