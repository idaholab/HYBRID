within NHES.Desalination.Media.BrineProp.Viscosities;
function dynamicViscosity_DuanZhang_pTXd
  "Multisalt-Version of viscosity calculation according to Duan et al 2009 and Zhang et al 1997: Considers NaCl and KCL, with geometric mixture rule"
  //doi:10.1007/s10765-009-0646-7
  input Modelica.Units.SI.Pressure p_Pa;
  input Modelica.Units.SI.Temperature T_K;
  input Modelica.Units.SI.MassFraction X[:] "mass fraction m_NaCl/m_Sol";
  input Modelica.Units.SI.Density d;
  input Modelica.Units.SI.MolarMass MM[:];
  input BrineProp.SaltDataDuan.SaltConstants[:] Salt_Constants;
  output Modelica.Units.SI.DynamicViscosity eta;
protected
  Modelica.Units.NonSI.Temperature_degC T_C=Modelica.Units.Conversions.to_degC(
      T_K);
  Pressure_bar p_bar = Modelica.Units.Conversions.to_bar(
                                             p_Pa);
  Real A;
  Real B;
  Real C;
  Real eta_relative;
  //  Integer nXi = size(X,1);
  Integer nX_salt = size(Salt_Constants, 1);
  //  SI.DynamicViscosity[nX_salt] etas=fill(0,nX_salt);
  Modelica.Units.SI.DynamicViscosity eta_H2O;
  Modelica.Media.Water.WaterIF97_pT.ThermodynamicState state_H2O;
  SaltDataDuan.SaltConstants salt;
  constant Molality[:] molalities = Utilities.massToMoleFractions(X, MM);
  // constant Partial_Units.Molality[:] molalities=X[1:nX_salt] ./ MM[1:nX_salt]/X[end];
  Molarity_molperliter c;
  Molality b "component molality";
  Real phi "mixing weight";
protected
  constant Pressure_bar p_min = 1;
  constant Pressure_bar p_max = 1000;
  constant Modelica.Units.NonSI.Temperature_degC T_min=0;
  constant Modelica.Units.NonSI.Temperature_degC T_max=400;
  String msg;
