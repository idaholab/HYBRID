within NHES.Systems.EnergyStorage.Latent_Heat_TES.Components;
model Generic_LHTES_AS
  import SIunits =
         Modelica.Units.SI;
  //Configuration parameters
  parameter SIunits.Length Length = 8*0.0254; //Length of tube in m
  parameter SIunits.Length ThicknessF = 0.097*0.0254;  //Thickness of HTF in m
  parameter SIunits.Length ThicknessT = 0.028*0.0254; //Thickness of Tube in m
  parameter SIunits.Length ThicknessP = 0.25*0.0254; //Thickness of Tube in m

  //Nodal definition
  parameter Integer zf = 50;//number of nodes in axial direction for the HTF
  parameter Integer rf = 10;//number of nodes in radial direction for the HTF

  parameter Integer zt=50; //number of nodes in axial direction for the tube
  parameter Integer rt=5; //number of nodes in radial direction for the tube

  parameter Integer zp=50; //number of nodes in axial direction for the PCM
  parameter Integer rp=10; //number of nodes in radial direction for the PCM

  //Fluid properties (water)
  parameter SIunits.Density rho_f = 1000;  //Fluid density
  parameter SIunits.SpecificHeatCapacity cp_f = 4200;  //specific heat
  parameter SIunits.ThermalConductivity k_f = 0.613;  //conductivity
  parameter SIunits.ThermalDiffusivity alp_f = k_f / (rho_f * cp_f);  //Thermal diffusivity

  //Metal properties (Stainless steel)
  parameter SIunits.Density rho_t = 8027;  //Fluid density
  parameter SIunits.SpecificHeatCapacity cp_t = 502.1; //specific heat
  parameter SIunits.ThermalConductivity k_t = 16.3; //conductivity
  parameter SIunits.ThermalDiffusivity alp_t = k_t/(rho_t*cp_t);   //Thermal diffusivity

  //PCM properties (Paraffin wax)
  parameter SIunits.Density rho_p = 829;  //water density
  parameter SIunits.SpecificHeatCapacity cp_p = 2480; //specific heat
  parameter SIunits.ThermalConductivity k_p = 0.21; //conductivity
  parameter SIunits.ThermalDiffusivity alp_p = k_p/(rho_p*cp_p);   //Thermal diffusivity
  parameter SIunits.Temperature T_melt_pcm = 328.15;   //Melting temperature of PCM
  parameter SIunits.Temperature T_ref = 294.15;   //Melting temperature of PCM
  parameter SIunits.SpecificEnthalpy h_fus = 228000;  //Enthalpy of fusion

  //Inlet velocity
  parameter SIunits.Velocity u_in = 0.1; //Inlet velocity in m/s

  //Computed parameters
  parameter SIunits.Length dzf = Length/zf;   //Nodal spacing in the axial for HTF
  parameter SIunits.Length drf = ThicknessF/rf;  //Nodal spacing in the radial for HTF

  parameter SIunits.Length dzt = Length/zt;  //Nodal spacing in the axial for Tube
  parameter SIunits.Length drt = ThicknessT/rt;  //Nodal spacing in the radial for Tube

  parameter SIunits.Length dzp = Length/zp;  //Nodal spacing in the axial for PCM
  parameter SIunits.Length drp = ThicknessP/rp;  //Nodal spacing in the radial for PCM

  //Interface thermal conductivities
  parameter SIunits.ThermalConductivity k_ft_int = (2*k_t*k_f)/(k_t+k_f);
  parameter SIunits.ThermalConductivity k_tp_int = (2*k_p*k_t)/(k_p+k_t);

  parameter SIunits.Power Q = 0;  //External flux to the PCM

  //Define counters
  //Integer i,j;

  //Array and Vector Definition
  SIunits.Temperature Th[zf,rf];
                              //Nodal temperatures
  SIunits.Temperature Tt[zt,rt];
                              //Nodal temperatures
  SIunits.Temperature Tp[zp,rp];
                              //Nodal temperatures
  SIunits.Enthalpy Hp[zp,rp]; //Enthalpy of PCM
  SIunits.Temperature Tin=360;//Fluid inlet temperature (this will have to be modified for solidification)
  SIunits.Length rnf[rf], rsf[rf], rnt[rt], rst[rt], rnp[rp], rsp[rp];

  //The 2 commands below need to be used for solidifcation
  //SIunits.Temp_K T_high = 360;
  //SIunits.SpecificEnthalpy Hp_solid = cp_p*(T_high - T_melt_pcm) + h_fus + cp_p*(T_melt_pcm - Tin);

  //Defining vectors
  SIunits.Length rof[rf], rot[rt], rop[rp];   //vector of radial positions: Length based on number of radial nodes
  SIunits.Velocity uj[rf]; //vector of radial velocities

  //
  // What this model needs to do to be integrated into the NHES framework:
  // 1) Question why are the HTF itmes nodalized instead of being 1-D averaged equations? We will have to figure out how to connect
  // fluid ports to both ends.
  // 2) What's the long-term capabilities of storing and discharging heat of this model?
  // 3) We'll need to make a Parafin wax media model that can exist in both solid and liquid states.
  // 4) Then we'll need to know about internal liquid movement of the paraffin wax.
  //
