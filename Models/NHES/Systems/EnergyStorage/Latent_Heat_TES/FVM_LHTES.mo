within NHES.Systems.EnergyStorage.Latent_Heat_TES;
model FVM_LHTES
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy CS, redeclare replaceable ED_Dummy ED, redeclare Data.Data_Dummy data);
  import SIunits =
         Modelica.Units.SI;
  replaceable package HTF = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium
  annotation(choicesAllMatching=True);

  //Configuration parameters
  parameter SIunits.Length Length = 0.5; //Length of tube in m
  parameter SIunits.Length ThicknessF = 0.05;  //Thickness of HTF in m
  parameter SIunits.Length ThicknessT = 0.025; //Thickness of Tube in m
  parameter SIunits.Length ThicknessP = 0.025; //Thickness of Tube in m

  //Nodal definition
  parameter Integer zf = 25;//number of nodes in axial direction for the HTF
  parameter Integer rf = 12;//number of nodes in radial direction for the HTF

  parameter Integer zt=25; //number of nodes in axial direction for the tube
  parameter Integer rt=12; //number of nodes in radial direction for the tube

  parameter Integer zp=25; //number of nodes in axial direction for the PCM
  parameter Integer rp=12; //number of nodes in radial direction for the PCM

  //Fluid properties (water)
  SIunits.Density rho_f[zf,rf];   //Fluid density
  SIunits.SpecificHeatCapacity cp_f[zf,rf];  //specific heat
  SIunits.ThermalConductivity k_f[zf,rf];  //conductivity
  SIunits.ThermalDiffusivity alp_f[zf,rf] = k_f./ (rho_f .* cp_f);  //Thermal diffusivity
  HTF.ThermodynamicState state[zf,rf]; //thermodynamic state at each node

  //Metal properties
  parameter SIunits.Density rho_t = 8027;  //Fluid density
  parameter SIunits.SpecificHeatCapacity cp_t = 502.1; //specific heat
  parameter SIunits.ThermalConductivity k_t = 16.3; //conductivity
  SIunits.ThermalDiffusivity alp_t = k_t/(rho_t*cp_t);   //Thermal diffusivity

  //PCM properties
  parameter SIunits.Density rho_p = 829;  //water density
  parameter SIunits.SpecificHeatCapacity cp_p = 2480; //specific heat
  parameter SIunits.ThermalConductivity k_p = 0.21; //conductivity
  parameter SIunits.ThermalDiffusivity alp_p = k_p/(rho_p*cp_p);   //Thermal diffusivity
  parameter SIunits.Temperature T_melt_pcm = 328.15;   //Melting temperature of PCM
  parameter SIunits.Temperature T_ref = 293.15;   //Melting temperature of PCM
  parameter SIunits.SpecificEnthalpy h_fus = 228000;  //Enthalpy of fusion

  //Inlet velocity
  SIunits.Velocity u_in; //Inlet velocity in m/s calculated based on mass flow rate input

  //Computed parameters
  SIunits.Length dzf = Length/zf;   //Nodal spacing in the axial for HTF
  SIunits.Length drf = ThicknessF/rf;  //Nodal spacing in the radial for HTF

  SIunits.Length dzt = Length/zt;  //Nodal spacing in the axial for Tube
  SIunits.Length drt = ThicknessT/rt;  //Nodal spacing in the radial for Tube

  SIunits.Length dzp = Length/zp;  //Nodal spacing in the axial for PCM
  SIunits.Length drp = ThicknessP/rp;  //Nodal spacing in the radial for PCM

  //Interface thermal conductivities
  SIunits.ThermalConductivity k_ft_int[zf,1];
  SIunits.ThermalConductivity k_tp_int = (2*k_p*k_t)/(k_p+k_t);

  //Heat gain or loss from the PCM boundary (this is useful primarily for single tube cases)
  parameter SIunits.Power Q = 0; //Heat addition/loss to/from PCM at the outer boundary

  //Array and Vector Definition
  SIunits.Temperature Th[zf,rf]; //Nodal temperatures
  SIunits.Temperature Tt[zt,rt]; //Nodal temperatures
  SIunits.Temperature Tp[zp,rp]; //Nodal temperatures
  SIunits.Temperature T_HTF_outlet;//Nodal temperatures
  SIunits.Enthalpy Hp[zp,rp]; //Enthalpy of PCM
  SIunits.SpecificEnthalpy h_in;//Fluid inlet enthalpy
  SIunits.Temperature Tin;//Fluid inlet temperature
  SIunits.Length rnf[rf], rsf[rf], rnt[rt], rst[rt], rnp[rp], rsp[rp];

  //Defining vectors
  SIunits.Length rof[rf], rot[rt], rop[rp];   //vector of radial positions: Length based on number of radial nodes
  SIunits.Velocity uj[rf]; //vector of radial velocities

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = HTF)
    annotation (Placement(transformation(extent={{-108,-10},{-92,8}}),
        iconTransformation(extent={{-108,-10},{-92,8}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_b(redeclare package Medium = HTF) annotation (Placement(
        transformation(extent={{92,-8},{108,10}}), iconTransformation(extent={{92,-8},
            {108,10}})));
initial equation
  Th[:,:] = fill(293.15,zf,rf);
  Tt[:,:] = fill(293.15,zt,rt);
  Tp[:,:] = fill(293.15,zp,rp);
  Hp[:,:] = fill(0,zp,rp);

equation

    //port equations
  port_a.p = port_b.p; //Assuming no pressure drop across the system
  port_a.m_flow = u_in*sum(rho_f[1,:])*3.14*ThicknessF^2/4;  //Mass flow rate based
  port_a.h_outflow = h_in;  //Inlet enthalpy of the HTF
  h_in=inStream(port_a.h_outflow);

  port_b.h_outflow = port_b.Medium.specificEnthalpy_pTX(port_b.p,sum(Th[zf,:])/rf,port_b.Medium.X_default); //Outlet enthalpy of the HTF
  port_b.m_flow+port_a.m_flow=0;  //Continuity equation (Mass balance)

  // Transport of substances
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  //Calculating the HTF thermophysical properties over the entire domain
  for i in 1:zf loop
    for j in 1:rf loop
      state[i,j]=HTF.setState_pT(port_a.p,Th[i,j]);
      rho_f[i,j]=HTF.density_pT(port_a.p,Th[i,j]);
      cp_f[i,j]=HTF.specificHeatCapacityCp(state[i,j]);
      k_f[i,j]=HTF.thermalConductivity(state[i,j]);
    end for;
  end for;

  //Inlet velocity profile of the HTF
  for j in 1:rf loop
    rof[j] =(2*j - 1)*drf/2;
    uj[j] = 2*u_in*(1 - (rof[j]/ThicknessF)^2);
    rnf[j] = rof[j] + drf/2;
    rsf[j] = rof[j] - drf/2;
  end for;

  Tin=HTF.temperature_ph(port_a.p,h_in); //Inlet temperature

//The following is a finite volume method-based code, which utilizes the discretized energy equation on all of the three domains, namely, the HTF, tube wall, and the PCM.
// The methodology followed to discretize the problem domain can be found in the book "Numerical methods for partial differential equations: finite difference and finite volume methods" by Sandip Mazumder.

//*************************************************************************************************************************************************
//*************************************************************************************************************************************************
// This section of the code is for the heat transfer fluid
//*************************************************************************************************************************************************
//*************************************************************************************************************************************************

  //Interior cells
  for i in 2:zf-1 loop
    for j in 2:rf-1 loop

      der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f[i,j]*(rnf[j] + rsf[j])*dzf/
        drf + 2*alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f[i,j]*
        rnf[j]*dzf/drf) + Th[i, j - 1]*(alp_f[i,j]*rsf[j]*dzf/drf) + Th[i + 1, j]*(
        alp_f[i,j]*rof[j]*drf/dzf) + Th[i - 1, j]*(alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[
        j]*drf));

    end for;
  end for;

  //Inlet cells
  for i in 1:1 loop
    for j in 2:rf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f[i,j]*(rnf[j] + rsf[j])*dzf/drf +
      4*alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f[i,j]*rnf[j]*
      dzf/drf) + Th[i, j - 1]*(alp_f[i,j]*rsf[j]*dzf/drf) + Th[i + 1, j]*(alp_f[i,j]*4/3*
      rof[j]*drf/dzf) + Tin*((8/3*alp_f[i,j]/dzf + uj[j])*rof[j]*drf));

    end for;
  end for;

  //Outlet cells
  for i in zf:zf loop
    for j in 2:rf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f[i,j]*(rnf[j] + rsf[j])*dzf/drf +
      alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f[i,j]*rnf[j]*dzf/
      drf) + Th[i, j - 1]*(alp_f[i,j]*rsf[j]*dzf/drf) + Th[i - 1, j]*(alp_f[i,j]*rof[j]*
      drf/dzf + uj[j]*rof[j]*drf));

    end for;
  end for;

  //Centerline cells
  for j in 1:1 loop
    for i in 2:zf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f[i,j]*rnf[j]*dzf/drf + 2*alp_f[i,j]*
      rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f[i,j]*rnf[j]*dzf/drf) +
      Th[i + 1, j]*(alp_f[i,j]*rof[j]*drf/dzf) + Th[i - 1, j]*(alp_f[i,j]*rof[j]*drf/dzf +
      uj[j]*rof[j]*drf));

    end for;
  end for;

  //Inlet bottom corner
  for i in 1:1 loop
    for j in 1:1 loop

  der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f[i,j]*rnf[j]*dzf/drf + 4*alp_f[i,j]*
    rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f[i,j]*rnf[j]*dzf/drf) +
    Th[i + 1, j]*(4/3*alp_f[i,j]*rof[j]*drf/dzf) + Tin*(8/3*alp_f[i,j]*rof[j]*drf/dzf +
    uj[j]*rof[j]*drf));

    end for;
  end for;

    //Outlet bottom corner
  for i in zf:zf loop
    for j in 1:1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f[i,j]*rnf[j]*dzf/drf + alp_f[i,j]*
    rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f[i,j]*rnf[j]*dzf/drf) +
    Th[i - 1, j]*(alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf));

    end for;
  end for;

  //HTF - Tube Wall interface
  //Interface thermal conductivity
  for i in 1:zf loop
    k_ft_int[i,1] = (2*k_t*k_f[i,rf])/(k_t+k_f[i,rf]);
  end for;

  for j in rf:rf loop
    for i in 2:zf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(k_ft_int[i,1]/(rho_f[i,j]*cp_f[i,j])*rnf[j]*dzf/(drf/2+drt/2) + alp_f[i,j]*rsf[j]*dzf/drf
     + 2*alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf)+ Th[i, j - 1]*(alp_f[i,j]*rsf[j]*dzf/drf) + Th[i + 1, j]*(alp_f[i,j]*rof[j]*
      drf/dzf) + Th[i - 1, j]*(alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Tt[i,1]*(rnf[j]*k_ft_int[i,1]/(rho_f[i,j]*cp_f[i,j])*dzf/(drf/2 + drt/2)));

    end for;
  end for;

   //Inlet top corner
  for i in 1:1 loop
    for j in rf:rf loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(k_ft_int[i,1]/(rho_f[i,j]*cp_f[i,j])*rnf[j]*dzf/(drf/2+drt/2)
    + alp_f[i,j]*rsf[j]*dzf/drf + 4*alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf)
     + Th[i, j - 1]*(alp_f[i,j]*rsf[j]*dzf/drf) + Th[i + 1, j]*(4/3*alp_f[i,j]*rof[j]*drf/
    dzf) + Tin*(8/3*alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Tt[i,1]*(rnf[j]*k_ft_int[i,1]/(rho_f[i,j]*cp_f[i,j])*dzf/(drf/2 + drt/2)));

    end for;
  end for;

   //Outlet top corner
  for i in zf:zf loop
    for j in rf:rf loop

  der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(k_ft_int[i,1]/(rho_f[i,j]*cp_f[i,j])*rnf[j]*dzf/(drf/2+drt/2)
    + alp_f[i,j]*rsf[j]*dzf/drf + alp_f[i,j]*rof[j]*drf/dzf + uj[j]*rof[j]*drf) +
    Th[i, j - 1]*(alp_f[i,j]*rsf[j]*dzf/drf) + Th[i - 1, j]*(alp_f[i,j]*rof[j]*drf/dzf +
    uj[j]*rof[j]*drf) + Tt[i,1]*(rnf[j]*k_ft_int[i,1]/(rho_f[i,j]*cp_f[i,j])*dzf/(drf/2 + drt/2)));

    end for;
  end for;

  //Outlet HTF temperature
  T_HTF_outlet=sum(Th[zf,:])/rf;

