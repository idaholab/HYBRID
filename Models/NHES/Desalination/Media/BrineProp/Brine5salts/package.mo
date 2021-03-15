within NHES.Desalination.Media.BrineProp;
package Brine5salts "One-phase (liquid) multisalt brine solution"
  extends BrineProp.PartialBrineMultiSaltOnePhase(redeclare package
      Salt_data =
        BrineProp.SaltDataDuan,                                                                         final saltNames = {"sodium chloride", "potassium chloride", "calcium chloride", "magnesium chloride", "strontium chloride"}, final MM_salt = Salt_data.MM_salt, final nM_salt = Salt_data.nM_salt);

  redeclare function extends density_pTX
      /*redeclare function density_pTX
                          extends Densities.density_Duan2008_pTX;*/

  algorithm
      //    print("MM:"+String(size(MM,1))+" "+String(MM[1]));
      d := Densities.density_Duan2008_pTX(p, T, X, MM_vec)
      "Defined in Salt_Data_Duan";
      //  d := Brine_Driesner.density_pTX(p,T,X[1:nX_salt],MM_salt);
      //  d := Modelica.Media.Water.WaterIF97_pT.density_pT(p,T)  "*(1+sum(X[1:nX_salt]))/X[end]";
      //   print("density_liquid_pTX: "+String(p*1e-5)+" bar,"+String(T)+" K->"+String(d)+"kg/m^3");
  end density_pTX;

  redeclare function extends specificEnthalpy_pTX
      // Partial_Units.Molality molalities = massFractionsToMoleFractions(X, MM_vec);
      //  SI.SpecificEnthalpy h_H2O := Modelica.Media.Water.WaterIF97_pT.specificEnthalpy_pT(p, T) "H2O";

  algorithm
      //    h_app[1] :=Brine_Driesner.specificEnthalpy_pTX(p,T,X) "NaCl";
      /*    h_app[1] :=apparentMolarEnthalpy_NaCl(p,T) "NaCl";
                            h_app[2] := 0 "apparentMolarEnthalpy_KCl_Holmes1983(T)KCl";
                            h_app[3] := 0 "apparentMolarEnthalpy_CaCl(p,T)CaCl2";
                            h_app[4] := 0 "apparentMolarEnthalpy_MgCl2(p,T)MgCl2";
                            h_app[5] := 0 "apparentMolarEnthalpy_SrCl2(p,T)0SrCl2";

                            h := (h_H2O + h_app*molalities) * X[end];
                        */
      //    h := SpecificEnthalpies.specificEnthalpy_pTX_Driesner(p,T,X);
      h := BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_liq_Francke_cp(p, T, X);
      //  print(String(p*1e-5)+" bar,"+String(T)+" K->"+String(h)+" J/kg (Brine_Duan_Multi_TwoPhase_ngas_3.specificEnthalpy_liq_pTX)");
      //print("h="+String(X[1])+"*"+String(h_vec[1])+"="+String(X[1:nX_salt]*h_vec));
  end specificEnthalpy_pTX;

  redeclare function extends dynamicViscosity_pTXd
protected
  Modelica.Units.SI.Temperature T_corr;

  algorithm
      //print("p="+String(p)+" Pa, T="+String(T)+" K (BrineProp.Brine_5salts_noGas.dynamicViscosity_pTX)");
      if T < 273.16 then
        print("T=" + String(T) + " too low (<0 degC), setting to 0 degC in PartialBrine_ngas_Newton.quality_pTX()");
      end if;
      T_corr := max(273.16, T);
      eta := Viscosities.dynamicViscosity_DuanZhang_pTXd(p, T_corr, X, d, MM_vec, Salt_data.saltConstants);
  end dynamicViscosity_pTXd;

  redeclare function extends specificHeatCapacityCp
    "calculation of liquid specific heat capacity from apparent molar heat capacities"
      extends BrineProp.SaltDataDuan.defineSaltOrder;