initial equation
  Th[:,:] = fill(294.15,zf,rf);
  Tt[:,:] = fill(294.15,zt,rt);
  Hp[:,:] = fill(0,zp,rp);
  //Hp[:,:] = fill(Hp_solid,zp,rp); (Needs to be used for solidification)

equation

//*************************************************************************************************************************************************
//*************************************************************************************************************************************************
// This section of the code is for the heat transfer fluid
//*************************************************************************************************************************************************
//*************************************************************************************************************************************************

  //For loop for the inlet parabolic velocity profile, and locations of cell centers, and north & south faces
  for j in 1:rf loop
    rof[j] =(2*j - 1)*drf/2;
    uj[j] = 2*u_in*(1 - (rof[j]/ThicknessF)^2);
    rnf[j] = rof[j] + drf/2;
    rsf[j] = rof[j] - drf/2;
  end for;

  //Interior cells
  for i in 2:zf-1 loop
    for j in 2:rf-1 loop

      der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f*(rnf[j] + rsf[j])*dzf/
        drf + 2*alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f*
        rnf[j]*dzf/drf) + Th[i, j - 1]*(alp_f*rsf[j]*dzf/drf) + Th[i + 1, j]*(
        alp_f*rof[j]*drf/dzf) + Th[i - 1, j]*(alp_f*rof[j]*drf/dzf + uj[j]*rof[
        j]*drf));

    end for;
  end for;

  //Inlet cells
  for i in 1:1 loop
    for j in 2:rf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f*(rnf[j] + rsf[j])*dzf/drf +
      4*alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f*rnf[j]*
      dzf/drf) + Th[i, j - 1]*(alp_f*rsf[j]*dzf/drf) + Th[i + 1, j]*(alp_f*4/3*
      rof[j]*drf/dzf) + Tin*((8/3*alp_f/dzf + uj[j])*rof[j]*drf));

    end for;
  end for;

  //Outlet cells
  for i in zf:zf loop
    for j in 2:rf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f*(rnf[j] + rsf[j])*dzf/drf +
      alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f*rnf[j]*dzf/
      drf) + Th[i, j - 1]*(alp_f*rsf[j]*dzf/drf) + Th[i - 1, j]*(alp_f*rof[j]*
      drf/dzf + uj[j]*rof[j]*drf));

    end for;
  end for;

  //Centerline cells
  for j in 1:1 loop
    for i in 2:zf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f*rnf[j]*dzf/drf + 2*alp_f*
      rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f*rnf[j]*dzf/drf) +
      Th[i + 1, j]*(alp_f*rof[j]*drf/dzf) + Th[i - 1, j]*(alp_f*rof[j]*drf/dzf +
      uj[j]*rof[j]*drf));

    end for;
  end for;

  //Inlet bottom corner
  for i in 1:1 loop
    for j in 1:1 loop

  der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f*rnf[j]*dzf/drf + 4*alp_f*
    rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f*rnf[j]*dzf/drf) +
    Th[i + 1, j]*(4/3*alp_f*rof[j]*drf/dzf) + Tin*(8/3*alp_f*rof[j]*drf/dzf +
    uj[j]*rof[j]*drf));

    end for;
  end for;

    //Outlet bottom corner
  for i in zf:zf loop
    for j in 1:1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(alp_f*rnf[j]*dzf/drf + alp_f*
    rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Th[i, j + 1]*(alp_f*rnf[j]*dzf/drf) +
    Th[i - 1, j]*(alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf));

    end for;
  end for;

    //HTF - Tube Wall interface
  for j in rf:rf loop
    for i in 2:zf-1 loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(k_ft_int/(rho_f*cp_f)*rnf[j]*dzf/(drf/2+drt/2) + alp_f*rsf[j]*dzf/drf
     + 2*alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf)+ Th[i, j - 1]*(alp_f*rsf[j]*dzf/drf) + Th[i + 1, j]*(alp_f*rof[j]*
      drf/dzf) + Th[i - 1, j]*(alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Tt[i,1]*(rnf[j]*k_ft_int/(rho_f*cp_f)*dzf/(drf/2 + drt/2)));

    end for;
  end for;

   //Inlet top corner
  for i in 1:1 loop
    for j in rf:rf loop

    der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(k_ft_int/(rho_f*cp_f)*rnf[j]*dzf/(drf/2+drt/2)
    + alp_f*rsf[j]*dzf/drf + 4*alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf)
     + Th[i, j - 1]*(alp_f*rsf[j]*dzf/drf) + Th[i + 1, j]*(4/3*alp_f*rof[j]*drf/
    dzf) + Tin*(8/3*alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf) + Tt[i,1]*(rnf[j]*k_ft_int/(rho_f*cp_f)*dzf/(drf/2 + drt/2)));

    end for;
  end for;

   //Outlet top corner
  for i in zf:zf loop
    for j in rf:rf loop

  der(Th[i,j]) =1/(rof[j]*drf*dzf)*(-Th[i, j]*(k_ft_int/(rho_f*cp_f)*rnf[j]*dzf/(drf/2+drt/2)
    + alp_f*rsf[j]*dzf/drf + alp_f*rof[j]*drf/dzf + uj[j]*rof[j]*drf) +
    Th[i, j - 1]*(alp_f*rsf[j]*dzf/drf) + Th[i - 1, j]*(alp_f*rof[j]*drf/dzf +
    uj[j]*rof[j]*drf) + Tt[i,1]*(rnf[j]*k_ft_int/(rho_f*cp_f)*dzf/(drf/2 + drt/2)));

    end for;
  end for;