//*************************************************************************************************************************************************
//*************************************************************************************************************************************************
// This section of the code is for the tube wall
//*************************************************************************************************************************************************
//*************************************************************************************************************************************************

  for j in 1:rt loop
    rot[j] = ThicknessF + (2*j - 1)*drt/2;
    rnt[j] = rot[j] + drt/2;
    rst[j] = rot[j] - drt/2;
  end for;

    //Interior cells
  for j in 2:rt-1 loop
    for i in 2:zt-1 loop

      der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*(rnt[j] + rst[j])*dzt/
        drt + 2*alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[
        i, j - 1]*(alp_t*rst[j]*dzt/drt) + Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt) +
        Tt[i - 1, j]*(alp_t*rot[j]*drt/dzt));
    end for;
  end for;

  //Left boundary
  for i in 1:1 loop
      for j in 2:rt-1 loop

    der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*(rnt[j] + rst[j])*dzt/drt +
      alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i, j - 1]*
      (alp_t*rst[j]*dzt/drt) + Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt));

    end for;
  end for;

  //Right boundary
  for i in zt:zt loop
    for j in 2:rt-1 loop

    der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*(rnt[j] + rst[j])*dzt/drt +
      alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i, j - 1]*
      (alp_t*rst[j]*dzt/drt) + Tt[i - 1, j]*(alp_t*rot[j]*drt/dzt));

    end for;
  end for;

  //Tube Wall - HTF Interface
  for j in 1:1 loop
    for i in 2:zt-1 loop

    der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*rnt[j]*dzt/drt + k_ft_int[i,1]/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)
     + 2*alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt) + Tt[i - 1,
      j]*(alp_t*rot[j]*drt/dzt) + Th[i, rf]*(k_ft_int[i,1]/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)));

    end for;
  end for;

  //Tube bottom inlet corner
  for i in 1:1 loop
    for j in 1:1 loop

  der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*rnt[j]*dzt/drt + k_ft_int[i,1]/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)
     + alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt)
     + Th[i, rf]*(k_ft_int[i,1]/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)));

    end for;
  end for;

  //Tube bottom right corner
  for i in zt:zt loop
    for j in 1:1 loop

  der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*rnt[j]*dzt/drt + k_ft_int[i,1]/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)
     + alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i -
    1, j]*(alp_t*rot[j]*drt/dzt) + Th[i, rf]*(k_ft_int[i,1]/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)));

    end for;
  end for;

  //Tube Wall - PCM Interface
  for j in rt:rt loop
    for i in 2:zt-1 loop

    der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(k_tp_int/(rho_t*cp_t)*rnt[j]*dzt/(drt/2 + drp/2)
     +alp_t*rst[j]*dzt/drt + 2*alp_t*rot[j]*drt/dzt) + Tt[i, j - 1]*(alp_t*rst[j]*dzt/
      drt) + Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt) + Tt[i - 1, j]*(alp_t*rot[j]*drt/dzt)
      + Tp[i, 1]*(k_tp_int/(rho_t*cp_t)*rnt[j]*dzt/(drt/2 + drp/2)));

    end for;
  end for;

  //Inlet top cornter
  for i in 1:1 loop
    for j in rt:rt loop

    der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(k_tp_int/(rho_t*cp_t)*rnt[j]*dzt/(drt/2 + drp/2)
     +alp_t*rst[j]*dzt/drt + alp_t*rot[j]*drt/dzt) + Tt[i, j - 1]*(alp_t*rst[j]*dzt/drt) +
    Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt) + Tp[i, 1]*(k_tp_int/(rho_t*cp_t)*rnt[j]*dzt/(drt/2 + drp/2)));

     end for;
  end for;

  //Outlet top corner
  for i in zt:zt loop
    for j in rt:rt loop

    der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(k_tp_int/(rho_t*cp_t)*rnt[j]*dzt/(drt/2 + drp/2)
     +alp_t*rst[j]*dzt/drt + alp_t*rot[j]*drt/dzt) + Tt[i, j - 1]*(alp_t*rst[j]*dzt/drt) +
    Tt[i - 1, j]*(alp_t*rot[j]*drt/dzt) + Tp[i, 1]*(k_tp_int/(rho_t*cp_t)*rnt[j]*dzt/(drt/2 + drp/2)));

    end for;
  end for;