protected
  Modelica.Units.SI.MolarMass MM_vec_salt[:]=BrineProp.SaltData.MM_salt[1:5];
  Modelica.Units.SI.Pressure p=state.p;
  Modelica.Units.SI.Temperature T=state.T;
  Modelica.Units.SI.MassFraction X[:]=state.X "mass fraction m_NaCl/m_Sol";
      Types.Molality b[size(X, 1)] = Utilities.massToMoleFractions(X, cat(1, MM_vec_salt, fill(-1, size(X, 1) - size(MM_vec_salt, 1))));
      /*  Real cp_by_cpWater[:]={0,
                              SpecificEnthalpies.HeatCapacityRatio_KCl_White(T, b[KCl]),
                              SpecificEnthalpies.HeatCapacityRatio_CaCl2_White(T, b[CaCl2]),
                              0,0} "cp/cp_H2O of salt solutions";*/
      Types.PartialMolarHeatCapacity[5] Cp_appmol
      "Apparent molar enthalpy of salts";
  Modelica.Units.SI.SpecificHeatCapacity cp_Driesner=
      SpecificEnthalpies.specificHeatCapacity_pTX_Driesner(
        p,
        T,
        X[1]/(X[1] + X[end]));
      //  SI.SpecificHeatCapacity cp_H2O=Modelica.Media.Water.IF97_Utilities.cp_pT(p,T);

  algorithm
      Cp_appmol := {0, if b[KCl] > 0 then SpecificEnthalpies.appMolarHeatCapacity_KCl_White(T, b[KCl]) else 0, if b[CaCl2] > 0 then SpecificEnthalpies.appMolarHeatCapacity_CaCl2_White(T, b[CaCl2]) else 0, 0, 0}
      "Apparent molar enthalpy of salts";
      //    Cp_appmol:={(if b[i] > 0 and cp_by_cpWater[i]>0 then ((1 .+ MM_vec_salt[i] .* b[i]) .* cp_by_cpWater[i] .- 1)*cp_H2O ./ b[i] else 0) for i in 1:5};
      cp := (X[NaCl] + X[end]) * cp_Driesner + X[end] * b[2:5] * Cp_appmol[2:5];
      //  cp:=(specificEnthalpy_pTX(state.p,state.T+.1,state.X)-state.h)/.1;
      //  cp := Modelica.Media.Water.IF97_Utilities.cp_pT(state.p, state.T)+mola[1:size(MM_vec_salt,1)];
      //  print("Cp_appmol: "+PowerPlant.vector2string(Cp_appmol)+" J/kg/K");
      //  print("cp_Driesner("+String(cp_Driesner)+")= J/(kg.K)");
    annotation(Documentation(info = "<html>
                                <p>In the two phase region this function returns the interpolated heat capacity between the
                                liquid and vapour state heat capacities.</p>
                                </html>"));
  end specificHeatCapacityCp;

  redeclare function extends surfaceTension_T
  algorithm
      sigma := Modelica.Media.Water.IF97_Utilities.surfaceTension(T)
      "TODO http://www.if.ufrgs.br/~levin/Pdfs.dir/6756.pdf";
  end surfaceTension_T;

  redeclare function extends thermalConductivity
    "Thermal conductivity of water TODO"
  algorithm
      lambda := Modelica.Media.Water.IF97_Utilities.thermalConductivity(Modelica.Media.Water.IF97_Utilities.rho_props_pT(state.p, state.T, Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(state.p, state.T, 1)), state.T, state.p, 1);
  end thermalConductivity;

  redeclare function extends dynamicViscosity_pTX
protected
  Modelica.Units.SI.Temperature T_corr;

  algorithm
      //print("p="+String(p)+" Pa, T="+String(T)+" K (BrineProp.Brine_5salts_noGas.dynamicViscosity_pTX)");
      if T < 273.16 then
        print("T=" + String(T) + " too low (<0 degC), setting to 0 degC in PartialBrine_ngas_Newton.quality_pTX()");
      end if;
      T_corr := max(273.16, T);
      eta := Viscosities.dynamicViscosity_Duan_pTX(p, T_corr, X, MM_vec, Salt_data.saltConstants);
  end dynamicViscosity_pTX;

  annotation(Documentation(info = "<html>
<p><b>BrineProp.Brine_5salts</b> is a medium package that provides properties of one-phase solution of five salts (NaCl, KCl, CaCl<sub>2</sub>, MgCl<sub>2</sub>, SrCl<sub>2</sub>).</p>
<h4>Usage</h4>
<p>It is based on Modelica.Media, the usage is accordingly:</p>
<p>Create an instance of the Medium: </p>
<pre>  package Medium = Brine_5salts;</pre>
<p>Create an instance of Medium.Baseproperties: </p>
<pre>  Medium.BaseProperties props;</pre>
<p>Use the BaseProperties model to define the actual brine composition(Xi or X), to define the thermodynamic state and calculate the corresponding properties. </p>
<pre>  props.p = 1e5;
  props.T = 300;
  props.Xi = {0.08, 0.004, 0.12, 0.001, 0.002} &QUOT;NaCl, KCl, CaCl2, MgCl2, SrCl2&QUOT;
  d = props.d;</pre>
<p>Pressure and temperature as well as pressure and specific enthalpy can be used to define a thermodynamic state.</p>

<p>All calculated values are returned in SI-Units and are mass based. </p>
<p><h4>Details</h4></p>
<p>The model is explicit for p and T, but for h(p,T) the inverse function T(p,h) is defined. T(p,h) is inverts h(p,T) numerically by bisection, stopping at a given tolerance.</p>
<p>Density and enthalpy are calculated like the liquid phase properties in <code>BrineProp.Brine_5salts_TwoPhase_3gas</code> .</p>
</html>"));
end Brine5salts;