//*************************************************************************************************************************************************
//*************************************************************************************************************************************************
// This section of the code is for the tube wall
//*************************************************************************************************************************************************
//*************************************************************************************************************************************************

  //Loop for tube domain cell centers, and north & south faces
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

    der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*rnt[j]*dzt/drt + k_ft_int/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)
     + 2*alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt) + Tt[i - 1,
      j]*(alp_t*rot[j]*drt/dzt) + Th[i, rf]*(k_ft_int/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)));

    end for;
  end for;

  //Tube bottom inlet corner
  for i in 1:1 loop
    for j in 1:1 loop

  der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*rnt[j]*dzt/drt + k_ft_int/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)
     + alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i + 1, j]*(alp_t*rot[j]*drt/dzt)
     + Th[i, rf]*(k_ft_int/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)));

    end for;
  end for;

  //Tube bottom right corner
  for i in zt:zt loop
    for j in 1:1 loop

  der(Tt[i,j]) =1/(rot[j]*drt*dzt)*(-Tt[i, j]*(alp_t*rnt[j]*dzt/drt + k_ft_int/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)
     + alp_t*rot[j]*drt/dzt) + Tt[i, j + 1]*(alp_t*rnt[j]*dzt/drt) + Tt[i -
    1, j]*(alp_t*rot[j]*drt/dzt) + Th[i, rf]*(k_ft_int/(rho_t*cp_t)*rst[j]*dzt/(drt/2 + drf/2)));

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
// This section of the code is for PCM
//*************************************************************************************************************************************************
//*************************************************************************************************************************************************

  //Loop for PCM domain cell centers, and north & south faces
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
<p>LHTES model based on the Ph.D. work of Amey Shigrekar. This model does not contain Modelica standard libraries for materials, which will be added in successive iterations of this model until a fully generalized and replaceable model is developed. </p>
</html>"));
end Generic_LHTES_AS;