//*************************************************************************************************************************************************
//*************************************************************************************************************************************************
// This section of the code is for PCM.
// It should be noted that the energy equation herein in enthalpy based, as phase change is assumed to be isothermal.
//*************************************************************************************************************************************************
//*************************************************************************************************************************************************

  for j in 1:rp loop
    rop[j] = ThicknessF + ThicknessT + (2*j - 1)*drp/2;
    rnp[j] = rop[j] + drp/2;
    rsp[j] = rop[j] - drp/2;
  end for;

    //Interior cells
  for j in 2:rp-1 loop
    for i in 2:zp-1 loop

      der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(-Hp[i, j]*(alp_p*(rnp[j] + rsp[j])*dzp/
        drp + 2*alp_p*rop[j]*drp/dzp) + Hp[i, j + 1]*(alp_p*rnp[j]*dzp/drp) + Hp[
        i, j - 1]*(alp_p*rsp[j]*dzp/drp) + Hp[i + 1, j]*(alp_p*rop[j]*drp/dzp) +
        Hp[i - 1, j]*(alp_p*rop[j]*drp/dzp));

    end for;
  end for;

  //Left boundary
  for i in 1:1 loop
      for j in 2:rp-1 loop

    der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(-Hp[i, j]*(alp_p*(rnp[j] + rsp[j])*dzp/drp +
      alp_p*rop[j]*drp/dzp) + Hp[i, j + 1]*(alp_p*rnp[j]*dzp/drp) + Hp[i, j - 1]*
      (alp_p*rsp[j]*dzp/drp) + Hp[i + 1, j]*(alp_p*rop[j]*drp/dzp));

    end for;
  end for;

  //Right boundary
  for i in zp:zp loop
    for j in 2:rp-1 loop

    der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(-Hp[i, j]*(alp_p*(rnp[j] + rsp[j])*dzp/drp +
      alp_p*rop[j]*drp/dzp) + Hp[i, j + 1]*(alp_p*rnp[j]*dzp/drp) + Hp[i, j - 1]*
      (alp_p*rsp[j]*dzp/drp) + Hp[i - 1, j]*(alp_p*rop[j]*drp/dzp));

    end for;
  end for;