algorithm
  //   print("X[3]="+String(X[3])+" (Brine.Viscosities.dynamicViscosity_DuanZhuang_pTXd)");
  if debugmode then
    print("p=" + String(p_Pa) + " Pa, T_K" + String(T_K) + " K (Brine.Viscosities.dynamicViscosity_DuanZhuang_pTXd)");
  end if;
  if outOfRangeMode == 1 then
    if not (p_bar >= p_min and p_bar <= p_max) then
      print("Pressure is " + String(p_bar) + " bar, but must be between " + String(p_min) + " bar and " + String(p_max) + " bar (BrineProp.Viscosities.dynamicViscosity_DuanZhang_pTXd)");
    end if;
    if not (T_C >= T_min and T_C <= T_max) then
      print("Temperature is " + String(T_C) + "degC, but must be between " + String(T_min) + "degC and " + String(T_max) + "degC (BrineProp.Viscosities.dynamicViscosity_DuanZhang_pTXd)");
    end if;
  elseif outOfRangeMode == 2 then
    assert(p_bar >= p_min and p_bar <= p_max, "p=" + String(p_bar) + ", but must be between " + String(p_min) + " and " + String(p_max) + " bar");
    assert(T_C >= T_min and T_C <= T_max, "T=" + String(T_C) + ", but must be between " + String(T_min) + " and " + String(T_max) + "degC");
  end if;
  //viscosity calculation
  state_H2O := Modelica.Media.Water.WaterIF97_pT.setState_pTX(p_Pa, T_K, X);
  eta_H2O := Modelica.Media.Water.WaterIF97_pT.dynamicViscosity(state_H2O);
  //  print("eta_H2O= "+String(eta_H2O)+" Pa.s");
  //for pure water skip the whole calculation and return water viscosity
  eta := eta_H2O "^X[end]";
  //  print("eta_H2O^X[end]= "+String(eta_H2O)+"^"+String(X[end]) + " -> "+String(eta)+" Pa.s");
  if max(X[1:nX_salt]) <= 1e-8 then
    return;
  end if;
  //pure water -> skip the rest
  for i in 1:nX_salt loop
    if molalities[i] > 1e-8 then
      salt := Salt_Constants[i];
      if not (ignoreLimitSalt_b[i] or molalities[i] >= 0 and molalities[i] <= salt.mola_max_eta) then
        msg := "Molality of " + salt.name + " is " + String(molalities[i]) + "(X=" + String(X[i]) + "), but must be between 0 and " + String(salt.mola_max_eta) + " mol/kg (dynamicViscosity_DuanZhang_pTXd)";
      end if;
      phi := molalities[i] / sum(molalities[1:nX_salt])
        "geometric mean mixture rule weighted with mass fraction (as in Laliberte)";
      assert(phi > 0, "phi= " + String(phi) + " should not be possible.");
      if i == 3 then
        c := X[i] / MM[i] * d / 1000 / phi "component molarity";
        eta_relative := 1 + salt.Zh_A * c ^ 0.5 + salt.Zh_B * c + salt.Zh_D * c ^ 2 + 1e-4 * salt.Zh_E * c ^ 3.5 + 1e-5 * salt.Zh_F * c ^ 7;
      else
        if max(cat(1, salt.a, salt.b, salt.c)) == 0 then
          msg := "No coefficients for " + salt.name + " (b=" + String(molalities[i]) + " mol/kg) in dynamicViscosity_DuanZhang_pTXd";
        end if;
        b := molalities[i] / phi;
        A := salt.a[1] + salt.a[2] * T_K + salt.a[3] * T_K ^ 2;
        B := salt.b[1] + salt.b[2] * T_K + salt.b[3] * T_K ^ 2;
        C := salt.c[1] + salt.c[2] * T_K;
        eta_relative := exp(A * b + B * b ^ 2 + C * b ^ 3)
          "Mixture is composed of binary solutions of the same molality";
      end if;
      eta := eta * eta_relative ^ phi;
      if msg <> "" then
        if outOfRangeMode == 1 then
          print(msg);
        elseif outOfRangeMode == 2 then
          assert(false, msg);
        end if;
      end if;
    end if;
  end for;
  //    if X[i]>0 then
  //factors
  //MIXING WEIGHT
  //  phi:=X[i]/sum(X[1:nX_salt]) "geometric mean mixture rule weighted with mass fraction (as in Laliberte)";
  //Zhang (available for NaCl, KCl and CaCl)
  //Duan (available for NaCl and KCl)
  //        print(salt.name+" Duan. A="+String(A)+" B="+String(B)+" C="+String(C)+" b="+String(molalities[i]));
  //        eta_relative := exp(A*molalities[i] + B*molalities[i]^2 + C*molalities[i]^3);
  //      etas[i] := eta_relative "* eta_H2O";
  //    print("molaMulti["+String(i)+"]: "+String(molalities[i]));
  //    print("eta_H2O: "+String(eta_H2O));
  //    print("eta_relative: "+String(eta_relative));
  //    print("etas["+String(i)+"]: "+String(etas[i]));
  //      eta:= eta*etas[i] ^X[i] "geometric mean mixture rule (as in Laliberte)";
  //      print("Viscosity "+salt.name+" phi="+String(phi)+": "+String(eta_relative)+"->"+String(eta)+" Pa.s (BrineProp.Viscosities.dynamicViscosity_Duan_pTX)");
  //    eta := eta + etas[i]*molalities[i];
  //  eta := eta * (1+ sum(etas)) "additive mixing rule (Zhang 1997)";
  //  eta := etas*molalities[1:nX_salt]/(sum(molalities[1:nX_salt])) "linear mixing rule molality weighted (as in Duan2009)";
  //  eta := prod(cat(1,{eta_H2O},etas).^X[1:nX_salt]) "geometric mean mixture rule (as in Laliberte)";
  //  print("Viscosity("+String(p_Pa)+","+String(T_K)+"): "+String(eta)+" Pa.s (Partial_Viscosity_Phillips.dynamicViscosity_Duan_pTX)");
end dynamicViscosity_DuanZhang_pTXd;
