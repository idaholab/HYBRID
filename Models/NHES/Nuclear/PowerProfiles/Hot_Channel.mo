within NHES.Nuclear.PowerProfiles;
model Hot_Channel
  "Determines the hot channel safety limitin values for a nuclear subchannel. (Uses the Weisman correlation for CHF in PWRs)."

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Coolant medium" annotation (choicesAllMatching=true);

  input SI.Power Q_power "Total Power input" annotation(Dialog(group="Inputs"));
  //Real Fq=1.0 "Power Peaking Factor";

  Medium.SaturationProperties sat "Saturation properties";
 // input Real cross1;

  input SI.Area SurfaceArea annotation(Dialog(tab="Hot Channel", group="Inputs"));
  input SI.Area CrossArea annotation(Dialog(group="Inputs"));
  input SI.MassFlowRate mass_flow annotation(Dialog(group="Inputs"));
  input SI.Power H_flow[nV+1] annotation(Dialog(group="Inputs"));
  input SI.Pressure Pressure_sat annotation(Dialog(group="Inputs"));
  input SI.Temperature Temp_sat annotation(Dialog(group="Inputs"));
  input SI.Length Dimension annotation(Dialog(group="Inputs"));  // "Hydraulic Diameter"

  parameter Integer nV = 4;
  parameter Integer n_hot=4;
  parameter Real nAssembly=37;

  SI.HeatFlux qflux[nV]={(Q_power/(nAssembly*SurfaceArea)/1000.0)*(3.17e-04) for i in 1:nV}  "MBtu/hr*ft^2";  //[kW/m^2]Pick up here.
  SI.HeatFlux q_avg=(Q_power/(SurfaceArea*nAssembly)/1000.0)*(3.17e-04) "MBtu/hr*ft^2";  //W/m^2

  Real x[nV] = {((H_flow[i]/mass_flow)-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat))
            /(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat)-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat)) for i in 1:nV};

 // Real hf = Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat);
 // Real hg = Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat);

  Real x_inlet = ((H_flow[1]/mass_flow)-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat))
            /(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat)-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat));
  SI.Pressure Pcrit = 22064000;
  Real Mass_Flux = (mass_flow/CrossArea);//*737.338; //kg/sec/m^2 to lbm/hr*ft^2
  Real P_red = Pressure_sat/(Pcrit);

  SI.HeatFlux CHF[nV]={TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.CHF.EPRI_flux(qflux[i], q_avg, x[i],Mass_Flux,x_inlet, P_red) for i in 1:nV};
  //Real DNBR[geometry.nV] = {qflux[i,1]/(CHF[i]*3.169983306e-7) for i in 1:geometry.nV};
  Real DNBR[nV] = {(CHF[i]*3.169983306e-7/qflux[i]) for i in 1:nV};

  Real x_hot[n_hot];
  SI.HeatFlux qflux_hot[n_hot];
  SI.HeatFlux CHF_hot[n_hot];
  Real DNBR_hot[n_hot];

  SI.Temperature T_hot[n_hot];
  SI.Temperature T_sat[n_hot]=fill(sat.Tsat,n_hot);

  SI.SpecificEnthalpy h_hot[n_hot];

  parameter Real Q_shape[n_hot] = fill(1/n_hot,n_hot);
  parameter Real Fh=1.0 "Hot Channel Peaking Factor in the radial direction (NuScale nomenclature of Fh and not Fr)";

  input SI.SpecificEnthalpy h_in annotation(Dialog(group="Inputs"));
  input SI.Temperature T_in annotation(Dialog(group="Inputs"));
//  Real debug1,debug2;

   //Addition of Jennes Lottes Correlation.
  parameter Real m=4 "Jennes Lottes Correlation Exponent";
  Real tilda = (Modelica.Constants.e^(4.0*TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(Pressure_sat)/900.0))/(60.0^4.0);

  Real T_co_F_sat[n_hot]= { TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degF(T_sat[i]) + (tilda^(-1.0/m))*((q_flux[i]*0.317/10e6)^(1.0/m)) for i in 1:n_hot};
  SI.Temperature T_co_sat[n_hot] = {TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF(T_co_F_sat[i]) for i in 1:n_hot} "Subcooled Nucleate Boiling from Jennes Lotts";

 // Debugging **********************************************************************************************************************************************
 // Real check_value[n_hot] = {(tilda^(-1.0/m))*((Q_shape[i]*Q_power*Fh/(SurfaceArea*nAssembly)/10e6)^(1.0/m)) for i in 1:n_hot};
 // Real check_value_flux[n_hot] = {(tilda^(-1.0/m))*((q_flux[i]*0.317/10e6)^(1.0/m)) for i in 1:n_hot};
 // Real temp_check[n_hot] = {TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degF(T_hot[i]) for i in 1:n_hot};
 // Real conv_check[n_hot] = {TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degF(T_co_F[i]) for i in 1:n_hot};
   //Interesting that the values are not running properly...
   //Not sure how to solve it yet.
 //End Debugging *******************************************************************************************************************************************

  SI.Temperature T_co_final[n_hot] "Final Wall Temperature";
  SI.Temperature T_co_subcooled[n_hot] "Single Phase Forced Convection";

  constant SI.DynamicViscosity mu = 87.5125e-6 "Pa*s @300C and 127.5bar";
  constant SI.SpecificHeatCapacityAtConstantPressure cp_liq= 6108.9 "J/kg*K @315C and 127.5bar";
  constant SI.ThermalConductivity k = 0.556722 "W/m*K @300C and 127.5bar";

  constant Real C_weisman = 0.042*(0.496/0.374) - 0.024;

    Real h_c= (k/Dimension)*C_weisman*(Re^0.8)*(Pr^(1/3));