//PCM top wall
  for j in rp:rp loop
    for i in 2:zp-1 loop

    der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(alp_p*rnp[j]*dzp*Q*cp_p/k_p - Hp[i, j]*(alp_p*
      rsp[j]*dzp/drp + 2*alp_p*rop[j]*drp/dzp) + Hp[i, j - 1]*(alp_p*rsp[j]*dzp/
      drp) + Hp[i + 1, j]*(alp_p*rop[j]*drp/dzp) + Hp[i - 1, j]*(alp_p*rop[j]*
      drp/dzp));

    end for;
  end for;

  //Inlet top cornper
  for i in 1:1 loop
    for j in rp:rp loop

    der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(alp_p*rnp[j]*dzp*Q*cp_p/k_p - Hp[i, j]*(alp_p*
    rsp[j]*dzp/drp + alp_p*rop[j]*drp/dzp) + Hp[i, j - 1]*(alp_p*rsp[j]*dzp/drp) +
    Hp[i + 1, j]*(alp_p*rop[j]*drp/dzp));

     end for;
  end for;

  //Outlet top cornper
  for i in zp:zp loop
    for j in rp:rp loop

    der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(alp_p*rnp[j]*dzp*Q*cp_p/k_p - Hp[i, j]*(alp_p*
    rsp[j]*dzp/drp + alp_p*rop[j]*drp/dzp) + Hp[i, j - 1]*(alp_p*rsp[j]*dzp/drp) +
    Hp[i - 1, j]*(alp_p*rop[j]*drp/dzp));

    end for;
  end for;

