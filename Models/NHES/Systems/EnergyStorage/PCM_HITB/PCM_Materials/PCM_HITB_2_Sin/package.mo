within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials;
package PCM_HITB_2_Sin "PCM_HITB_using_sin_and_cos with literature values"
  //Cp(T)_melting = a*T^2+b*T+c*sin(k*T)+d*cos(k*T)+e
  //Under construction 7/25/2022
  extends TRANSFORM.Media.Interfaces.Solids.PartialSimpleAlloy(
    mediumName="GenericSolid",
    T_min=273.15,
    T_max=1100);
  constant Modelica.Units.SI.Temperature T_melt = 450+273.15;
  constant Modelica.Units.SI.Temperature T_meltmin = T_melt - 4.0;
  constant Modelica.Units.SI.Temperature T_meltplus = T_melt + 4.0;
 // constant Modelica.Units.SI.Temperature T_meltmin = T_melt - 1.5;
 // constant Modelica.Units.SI.Temperature T_meltplus = T_melt + 1.5;

  constant Real m1(unit = "J/(kg.K.K)") = 0.194;
                                                 //Linear slope for Cp function at T<T_melt (solid)
  constant Real b1(unit = "J/(kg.K)") = 652.128;
                                                 //Cp at T=0, y-intercept value for solid state
  constant Real m3(unit = "J/(kg.K.K)") = -0.194;
                                                  //Linear slope for Cp function at T>T_melt (liquid)
  constant Real b3(unit = "J/(kg.K)") = 1188.57;
                                                 //y-intercept during liquid state
  constant Real h_melt(unit = "J/kg") = 310000;
                                                //latent heat of fusion
  constant Real fT(unit = "1/K") = 2*Modelica.Constants.pi/(T_meltplus-T_meltmin);
                                                                                   //New constant

  redeclare function extends specificEnthalpy
    "Specific enthalpy"

  protected
      Real a(unit = "J/(kg.K.K.K)");
      Real b(unit = "J/(kg.K.K)");
      Real c(unit = "J/(kg.K)");
      Real d(unit = "J/(kg.K)");
      Real e(unit = "J/(kg.K)");

      parameter Real A_mat[5,5] = {{T_meltmin^2,T_meltmin,sin(fT*T_meltmin), cos(fT*T_meltmin),1},
                              {T_meltplus^2, T_meltplus, sin(fT*T_meltplus), cos(fT*T_meltplus),1},
                              {2*T_meltmin,1,fT*cos(fT*T_meltmin),-fT*sin(fT*T_meltmin),0},
                              {2*T_meltplus,1,fT*cos(fT*T_meltplus),-fT*sin(fT*T_meltmin),0},
                              {(T_meltplus^3-T_meltmin^3)/3,(T_meltplus^2-T_meltmin^2)/2,-cos(fT*T_meltplus)/fT+cos(fT*T_meltmin)/fT,sin(fT*T_meltplus)/fT-sin(fT*T_meltmin)/fT,T_meltplus-T_meltmin}};
      parameter Real b_mat[5] = {m1*T_meltmin+b1,m3*T_meltplus+b3, m1, m3, m1*(T_melt*T_melt-T_meltmin*T_meltmin)/2+b1*(T_melt-T_meltmin)+m3*(T_meltplus*T_meltplus-T_melt*T_melt)/2+b3*(T_melt-T_meltplus)+h_melt};
      Real x_mat[5];

      Modelica.Units.SI.Temperature dTmelt = T_meltplus-T_meltmin;
      Modelica.Units.SI.Temperature Tuse;
  algorithm
      x_mat := Modelica.Math.Matrices.solve(A_mat,b_mat);
      a := x_mat[1];
      b := x_mat[2];
      c := x_mat[3];
      d := x_mat[4];
      e := x_mat[5];
      Tuse:=min(max(state.T,T_meltmin),T_meltplus);
      h := h_melt*(Tuse-T_meltmin)/dTmelt+m1/2*min(T_melt^2,state.T^2)+b1*min(T_melt,state.T)+m3/2*(max(T_melt^2,state.T^2)-T_melt^2)+b3*(max(T_melt,state.T)-T_melt);
      if state.T<T_meltmin then
        h := m1*state.T*state.T + b1*state.T;
      elseif state.T>T_meltplus then
        h := m3*(state.T*state.T-T_meltplus*T_meltplus)+b3*(state.T-T_meltplus) + a*(T_meltplus^3-T_meltmin^3)/3+b*(T_meltplus^2-T_meltmin^2)/2+c/fT*(cos(fT*T_meltmin)-cos(fT*T_meltplus))+d/fT*(sin(fT*T_meltplus)-sin(fT*T_meltmin))+e*(T_meltplus-T_meltmin)+m1*T_meltmin*T_meltmin+b1*T_meltmin;
      else
        h := a*(state.T^3-T_meltmin^3)/3+b*(state.T^2-T_meltmin^2)/2+c/fT*(cos(fT*T_meltmin)-cos(fT*state.T))+d/fT*(sin(fT*state.T)-sin(fT*T_meltmin))+e*(state.T-T_meltmin)+m1*T_meltmin*T_meltmin+b1*T_meltmin;
     end if;
  end specificEnthalpy;

  redeclare function extends density
    "Density"
  protected
    Modelica.Units.SI.Density solid;
    Modelica.Units.SI.Density liquid;
  algorithm
    solid := 2380;
    liquid := 2380;
    d := 0.5*(Modelica.Math.tanh(2*Modelica.Constants.pi*(state.T-T_melt)/(T_meltplus-T_meltmin))+1)*liquid + 0.5*(Modelica.Math.tanh(-2*Modelica.Constants.pi*(state.T-T_melt)/(T_meltplus-T_meltmin))+1)*solid;
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity"
  protected
    Modelica.Units.SI.ThermalConductivity solid;
    Modelica.Units.SI.ThermalConductivity liquid;
  algorithm
    //solid := -0.00536*state.T + 112; //20?
   // solid := -0.08823529*state.T + 142.925;
   // liquid := -0.04*state.T+78.926;
    solid := -0.08823529*state.T + 112.925;
    liquid := -0.04*state.T+53.926;
    //liquid :=-0.00536*state.T + 111.7;
    lambda := 0.5*(Modelica.Math.tanh(2*Modelica.Constants.pi*(state.T-T_melt)/(T_meltplus-T_meltmin))+1)*liquid + 0.5*(Modelica.Math.tanh(-2*Modelica.Constants.pi*(state.T-T_melt)/(T_meltplus-T_meltmin))+1)*solid;
  end thermalConductivity;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity"
  protected
      Real a(unit = "J/(kg.K.K.K)");
      Real b(unit = "J/(kg.K.K)");
      Real c(unit = "J/(kg.K)");
      Real d(unit = "J/(kg.K)");
      Real e(unit = "J/(kg.K)");
    parameter Real A_mat[5,5] = {{T_meltmin^2,T_meltmin,sin(fT*T_meltmin), cos(fT*T_meltmin),1},
                              {T_meltplus^2, T_meltplus, sin(fT*T_meltplus), cos(fT*T_meltplus),1},
                              {2*T_meltmin,1,fT*cos(fT*T_meltmin),-fT*sin(fT*T_meltmin),0},
                              {2*T_meltplus,1,fT*cos(fT*T_meltplus),-fT*sin(fT*T_meltmin),0},
                              {(T_meltplus^3-T_meltmin^3)/3,(T_meltplus^2-T_meltmin^2)/2,-cos(fT*T_meltplus)/fT+cos(fT*T_meltmin)/fT,sin(fT*T_meltplus)/fT-sin(fT*T_meltmin)/fT,T_meltplus-T_meltmin}};
        parameter Real b_mat[5] = {m1*T_meltmin+b1,m3*T_meltplus+b3, m1, m3, m1*(T_melt*T_melt-T_meltmin*T_meltmin)/2+b1*(T_melt-T_meltmin)+m3*(T_meltplus*T_meltplus-T_melt*T_melt)/2+b3*(T_melt-T_meltplus)+h_melt};
      Real x_mat[5];

      Modelica.Units.SI.Temperature dTmelt = T_meltplus-T_meltmin;

  algorithm
      x_mat := Modelica.Math.Matrices.solve(A_mat,b_mat);
      a := x_mat[1];
      b := x_mat[2];
      c := x_mat[3];
      d := x_mat[4];
      e := x_mat[5];
      if state.T<T_meltmin then
        cp := m1*state.T+b1;
      elseif state.T>T_meltplus then
        cp := m3*state.T+b3;
      else
        cp := a*state.T^2+b*state.T+c*sin(fT*state.T)+d*cos(fT*state.T)+e;
      end if;
  end specificHeatCapacityCp;

    redeclare function extends linearExpansionCoefficient
    "Linear expansion coefficient"
  protected
              Real solid(unit = "1/K") = 0;
              Real liquid(unit = "1/K") = 2.2e-5;
    algorithm
    alpha := 0.5*(Modelica.Math.tanh(Modelica.Constants.pi*(state.T-T_meltmin)/(T_meltplus-T_melt))+1)*liquid;
    end linearExpansionCoefficient;
end PCM_HITB_2_Sin;