//Input Weisman single phase heat transfer correlation...
  SI.ReynoldsNumber Re;

//Prandtl Number
  SI.PrandtlNumber Pr = cp_liq*mu/k;
//Modelica.Fluid.Dissipation.Utilities.Functions.General.PrandtlNumber(1);

//Equivalent Diameter
  SI.HeatFlux q_flux[n_hot];

equation

  //Switch of T_co_final for clad temperature.
   sat.psat = Pressure_sat;
   sat.Tsat = Modelica.Media.Water.WaterIF97_base.saturationTemperature(Pressure_sat);

  for i in 2:n_hot loop
    if T_co_subcooled[i] > T_co_sat[i] or T_co_final[i-1] < T_co_subcooled[i-1] then
      T_co_final[i] = T_co_sat[i];
    else
      T_co_final[i] = T_co_subcooled[i];
    end if;
  end for;

  if T_co_subcooled[1] > T_co_sat[1] then
      T_co_final[1] = T_co_sat[1];
  else
      T_co_final[1] = T_co_subcooled[1];
  end if;

//Reynolds Number
  if mass_flow > 0.1 then
     Re = (mass_flow/CrossArea)*Dimension/mu;
  else
     Re = 10000; //"Just makes the system behave a bit better"
  end if;

    if time > 5 then
    //T_co_subcooled[1] = T_in;
    //q_flux[1] = (Q_shape[1]*Q_power*Fh*n_hot/(SurfaceArea*nAssembly)); //n_hot in the numerator renormalizes the Q_shape function.
  for i in 1:n_hot loop

    q_flux[i] = (Q_shape[i]*Q_power*Fh*n_hot/(SurfaceArea*nAssembly));

    if h_c > 4000 then
    T_co_subcooled[i] = T_hot[i] + q_flux[i]/h_c;
    else
      T_co_subcooled[i] = T_hot[i];
    end if;
  end for;
    else

      for i in 1:n_hot loop
        q_flux[i] = (Q_shape[i]*Q_power*Fh*n_hot/(SurfaceArea*nAssembly));
        //q_flux[i] =10000;
        T_co_subcooled[i] = T_in;
      end for;
    end if;

algorithm

//Hot Channel enthalpy rise.
   h_hot[1]:=h_in; //Should be going in the right direction.;
   T_hot[1] :=T_in;

   for i in 2:n_hot loop
     h_hot[i]:=h_hot[i - 1] + Fh*Q_shape[i]*Q_power/(mass_flow*nAssembly);
     T_hot[i]:=T_hot[i - 1] + Fh*Q_shape[i]*Q_power/(mass_flow*nAssembly*cp_liq);

     if T_hot[i] > sat.Tsat then
        T_hot[i]:=sat.Tsat;
     end if;

     x_hot[i]:=(h_hot[i] - Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(
       sat))/(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat) -
       Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat));

//     debug1 :=Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat);

 //    debug2 :=(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat) -
 //      Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat));

     qflux_hot[i]:=Fh*(Q_shape[i]/(1/n_hot))*q_avg;
     CHF_hot[i] :=
       TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.CHF.EPRI_flux(
       qflux_hot[i],
       q_avg,
       x_hot[i],
       Mass_Flux,
       x_inlet,
       P_red);

   DNBR_hot[i]:=(CHF_hot[i]*3.169983306e-7/qflux_hot[i]);
   end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {20,60}}), graphics={Bitmap(extent={{-126,-110},{42,60}}, fileName="modelica://NHES/Resources/Images/Systems/Fire.jpg"),
          Text(
          extent={{-102,80},{14,60}},
          lineColor={0,0,255},
          textStyle={TextStyle.Bold},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{20,60}})),
    Documentation(info="<html>
<p>This model determines the hot channel critical heat flux, hot channel heat flux, hot channel temperature distribution. </p>
<p>The model uses </p>
<ul>
<li>EPRI correlation to determine critical heat flux. </li>
<li>Jenns Lottes alongside single phase forced convection used to determine the outer clad temperature </li>
<li>Wesiman correlation used to determine heat transfer correlation on outside of tube bundle.</li>
</ul>
</html>"));
end Hot_Channel;