//PCM - Tube Wall Interface
  for j in 1:1 loop
    for i in 2:zp-1 loop

    der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(-Hp[i, j]*(alp_p*rnp[j]*dzp/drp + 2*alp_p*rop[j]*drp/dzp)
     + Hp[i, j + 1]*(alp_p*rnp[j]*dzp/drp) + Hp[i + 1, j]*(alp_p*rop[j]*drp/dzp)
     + Hp[i - 1,j]*(alp_p*rop[j]*drp/dzp) - rsp[j]*(k_tp_int/rho_p)*(Tp[i,j] - Tt[i,rt])*dzp/(drp/2 + drt/2));

    end for;
  end for;

  //PCM bottom inlet corner
  for i in 1:1 loop
    for j in 1:1 loop

  der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(-Hp[i, j]*(alp_p*rnp[j]*dzp/drp + 2*alp_p*rop[j]*drp/dzp)
    + Hp[i, j + 1]*(alp_p*rnp[j]*dzp/drp) + Hp[i + 1, j]*(alp_p*rop[j]*drp/dzp)
     - rsp[j]*(k_tp_int/rho_p)*(Tp[i,j] - Tt[i,rt])*dzp/(drp/2 + drt/2));

    end for;
  end for;

  //PCM bottom right corner
  for i in zp:zp loop
    for j in 1:1 loop

  der(Hp[i,j]) =1/(rop[j]*drp*dzp)*(-Hp[i, j]*(alp_p*rnp[j]*dzp/drp + 2*alp_p*rop[j]*drp/dzp)
     + Hp[i, j + 1]*(alp_p*rnp[j]*dzp/drp) + Hp[i -1, j]*(alp_p*rop[j]*drp/dzp)
      - rsp[j]*(k_tp_int/rho_p)*(Tp[i,j] - Tt[i,rt])*dzp/(drp/2 + drt/2));

    end for;
  end for;

  //Loop to convert the enthalpy information back to temperature
  for i in 1:zp loop
    for j in 1:rp loop

      if Hp[i,j] <= cp_p*(T_melt_pcm - T_ref) then
        Tp[i,j] = Hp[i,j]/cp_p + T_ref;
      elseif cp_p*(T_melt_pcm - T_ref) < Hp[i,j] and Hp[i,j] <= cp_p*(T_melt_pcm - T_ref) + h_fus then
        Tp[i,j] = T_melt_pcm;
      else
        Tp[i,j] = (Hp[i,j] - (cp_p*(T_melt_pcm - T_ref) + h_fus))/cp_p + T_melt_pcm;
      end if;

    end for;
  end for;

  annotation (experiment(StopTime=5, __Dymola_Algorithm="Esdirk45a"),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
        <p>This is a base model for a latent heat thermal energy storage system capable of simulating charging and discharging cycles. The code is based on the finite volume method and makes the following assumptions for simplification.</p>
        <p>1. The problem domain is axisymmetric  i.e. no variations in the azimuthal directions, and the outer boundary of the PCM is adiabatic</p>
        <p>2. The heat transfer fluid is incompressible and fully developed within the tubes, thereby allowing one to ignore the continuity and momentum equations</p>
        <p>3. The PCM is homogeneous and the mode of heat transfer within the PCM is pure conduction</p>
        <p>4. The initial temperature of the problem is uniform</p>
        <p></p>
</html>"));
end FVM_LHTES;
