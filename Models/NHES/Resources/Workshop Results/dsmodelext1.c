#include <moutil.c>
PreNonAliasDef(6)
PreNonAliasDef(7)
PreNonAliasDef(8)
PreNonAliasDef(9)
PreNonAliasDef(10)
StartNonAlias(5)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD5.port[1].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD5.port[2].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[2, 1]", 1,\
 1, 46, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD5.port[2].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD5.port[3].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 1]", 1,\
 5, 5504, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD5.port[3].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.n", "Output array size [:#(type=Integer)]",\
 4, 0.0,0.0,0.0,0,517)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF_start[1]", \
"Initial shape function, sum(SF) = 1 [1]", 0.25, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF_start[2]", \
"Initial shape function, sum(SF) = 1 [1]", 0.25, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF_start[3]", \
"Initial shape function, sum(SF) = 1 [1]", 0.25, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF_start[4]", \
"Initial shape function, sum(SF) = 1 [1]", 0.25, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.dSF[1]", \
"Change in shape function [1]", 0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.dSF[2]", \
"Change in shape function [1]", 0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.dSF[3]", \
"Change in shape function [1]", 0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.dSF[4]", \
"Change in shape function [1]", 0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF[1]", "Shape function [1]",\
 0.25, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF[2]", "Shape function [1]",\
 0.25, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF[3]", "Shape function [1]",\
 0.25, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.shapeFactor.SF[4]", "Shape function [1]",\
 0.25, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.shapeFactor.u", "Scalar input [W]", \
"nuScale_Tave_enthalpy.sensorBus.Q_total", 1, 5, 155, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.shapeFactor.y[1]", "Shaped array output [W]",\
 "nuScale_Tave_enthalpy.core.fuelModel.Power_in[1]", 1, 5, 5216, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.shapeFactor.y[2]", "Shaped array output [W]",\
 "nuScale_Tave_enthalpy.core.fuelModel.Power_in[2]", 1, 5, 5217, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.shapeFactor.y[3]", "Shaped array output [W]",\
 "nuScale_Tave_enthalpy.core.fuelModel.Power_in[3]", 1, 5, 5218, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.shapeFactor.y[4]", "Shaped array output [W]",\
 "nuScale_Tave_enthalpy.core.fuelModel.Power_in[4]", 1, 5, 5219, 0)
DeclareParameter("nuScale_Tave_enthalpy.core.toggle_ReactivityFP", \
"=true to include fission product reacitivity feedback [:#(type=Boolean)]", 475,\
 true, 0.0,0.0,0.0,0,562)
DeclareVariable("nuScale_Tave_enthalpy.massFlowRate1.allowFlowReversal", \
"= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("nuScale_Tave_enthalpy.massFlowRate1.port_a.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"nuScale_Tave_enthalpy.port_a.m_flow", 1, 5, 173, 132)
DeclareAlias2("nuScale_Tave_enthalpy.massFlowRate1.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1, 1, 121, 4)
DeclareAlias2("nuScale_Tave_enthalpy.massFlowRate1.port_a.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", 1, 1, 122, 4)
DeclareAlias2("nuScale_Tave_enthalpy.massFlowRate1.port_b.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", \
"nuScale_Tave_enthalpy.port_a.m_flow", -1, 5, 173, 132)
DeclareAlias2("nuScale_Tave_enthalpy.massFlowRate1.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1, 1, 121, 4)
DeclareAlias2("nuScale_Tave_enthalpy.massFlowRate1.port_b.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.port_b1.h_outflow", 1, 5, 5723, 4)
DeclareParameter("nuScale_Tave_enthalpy.massFlowRate1.port_a_exposesState", \
"= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]", 476, \
false, 0.0,0.0,0.0,0,2610)
DeclareParameter("nuScale_Tave_enthalpy.massFlowRate1.port_b_exposesState", \
"= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]", 477,\
 false, 0.0,0.0,0.0,0,2610)
DeclareParameter("nuScale_Tave_enthalpy.massFlowRate1.showDesignFlowDirection", \
"= false to hide the arrow in the model icon [:#(type=Boolean)]", 478, true, \
0.0,0.0,0.0,0,2610)
DeclareVariable("nuScale_Tave_enthalpy.massFlowRate1.m_flow_nominal", \
"Nominal value of m_flow = port_a.m_flow [kg/s]", 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.massFlowRate1.m_flow_small", \
"Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.massFlowRate1.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", 1, 5, 173, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CR_reactivity.u", "Value of Real output [1]",\
 "nuScale_Tave_enthalpy.actuatorBus.reactivity_ControlRod", 1, 5, 151, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CR_reactivity.y", "[1]", "nuScale_Tave_enthalpy.actuatorBus.reactivity_ControlRod", 1,\
 5, 151, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Q_total.y", "Value of Real output [W]", \
"nuScale_Tave_enthalpy.sensorBus.Q_total", 1, 5, 155, 0)
DeclareVariable("nuScale_Tave_enthalpy.Secondary_Side_Pressure.port.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", 0, 0.0,\
100000.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.Secondary_Side_Pressure.port.p", \
"Thermodynamic pressure in the connection point [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1,\
 1, 139, 4)
DeclareVariable("nuScale_Tave_enthalpy.Secondary_Side_Pressure.port.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 84013.0581525969, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareAlias2("nuScale_Tave_enthalpy.Secondary_Side_Pressure.p", \
"Pressure at port [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1,\
 1, 139, 0)
DeclareVariable("nuScale_Tave_enthalpy.Steam_exit_enthalpy.port.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", 0, 0.0,\
100000.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.Steam_exit_enthalpy.port.p", \
"Thermodynamic pressure in the connection point [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1,\
 1, 139, 4)
DeclareVariable("nuScale_Tave_enthalpy.Steam_exit_enthalpy.port.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 84013.0581525969, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareVariable("nuScale_Tave_enthalpy.Steam_exit_enthalpy.h_out", \
"Specific enthalpy in port medium [J/kg]", 100000.0, -10000000000.0,\
10000000000.0,500000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Feed_Enthalpy.port.m_flow", \
"Mass flow rate from the connection point into the component [kg/s]", 0, 0.0,\
100000.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.Feed_Enthalpy.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1, 1, 121, 4)
DeclareVariable("nuScale_Tave_enthalpy.Feed_Enthalpy.port.h_outflow", \
"Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 84013.0581525969, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareVariable("nuScale_Tave_enthalpy.Feed_Enthalpy.h_out", "Specific enthalpy in port medium [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareAlias2("EM.CS.actuatorBus.opening_TDV", "TDV fraction open", \
"EM.CS.TDV_opening.k", 1, 7, 480, 4)
DeclareAlias2("EM.CS.actuatorBus.opening_IPDV", "IPDV fraction open", \
"EM.CS.IPDV_opening.k", 1, 7, 481, 4)
DeclareAlias2("EM.CS.actuatorBus.opening_BPDV", "BPDV fraction open", \
"EM.CS.BPDV_opening.k", 1, 7, 482, 4)
DeclareAlias2("EM.CS.actuatorBus.opening_valve_toBOP", "valve_toBOP fraction open",\
 "EM.CS.opening_valve_toBOP.k", 1, 7, 483, 4)
DeclareVariable("EM.CS.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("EM.CS.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareParameter("EM.CS.nPorts_a3", "Number of port_a3 connections [:#(type=Integer)]",\
 479, 0, 0.0,0.0,0.0,0,564)
DeclareVariable("EM.CS.nPorts_b3", "Number of port_b3 connections [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,517)
DeclareParameter("EM.CS.TDV_opening.k", "Constant output value", 480, 0.5, \
0.0,0.0,0.0,0,560)
DeclareAlias2("EM.CS.TDV_opening.y", "Connector of Real output signal", \
"EM.CS.TDV_opening.k", 1, 7, 480, 0)
DeclareParameter("EM.CS.IPDV_opening.k", "Constant output value", 481, 0.5, \
0.0,0.0,0.0,0,560)
DeclareAlias2("EM.CS.IPDV_opening.y", "Connector of Real output signal", \
"EM.CS.IPDV_opening.k", 1, 7, 481, 0)
DeclareParameter("EM.CS.BPDV_opening.k", "Constant output value", 482, 0.5, \
0.0,0.0,0.0,0,560)
DeclareAlias2("EM.CS.BPDV_opening.y", "Connector of Real output signal", \
"EM.CS.BPDV_opening.k", 1, 7, 482, 0)
DeclareParameter("EM.CS.opening_valve_toBOP.k", "Constant output value", 483, 1,\
 0.0,1.0,0.0,0,560)
DeclareAlias2("EM.CS.opening_valve_toBOP.y", "Connector of Real output signal", \
"EM.CS.opening_valve_toBOP.k", 1, 7, 483, 0)
DeclareAlias2("EM.ED.actuatorBus.opening_TDV", "TDV fraction open", \
"EM.CS.TDV_opening.k", 1, 7, 480, 4)
DeclareAlias2("EM.ED.actuatorBus.opening_IPDV", "IPDV fraction open", \
"EM.CS.IPDV_opening.k", 1, 7, 481, 4)
DeclareAlias2("EM.ED.actuatorBus.opening_BPDV", "BPDV fraction open", \
"EM.CS.BPDV_opening.k", 1, 7, 482, 4)
DeclareAlias2("EM.ED.actuatorBus.opening_valve_toBOP", "valve_toBOP fraction open",\
 "EM.CS.opening_valve_toBOP.k", 1, 7, 483, 4)
DeclareVariable("EM.ED.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("EM.ED.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareAlias2("EM.actuatorBus.opening_TDV", "TDV fraction open", \
"EM.CS.TDV_opening.k", 1, 7, 480, 4)
DeclareAlias2("EM.actuatorBus.opening_IPDV", "IPDV fraction open", \
"EM.CS.IPDV_opening.k", 1, 7, 481, 4)
DeclareAlias2("EM.actuatorBus.opening_BPDV", "BPDV fraction open", \
"EM.CS.BPDV_opening.k", 1, 7, 482, 4)
DeclareAlias2("EM.actuatorBus.opening_valve_toBOP", "valve_toBOP fraction open",\
 "EM.CS.opening_valve_toBOP.k", 1, 7, 483, 4)
DeclareVariable("EM.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("EM.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("EM.Q_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.W_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.nPorts_b3", "Number of port_b3 connections [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.port_a1_nominal.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a1_nominal.T", "Temperature [K|degC]", 288.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.port_a1_nominal.h", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a1_nominal.m_flow", "Mass flow rate [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b1_nominal.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b1_nominal.T", "Temperature [K|degC]", 288.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.port_b1_nominal.h", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b1_nominal.m_flow", "Mass flow rate [kg/s]", -70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a2_nominal.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a2_nominal.T", "Temperature [K|degC]", 288.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.port_a2_nominal.h", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a2_nominal.m_flow", "Mass flow rate [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b2_nominal.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b2_nominal.T", "Temperature [K|degC]", 288.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.port_b2_nominal.h", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b2_nominal.m_flow", "Mass flow rate [kg/s]", -70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a1_start.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a1_start.T", "Temperature [K|degC]", 288.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.port_a1_start.h", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("EM.port_a1_start.m_flow", "Mass flow rate [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b1_start.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b1_start.T", "Temperature [K|degC]", 288.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.port_b1_start.h", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("EM.port_b1_start.m_flow", "Mass flow rate [kg/s]", -70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a2_start.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_a2_start.T", "Temperature [K|degC]", 288.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.port_a2_start.h", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("EM.port_a2_start.m_flow", "Mass flow rate [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b2_start.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.port_b2_start.T", "Temperature [K|degC]", 288.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.port_b2_start.h", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("EM.port_b2_start.m_flow", "Mass flow rate [kg/s]", -70.0, \
0.0,0.0,0.0,0,513)
DeclareAlias2("EM.port_a1.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_b.m_flow", -1, 5, 175, 132)
DeclareAlias2("EM.port_a1.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1, 1, 139, 4)
DeclareAlias2("EM.port_a1.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.steamHeader.medium.h", 1, 1, 51, 4)
DeclareAlias2("EM.port_b1.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", -1, 5, 173, 132)
DeclareAlias2("EM.port_b1.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.port_a.p", 1, 5, 174, 4)
DeclareVariable("EM.port_b1.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,520)
DeclareAlias2("EM.port_a2.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", 1, 5, 173, 132)
DeclareAlias2("EM.port_a2.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.port_a.p", 1, 5, 174, 4)
DeclareAlias2("EM.port_a2.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", 1, 1, 122, 4)
DeclareVariable("EM.port_b2.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 -70.0, -100000.0,100000.0,0.0,0,776)
DeclareVariable("EM.port_b2.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 5000000.0, 611.657,100000000.0,1000000.0,0,520)
DeclareAlias2("EM.port_b2.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.steamHeader.medium.h", 1, 1, 51, 4)
DeclareParameter("EM.dp_nominal_valve_b2", "Nominal pressure drop at full opening [Pa|bar]",\
 484, 10000.0, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.use_pipeDelay_b2", "=true to use include pipe effects due to distance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.length_b2", "Length of pipe to port_b2 [m]", 485, 10, \
0.0,0.0,0.0,0,560)
DeclareParameter("EM.diameter_b2", "Diameter of pipe to port_b2 [m]", 486, 2.5, \
0.0,1E+100,0.0,0,560)
DeclareVariable("EM.use_pipeDelay_a2", "=true to use include pipe effects due to distance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.length_a2", "Length of pipe from port_a2 [m]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("EM.diameter_a2", "Diameter of pipe from port_a2 [m]", 0.0, 0.0,\
1E+100,0.0,0,513)
DeclareVariable("EM.use_pipeDelay_b3", "=true to use include pipe effects due to distance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("EM.resistance.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_b.m_flow", -1, 5, 175, 132)
DeclareAlias2("EM.resistance.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1, 1, 139, 4)
DeclareAlias2("EM.resistance.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.steamHeader.medium.h", 1, 1, 51, 4)
DeclareAlias2("EM.resistance.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_b.m_flow", 1, 5, 175, 132)
DeclareAlias2("EM.resistance.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.steamHeader.medium.p", 1, 1, 50, 4)
DeclareAlias2("EM.resistance.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "nuScale_Tave_enthalpy.port_b.h_outflow", 1, 5, 176, 4)
DeclareVariable("EM.resistance.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("EM.resistance.state.h", "Specific enthalpy [J/kg]", \
"nuScale_Tave_enthalpy.port_b.h_outflow", 1, 5, 176, 0)
DeclareVariable("EM.resistance.state.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("EM.resistance.state.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("EM.resistance.state.p", "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1,\
 1, 139, 0)
DeclareVariable("EM.resistance.dp", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.resistance.m_flow", "[kg/s]", "nuScale_Tave_enthalpy.port_b.m_flow", -1,\
 5, 175, 0)
DeclareParameter("EM.resistance.showName", "[:#(type=Boolean)]", 487, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("EM.resistance.showDP", "[:#(type=Boolean)]", 488, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("EM.resistance.precision", "Number of decimals displayed [:#(type=Integer)]",\
 489, 3, 0.0,1E+100,0.0,0,564)
DeclareVariable("EM.resistance.R", "Hydraulic resistance [Pa/(kg/s)]", 1, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.steamHeader.nPorts_a", "Number of port_a connections [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.steamHeader.nPorts_b", "Number of port_b connections [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.steamHeader.port_a[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_b.m_flow", -1, 5, 175, 132)
DeclareAlias2("EM.steamHeader.port_a[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.steamHeader.medium.p", 1, 1, 50, 4)
DeclareAlias2("EM.steamHeader.port_a[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.steamHeader.medium.h", 1, 1, 51, 4)
DeclareAlias2("EM.steamHeader.port_b[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "EM.port_b2.m_flow", 1, 5, 5724, 132)
DeclareAlias2("EM.steamHeader.port_b[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.steamHeader.medium.p", 1, 1, 50, 4)
DeclareAlias2("EM.steamHeader.port_b[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.steamHeader.medium.h", 1, 1, 51, 4)
DeclareVariable("EM.steamHeader.V", "Volume [m3]", 20, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.steamHeader.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.steamHeader.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.steamHeader.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.steamHeader.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.steamHeader.p_start", "Pressure [Pa|bar]", 0.0, 0.0,1E+100,\
100000.0,0,513)
DeclareVariable("EM.steamHeader.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.steamHeader.T_start", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.steamHeader.h_start", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("EM.steamHeader.X_start[1]", "Mass fraction [1]", 490, 1.0, 0.0,\
1.0,0.0,0,560)
DeclareState("EM.steamHeader.medium.p", "Absolute pressure of medium [Pa|bar]", 50,\
 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("EM.steamHeader.medium.der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("EM.steamHeader.medium.h", "Specific enthalpy of medium [J/kg]", 51,\
 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("EM.steamHeader.medium.der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.medium.d", "Density of medium [kg/m3|g/cm3]", \
0.0, 0.0,100000.0,500.0,0,512)
DeclareVariable("EM.steamHeader.medium.der(d)", "der(Density of medium) [Pa.m-2.s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.medium.T", "Temperature of medium [K|degC]", \
500.0, 273.15,2273.15,500.0,0,512)
DeclareVariable("EM.steamHeader.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("EM.steamHeader.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("EM.steamHeader.medium.der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("EM.steamHeader.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("EM.steamHeader.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,644)
DeclareAlias2("EM.steamHeader.medium.state.h", "Specific enthalpy [J/kg]", \
"EM.steamHeader.medium.h", 1, 1, 51, 0)
DeclareAlias2("EM.steamHeader.medium.state.d", "Density [kg/m3|g/cm3]", \
"EM.steamHeader.medium.d", 1, 5, 5747, 0)
DeclareAlias2("EM.steamHeader.medium.state.T", "Temperature [K|degC]", \
"EM.steamHeader.medium.T", 1, 5, 5749, 0)
DeclareAlias2("EM.steamHeader.medium.state.p", "Pressure [Pa|bar]", \
"EM.steamHeader.medium.p", 1, 1, 50, 0)
DeclareVariable("EM.steamHeader.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.steamHeader.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.steamHeader.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.steamHeader.medium.sat.psat", "Saturation pressure [Pa|bar]", \
"EM.steamHeader.medium.p", 1, 1, 50, 0)
DeclareVariable("EM.steamHeader.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("EM.steamHeader.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "EM.steamHeader.medium.state.phase", 1, 5, 5755, 66)
DeclareVariable("EM.steamHeader.m", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("EM.steamHeader.der(m)", "der(Mass) [kg/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.U", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.der(U)", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("EM.steamHeader.mb", "Mass flow rate source/sinks within volumes [kg/s]",\
 "EM.steamHeader.der(m)", 1, 5, 5762, 0)
DeclareAlias2("EM.steamHeader.Ub", "Energy source/sinks within volumes (e.g., ohmic heating, external convection) [W]",\
 "EM.steamHeader.der(U)", 1, 5, 5764, 0)
DeclareParameter("EM.steamHeader.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 491, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("EM.steamHeader.geometry.V", "Volume [m3]", 20.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.steamHeader.geometry.angle", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("EM.steamHeader.geometry.dheight", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.steamHeader.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.steamHeader.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.steamHeader.g_n", "Gravitational acceleration [m/s2]", \
9.80665, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.steamHeader.H_flows_a[1]", "Enthalpy flow rates at port_a [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.H_flows_b[1]", "Enthalpy flow rates at port_b [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.steamHeader.use_HeatPort", "=true to toggle heat port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.steamHeader.Q_gen", "Internal heat generation [W]", 0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.steamHeader.use_TraceMassPort", "=true to toggle trace mass port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.steamHeader.showName", "[:#(type=Boolean)]", 492, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("EM.steamHeader.Q_flow_internal", "[W]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.valve_b2.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.valve_b2.showDesignFlowDirection", "= false to hide the flow direction arrow [:#(type=Boolean)]",\
 493, true, 0.0,0.0,0.0,0,562)
DeclareParameter("EM.valve_b2.showName", "= false to hide component name [:#(type=Boolean)]",\
 494, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("EM.valve_b2.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "EM.port_b2.m_flow", -1, 5, 5724, 132)
DeclareAlias2("EM.valve_b2.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.steamHeader.medium.p", 1, 1, 50, 4)
DeclareAlias2("EM.valve_b2.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareAlias2("EM.valve_b2.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "EM.port_b2.m_flow", 1, 5, 5724, 132)
DeclareAlias2("EM.valve_b2.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.port_b2.p", 1, 5, 5725, 4)
DeclareAlias2("EM.valve_b2.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.steamHeader.medium.h", 1, 1, 51, 4)
DeclareVariable("EM.valve_b2.dp_start", "Guess value of dp = port_a.p - port_b.p [Pa|bar]",\
 5000000.0, -1E+60,100000000.0,1000000.0,0,513)
DeclareVariable("EM.valve_b2.m_flow_start", "Guess value of m_flow = port_a.m_flow [kg/s]",\
 70.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("EM.valve_b2.m_flow_small", "Small mass flow rate for regularization of zero flow [kg/s]",\
 0.007, -100000.0,100000.0,0.0,0,513)
DeclareVariable("EM.valve_b2.show_T", "= true, if temperatures at port_a and port_b are computed [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.valve_b2.show_V_flow", "= true, if volume flow rate at inflowing port is computed [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("EM.valve_b2.m_flow", "Mass flow rate in design flow direction [kg/s]",\
 "EM.port_b2.m_flow", -1, 5, 5724, 0)
DeclareVariable("EM.valve_b2.dp", "Pressure difference between port_a and port_b (= port_a.p - port_b.p) [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.valve_b2.V_flow", "Volume flow rate at inflowing port (positive when flow from port_a to port_b) [m3/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.valve_b2.port_a_T", "Temperature close to port_a, if show_T = true [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("EM.valve_b2.port_b_T", "Temperature close to port_b, if show_T = true [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("EM.valve_b2.state_a.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,2565)
DeclareAlias2("EM.valve_b2.state_a.h", "Specific enthalpy [J/kg]", \
"EM.steamHeader.medium.h", 1, 1, 51, 1024)
DeclareVariable("EM.valve_b2.state_a.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("EM.valve_b2.state_a.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,2560)
DeclareAlias2("EM.valve_b2.state_a.p", "Pressure [Pa|bar]", "EM.steamHeader.medium.p", 1,\
 1, 50, 1024)
DeclareVariable("EM.valve_b2.state_b.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,2565)
DeclareAlias2("EM.valve_b2.state_b.h", "Specific enthalpy [J/kg]", \
"BOP.header.medium.h", 1, 1, 66, 1024)
DeclareVariable("EM.valve_b2.state_b.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("EM.valve_b2.state_b.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,2560)
DeclareAlias2("EM.valve_b2.state_b.p", "Pressure [Pa|bar]", "EM.port_b2.p", 1, 5,\
 5725, 1024)
DeclareVariable("EM.valve_b2.CvData", "Selection of flow coefficient [:#(type=Modelica.Fluid.Types.CvTypes)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.valve_b2.Av", "Av (metric) flow coefficient [m2]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("EM.valve_b2.Kv", "Kv (metric) flow coefficient [m3/h] [1]", 495,\
 0, 0.0,0.0,0.0,0,560)
DeclareParameter("EM.valve_b2.Cv", "Cv (US) flow coefficient [USG/min] [1]", 496,\
 0, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.valve_b2.dp_nominal", "Nominal pressure drop [Pa|bar]", 0.0,\
 0.0,0.0,0.0,0,513)
DeclareVariable("EM.valve_b2.m_flow_nominal", "Nominal mass flowrate [kg/s]", \
70.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("EM.valve_b2.rho_nominal", "Nominal inlet density [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,513)
DeclareParameter("EM.valve_b2.opening_nominal", "Nominal opening", 497, 1, 0.0,\
1.0,0.0,0,560)
DeclareVariable("EM.valve_b2.filteredOpening", "= true, if opening is filtered with a 2nd order CriticalDamping filter [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.valve_b2.riseTime", "Rise time of the filter (time to reach 99.6 % of an opening step) [s]",\
 498, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("EM.valve_b2.leakageOpening", "The opening signal is limited by leakageOpening (to improve the numerics)",\
 499, 0.001, 0.0,1.0,0.0,0,560)
DeclareVariable("EM.valve_b2.checkValve", "Reverse flow stopped [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.valve_b2.dp_small", "Regularisation of zero flow [Pa|bar]", \
0.0, 0.0,1E+100,100000.0,0,513)
DeclareVariable("EM.valve_b2.Kv2Av", "Conversion factor [m2]", 2.77E-05, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.valve_b2.Cv2Av", "Conversion factor [m2]", 2.4E-05, 0.0,0.0,\
0.0,0,513)
DeclareAlias2("EM.valve_b2.opening", "Valve position in the range 0..1", \
"EM.CS.opening_valve_toBOP.k", 1, 7, 483, 0)
DeclareAlias2("EM.valve_b2.opening_actual", "", "EM.CS.opening_valve_toBOP.k", 1,\
 7, 483, 1024)
DeclareVariable("EM.valve_b2.minLimiter.uMin", "Lower limit of input signal", \
0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("EM.valve_b2.minLimiter.u", "Connector of Real input signal", \
"EM.CS.opening_valve_toBOP.k", 1, 7, 483, 1024)
DeclareVariable("EM.valve_b2.minLimiter.y", "Connector of Real output signal", \
0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.valve_b2.Re_turbulent", "cf. straight pipe for fully open valve -- dp_turbulent increases for closing valve [1]",\
 4000, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.valve_b2.use_Re", "= true, if turbulent region is defined by Re, otherwise by m_flow_small [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("EM.valve_b2.dp_turbulent", "[Pa|bar]", "EM.valve_b2.dp_small", 1,\
 5, 5800, 0)
DeclareAlias2("EM.valve_b2.relativeFlowCoefficient", "", "EM.CS.opening_valve_toBOP.k", 1,\
 7, 483, 1024)
DeclareVariable("EM.pipe_b2.summary.T_effective", "Unit cell mass averaged temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,512)
DeclareVariable("EM.pipe_b2.summary.T_max", "Maximum temperature [K|degC]", \
288.15, 0.0,1E+100,300.0,0,512)
DeclareVariable("EM.pipe_b2.summary.xpos[1]", "x-position for physical location reference",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.summary.xpos[2]", "x-position for physical location reference",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.summary.xpos_norm[1]", "x-position for physical location reference normalized by total length",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.summary.xpos_norm[2]", "x-position for physical location reference normalized by total length",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -1E+60,100000.0,0.0,0,777)
DeclareAlias2("EM.pipe_b2.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.pipe_b2.mediums[1].p", 1, 1, 183, 4)
DeclareAlias2("EM.pipe_b2.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 4)
DeclareVariable("EM.pipe_b2.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,1E+60,0.0,0,777)
DeclareAlias2("EM.pipe_b2.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.pipe_b2.mediums[2].p", 1, 1, 185, 4)
DeclareAlias2("EM.pipe_b2.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 4)
DeclareParameter("EM.pipe_b2.nParallel", "Number of parallel components [1]", 500,\
 1, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_b2.nV", "Number of discrete volumes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareVariable("EM.pipe_b2.Vs[1]", "Discretized volumes [m3]", 0.0, 0.0,1E+100,\
0.0,0,513)
DeclareVariable("EM.pipe_b2.Vs[2]", "Discretized volumes [m3]", 0.0, 0.0,1E+100,\
0.0,0,513)
DeclareVariable("EM.pipe_b2.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.ps_start[1]", "Pressure [Pa|bar]", 0.0, 0.0,1E+100,\
100000.0,0,513)
DeclareVariable("EM.pipe_b2.ps_start[2]", "Pressure [Pa|bar]", 0.0, 0.0,1E+100,\
100000.0,0,513)
DeclareVariable("EM.pipe_b2.use_Ts_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.Ts_start[1]", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_b2.Ts_start[2]", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_b2.hs_start[1]", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.hs_start[2]", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.Xs_start[1, 1]", "Mass fraction [1]", 0.0, 0.0,1.0,\
0.0,0,513)
DeclareVariable("EM.pipe_b2.Xs_start[2, 1]", "Mass fraction [1]", 0.0, 0.0,1.0,\
0.0,0,513)
DeclareVariable("EM.pipe_b2.ms[1]", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("EM.pipe_b2.ms[2]", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("EM.pipe_b2.der(ms[1])", "der(Mass) [kg/s]", 0.0, -1E+100,1E+60,\
0.0,0,512)
DeclareAlias2("EM.pipe_b2.der(ms[2])", "der(Mass) [kg/s]", "EM.pipe_b2.der(ms[1])", -1,\
 5, 5834, 0)
DeclareVariable("EM.pipe_b2.Us[1]", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.Us[2]", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.der(Us[1])", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.der(Us[2])", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_b2.mbs[1]", "Mass flow rate balances across volume interfaces (e.g., enthalpy flow, diffusion) and source/sinks within volumes [kg/s]",\
 "EM.pipe_b2.der(ms[1])", 1, 5, 5834, 0)
DeclareAlias2("EM.pipe_b2.mbs[2]", "Mass flow rate balances across volume interfaces (e.g., enthalpy flow, diffusion) and source/sinks within volumes [kg/s]",\
 "EM.pipe_b2.der(ms[1])", -1, 5, 5834, 0)
DeclareAlias2("EM.pipe_b2.Ubs[1]", "Energy sources across volume interfaces (e.g., thermal diffusion) and source/sinks within volumes [W]",\
 "EM.pipe_b2.der(Us[1])", 1, 5, 5837, 0)
DeclareAlias2("EM.pipe_b2.Ubs[2]", "Energy sources across volume interfaces (e.g., thermal diffusion) and source/sinks within volumes [W]",\
 "EM.pipe_b2.der(Us[2])", 1, 5, 5838, 0)
DeclareParameter("EM.pipe_b2.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 501, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("EM.pipe_b2.p_a_start", "Pressure at port a [Pa|bar]", 0.0, 0.0,\
1E+100,100000.0,0,513)
DeclareVariable("EM.pipe_b2.p_b_start", "Pressure at port b [Pa|bar]", 0.0, 0.0,\
1E+100,100000.0,0,513)
DeclareVariable("EM.pipe_b2.T_a_start", "Temperature at port a [K|degC]", 293.15,\
 0.0,1E+100,300.0,0,513)
DeclareVariable("EM.pipe_b2.T_b_start", "Temperature at port b [K|degC]", 293.15,\
 0.0,1E+100,300.0,0,513)
DeclareVariable("EM.pipe_b2.h_a_start", "Specific enthalpy at port a [J/kg]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.h_b_start", "Specific enthalpy at port b [J/kg]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("EM.pipe_b2.X_a_start[1]", "Mass fraction at port a [1]", 502, \
1.0, 0.0,1.0,0.0,0,560)
DeclareVariable("EM.pipe_b2.X_b_start[1]", "Mass fraction at port b [1]", 0.0, \
0.0,1.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.m_flow_a_start", "Mass flow rate at port_a [kg/s]", \
70.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.m_flow_b_start", "Mass flow rate at port_b [kg/s]", \
-70.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.m_flows_start[1]", "Mass flow rates [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.m_flows_start[2]", "Mass flow rates [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.m_flows_start[3]", "Mass flow rates [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_b2.geometry.dimension", "Characteristic dimension (e.g., hydraulic diameter) [m]",\
 "EM.diameter_b2", 1, 7, 486, 0)
DeclareAlias2("EM.pipe_b2.geometry.crossArea", "Cross-sectional flow areas [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.geometry.perimeter", "Wetted perimeters [m]", \
"EM.pipe_b2.perimetersFM[1]", 1, 5, 6044, 0)
DeclareAlias2("EM.pipe_b2.geometry.length", "Pipe length [m]", "EM.length_b2", 1,\
 7, 485, 0)
DeclareVariable("EM.pipe_b2.geometry.roughness", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.surfaceArea[1]", "Area per transfer surface [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.angle", "Vertical angle from the horizontal (-pi/2 < x <= pi/2) [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.dheight", "Height(port_b) - Height(port_a) distributed by flow segment [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.figure", "Index for Icon figure [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.geometry.nV", "Number of volume nodes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareVariable("EM.pipe_b2.geometry.nSurfaces", "Number of transfer (heat/mass) surfaces [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_b2.geometry.dimensions[1]", "Characteristic dimension (e.g., hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[1]", 1, 5, 6041, 0)
DeclareAlias2("EM.pipe_b2.geometry.dimensions[2]", "Characteristic dimension (e.g., hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[2]", 1, 5, 6042, 0)
DeclareAlias2("EM.pipe_b2.geometry.crossAreas[1]", "Cross sectional area of unit volumes [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.geometry.crossAreas[2]", "Cross sectional area of unit volumes [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.geometry.perimeters[1]", "Wetted perimeter of unit volumes [m]",\
 "EM.pipe_b2.perimetersFM[1]", 1, 5, 6044, 0)
DeclareAlias2("EM.pipe_b2.geometry.perimeters[2]", "Wetted perimeter of unit volumes [m]",\
 "EM.pipe_b2.perimetersFM[1]", 1, 5, 6044, 0)
DeclareVariable("EM.pipe_b2.geometry.dlengths[1]", "Unit cell length [m]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.dlengths[2]", "Unit cell length [m]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.roughnesses[1]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.roughnesses[2]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.surfaceAreas[1, 1]", "Discretized area per transfer surface [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.surfaceAreas[2, 1]", "Discretized area per transfer surface [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.angles[1]", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.angles[2]", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.dheights[1]", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.dheights[2]", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_b2.geometry.Vs[1]", "Unit volumes [m3]", "EM.pipe_b2.Vs[1]", 1,\
 5, 5817, 0)
DeclareAlias2("EM.pipe_b2.geometry.Vs[2]", "Unit volumes [m3]", "EM.pipe_b2.Vs[2]", 1,\
 5, 5818, 0)
DeclareVariable("EM.pipe_b2.geometry.V_total", "Total volume of component [m3]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_b2.geometry.surfaceAreas_nVtotal[1]", "Total surface area for each volume node [m2]",\
 "EM.pipe_b2.geometry.surfaceAreas[1, 1]", 1, 5, 5862, 0)
DeclareAlias2("EM.pipe_b2.geometry.surfaceAreas_nVtotal[2]", "Total surface area for each volume node [m2]",\
 "EM.pipe_b2.geometry.surfaceAreas[1, 1]", 1, 5, 5862, 0)
DeclareVariable("EM.pipe_b2.geometry.surfaceArea_total", "Total surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.dxs[1]", "Fractional lengths [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.geometry.dxs[2]", "Fractional lengths [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.nFM", "Number of discrete flow models [:#(type=Integer)]",\
 1, 1.0,1E+100,0.0,0,517)
DeclareVariable("EM.pipe_b2.flowModel.g_n", "Gravitational acceleration [m/s2]",\
 9.80665, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.momentumDynamics", "Formulation of momentum balance [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.flowModel.dps_start[1]", "Pressure changes {p[2]-p[1],...,p[n+1]-p[n]} [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.m_flows_start[1]", "Mass flow rates [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_b2.flowModel.vs[1]", "Mean velocities of fluid flow [m/s]",\
 "EM.pipe_b2.vs[1]", 1, 5, 6017, 0)
DeclareAlias2("EM.pipe_b2.flowModel.vs[2]", "Mean velocities of fluid flow [m/s]",\
 "EM.pipe_b2.vs[2]", 1, 5, 6018, 0)
DeclareAlias2("EM.pipe_b2.flowModel.Ts_wall[1]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.flowModel.Ts_wall[2]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.flowModel.dimensions[1]", "Characteristic dimensions (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[1]", 1, 5, 6041, 0)
DeclareAlias2("EM.pipe_b2.flowModel.dimensions[2]", "Characteristic dimensions (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[2]", 1, 5, 6042, 0)
DeclareAlias2("EM.pipe_b2.flowModel.crossAreas[1]", "Cross sectional area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.flowModel.crossAreas[2]", "Cross sectional area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.flowModel.perimeters[1]", "Wetted perimeter [m]", \
"EM.pipe_b2.perimetersFM[1]", 1, 5, 6044, 0)
DeclareAlias2("EM.pipe_b2.flowModel.perimeters[2]", "Wetted perimeter [m]", \
"EM.pipe_b2.perimetersFM[1]", 1, 5, 6044, 0)
DeclareAlias2("EM.pipe_b2.flowModel.dlengths[1]", "Length of flow model [m]", \
"EM.pipe_b2.dlengthsFM[1]", 1, 5, 6039, 0)
DeclareVariable("EM.pipe_b2.flowModel.roughnesses[1]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.roughnesses[2]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.dheights[1]", "Height(states[2:nFM+1]) - Height(states[1:nFM]) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (m_flows >= zeros(m)) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.flowModel.Re_lam", "Laminar transition Reynolds number [1]",\
 2300, -1E+100,4000.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.Re_turb", "Turbulent transition Reynolds number [1]",\
 4000, 2300.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.from_dp", "= true, use m_flow = f(dp), otherwise dp = f(m_flow) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.pipe_b2.flowModel.m_flow_small", "Within regularization if |m_flows| < m_flow_small (may be wider for large discontinuities in static head) [kg/s]",\
 503, 0.001, 0.0,0.0,0.0,0,560)
DeclareParameter("EM.pipe_b2.flowModel.dp_small", "Within regularization if |dp| < dp_small (may be wider for large discontinuities in static head) [Pa|bar]",\
 504, 1, 0.0,1E+100,100000.0,0,560)
DeclareAlias2("EM.pipe_b2.flowModel.m_flows[1]", "Mass flow rate across interfaces [kg/s]",\
 "EM.pipe_b2.der(ms[1])", -1, 5, 5834, 0)
DeclareVariable("EM.pipe_b2.flowModel.Is[1]", "Momenta of flow segments [kg.m/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.flowModel.Ibs[1]", "Flow of momentum across boundaries and source/sink in volumes [N]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_b2.flowModel.Ts_fluid[1]", "Fluid temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.flowModel.Ts_fluid[2]", "Fluid temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareVariable("EM.pipe_b2.flowModel.Res[1]", "Reynolds number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.flowModel.Re_center", "Re smoothing transition center [1]",\
 3150.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_b2.flowModel.Re_width", "Re smoothing transition width [1]",\
 850.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_b2.flowModel.Ks_ab[1]", "Minor loss coefficients. Flow in direction a -> b [1]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.Ks_ba[1]", "Minor loss coefficients. Flow in direction b -> a [1]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.use_I_flows", "= true to consider differences in flow of momentum through boundaries [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.pipe_b2.flowModel.taus[1]", "Time Constant for first order delay of {dps_K,dps_add} [s]",\
 505, 0.01, 0.0,0.0,0.0,0,560)
DeclareParameter("EM.pipe_b2.flowModel.taus[2]", "Time Constant for first order delay of {dps_K,dps_add} [s]",\
 506, 0.01, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_b2.flowModel.I_flows[1]", "Flow of momentum across boundaries [N]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.Fs_p[1]", "Pressure forces [N]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_b2.flowModel.Fs_fg[1]", "Friction and gravity forces [N]",\
 "EM.pipe_b2.flowModel.Fs_p[1]", -1, 5, 5895, 0)
DeclareVariable("EM.pipe_b2.flowModel.dps_fg[1]", "Pressure drop between states [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.flowModel.dps_K[1]", "Minor form-losses (K-loss) [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.dp_nominal", "Nominal pressure loss (only for nominal models) [Pa|bar]",\
 1, 0.0,1E+100,100000.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.m_flow_nominal", "Nominal mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.use_d_nominal", "= true, if d_nominal is used, otherwise computed from medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.flowModel.d_nominal", "Nominal density (e.g., rho_liquidWater = 995, rho_air = 1.2) [kg/m3|g/cm3]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.use_mu_nominal", "= true, if mu_nominal is used, otherwise computed from medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.flowModel.mu_nominal", "Nominal dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5) [Pa.s]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.continuousFlowReversal", "= true if the pressure loss is continuous around zero flow [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.flowModel.mus[1]", "[Pa.s]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("EM.pipe_b2.flowModel.mus_a[1]", "[Pa.s]", 0.001, 0.0,\
100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_b2.flowModel.mus_b[1]", "[Pa.s]", 0.001, 0.0,\
100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_b2.flowModel.ds[1]", "[kg/m3|g/cm3]", 0.0, 0.0,1E+100,\
0.0,0,512)
DeclareAlias2("EM.pipe_b2.flowModel.ds_a[1]", "[kg/m3|g/cm3]", "EM.pipe_b2.statesFM[1].d", 1,\
 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.flowModel.ds_b[1]", "[kg/m3|g/cm3]", "EM.pipe_b2.statesFM[2].d", 1,\
 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var_nominal.rho_a", "Density at port_a [kg/m3|g/cm3]",\
 "EM.pipe_b2.flowModel.d_nominal", 1, 5, 5901, 1024)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var_nominal.rho_b", "Density at port_b [kg/m3|g/cm3]",\
 "EM.pipe_b2.flowModel.d_nominal", 1, 5, 5901, 1024)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var_nominal.mu_a", "Dynamic viscosity at port_a [Pa.s]",\
 "EM.pipe_b2.flowModel.mu_nominal", 1, 5, 5903, 1024)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var_nominal.mu_b", "Dynamic viscosity at port_b [Pa.s]",\
 "EM.pipe_b2.flowModel.mu_nominal", 1, 5, 5903, 1024)
DeclareVariable("EM.pipe_b2.flowModel.dp_fric_nominal", "pressure loss for nominal conditions [Pa|bar]",\
 0.0, 0.0,1E+100,100000.0,0,2561)
DeclareVariable("EM.pipe_b2.use_HeatTransfer", "= true to use the HeatTransfer model [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.heatTransfer.nParallel", "Number of parallel components [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.nHT", "Number of heat transfer segments [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.heatTransfer.nSurfaces", "Number of heat transfer surfaces [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.heatTransfer.flagIdeal", "Flag for models to handle ideal boundary [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[1].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[1].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[2].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[2].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.vs[1]", "Fluid Velocity [m/s]", \
"EM.pipe_b2.vs[1]", 1, 5, 6017, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.vs[2]", "Fluid Velocity [m/s]", \
"EM.pipe_b2.vs[2]", 1, 5, 6018, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[1]", 1, 5, 6041, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[2]", 1, 5, 6042, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.crossAreas[1]", "Cross sectional flow area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.crossAreas[2]", "Cross sectional flow area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.dlengths[1]", "Characteristic length of heat transfer segment [m]",\
 "EM.pipe_b2.geometry.dlengths[1]", 1, 5, 5858, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.dlengths[2]", "Characteristic length of heat transfer segment [m]",\
 "EM.pipe_b2.geometry.dlengths[2]", 1, 5, 5859, 0)
DeclareVariable("EM.pipe_b2.heatTransfer.roughnesses[1]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.roughnesses[2]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareAlias2("EM.pipe_b2.heatTransfer.surfaceAreas[1, 1]", "Surface area for heat transfer [m2]",\
 "EM.pipe_b2.geometry.surfaceAreas[1, 1]", 1, 5, 5862, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.surfaceAreas[2, 1]", "Surface area for heat transfer [m2]",\
 "EM.pipe_b2.geometry.surfaceAreas[2, 1]", 1, 5, 5863, 0)
DeclareVariable("EM.pipe_b2.heatTransfer.Ts_start[1]", "[K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.Ts_start[2]", "[K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.Re_lam", "Laminar transition Reynolds number [1]",\
 2300, -1E+100,4000.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.Re_turb", "Turbulent transition Reynolds number [1]",\
 4000, 2300.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.CF", "Correction Factor: Q = CF*alpha*A*dT [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.CFs[1, 1]", "if non-uniform then set [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.CFs[2, 1]", "if non-uniform then set [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.states_wall[1, 1].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.heatTransfer.states_wall[1, 1].h", "Specific enthalpy [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.states_wall[1, 1].d", "Density [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,512)
DeclareAlias2("EM.pipe_b2.heatTransfer.states_wall[1, 1].T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states_wall[1, 1].p", "Pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareVariable("EM.pipe_b2.heatTransfer.states_wall[2, 1].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.heatTransfer.states_wall[2, 1].h", "Specific enthalpy [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.states_wall[2, 1].d", "Density [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,512)
DeclareAlias2("EM.pipe_b2.heatTransfer.states_wall[2, 1].T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.states_wall[2, 1].p", "Pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.Ts_fluid[1]", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.Ts_fluid[2]", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.Ts_wall[1, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.Ts_wall[2, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareVariable("EM.pipe_b2.heatTransfer.m_flows[1]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.m_flows[2]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.Res[1]", "Reynolds number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.Res[2]", "Reynolds number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.Prs[1]", "Prandtl number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.Prs[2]", "Prandtl number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.alphas[1, 1]", "Coefficient of heat transfer [W/(m2.K)]",\
 1E+60, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.alphas[2, 1]", "Coefficient of heat transfer [W/(m2.K)]",\
 1E+60, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.Nus[1, 1]", "Nusselt number [1]", 1E+60,\
 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.Nus[2, 1]", "Nusselt number [1]", 1E+60,\
 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.Q_flows[1, 1]", "Heat flow rate [W]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.Q_flows[2, 1]", "Heat flow rate [W]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.heatTransfer.heatPorts[1, 1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("EM.pipe_b2.heatTransfer.heatPorts[1, 1].T", "Temperature at the connection point [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 4)
DeclareVariable("EM.pipe_b2.heatTransfer.heatPorts[2, 1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("EM.pipe_b2.heatTransfer.heatPorts[2, 1].T", "Temperature at the connection point [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 4)
DeclareVariable("EM.pipe_b2.heatTransfer.Re_center", "Re smoothing transition center [1]",\
 3150.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_b2.heatTransfer.Re_width", "Re smoothing transition width [1]",\
 850.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].state.T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].T", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[1].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareVariable("EM.pipe_b2.heatTransfer.mediums[1].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.mediums[1].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.mediums[1].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].state.T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].T", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.heatTransfer.mediums[2].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareVariable("EM.pipe_b2.heatTransfer.mediums[2].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.mediums[2].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_b2.heatTransfer.mediums[2].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("EM.pipe_b2.internalHeatGen.nV", "Number of discrete volumes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[1].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[1].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[2].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[2].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.Vs[1]", "Volumes [m3]", \
"EM.pipe_b2.Vs[1]", 1, 5, 5817, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.Vs[2]", "Volumes [m3]", \
"EM.pipe_b2.Vs[2]", 1, 5, 5818, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[1]", 1, 5, 6041, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[2]", 1, 5, 6042, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.crossAreas[1]", "Volumes cross sectional area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.crossAreas[2]", "Volumes cross sectional area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.dlengths[1]", "Volumes length [m]", \
"EM.pipe_b2.geometry.dlengths[1]", 1, 5, 5858, 0)
DeclareAlias2("EM.pipe_b2.internalHeatGen.dlengths[2]", "Volumes length [m]", \
"EM.pipe_b2.geometry.dlengths[2]", 1, 5, 5859, 0)
DeclareVariable("EM.pipe_b2.internalHeatGen.Q_flows[1]", "Internal heat generated [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.internalHeatGen.Q_flows[2]", "Internal heat generated [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.internalHeatGen.Q_gen", "Per volume heat generation [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.internalHeatGen.Q_gens[1]", "if non-uniform then set Q_gens [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.internalHeatGen.Q_gens[2]", "if non-uniform then set Q_gens [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.use_TraceMassTransfer", "= true to use the TraceMassTransfer model [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.traceMassTransfer.nParallel", "Number of parallel components [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.traceMassTransfer.nMT", "Number of mass transfer segments [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.traceMassTransfer.nSurfaces", "Number of mass transfer surfaces [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.traceMassTransfer.flagIdeal", "Flag for models to handle ideal boundary [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[1].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[1].T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[2].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[2].T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.Ts_wall[1, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.Ts_wall[2, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.vs[1]", "Fluid Velocity [m/s]", \
"EM.pipe_b2.vs[1]", 1, 5, 6017, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.vs[2]", "Fluid Velocity [m/s]", \
"EM.pipe_b2.vs[2]", 1, 5, 6018, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[1]", 1, 5, 6041, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[2]", 1, 5, 6042, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.crossAreas[1]", "Cross sectional flow area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.crossAreas[2]", "Cross sectional flow area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.dlengths[1]", "Characteristic length of transfer segment [m]",\
 "EM.pipe_b2.geometry.dlengths[1]", 1, 5, 5858, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.dlengths[2]", "Characteristic length of transfer segment [m]",\
 "EM.pipe_b2.geometry.dlengths[2]", 1, 5, 5859, 0)
DeclareVariable("EM.pipe_b2.traceMassTransfer.roughnesses[1]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.traceMassTransfer.roughnesses[2]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.surfaceAreas[1, 1]", \
"Surface area for transfer [m2]", "EM.pipe_b2.geometry.surfaceAreas[1, 1]", 1, 5,\
 5862, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.surfaceAreas[2, 1]", \
"Surface area for transfer [m2]", "EM.pipe_b2.geometry.surfaceAreas[2, 1]", 1, 5,\
 5863, 0)
DeclareVariable("EM.pipe_b2.traceMassTransfer.nC", "[:#(type=Integer)]", 0, \
0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.traceMassTransfer.diffusionCoeff[1].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.diffusionCoeff[1].T", \
"Temperature [K|degC]", "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareVariable("EM.pipe_b2.traceMassTransfer.diffusionCoeff[1].D_ab0", \
"Diffusion Coefficient [m2/s]", 1E-15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.traceMassTransfer.diffusionCoeff[2].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.diffusionCoeff[2].T", \
"Temperature [K|degC]", "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareVariable("EM.pipe_b2.traceMassTransfer.diffusionCoeff[2].D_ab0", \
"Diffusion Coefficient [m2/s]", 1E-15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.traceMassTransfer.Re_lam", "Laminar transition Reynolds number [1]",\
 2300, -1E+100,4000.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.traceMassTransfer.Re_turb", "Turbulent transition Reynolds number [1]",\
 4000, 2300.0,1E+100,0.0,0,513)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.Ts_fluid[1]", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.Ts_fluid[2]", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareVariable("EM.pipe_b2.traceMassTransfer.m_flows[1]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.m_flows[2]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.Res[1]", "Reynolds number [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.Res[2]", "Reynolds number [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.xs[1]", "Position of local mass transfer calculation [m]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.xs[2]", "Position of local mass transfer calculation [m]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.massPorts[1, 1].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,525)
DeclareVariable("EM.pipe_b2.traceMassTransfer.massPorts[2, 1].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,525)
DeclareVariable("EM.pipe_b2.traceMassTransfer.toMole_unitConv", "[mol]", 1, 0.0,\
1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_b2.traceMassTransfer.Re_center", "Re smoothing transition center [1]",\
 3150.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_b2.traceMassTransfer.Re_width", "Re smoothing transition width [1]",\
 850.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_b2.traceMassTransfer.nC_noT", "# of species not transfered from fluid [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,2565)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].state.T", \
"Temperature [K|degC]", "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].state.p", \
"Pressure [Pa|bar]", "EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].T", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[1].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareVariable("EM.pipe_b2.traceMassTransfer.mediums[1].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.mediums[1].lambda", \
"Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.mediums[1].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].state.T", \
"Temperature [K|degC]", "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].state.p", \
"Pressure [Pa|bar]", "EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].T", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.traceMassTransfer.mediums[2].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareVariable("EM.pipe_b2.traceMassTransfer.mediums[2].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.mediums[2].lambda", \
"Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_b2.traceMassTransfer.mediums[2].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("EM.pipe_b2.internalTraceGen.nV", "Number of discrete volumes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[1].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[1].T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[2].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[2].T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.Vs[1]", "Volumes [m3]", \
"EM.pipe_b2.Vs[1]", 1, 5, 5817, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.Vs[2]", "Volumes [m3]", \
"EM.pipe_b2.Vs[2]", 1, 5, 5818, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[1]", 1, 5, 6041, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_b2.dimensionsFM[2]", 1, 5, 6042, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.crossAreas[1]", "Volumes cross sectional area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.crossAreas[2]", "Volumes cross sectional area [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.dlengths[1]", "Volumes length [m]", \
"EM.pipe_b2.geometry.dlengths[1]", 1, 5, 5858, 0)
DeclareAlias2("EM.pipe_b2.internalTraceGen.dlengths[2]", "Volumes length [m]", \
"EM.pipe_b2.geometry.dlengths[2]", 1, 5, 5859, 0)
DeclareVariable("EM.pipe_b2.exposeState_a", "=true, p is calculated at port_a else m_flow [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.exposeState_b", "=true, p is calculated at port_b else m_flow [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.momentumDynamics", "Formulation of momentum balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.g_n", "Gravitational acceleration [m/s2]", 9.80665, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.useInnerPortProperties", "=true to take port properties for flow models from internal control volumes [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.useLumpedPressure", "=true to lump pressure states together [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.pipe_b2.lumpPressureAt", "Location of pressure for flow calculations [:#(type=TRANSFORM.Fluid.Types.LumpedLocation)]",\
 507, 1, 1.0,2.0,0.0,0,564)
DeclareVariable("EM.pipe_b2.nFM", "number of flow models in flowModel [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.nFMDistributed", "[:#(type=Integer)]", 1, 0.0,0.0,\
0.0,0,517)
DeclareVariable("EM.pipe_b2.nFMLumped", "[:#(type=Integer)]", 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.iLumped", "Index of control volume with representative state if useLumpedPressure [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.dp_start", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.dps_start[1]", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.m_flowsFM_start[1]", "[kg/s]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.Ts_wallFM_start[1]", "[K|degC]", 293.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.pipe_b2.Ts_wallFM_start[2]", "[K|degC]", 293.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.pipe_b2.state_a.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("EM.pipe_b2.state_a.h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareVariable("EM.pipe_b2.state_a.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("EM.pipe_b2.state_a.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_b2.state_a.p", "Pressure [Pa|bar]", "EM.pipe_b2.mediums[1].p", 1,\
 1, 183, 0)
DeclareVariable("EM.pipe_b2.state_b.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("EM.pipe_b2.state_b.h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareVariable("EM.pipe_b2.state_b.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("EM.pipe_b2.state_b.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_b2.state_b.p", "Pressure [Pa|bar]", "EM.pipe_b2.mediums[2].p", 1,\
 1, 185, 0)
DeclareVariable("EM.pipe_b2.m_flows[1]", "Mass flow rates across segment boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_b2.m_flows[2]", "Mass flow rates across segment boundaries [kg/s]",\
 "EM.pipe_b2.der(ms[1])", -1, 5, 5834, 0)
DeclareVariable("EM.pipe_b2.m_flows[3]", "Mass flow rates across segment boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.H_flows[1]", "Enthalpy flow rates across segment boundaries [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.H_flows[2]", "Enthalpy flow rates across segment boundaries [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.H_flows[3]", "Enthalpy flow rates across segment boundaries [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.vs[1]", "mean velocities in flow segments [m/s]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.vs[2]", "mean velocities in flow segments [m/s]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.Ts_wall[1, 1]", "use_HeatTransfer = true then wall temperature else bulk medium temperature [K|degC]",\
 293.15, 273.15,2273.15,300.0,0,512)
DeclareVariable("EM.pipe_b2.Ts_wall[2, 1]", "use_HeatTransfer = true then wall temperature else bulk medium temperature [K|degC]",\
 293.15, 273.15,2273.15,300.0,0,512)
DeclareVariable("EM.pipe_b2.Wb_flows[1]", "Mechanical power, p*der(V) etc. [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.Wb_flows[2]", "Mechanical power, p*der(V) etc. [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("EM.pipe_b2.showName", "[:#(type=Boolean)]", 508, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("EM.pipe_b2.showDesignFlowDirection", "[:#(type=Boolean)]", 509,\
 true, 0.0,0.0,0.0,0,562)
DeclareVariable("EM.pipe_b2.showColors", "Toggle dynamic color display [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("EM.pipe_b2.val", "Color map input variable [K]", "EM.pipe_b2.summary.T_effective", 1,\
 5, 5807, 0)
DeclareVariable("EM.pipe_b2.val_min", "val <= val_min is mapped to colorMap[1,:] []",\
 293.15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.val_max", "val >= val_max is mapped to colorMap[end,:] []",\
 373.15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.n_colors", "Number of colors in the colorMap, multiples of 4 is best [:#(type=Integer)]",\
 64, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_b2.dynColor[1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.dynColor[2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.dynColor[3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.calc_Wb", "= false to not calculate p*der(V) [Wb_flows] for energy equation [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("EM.pipe_b2.heatPorts_int[1, 1].T", "Port temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 1028)
DeclareVariable("EM.pipe_b2.heatPorts_int[1, 1].Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareAlias2("EM.pipe_b2.heatPorts_int[2, 1].T", "Port temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 1028)
DeclareVariable("EM.pipe_b2.heatPorts_int[2, 1].Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("EM.pipe_b2.statesFM[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,2692)
DeclareAlias2("EM.pipe_b2.statesFM[1].h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[1].h", 1, 1, 184, 1024)
DeclareVariable("EM.pipe_b2.statesFM[1].d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("EM.pipe_b2.statesFM[1].der(d)", "der(Density) [Pa.m-2.s]", 0.0,\
 0.0,0.0,0.0,0,2560)
DeclareAlias2("EM.pipe_b2.statesFM[1].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 1024)
DeclareAlias2("EM.pipe_b2.statesFM[1].p", "Pressure [Pa|bar]", "EM.pipe_b2.mediums[1].p", 1,\
 1, 183, 1024)
DeclareVariable("EM.pipe_b2.statesFM[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,2692)
DeclareAlias2("EM.pipe_b2.statesFM[2].h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[2].h", 1, 1, 186, 1024)
DeclareVariable("EM.pipe_b2.statesFM[2].d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("EM.pipe_b2.statesFM[2].der(d)", "der(Density) [Pa.m-2.s]", 0.0,\
 0.0,0.0,0.0,0,2560)
DeclareAlias2("EM.pipe_b2.statesFM[2].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 1024)
DeclareAlias2("EM.pipe_b2.statesFM[2].p", "Pressure [Pa|bar]", "EM.pipe_b2.mediums[2].p", 1,\
 1, 185, 1024)
DeclareAlias2("EM.pipe_b2.Ts_wallFM[1]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 1024)
DeclareAlias2("EM.pipe_b2.Ts_wallFM[2]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 1024)
DeclareAlias2("EM.pipe_b2.vsFM[1]", "Mean velocities in flow segments [m/s]", \
"EM.pipe_b2.vs[1]", 1, 5, 6017, 1024)
DeclareAlias2("EM.pipe_b2.vsFM[2]", "Mean velocities in flow segments [m/s]", \
"EM.pipe_b2.vs[2]", 1, 5, 6018, 1024)
DeclareVariable("EM.pipe_b2.dlengthsFM[1]", "Lengths of flow segments [m]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_b2.dheightsFM[1]", "Differences in heights between flow segments [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_b2.dimensionsFM[1]", "Hydraulic diameters of flow segments [m]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_b2.dimensionsFM[2]", "Hydraulic diameters of flow segments [m]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_b2.crossAreasFM[1]", "Cross flow areas of flow segments [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("EM.pipe_b2.crossAreasFM[2]", "Cross flow areas of flow segments [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 1024)
DeclareVariable("EM.pipe_b2.perimetersFM[1]", "Wetted perimeters of flow segments [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("EM.pipe_b2.perimetersFM[2]", "Wetted perimeters of flow segments [m]",\
 "EM.pipe_b2.perimetersFM[1]", 1, 5, 6044, 1024)
DeclareVariable("EM.pipe_b2.roughnessesFM[1]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_b2.roughnessesFM[2]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_a2.summary.T_effective", "Unit cell mass averaged temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,512)
DeclareVariable("EM.pipe_a2.summary.T_max", "Maximum temperature [K|degC]", \
288.15, 0.0,1E+100,300.0,0,512)
DeclareVariable("EM.pipe_a2.summary.xpos[1]", "x-position for physical location reference",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.summary.xpos[2]", "x-position for physical location reference",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.summary.xpos_norm[1]", "x-position for physical location reference normalized by total length",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.summary.xpos_norm[2]", "x-position for physical location reference normalized by total length",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -1E+60,100000.0,0.0,0,777)
DeclareAlias2("EM.pipe_a2.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.pipe_a2.mediums[1].p", 1, 1, 188, 4)
DeclareAlias2("EM.pipe_a2.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 4)
DeclareVariable("EM.pipe_a2.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,1E+60,0.0,0,777)
DeclareAlias2("EM.pipe_a2.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.pipe_a2.mediums[2].p", 1, 1, 190, 4)
DeclareAlias2("EM.pipe_a2.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 4)
DeclareParameter("EM.pipe_a2.nParallel", "Number of parallel components [1]", 510,\
 1, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_a2.nV", "Number of discrete volumes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareVariable("EM.pipe_a2.Vs[1]", "Discretized volumes [m3]", 0.0, 0.0,1E+100,\
0.0,0,513)
DeclareVariable("EM.pipe_a2.Vs[2]", "Discretized volumes [m3]", 0.0, 0.0,1E+100,\
0.0,0,513)
DeclareVariable("EM.pipe_a2.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.ps_start[1]", "Pressure [Pa|bar]", 0.0, 0.0,1E+100,\
100000.0,0,513)
DeclareVariable("EM.pipe_a2.ps_start[2]", "Pressure [Pa|bar]", 0.0, 0.0,1E+100,\
100000.0,0,513)
DeclareVariable("EM.pipe_a2.use_Ts_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.Ts_start[1]", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_a2.Ts_start[2]", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_a2.hs_start[1]", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.hs_start[2]", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.Xs_start[1, 1]", "Mass fraction [1]", 0.0, 0.0,1.0,\
0.0,0,513)
DeclareVariable("EM.pipe_a2.Xs_start[2, 1]", "Mass fraction [1]", 0.0, 0.0,1.0,\
0.0,0,513)
DeclareVariable("EM.pipe_a2.ms[1]", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("EM.pipe_a2.ms[2]", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("EM.pipe_a2.der(ms[1])", "der(Mass) [kg/s]", 0.0, -1E+100,1E+60,\
0.0,0,512)
DeclareAlias2("EM.pipe_a2.der(ms[2])", "der(Mass) [kg/s]", "EM.pipe_a2.der(ms[1])", -1,\
 5, 6074, 0)
DeclareVariable("EM.pipe_a2.Us[1]", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.Us[2]", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.der(Us[1])", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.der(Us[2])", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_a2.mbs[1]", "Mass flow rate balances across volume interfaces (e.g., enthalpy flow, diffusion) and source/sinks within volumes [kg/s]",\
 "EM.pipe_a2.der(ms[1])", 1, 5, 6074, 0)
DeclareAlias2("EM.pipe_a2.mbs[2]", "Mass flow rate balances across volume interfaces (e.g., enthalpy flow, diffusion) and source/sinks within volumes [kg/s]",\
 "EM.pipe_a2.der(ms[1])", -1, 5, 6074, 0)
DeclareAlias2("EM.pipe_a2.Ubs[1]", "Energy sources across volume interfaces (e.g., thermal diffusion) and source/sinks within volumes [W]",\
 "EM.pipe_a2.der(Us[1])", 1, 5, 6077, 0)
DeclareAlias2("EM.pipe_a2.Ubs[2]", "Energy sources across volume interfaces (e.g., thermal diffusion) and source/sinks within volumes [W]",\
 "EM.pipe_a2.der(Us[2])", 1, 5, 6078, 0)
DeclareParameter("EM.pipe_a2.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 511, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("EM.pipe_a2.p_a_start", "Pressure at port a [Pa|bar]", 0.0, 0.0,\
1E+100,100000.0,0,513)
DeclareVariable("EM.pipe_a2.p_b_start", "Pressure at port b [Pa|bar]", 0.0, 0.0,\
1E+100,100000.0,0,513)
DeclareVariable("EM.pipe_a2.T_a_start", "Temperature at port a [K|degC]", 293.15,\
 0.0,1E+100,300.0,0,513)
DeclareVariable("EM.pipe_a2.T_b_start", "Temperature at port b [K|degC]", 293.15,\
 0.0,1E+100,300.0,0,513)
DeclareVariable("EM.pipe_a2.h_a_start", "Specific enthalpy at port a [J/kg]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.h_b_start", "Specific enthalpy at port b [J/kg]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("EM.pipe_a2.X_a_start[1]", "Mass fraction at port a [1]", 512, \
1.0, 0.0,1.0,0.0,0,560)
DeclareVariable("EM.pipe_a2.X_b_start[1]", "Mass fraction at port b [1]", 0.0, \
0.0,1.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.m_flow_a_start", "Mass flow rate at port_a [kg/s]", \
70.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.m_flow_b_start", "Mass flow rate at port_b [kg/s]", \
-70.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.m_flows_start[1]", "Mass flow rates [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.m_flows_start[2]", "Mass flow rates [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.m_flows_start[3]", "Mass flow rates [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_a2.geometry.dimension", "Characteristic dimension (e.g., hydraulic diameter) [m]",\
 "EM.diameter_a2", 1, 5, 5729, 0)
DeclareAlias2("EM.pipe_a2.geometry.crossArea", "Cross-sectional flow areas [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.geometry.perimeter", "Wetted perimeters [m]", \
"EM.pipe_a2.perimetersFM[1]", 1, 5, 6284, 0)
DeclareAlias2("EM.pipe_a2.geometry.length", "Pipe length [m]", "EM.length_a2", 1,\
 5, 5728, 0)
DeclareVariable("EM.pipe_a2.geometry.roughness", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.surfaceArea[1]", "Area per transfer surface [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.angle", "Vertical angle from the horizontal (-pi/2 < x <= pi/2) [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.dheight", "Height(port_b) - Height(port_a) distributed by flow segment [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.figure", "Index for Icon figure [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.geometry.nV", "Number of volume nodes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareVariable("EM.pipe_a2.geometry.nSurfaces", "Number of transfer (heat/mass) surfaces [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_a2.geometry.dimensions[1]", "Characteristic dimension (e.g., hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[1]", 1, 5, 6281, 0)
DeclareAlias2("EM.pipe_a2.geometry.dimensions[2]", "Characteristic dimension (e.g., hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[2]", 1, 5, 6282, 0)
DeclareAlias2("EM.pipe_a2.geometry.crossAreas[1]", "Cross sectional area of unit volumes [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.geometry.crossAreas[2]", "Cross sectional area of unit volumes [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.geometry.perimeters[1]", "Wetted perimeter of unit volumes [m]",\
 "EM.pipe_a2.perimetersFM[1]", 1, 5, 6284, 0)
DeclareAlias2("EM.pipe_a2.geometry.perimeters[2]", "Wetted perimeter of unit volumes [m]",\
 "EM.pipe_a2.perimetersFM[1]", 1, 5, 6284, 0)
DeclareVariable("EM.pipe_a2.geometry.dlengths[1]", "Unit cell length [m]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.dlengths[2]", "Unit cell length [m]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.roughnesses[1]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.roughnesses[2]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.surfaceAreas[1, 1]", "Discretized area per transfer surface [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.surfaceAreas[2, 1]", "Discretized area per transfer surface [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.angles[1]", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.angles[2]", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.dheights[1]", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.dheights[2]", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_a2.geometry.Vs[1]", "Unit volumes [m3]", "EM.pipe_a2.Vs[1]", 1,\
 5, 6057, 0)
DeclareAlias2("EM.pipe_a2.geometry.Vs[2]", "Unit volumes [m3]", "EM.pipe_a2.Vs[2]", 1,\
 5, 6058, 0)
DeclareVariable("EM.pipe_a2.geometry.V_total", "Total volume of component [m3]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_a2.geometry.surfaceAreas_nVtotal[1]", "Total surface area for each volume node [m2]",\
 "EM.pipe_a2.geometry.surfaceAreas[1, 1]", 1, 5, 6102, 0)
DeclareAlias2("EM.pipe_a2.geometry.surfaceAreas_nVtotal[2]", "Total surface area for each volume node [m2]",\
 "EM.pipe_a2.geometry.surfaceAreas[1, 1]", 1, 5, 6102, 0)
DeclareVariable("EM.pipe_a2.geometry.surfaceArea_total", "Total surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.dxs[1]", "Fractional lengths [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.geometry.dxs[2]", "Fractional lengths [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.nFM", "Number of discrete flow models [:#(type=Integer)]",\
 1, 1.0,1E+100,0.0,0,517)
DeclareVariable("EM.pipe_a2.flowModel.g_n", "Gravitational acceleration [m/s2]",\
 9.80665, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.momentumDynamics", "Formulation of momentum balance [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.flowModel.dps_start[1]", "Pressure changes {p[2]-p[1],...,p[n+1]-p[n]} [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.m_flows_start[1]", "Mass flow rates [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_a2.flowModel.vs[1]", "Mean velocities of fluid flow [m/s]",\
 "EM.pipe_a2.vs[1]", 1, 5, 6257, 0)
DeclareAlias2("EM.pipe_a2.flowModel.vs[2]", "Mean velocities of fluid flow [m/s]",\
 "EM.pipe_a2.vs[2]", 1, 5, 6258, 0)
DeclareAlias2("EM.pipe_a2.flowModel.Ts_wall[1]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.flowModel.Ts_wall[2]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.flowModel.dimensions[1]", "Characteristic dimensions (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[1]", 1, 5, 6281, 0)
DeclareAlias2("EM.pipe_a2.flowModel.dimensions[2]", "Characteristic dimensions (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[2]", 1, 5, 6282, 0)
DeclareAlias2("EM.pipe_a2.flowModel.crossAreas[1]", "Cross sectional area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.flowModel.crossAreas[2]", "Cross sectional area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.flowModel.perimeters[1]", "Wetted perimeter [m]", \
"EM.pipe_a2.perimetersFM[1]", 1, 5, 6284, 0)
DeclareAlias2("EM.pipe_a2.flowModel.perimeters[2]", "Wetted perimeter [m]", \
"EM.pipe_a2.perimetersFM[1]", 1, 5, 6284, 0)
DeclareAlias2("EM.pipe_a2.flowModel.dlengths[1]", "Length of flow model [m]", \
"EM.pipe_a2.dlengthsFM[1]", 1, 5, 6279, 0)
DeclareVariable("EM.pipe_a2.flowModel.roughnesses[1]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.roughnesses[2]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.dheights[1]", "Height(states[2:nFM+1]) - Height(states[1:nFM]) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (m_flows >= zeros(m)) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.flowModel.Re_lam", "Laminar transition Reynolds number [1]",\
 2300, -1E+100,4000.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.Re_turb", "Turbulent transition Reynolds number [1]",\
 4000, 2300.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.from_dp", "= true, use m_flow = f(dp), otherwise dp = f(m_flow) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.pipe_a2.flowModel.m_flow_small", "Within regularization if |m_flows| < m_flow_small (may be wider for large discontinuities in static head) [kg/s]",\
 513, 0.001, 0.0,0.0,0.0,0,560)
DeclareParameter("EM.pipe_a2.flowModel.dp_small", "Within regularization if |dp| < dp_small (may be wider for large discontinuities in static head) [Pa|bar]",\
 514, 1, 0.0,1E+100,100000.0,0,560)
DeclareAlias2("EM.pipe_a2.flowModel.m_flows[1]", "Mass flow rate across interfaces [kg/s]",\
 "EM.pipe_a2.der(ms[1])", -1, 5, 6074, 0)
DeclareVariable("EM.pipe_a2.flowModel.Is[1]", "Momenta of flow segments [kg.m/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.flowModel.Ibs[1]", "Flow of momentum across boundaries and source/sink in volumes [N]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_a2.flowModel.Ts_fluid[1]", "Fluid temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.flowModel.Ts_fluid[2]", "Fluid temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareVariable("EM.pipe_a2.flowModel.Res[1]", "Reynolds number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.flowModel.Re_center", "Re smoothing transition center [1]",\
 3150.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_a2.flowModel.Re_width", "Re smoothing transition width [1]",\
 850.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_a2.flowModel.Ks_ab[1]", "Minor loss coefficients. Flow in direction a -> b [1]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.Ks_ba[1]", "Minor loss coefficients. Flow in direction b -> a [1]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.use_I_flows", "= true to consider differences in flow of momentum through boundaries [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.pipe_a2.flowModel.taus[1]", "Time Constant for first order delay of {dps_K,dps_add} [s]",\
 515, 0.01, 0.0,0.0,0.0,0,560)
DeclareParameter("EM.pipe_a2.flowModel.taus[2]", "Time Constant for first order delay of {dps_K,dps_add} [s]",\
 516, 0.01, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_a2.flowModel.I_flows[1]", "Flow of momentum across boundaries [N]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.Fs_p[1]", "Pressure forces [N]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_a2.flowModel.Fs_fg[1]", "Friction and gravity forces [N]",\
 "EM.pipe_a2.flowModel.Fs_p[1]", -1, 5, 6135, 0)
DeclareVariable("EM.pipe_a2.flowModel.dps_fg[1]", "Pressure drop between states [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.flowModel.dps_K[1]", "Minor form-losses (K-loss) [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.dp_nominal", "Nominal pressure loss (only for nominal models) [Pa|bar]",\
 1, 0.0,1E+100,100000.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.m_flow_nominal", "Nominal mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.use_d_nominal", "= true, if d_nominal is used, otherwise computed from medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.flowModel.d_nominal", "Nominal density (e.g., rho_liquidWater = 995, rho_air = 1.2) [kg/m3|g/cm3]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.use_mu_nominal", "= true, if mu_nominal is used, otherwise computed from medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.flowModel.mu_nominal", "Nominal dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5) [Pa.s]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.continuousFlowReversal", "= true if the pressure loss is continuous around zero flow [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.flowModel.mus[1]", "[Pa.s]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("EM.pipe_a2.flowModel.mus_a[1]", "[Pa.s]", 0.001, 0.0,\
100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_a2.flowModel.mus_b[1]", "[Pa.s]", 0.001, 0.0,\
100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_a2.flowModel.ds[1]", "[kg/m3|g/cm3]", 0.0, 0.0,1E+100,\
0.0,0,512)
DeclareAlias2("EM.pipe_a2.flowModel.ds_a[1]", "[kg/m3|g/cm3]", "EM.pipe_a2.statesFM[1].d", 1,\
 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.flowModel.ds_b[1]", "[kg/m3|g/cm3]", "EM.pipe_a2.statesFM[2].d", 1,\
 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var_nominal.rho_a", "Density at port_a [kg/m3|g/cm3]",\
 "EM.pipe_a2.flowModel.d_nominal", 1, 5, 6141, 1024)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var_nominal.rho_b", "Density at port_b [kg/m3|g/cm3]",\
 "EM.pipe_a2.flowModel.d_nominal", 1, 5, 6141, 1024)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var_nominal.mu_a", "Dynamic viscosity at port_a [Pa.s]",\
 "EM.pipe_a2.flowModel.mu_nominal", 1, 5, 6143, 1024)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var_nominal.mu_b", "Dynamic viscosity at port_b [Pa.s]",\
 "EM.pipe_a2.flowModel.mu_nominal", 1, 5, 6143, 1024)
DeclareVariable("EM.pipe_a2.flowModel.dp_fric_nominal", "pressure loss for nominal conditions [Pa|bar]",\
 0.0, 0.0,1E+100,100000.0,0,2561)
DeclareVariable("EM.pipe_a2.use_HeatTransfer", "= true to use the HeatTransfer model [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.heatTransfer.nParallel", "Number of parallel components [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.nHT", "Number of heat transfer segments [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.heatTransfer.nSurfaces", "Number of heat transfer surfaces [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.heatTransfer.flagIdeal", "Flag for models to handle ideal boundary [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[1].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[1].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[2].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[2].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.vs[1]", "Fluid Velocity [m/s]", \
"EM.pipe_a2.vs[1]", 1, 5, 6257, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.vs[2]", "Fluid Velocity [m/s]", \
"EM.pipe_a2.vs[2]", 1, 5, 6258, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[1]", 1, 5, 6281, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[2]", 1, 5, 6282, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.crossAreas[1]", "Cross sectional flow area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.crossAreas[2]", "Cross sectional flow area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.dlengths[1]", "Characteristic length of heat transfer segment [m]",\
 "EM.pipe_a2.geometry.dlengths[1]", 1, 5, 6098, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.dlengths[2]", "Characteristic length of heat transfer segment [m]",\
 "EM.pipe_a2.geometry.dlengths[2]", 1, 5, 6099, 0)
DeclareVariable("EM.pipe_a2.heatTransfer.roughnesses[1]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.roughnesses[2]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareAlias2("EM.pipe_a2.heatTransfer.surfaceAreas[1, 1]", "Surface area for heat transfer [m2]",\
 "EM.pipe_a2.geometry.surfaceAreas[1, 1]", 1, 5, 6102, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.surfaceAreas[2, 1]", "Surface area for heat transfer [m2]",\
 "EM.pipe_a2.geometry.surfaceAreas[2, 1]", 1, 5, 6103, 0)
DeclareVariable("EM.pipe_a2.heatTransfer.Ts_start[1]", "[K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.Ts_start[2]", "[K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.Re_lam", "Laminar transition Reynolds number [1]",\
 2300, -1E+100,4000.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.Re_turb", "Turbulent transition Reynolds number [1]",\
 4000, 2300.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.CF", "Correction Factor: Q = CF*alpha*A*dT [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.CFs[1, 1]", "if non-uniform then set [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.CFs[2, 1]", "if non-uniform then set [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.states_wall[1, 1].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.heatTransfer.states_wall[1, 1].h", "Specific enthalpy [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.states_wall[1, 1].d", "Density [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,512)
DeclareAlias2("EM.pipe_a2.heatTransfer.states_wall[1, 1].T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states_wall[1, 1].p", "Pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareVariable("EM.pipe_a2.heatTransfer.states_wall[2, 1].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.heatTransfer.states_wall[2, 1].h", "Specific enthalpy [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.states_wall[2, 1].d", "Density [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,512)
DeclareAlias2("EM.pipe_a2.heatTransfer.states_wall[2, 1].T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.states_wall[2, 1].p", "Pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.Ts_fluid[1]", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.Ts_fluid[2]", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.Ts_wall[1, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.Ts_wall[2, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareVariable("EM.pipe_a2.heatTransfer.m_flows[1]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.m_flows[2]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.Res[1]", "Reynolds number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.Res[2]", "Reynolds number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.Prs[1]", "Prandtl number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.Prs[2]", "Prandtl number [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.alphas[1, 1]", "Coefficient of heat transfer [W/(m2.K)]",\
 1E+60, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.alphas[2, 1]", "Coefficient of heat transfer [W/(m2.K)]",\
 1E+60, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.Nus[1, 1]", "Nusselt number [1]", 1E+60,\
 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.Nus[2, 1]", "Nusselt number [1]", 1E+60,\
 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.Q_flows[1, 1]", "Heat flow rate [W]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.Q_flows[2, 1]", "Heat flow rate [W]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.heatTransfer.heatPorts[1, 1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("EM.pipe_a2.heatTransfer.heatPorts[1, 1].T", "Temperature at the connection point [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 4)
DeclareVariable("EM.pipe_a2.heatTransfer.heatPorts[2, 1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("EM.pipe_a2.heatTransfer.heatPorts[2, 1].T", "Temperature at the connection point [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 4)
DeclareVariable("EM.pipe_a2.heatTransfer.Re_center", "Re smoothing transition center [1]",\
 3150.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_a2.heatTransfer.Re_width", "Re smoothing transition width [1]",\
 850.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].state.T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].T", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[1].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareVariable("EM.pipe_a2.heatTransfer.mediums[1].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.mediums[1].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.mediums[1].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].state.T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].T", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.heatTransfer.mediums[2].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareVariable("EM.pipe_a2.heatTransfer.mediums[2].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.mediums[2].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_a2.heatTransfer.mediums[2].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("EM.pipe_a2.internalHeatGen.nV", "Number of discrete volumes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[1].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[1].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[2].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[2].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.Vs[1]", "Volumes [m3]", \
"EM.pipe_a2.Vs[1]", 1, 5, 6057, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.Vs[2]", "Volumes [m3]", \
"EM.pipe_a2.Vs[2]", 1, 5, 6058, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[1]", 1, 5, 6281, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[2]", 1, 5, 6282, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.crossAreas[1]", "Volumes cross sectional area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.crossAreas[2]", "Volumes cross sectional area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.dlengths[1]", "Volumes length [m]", \
"EM.pipe_a2.geometry.dlengths[1]", 1, 5, 6098, 0)
DeclareAlias2("EM.pipe_a2.internalHeatGen.dlengths[2]", "Volumes length [m]", \
"EM.pipe_a2.geometry.dlengths[2]", 1, 5, 6099, 0)
DeclareVariable("EM.pipe_a2.internalHeatGen.Q_flows[1]", "Internal heat generated [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.internalHeatGen.Q_flows[2]", "Internal heat generated [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.internalHeatGen.Q_gen", "Per volume heat generation [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.internalHeatGen.Q_gens[1]", "if non-uniform then set Q_gens [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.internalHeatGen.Q_gens[2]", "if non-uniform then set Q_gens [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.use_TraceMassTransfer", "= true to use the TraceMassTransfer model [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.traceMassTransfer.nParallel", "Number of parallel components [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.traceMassTransfer.nMT", "Number of mass transfer segments [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.traceMassTransfer.nSurfaces", "Number of mass transfer surfaces [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.traceMassTransfer.flagIdeal", "Flag for models to handle ideal boundary [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[1].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[1].T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[2].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[2].T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.Ts_wall[1, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.Ts_wall[2, 1]", "Wall temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.vs[1]", "Fluid Velocity [m/s]", \
"EM.pipe_a2.vs[1]", 1, 5, 6257, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.vs[2]", "Fluid Velocity [m/s]", \
"EM.pipe_a2.vs[2]", 1, 5, 6258, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[1]", 1, 5, 6281, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[2]", 1, 5, 6282, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.crossAreas[1]", "Cross sectional flow area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.crossAreas[2]", "Cross sectional flow area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.dlengths[1]", "Characteristic length of transfer segment [m]",\
 "EM.pipe_a2.geometry.dlengths[1]", 1, 5, 6098, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.dlengths[2]", "Characteristic length of transfer segment [m]",\
 "EM.pipe_a2.geometry.dlengths[2]", 1, 5, 6099, 0)
DeclareVariable("EM.pipe_a2.traceMassTransfer.roughnesses[1]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.traceMassTransfer.roughnesses[2]", "Average height of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.surfaceAreas[1, 1]", \
"Surface area for transfer [m2]", "EM.pipe_a2.geometry.surfaceAreas[1, 1]", 1, 5,\
 6102, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.surfaceAreas[2, 1]", \
"Surface area for transfer [m2]", "EM.pipe_a2.geometry.surfaceAreas[2, 1]", 1, 5,\
 6103, 0)
DeclareVariable("EM.pipe_a2.traceMassTransfer.nC", "[:#(type=Integer)]", 0, \
0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.traceMassTransfer.diffusionCoeff[1].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.diffusionCoeff[1].T", \
"Temperature [K|degC]", "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareVariable("EM.pipe_a2.traceMassTransfer.diffusionCoeff[1].D_ab0", \
"Diffusion Coefficient [m2/s]", 1E-15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.traceMassTransfer.diffusionCoeff[2].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,517)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.diffusionCoeff[2].T", \
"Temperature [K|degC]", "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareVariable("EM.pipe_a2.traceMassTransfer.diffusionCoeff[2].D_ab0", \
"Diffusion Coefficient [m2/s]", 1E-15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.traceMassTransfer.Re_lam", "Laminar transition Reynolds number [1]",\
 2300, -1E+100,4000.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.traceMassTransfer.Re_turb", "Turbulent transition Reynolds number [1]",\
 4000, 2300.0,1E+100,0.0,0,513)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.Ts_fluid[1]", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.Ts_fluid[2]", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareVariable("EM.pipe_a2.traceMassTransfer.m_flows[1]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.m_flows[2]", "Fluid mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.Res[1]", "Reynolds number [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.Res[2]", "Reynolds number [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.xs[1]", "Position of local mass transfer calculation [m]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.xs[2]", "Position of local mass transfer calculation [m]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.massPorts[1, 1].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,525)
DeclareVariable("EM.pipe_a2.traceMassTransfer.massPorts[2, 1].nC", \
"Number of substances [:#(type=Integer)]", 0, 0.0,0.0,0.0,0,525)
DeclareVariable("EM.pipe_a2.traceMassTransfer.toMole_unitConv", "[mol]", 1, 0.0,\
1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_a2.traceMassTransfer.Re_center", "Re smoothing transition center [1]",\
 3150.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_a2.traceMassTransfer.Re_width", "Re smoothing transition width [1]",\
 850.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_a2.traceMassTransfer.nC_noT", "# of species not transfered from fluid [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,2565)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].state.T", \
"Temperature [K|degC]", "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].state.p", \
"Pressure [Pa|bar]", "EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].T", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[1].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareVariable("EM.pipe_a2.traceMassTransfer.mediums[1].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.mediums[1].lambda", \
"Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.mediums[1].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].state.T", \
"Temperature [K|degC]", "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].state.p", \
"Pressure [Pa|bar]", "EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].T", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.traceMassTransfer.mediums[2].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareVariable("EM.pipe_a2.traceMassTransfer.mediums[2].mu", "Dynamic viscosity [Pa.s]",\
 0.001, 0.0,100000000.0,0.001,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.mediums[2].lambda", \
"Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_a2.traceMassTransfer.mediums[2].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("EM.pipe_a2.internalTraceGen.nV", "Number of discrete volumes [:#(type=Integer)]",\
 2, 1.0,1E+100,0.0,0,517)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[1].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[1].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[1].T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[2].h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[2].d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[2].T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.Vs[1]", "Volumes [m3]", \
"EM.pipe_a2.Vs[1]", 1, 5, 6057, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.Vs[2]", "Volumes [m3]", \
"EM.pipe_a2.Vs[2]", 1, 5, 6058, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.dimensions[1]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[1]", 1, 5, 6281, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.dimensions[2]", "Characteristic dimension (e.g. hydraulic diameter) [m]",\
 "EM.pipe_a2.dimensionsFM[2]", 1, 5, 6282, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.crossAreas[1]", "Volumes cross sectional area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.crossAreas[2]", "Volumes cross sectional area [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.dlengths[1]", "Volumes length [m]", \
"EM.pipe_a2.geometry.dlengths[1]", 1, 5, 6098, 0)
DeclareAlias2("EM.pipe_a2.internalTraceGen.dlengths[2]", "Volumes length [m]", \
"EM.pipe_a2.geometry.dlengths[2]", 1, 5, 6099, 0)
DeclareVariable("EM.pipe_a2.exposeState_a", "=true, p is calculated at port_a else m_flow [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.exposeState_b", "=true, p is calculated at port_b else m_flow [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.momentumDynamics", "Formulation of momentum balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.g_n", "Gravitational acceleration [m/s2]", 9.80665, \
0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.useInnerPortProperties", "=true to take port properties for flow models from internal control volumes [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.useLumpedPressure", "=true to lump pressure states together [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("EM.pipe_a2.lumpPressureAt", "Location of pressure for flow calculations [:#(type=TRANSFORM.Fluid.Types.LumpedLocation)]",\
 517, 1, 1.0,2.0,0.0,0,564)
DeclareVariable("EM.pipe_a2.nFM", "number of flow models in flowModel [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.nFMDistributed", "[:#(type=Integer)]", 1, 0.0,0.0,\
0.0,0,517)
DeclareVariable("EM.pipe_a2.nFMLumped", "[:#(type=Integer)]", 1, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.iLumped", "Index of control volume with representative state if useLumpedPressure [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.dp_start", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.dps_start[1]", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.m_flowsFM_start[1]", "[kg/s]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.Ts_wallFM_start[1]", "[K|degC]", 293.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.pipe_a2.Ts_wallFM_start[2]", "[K|degC]", 293.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("EM.pipe_a2.state_a.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("EM.pipe_a2.state_a.h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareVariable("EM.pipe_a2.state_a.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("EM.pipe_a2.state_a.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_a2.state_a.p", "Pressure [Pa|bar]", "EM.pipe_a2.mediums[1].p", 1,\
 1, 188, 0)
DeclareVariable("EM.pipe_a2.state_b.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("EM.pipe_a2.state_b.h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareVariable("EM.pipe_a2.state_b.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("EM.pipe_a2.state_b.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_a2.state_b.p", "Pressure [Pa|bar]", "EM.pipe_a2.mediums[2].p", 1,\
 1, 190, 0)
DeclareVariable("EM.pipe_a2.m_flows[1]", "Mass flow rates across segment boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_a2.m_flows[2]", "Mass flow rates across segment boundaries [kg/s]",\
 "EM.pipe_a2.der(ms[1])", -1, 5, 6074, 0)
DeclareVariable("EM.pipe_a2.m_flows[3]", "Mass flow rates across segment boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.H_flows[1]", "Enthalpy flow rates across segment boundaries [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.H_flows[2]", "Enthalpy flow rates across segment boundaries [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.H_flows[3]", "Enthalpy flow rates across segment boundaries [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.vs[1]", "mean velocities in flow segments [m/s]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.vs[2]", "mean velocities in flow segments [m/s]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.Ts_wall[1, 1]", "use_HeatTransfer = true then wall temperature else bulk medium temperature [K|degC]",\
 293.15, 273.15,2273.15,300.0,0,512)
DeclareVariable("EM.pipe_a2.Ts_wall[2, 1]", "use_HeatTransfer = true then wall temperature else bulk medium temperature [K|degC]",\
 293.15, 273.15,2273.15,300.0,0,512)
DeclareVariable("EM.pipe_a2.Wb_flows[1]", "Mechanical power, p*der(V) etc. [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.Wb_flows[2]", "Mechanical power, p*der(V) etc. [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("EM.pipe_a2.showName", "[:#(type=Boolean)]", 518, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("EM.pipe_a2.showDesignFlowDirection", "[:#(type=Boolean)]", 519,\
 true, 0.0,0.0,0.0,0,562)
DeclareVariable("EM.pipe_a2.showColors", "Toggle dynamic color display [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("EM.pipe_a2.val", "Color map input variable [K]", "EM.pipe_a2.summary.T_effective", 1,\
 5, 6047, 0)
DeclareVariable("EM.pipe_a2.val_min", "val <= val_min is mapped to colorMap[1,:] []",\
 293.15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.val_max", "val >= val_max is mapped to colorMap[end,:] []",\
 373.15, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.n_colors", "Number of colors in the colorMap, multiples of 4 is best [:#(type=Integer)]",\
 64, 0.0,0.0,0.0,0,517)
DeclareVariable("EM.pipe_a2.dynColor[1]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.dynColor[2]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.dynColor[3]", "", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.calc_Wb", "= false to not calculate p*der(V) [Wb_flows] for energy equation [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("EM.pipe_a2.heatPorts_int[1, 1].T", "Port temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 1028)
DeclareVariable("EM.pipe_a2.heatPorts_int[1, 1].Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareAlias2("EM.pipe_a2.heatPorts_int[2, 1].T", "Port temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 1028)
DeclareVariable("EM.pipe_a2.heatPorts_int[2, 1].Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("EM.pipe_a2.statesFM[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,2692)
DeclareAlias2("EM.pipe_a2.statesFM[1].h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[1].h", 1, 1, 189, 1024)
DeclareVariable("EM.pipe_a2.statesFM[1].d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("EM.pipe_a2.statesFM[1].der(d)", "der(Density) [Pa.m-2.s]", 0.0,\
 0.0,0.0,0.0,0,2560)
DeclareAlias2("EM.pipe_a2.statesFM[1].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 1024)
DeclareAlias2("EM.pipe_a2.statesFM[1].p", "Pressure [Pa|bar]", "EM.pipe_a2.mediums[1].p", 1,\
 1, 188, 1024)
DeclareVariable("EM.pipe_a2.statesFM[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,2692)
DeclareAlias2("EM.pipe_a2.statesFM[2].h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[2].h", 1, 1, 191, 1024)
DeclareVariable("EM.pipe_a2.statesFM[2].d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("EM.pipe_a2.statesFM[2].der(d)", "der(Density) [Pa.m-2.s]", 0.0,\
 0.0,0.0,0.0,0,2560)
DeclareAlias2("EM.pipe_a2.statesFM[2].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 1024)
DeclareAlias2("EM.pipe_a2.statesFM[2].p", "Pressure [Pa|bar]", "EM.pipe_a2.mediums[2].p", 1,\
 1, 190, 1024)
DeclareAlias2("EM.pipe_a2.Ts_wallFM[1]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 1024)
DeclareAlias2("EM.pipe_a2.Ts_wallFM[2]", "Mean wall temperatures of heat transfer surface [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 1024)
DeclareAlias2("EM.pipe_a2.vsFM[1]", "Mean velocities in flow segments [m/s]", \
"EM.pipe_a2.vs[1]", 1, 5, 6257, 1024)
DeclareAlias2("EM.pipe_a2.vsFM[2]", "Mean velocities in flow segments [m/s]", \
"EM.pipe_a2.vs[2]", 1, 5, 6258, 1024)
DeclareVariable("EM.pipe_a2.dlengthsFM[1]", "Lengths of flow segments [m]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_a2.dheightsFM[1]", "Differences in heights between flow segments [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EM.pipe_a2.dimensionsFM[1]", "Hydraulic diameters of flow segments [m]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_a2.dimensionsFM[2]", "Hydraulic diameters of flow segments [m]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_a2.crossAreasFM[1]", "Cross flow areas of flow segments [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("EM.pipe_a2.crossAreasFM[2]", "Cross flow areas of flow segments [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 1024)
DeclareVariable("EM.pipe_a2.perimetersFM[1]", "Wetted perimeters of flow segments [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("EM.pipe_a2.perimetersFM[2]", "Wetted perimeters of flow segments [m]",\
 "EM.pipe_a2.perimetersFM[1]", 1, 5, 6284, 1024)
DeclareVariable("EM.pipe_a2.roughnessesFM[1]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,2561)
DeclareVariable("EM.pipe_a2.roughnessesFM[2]", "Average heights of surface asperities [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("BOP.CS.actuatorBus.opening_TCV", "TCV fraction open", \
"BOP.actuatorBus.opening_TCV", 1, 5, 6368, 4)
DeclareAlias2("BOP.CS.actuatorBus.opening_BV", "BV fraction open", \
"BOP.actuatorBus.opening_BV", 1, 5, 6369, 4)
DeclareVariable("BOP.CS.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("BOP.CS.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareAlias2("BOP.CS.sensorBus.W_total", "Total electrical power generated [W]",\
 "BOP.sensorBus.W_total", 1, 5, 6372, 4)
DeclareAlias2("BOP.CS.sensorBus.p_inlet_steamTurbine", "Inlet pressure to steam turbine [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareParameter("BOP.CS.delayStartTCV", "Delay start of TCV control [s]", 520, 0,\
 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.delayStartBV", "Delay start of BV control [s]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.CS.p_nominal", "Steam Pressure [Pa|bar]", 521, 3447400, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.TCV_opening_nominal", "Nominal opening of TCV - controls power",\
 522, 0.5, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.BV_opening_nominal", "Nominal opening of BV - controls pressure",\
 523, 0.001, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.W_totalSetpoint", "Total setpoint power from BOP [W]", \
"SC.W_totalSetpoint_BOP", 1, 5, 6938, 0)
DeclareVariable("BOP.CS.TCV_openingNominal.k", "Constant output value", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.TCV_openingNominal.y", "Connector of Real output signal", \
"BOP.CS.TCV_openingNominal.k", 1, 5, 6290, 0)
DeclareVariable("BOP.CS.switch_BV.u1", "Connector of first Real input signal", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.switch_BV.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,642)
DeclareAlias2("BOP.CS.switch_BV.u3", "Connector of second Real input signal", \
"BOP.CS.BV_diffopeningNominal.k", 1, 7, 575, 0)
DeclareVariable("BOP.CS.switch_BV.y", "Connector of Real output signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.BV_openingNominal.k", "Constant output value", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.BV_openingNominal.y", "Connector of Real output signal", \
"BOP.CS.BV_openingNominal.k", 1, 5, 6294, 0)
DeclareVariable("BOP.CS.greater5.u1", "Connector of first Real input signal [s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.CS.greater5.u2", "Connector of second Real input signal [s]",\
 "BOP.CS.valvedelay.k", 1, 5, 6297, 0)
DeclareVariable("BOP.CS.greater5.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,642)
DeclareAlias2("BOP.CS.clock.y", "Connector of Real output signal [s]", \
"BOP.CS.greater5.u1", 1, 5, 6295, 0)
DeclareParameter("BOP.CS.clock.offset", "Offset of output signal y [s]", 524, 0,\
 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.clock.startTime", "Output y = offset for time < startTime [s]",\
 525, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.valvedelay.k", "Constant output value [s]", 1, 0.0,0.0,\
0.0,0,513)
DeclareAlias2("BOP.CS.valvedelay.y", "Connector of Real output signal [s]", \
"BOP.CS.valvedelay.k", 1, 5, 6297, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.u_s", "Connector of setpoint input signal [Pa]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.CS.PID_TCV_opening.u_m", "Connector of measurement input signal [Pa]",\
 "BOP.CS.p_Nominal1.k", 1, 5, 6365, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.y", "Connector of actuator output signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_TCV_opening.controlError", "Control error (set point - measurement) [Pa]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_TCV_opening.controllerType", "Type of controller [:#(type=Modelica.Blocks.Types.SimpleController)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_TCV_opening.with_FF", "enable feed-forward input signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.CS.PID_TCV_opening.derMeas", "=true avoid derivative kick [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.CS.PID_TCV_opening.k", "Controller gain: +/- for direct/reverse acting [1]",\
 526, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.Ti", "Time constant of Integrator block [s]",\
 527, 0.5, 1E-60,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.Td", "Time constant of Derivative block [s]",\
 528, 0.1, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.yb", "Output bias. May improve simulation",\
 529, 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.k_s", "Setpoint input scaling: k_s*u_s. May improve simulation [1]",\
 530, 2.5E-09, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.k_m", "Measurement input scaling: k_m*u_m. May improve simulation [1]",\
 531, 2.5E-09, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.k_ff", "Measurement input scaling: k_ff*u_ff. May improve simulation",\
 532, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.PID_TCV_opening.yMax", "Upper limit of output", 1, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.yMin", "Lower limit of output", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.CS.PID_TCV_opening.wp", "Set-point weight for Proportional block (0..1)",\
 533, 1, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.wd", "Set-point weight for Derivative block (0..1)",\
 534, 0, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.Ni", "Ni*Ti is time constant of anti-windup compensation",\
 535, 0.9, 1E-13,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.Nd", "The higher Nd, the more ideal the derivative block",\
 536, 10, 1E-13,1E+100,0.0,0,560)
DeclareVariable("BOP.CS.PID_TCV_opening.initType", "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_TCV_opening.xi_start", "Initial or guess value value for integrator output (= integrator state)",\
 0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.CS.PID_TCV_opening.xd_start", "Initial or guess value for state of derivative block",\
 537, 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.y_start", "Initial value of output", 538,\
 0, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.PID_TCV_opening.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.CS.PID_TCV_opening.reset", "Type of controller output reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_TCV_opening.y_reset", "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.addP.u1", "Connector of Real input signal 1 [Pa]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_TCV_opening.addP.u2", "Connector of Real input signal 2 [Pa]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.addP.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_TCV_opening.addP.k1", "Gain of input signal 1", 0.0,\
 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.CS.PID_TCV_opening.addP.k2", "Gain of input signal 2", 539,\
 -1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.P.k", "Gain value multiplied with input signal [1]",\
 540, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_TCV_opening.P.u", "Input signal connector", \
"BOP.CS.PID_TCV_opening.addP.y", 1, 5, 6313, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.P.y", "Output signal connector", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_TCV_opening.gainPID.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.gainPID.u", "Input signal connector", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_TCV_opening.gainPID.y", "Output signal connector", \
0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("BOP.CS.PID_TCV_opening.addPID.k1", "Gain of input signal 1", 541,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.addPID.k2", "Gain of input signal 2", 542,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.addPID.k3", "Gain of input signal 3", 543,\
 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_TCV_opening.addPID.u1", "Connector of Real input signal 1",\
 "BOP.CS.PID_TCV_opening.P.y", 1, 5, 6315, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addPID.u2", "Connector of Real input signal 2",\
 "BOP.CS.PID_TCV_opening.Dzero.k", 1, 7, 885, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addPID.u3", "Connector of Real input signal 3",\
 "BOP.CS.PID_TCV_opening.I.y", 1, 1, 193, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addPID.y", "Connector of Real output signal",\
 "BOP.CS.PID_TCV_opening.gainPID.u", 1, 5, 6317, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.limiter.uMax", "Upper limits of input signals",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.limiter.uMin", "Lower limits of input signals",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.limiter.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.CS.PID_TCV_opening.limiter.homotopyType", "Simplified model for homotopy-based initialization [:#(type=Modelica.Blocks.Types.LimiterHomotopy)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_TCV_opening.limiter.u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.CS.PID_TCV_opening.limiter.y", "Connector of Real output signal",\
 "BOP.CS.PID_TCV_opening.y", 1, 5, 6299, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.limiter.simplifiedExpr", "Simplified expression for homotopy-based initialization",\
 "BOP.CS.PID_TCV_opening.limiter.u", 1, 5, 6323, 1024)
DeclareParameter("BOP.CS.PID_TCV_opening.Fzero.k", "Constant output value", 544,\
 0, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_TCV_opening.Fzero.y", "Connector of Real output signal",\
 "BOP.CS.PID_TCV_opening.Fzero.k", 1, 7, 544, 0)
DeclareParameter("BOP.CS.PID_TCV_opening.addFF.k1", "Gain of input signal 1", 545,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.addFF.k2", "Gain of input signal 2", 546,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.addFF.k3", "Gain of input signal 3", 547,\
 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_TCV_opening.addFF.u1", "Connector of Real input signal 1",\
 "BOP.CS.PID_TCV_opening.Fzero.k", 1, 7, 544, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addFF.u2", "Connector of Real input signal 2",\
 "BOP.CS.PID_TCV_opening.gainPID.y", 1, 5, 6318, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addFF.u3", "Connector of Real input signal 3",\
 "BOP.CS.PID_TCV_opening.null_bias.k", 1, 5, 6326, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addFF.y", "Connector of Real output signal",\
 "BOP.CS.PID_TCV_opening.limiter.u", 1, 5, 6323, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.gain_u_s.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_TCV_opening.gain_u_s.u", "Input signal connector [Pa]",\
 "BOP.CS.PID_TCV_opening.u_s", 1, 5, 6298, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.gain_u_s.y", "Output signal connector [Pa]",\
 "BOP.CS.PID_TCV_opening.addP.u1", 1, 5, 6311, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.gain_u_m.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_TCV_opening.gain_u_m.u", "Input signal connector [Pa]",\
 "BOP.CS.p_Nominal1.k", 1, 5, 6365, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.gain_u_m.y", "Output signal connector [Pa]",\
 "BOP.CS.PID_TCV_opening.addP.u2", 1, 5, 6312, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.null_bias.k", "Constant output value", 1,\
 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_TCV_opening.null_bias.y", "Connector of Real output signal",\
 "BOP.CS.PID_TCV_opening.null_bias.k", 1, 5, 6326, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.unitTime", "[s]", 1, 0.0,0.0,0.0,0,1537)
DeclareVariable("BOP.CS.PID_TCV_opening.with_I", "[:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.CS.PID_TCV_opening.with_D", "[:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.CS.PID_TCV_opening.y_reset_internal", "Internal connector for controller output reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.CS.switch_P_setpoint_TCV.u1", "Connector of first Real input signal [Pa]",\
 "BOP.header.medium.p", 1, 1, 65, 0)
DeclareAlias2("BOP.CS.switch_P_setpoint_TCV.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "BOP.CS.greater5.y", 1, 5, 6296, 65)
DeclareAlias2("BOP.CS.switch_P_setpoint_TCV.u3", "Connector of second Real input signal [Pa]",\
 "BOP.CS.p_Nominal1.k", 1, 5, 6365, 0)
DeclareAlias2("BOP.CS.switch_P_setpoint_TCV.y", "Connector of Real output signal [Pa]",\
 "BOP.CS.PID_TCV_opening.u_s", 1, 5, 6298, 0)
DeclareAlias2("BOP.CS.switch_TCV_setpoint.u1", "Connector of first Real input signal",\
 "BOP.CS.PID_TCV_opening.y", 1, 5, 6299, 0)
DeclareAlias2("BOP.CS.switch_TCV_setpoint.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "BOP.CS.greater5.y", 1, 5, 6296, 65)
DeclareAlias2("BOP.CS.switch_TCV_setpoint.u3", "Connector of second Real input signal",\
 "BOP.CS.TCV_diffopeningNominal.k", 1, 7, 548, 0)
DeclareVariable("BOP.CS.switch_TCV_setpoint.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("BOP.CS.TCV_diffopeningNominal.k", "Constant output value", 548,\
 0, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.TCV_diffopeningNominal.y", "Connector of Real output signal",\
 "BOP.CS.TCV_diffopeningNominal.k", 1, 7, 548, 0)
DeclareAlias2("BOP.CS.TCV_opening.u1", "Connector of Real input signal 1", \
"BOP.CS.switch_TCV_setpoint.y", 1, 5, 6331, 0)
DeclareAlias2("BOP.CS.TCV_opening.u2", "Connector of Real input signal 2", \
"BOP.CS.TCV_openingNominal.k", 1, 5, 6290, 0)
DeclareAlias2("BOP.CS.TCV_opening.y", "Connector of Real output signal", \
"BOP.actuatorBus.opening_TCV", 1, 5, 6368, 0)
DeclareParameter("BOP.CS.TCV_opening.k1", "Gain of input signal 1", 549, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.TCV_opening.k2", "Gain of input signal 2", 550, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.switch_P_setpoint.u1", "Connector of first Real input signal [W]",\
 "BOP.sensorBus.W_total", 1, 5, 6372, 0)
DeclareAlias2("BOP.CS.switch_P_setpoint.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "BOP.CS.switch_BV.u2", 1, 5, 6292, 65)
DeclareAlias2("BOP.CS.switch_P_setpoint.u3", "Connector of second Real input signal [W]",\
 "SC.W_totalSetpoint_BOP", 1, 5, 6938, 0)
DeclareVariable("BOP.CS.switch_P_setpoint.y", "Connector of Real output signal [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.valvedelayBV.k", "Constant output value [s]", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.valvedelayBV.y", "Connector of Real output signal [s]", \
"BOP.CS.valvedelayBV.k", 1, 5, 6333, 0)
DeclareAlias2("BOP.CS.greater1.u1", "Connector of first Real input signal [s]", \
"BOP.CS.greater5.u1", 1, 5, 6295, 0)
DeclareAlias2("BOP.CS.greater1.u2", "Connector of second Real input signal [s]",\
 "BOP.CS.valvedelayBV.k", 1, 5, 6333, 0)
DeclareAlias2("BOP.CS.greater1.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 "BOP.CS.switch_BV.u2", 1, 5, 6292, 65)
DeclareAlias2("BOP.CS.PID_BV_opening.u_s", "Connector of setpoint input signal [W]",\
 "SC.W_totalSetpoint_BOP", 1, 5, 6938, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.u_m", "Connector of measurement input signal [W]",\
 "BOP.CS.switch_P_setpoint.y", 1, 5, 6332, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.y", "Connector of actuator output signal", \
"BOP.CS.switch_BV.u1", 1, 5, 6291, 0)
DeclareVariable("BOP.CS.PID_BV_opening.controlError", "Control error (set point - measurement) [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_BV_opening.controllerType", "Type of controller [:#(type=Modelica.Blocks.Types.SimpleController)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_BV_opening.with_FF", "enable feed-forward input signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.CS.PID_BV_opening.derMeas", "=true avoid derivative kick [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.CS.PID_BV_opening.k", "Controller gain: +/- for direct/reverse acting [1]",\
 551, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.Ti", "Time constant of Integrator block [s]",\
 552, 10, 1E-60,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.Td", "Time constant of Derivative block [s]",\
 553, 0.1, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.yb", "Output bias. May improve simulation",\
 554, 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.k_s", "Setpoint input scaling: k_s*u_s. May improve simulation [1]",\
 555, 5E-10, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.k_m", "Measurement input scaling: k_m*u_m. May improve simulation [1]",\
 556, 5E-10, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.k_ff", "Measurement input scaling: k_ff*u_ff. May improve simulation",\
 557, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.PID_BV_opening.yMax", "Upper limit of output", 1, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.yMin", "Lower limit of output", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.CS.PID_BV_opening.wp", "Set-point weight for Proportional block (0..1)",\
 558, 1, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.wd", "Set-point weight for Derivative block (0..1)",\
 559, 0, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.Ni", "Ni*Ti is time constant of anti-windup compensation",\
 560, 0.9, 1E-13,1E+100,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.Nd", "The higher Nd, the more ideal the derivative block",\
 561, 10, 1E-13,1E+100,0.0,0,560)
DeclareVariable("BOP.CS.PID_BV_opening.initType", "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_BV_opening.xi_start", "Initial or guess value value for integrator output (= integrator state)",\
 0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.CS.PID_BV_opening.xd_start", "Initial or guess value for state of derivative block",\
 562, 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.y_start", "Initial value of output", 563,\
 0, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.PID_BV_opening.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.CS.PID_BV_opening.reset", "Type of controller output reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_BV_opening.y_reset", "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.addP.u1", "Connector of Real input signal 1 [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_BV_opening.addP.u2", "Connector of Real input signal 2 [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_BV_opening.addP.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_BV_opening.addP.k1", "Gain of input signal 1", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.CS.PID_BV_opening.addP.k2", "Gain of input signal 2", 564,\
 -1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.P.k", "Gain value multiplied with input signal [1]",\
 565, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_BV_opening.P.u", "Input signal connector", \
"BOP.CS.PID_BV_opening.addP.y", 1, 5, 6347, 0)
DeclareVariable("BOP.CS.PID_BV_opening.P.y", "Output signal connector", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_BV_opening.gainPID.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.gainPID.u", "Input signal connector", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_BV_opening.gainPID.y", "Output signal connector", \
0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("BOP.CS.PID_BV_opening.addPID.k1", "Gain of input signal 1", 566,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.addPID.k2", "Gain of input signal 2", 567,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.addPID.k3", "Gain of input signal 3", 568,\
 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_BV_opening.addPID.u1", "Connector of Real input signal 1",\
 "BOP.CS.PID_BV_opening.P.y", 1, 5, 6349, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addPID.u2", "Connector of Real input signal 2",\
 "BOP.CS.PID_BV_opening.Dzero.k", 1, 7, 891, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addPID.u3", "Connector of Real input signal 3",\
 "BOP.CS.PID_BV_opening.I.y", 1, 1, 194, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addPID.y", "Connector of Real output signal",\
 "BOP.CS.PID_BV_opening.gainPID.u", 1, 5, 6351, 0)
DeclareVariable("BOP.CS.PID_BV_opening.limiter.uMax", "Upper limits of input signals",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.limiter.uMin", "Lower limits of input signals",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.limiter.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.CS.PID_BV_opening.limiter.homotopyType", "Simplified model for homotopy-based initialization [:#(type=Modelica.Blocks.Types.LimiterHomotopy)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_BV_opening.limiter.u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.CS.PID_BV_opening.limiter.y", "Connector of Real output signal",\
 "BOP.CS.switch_BV.u1", 1, 5, 6291, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.limiter.simplifiedExpr", "Simplified expression for homotopy-based initialization",\
 "BOP.CS.PID_BV_opening.limiter.u", 1, 5, 6357, 1024)
DeclareParameter("BOP.CS.PID_BV_opening.Fzero.k", "Constant output value", 569, 0,\
 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_BV_opening.Fzero.y", "Connector of Real output signal",\
 "BOP.CS.PID_BV_opening.Fzero.k", 1, 7, 569, 0)
DeclareParameter("BOP.CS.PID_BV_opening.addFF.k1", "Gain of input signal 1", 570,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.addFF.k2", "Gain of input signal 2", 571,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.addFF.k3", "Gain of input signal 3", 572,\
 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_BV_opening.addFF.u1", "Connector of Real input signal 1",\
 "BOP.CS.PID_BV_opening.Fzero.k", 1, 7, 569, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addFF.u2", "Connector of Real input signal 2",\
 "BOP.CS.PID_BV_opening.gainPID.y", 1, 5, 6352, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addFF.u3", "Connector of Real input signal 3",\
 "BOP.CS.PID_BV_opening.null_bias.k", 1, 5, 6360, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addFF.y", "Connector of Real output signal",\
 "BOP.CS.PID_BV_opening.limiter.u", 1, 5, 6357, 0)
DeclareVariable("BOP.CS.PID_BV_opening.gain_u_s.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_BV_opening.gain_u_s.u", "Input signal connector [W]", \
"SC.W_totalSetpoint_BOP", 1, 5, 6938, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.gain_u_s.y", "Output signal connector [W]",\
 "BOP.CS.PID_BV_opening.addP.u1", 1, 5, 6345, 0)
DeclareVariable("BOP.CS.PID_BV_opening.gain_u_m.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_BV_opening.gain_u_m.u", "Input signal connector [W]", \
"BOP.CS.switch_P_setpoint.y", 1, 5, 6332, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.gain_u_m.y", "Output signal connector [W]",\
 "BOP.CS.PID_BV_opening.addP.u2", 1, 5, 6346, 0)
DeclareVariable("BOP.CS.PID_BV_opening.null_bias.k", "Constant output value", 1,\
 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_BV_opening.null_bias.y", "Connector of Real output signal",\
 "BOP.CS.PID_BV_opening.null_bias.k", 1, 5, 6360, 0)
DeclareVariable("BOP.CS.PID_BV_opening.unitTime", "[s]", 1, 0.0,0.0,0.0,0,1537)
DeclareVariable("BOP.CS.PID_BV_opening.with_I", "[:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.CS.PID_BV_opening.with_D", "[:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.CS.PID_BV_opening.y_reset_internal", "Internal connector for controller output reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.CS.BV_opening.u1", "Connector of Real input signal 1", \
"BOP.CS.switch_BV.y", 1, 5, 6293, 0)
DeclareAlias2("BOP.CS.BV_opening.u2", "Connector of Real input signal 2", \
"BOP.CS.BV_openingNominal.k", 1, 5, 6294, 0)
DeclareAlias2("BOP.CS.BV_opening.y", "Connector of Real output signal", \
"BOP.actuatorBus.opening_BV", 1, 5, 6369, 0)
DeclareParameter("BOP.CS.BV_opening.k1", "Gain of input signal 1", 573, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.BV_opening.k2", "Gain of input signal 2", 574, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.BV_diffopeningNominal.k", "Constant output value", 575,\
 0, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.BV_diffopeningNominal.y", "Connector of Real output signal",\
 "BOP.CS.BV_diffopeningNominal.k", 1, 7, 575, 0)
DeclareAlias2("BOP.CS.Power_Nominal.y", "Value of Real output [W]", \
"SC.W_totalSetpoint_BOP", 1, 5, 6938, 0)
DeclareVariable("BOP.CS.p_Nominal1.k", "Constant output value [Pa]", 1, 0.0,0.0,\
0.0,0,513)
DeclareAlias2("BOP.CS.p_Nominal1.y", "Connector of Real output signal [Pa]", \
"BOP.CS.p_Nominal1.k", 1, 5, 6365, 0)
DeclareAlias2("BOP.ED.actuatorBus.opening_TCV", "TCV fraction open", \
"BOP.actuatorBus.opening_TCV", 1, 5, 6368, 4)
DeclareAlias2("BOP.ED.actuatorBus.opening_BV", "BV fraction open", \
"BOP.actuatorBus.opening_BV", 1, 5, 6369, 4)
DeclareVariable("BOP.ED.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("BOP.ED.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareAlias2("BOP.ED.sensorBus.W_total", "Total electrical power generated [W]",\
 "BOP.sensorBus.W_total", 1, 5, 6372, 4)
DeclareAlias2("BOP.ED.sensorBus.p_inlet_steamTurbine", "Inlet pressure to steam turbine [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareVariable("BOP.actuatorBus.opening_TCV", "TCV fraction open", 0.0, 0.0,1.0,\
0.0,0,520)
DeclareVariable("BOP.actuatorBus.opening_BV", "BV fraction open", 0.0, 0.0,1.0,\
0.0,0,520)
DeclareVariable("BOP.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("BOP.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("BOP.sensorBus.W_total", "Total electrical power generated [W]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareAlias2("BOP.sensorBus.p_inlet_steamTurbine", "Inlet pressure to steam turbine [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareVariable("BOP.Q_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,\
0,513)
DeclareVariable("BOP.W_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,\
0,513)
DeclareVariable("BOP.nPorts_a3", "Number of port_a3 connections [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,517)
DeclareVariable("BOP.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.port_a_nominal.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_a_nominal.T", "Temperature [K|degC]", 288.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("BOP.port_a_nominal.h", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_a_nominal.m_flow", "Mass flow rate [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_b_nominal.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_b_nominal.T", "Temperature [K|degC]", 288.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("BOP.port_b_nominal.h", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_b_nominal.m_flow", "Mass flow rate [kg/s]", -70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_a_start.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_a_start.T", "Temperature [K|degC]", 288.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("BOP.port_a_start.h", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("BOP.port_a_start.m_flow", "Mass flow rate [kg/s]", 70.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_b_start.p", "Absolute pressure [Pa|bar]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.port_b_start.T", "Temperature [K|degC]", 288.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("BOP.port_b_start.h", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("BOP.port_b_start.m_flow", "Mass flow rate [kg/s]", -70.0, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "EM.port_b2.m_flow", -1, 5, 5724, 132)
DeclareAlias2("BOP.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.port_b2.p", 1, 5, 5725, 4)
DeclareAlias2("BOP.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareAlias2("BOP.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", -1, 5, 173, 132)
DeclareAlias2("BOP.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.port_a.p", 1, 5, 174, 4)
DeclareAlias2("BOP.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.port_b1.h_outflow", 1, 5, 5723, 4)
DeclareAlias2("BOP.portElec_b.W", "Active power [W]", "BOP.sensorBus.W_total", -1,\
 5, 6372, 132)
DeclareVariable("BOP.portElec_b.f", "Frequency [Hz]", 0.0, 0.0,0.0,0.0,0,520)
DeclareParameter("BOP.p_condenser", "Condenser operating pressure [Pa|bar]", 576,\
 10000.0, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.p_reservoir", "Reservoir operating pressure [Pa|bar]", 0.0,\
 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.portHP.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 70.0, -100000.0,100000.0,0.0,0,776)
DeclareVariable("BOP.steamTurbine.portHP.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 1000000.0, 611.657,100000000.0,1000000.0,0,520)
DeclareVariable("BOP.steamTurbine.portHP.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,500000.0,0,520)
DeclareAlias2("BOP.steamTurbine.portLP.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.steamTurbine.portHP.m_flow", -1, 5, 6395, 132)
DeclareAlias2("BOP.steamTurbine.portLP.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume.medium.p", 1, 1, 57, 4)
DeclareVariable("BOP.steamTurbine.portLP.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,520)
DeclareAlias2("BOP.steamTurbine.shaft_a.phi", "Absolute rotation angle of flange [rad|deg]",\
 "BOP.generator1.shaft_a.phi", 1, 1, 55, 4)
DeclareVariable("BOP.steamTurbine.shaft_a.tau", "Cut torque in the flange [N.m]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("BOP.steamTurbine.shaft_b.phi", "Absolute rotation angle of flange [rad|deg]",\
 "BOP.generator1.shaft_a.phi", 1, 1, 55, 4)
DeclareVariable("BOP.steamTurbine.shaft_b.tau", "Cut torque in the flange [N.m]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareVariable("BOP.steamTurbine.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.steamTurbine.nUnits", "Number of turbine units, e.g., high pressure and low pressure [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("BOP.steamTurbine.energyDynamics", "=true to use turbine dynamics [:#(type=TRANSFORM.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareParameter("BOP.steamTurbine.taus[1]", "Characteristic time constant of each unit [s]",\
 577, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.steamTurbine.taus[2]", "Characteristic time constant of each unit [s]",\
 578, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.steamTurbine.Q_fracs[1]", "Fraction of power provided per unit [1]",\
 0.5, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.Q_fracs[2]", "Fraction of power provided per unit [1]",\
 0.5, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.Q_units_start[1]", "Initial power output per unit [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.Q_units_start[2]", "Initial power output per unit [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.steamTurbine.eta_mech", "Mechanical efficiency [1]", 579, \
1.0, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.steamTurbine.eta_wetSteam.x_abs_in", "Inlet quality [1]", \
"BOP.steamTurbine.x_abs_in", 1, 5, 6446, 0)
DeclareAlias2("BOP.steamTurbine.eta_wetSteam.x_abs_out", "Outlet quality [1]", \
"BOP.steamTurbine.x_abs_out", 1, 5, 6448, 0)
DeclareParameter("BOP.steamTurbine.eta_wetSteam.eta_nominal", "Nominal efficiency due to wetness [1]",\
 580, 0.85, 0.0,1E+100,0.0,0,560)
DeclareAlias2("BOP.steamTurbine.eta_wetSteam.eta", "Turbine efficiency due to wetness [1]",\
 "BOP.steamTurbine.eta_wetSteam.eta_nominal", 1, 7, 580, 0)
DeclareVariable("BOP.steamTurbine.p_a_start", "Pressure at port a [Pa|bar]", \
5000000.0, 611.657,100000000.0,1000000.0,0,513)
DeclareVariable("BOP.steamTurbine.p_b_start", "Pressure at port b [Pa|bar]", \
5000000.0, 611.657,100000000.0,1000000.0,0,513)
DeclareVariable("BOP.steamTurbine.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.steamTurbine.T_a_start", "Temperature at port a [K|degC]", 500,\
 273.15,2273.15,500.0,0,513)
DeclareVariable("BOP.steamTurbine.T_b_start", "Temperature at port b [K|degC]", 500,\
 273.15,2273.15,500.0,0,513)
DeclareVariable("BOP.steamTurbine.h_a_start", "Specific enthalpy at port a [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,513)
DeclareVariable("BOP.steamTurbine.h_b_start", "Specific enthalpy at port b [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,513)
DeclareParameter("BOP.steamTurbine.X_start[1]", "Mass fractions m_i/m [kg/kg]", 581,\
 1.0, 0.0,1.0,0.1,0,560)
DeclareVariable("BOP.steamTurbine.m_flow_start", "Mass flow rate [kg/s]", 70.0, \
-100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.state_a.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.steamTurbine.state_a.h", "Specific enthalpy [J/kg]", \
"BOP.header.medium.h", 1, 1, 66, 0)
DeclareVariable("BOP.steamTurbine.state_a.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.steamTurbine.state_a.T", "Temperature [K|degC]", 500, \
273.15,2273.15,500.0,0,512)
DeclareAlias2("BOP.steamTurbine.state_a.p", "Pressure [Pa|bar]", \
"BOP.steamTurbine.portHP.p", 1, 5, 6396, 0)
DeclareVariable("BOP.steamTurbine.state_b.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.steamTurbine.state_b.h", "Specific enthalpy [J/kg]", \
"BOP.volume.medium.h", 1, 1, 58, 0)
DeclareVariable("BOP.steamTurbine.state_b.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.steamTurbine.state_b.T", "Temperature [K|degC]", 500, \
273.15,2273.15,500.0,0,512)
DeclareAlias2("BOP.steamTurbine.state_b.p", "Pressure [Pa|bar]", \
"BOP.volume.medium.p", 1, 1, 57, 0)
DeclareVariable("BOP.steamTurbine.p_ratio", "p_out/p_in pressure ratio [1]", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.steamTurbine.phi", "Shaft rotation angle [rad|deg]", \
"BOP.generator1.shaft_a.phi", 1, 1, 55, 0)
DeclareAlias2("BOP.steamTurbine.der(phi)", "der(Shaft rotation angle) [rad/s]", \
"BOP.generator1.omega_m", 1, 1, 54, 0)
DeclareAlias2("BOP.steamTurbine.tau", "Net torque acting on the turbine [N.m]", \
"BOP.steamTurbine.shaft_b.tau", 1, 5, 6400, 0)
DeclareAlias2("BOP.steamTurbine.omega", "Shaft angular velocity [rad/s]", \
"BOP.generator1.omega_m", 1, 1, 54, 0)
DeclareAlias2("BOP.steamTurbine.m_flow", "Mass flow rate [kg/s]", \
"BOP.steamTurbine.portHP.m_flow", 1, 5, 6395, 0)
DeclareAlias2("BOP.steamTurbine.h_in", "Inlet enthalpy [J/kg]", "BOP.header.medium.h", 1,\
 1, 66, 0)
DeclareVariable("BOP.steamTurbine.h_out", "Outlet enthalpy [J/kg]", 0.0, \
-10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("BOP.steamTurbine.h_is", "Isentropic outlet enthalpy [J/kg]", \
0.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareAlias2("BOP.steamTurbine.p_in", "Inlet pressure [Pa|bar]", \
"BOP.steamTurbine.portHP.p", 1, 5, 6396, 0)
DeclareAlias2("BOP.steamTurbine.p_out", "Outlet pressure [Pa|bar]", \
"BOP.volume.medium.p", 1, 1, 57, 0)
DeclareVariable("BOP.steamTurbine.Q_mech", "Total mechanical power [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareState("BOP.steamTurbine.Q_units[1]", "Mechanical power per unit [W]", 52,\
 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("BOP.steamTurbine.der(Q_units[1])", "der(Mechanical power per unit) [W/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("BOP.steamTurbine.Q_units[2]", "Mechanical power per unit [W]", 53,\
 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("BOP.steamTurbine.der(Q_units[2])", "der(Mechanical power per unit) [W/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.steamTurbine.Qbs[1]", "Power balance [W]", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareVariable("BOP.steamTurbine.Qbs[2]", "Power balance [W]", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareAlias2("BOP.steamTurbine.eta_is", "Isentropic efficiency [1]", \
"BOP.steamTurbine.eta_wetSteam.eta_nominal", 1, 7, 580, 0)
DeclareVariable("BOP.steamTurbine.p_crit", "Medium critical pressure [Pa|bar]", \
22064000.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.sat_in.psat", "Saturation pressure [Pa|bar]", \
5000000.0, 611.657,100000000.0,1000000.0,0,512)
DeclareVariable("BOP.steamTurbine.sat_in.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.steamTurbine.sat_out.psat", "Saturation pressure [Pa|bar]",\
 5000000.0, 611.657,100000000.0,1000000.0,0,512)
DeclareVariable("BOP.steamTurbine.sat_out.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.steamTurbine.bubble_in.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("BOP.steamTurbine.bubble_in.h", "Specific enthalpy [J/kg]", \
100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("BOP.steamTurbine.bubble_in.d", "Density [kg/m3|g/cm3]", 150, \
0.0,100000.0,500.0,0,512)
DeclareAlias2("BOP.steamTurbine.bubble_in.T", "Temperature [K|degC]", \
"BOP.steamTurbine.sat_in.Tsat", 1, 5, 6430, 0)
DeclareAlias2("BOP.steamTurbine.bubble_in.p", "Pressure [Pa|bar]", \
"BOP.steamTurbine.sat_in.psat", 1, 5, 6429, 0)
DeclareVariable("BOP.steamTurbine.dew_in.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("BOP.steamTurbine.dew_in.h", "Specific enthalpy [J/kg]", \
100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("BOP.steamTurbine.dew_in.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareAlias2("BOP.steamTurbine.dew_in.T", "Temperature [K|degC]", \
"BOP.steamTurbine.sat_in.Tsat", 1, 5, 6430, 0)
DeclareAlias2("BOP.steamTurbine.dew_in.p", "Pressure [Pa|bar]", "BOP.steamTurbine.sat_in.psat", 1,\
 5, 6429, 0)
DeclareVariable("BOP.steamTurbine.bubble_out.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("BOP.steamTurbine.bubble_out.h", "Specific enthalpy [J/kg]", \
100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("BOP.steamTurbine.bubble_out.d", "Density [kg/m3|g/cm3]", 150, \
0.0,100000.0,500.0,0,512)
DeclareAlias2("BOP.steamTurbine.bubble_out.T", "Temperature [K|degC]", \
"BOP.steamTurbine.sat_out.Tsat", 1, 5, 6432, 0)
DeclareAlias2("BOP.steamTurbine.bubble_out.p", "Pressure [Pa|bar]", \
"BOP.steamTurbine.sat_out.psat", 1, 5, 6431, 0)
DeclareVariable("BOP.steamTurbine.dew_out.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareVariable("BOP.steamTurbine.dew_out.h", "Specific enthalpy [J/kg]", \
100000.0, -10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("BOP.steamTurbine.dew_out.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareAlias2("BOP.steamTurbine.dew_out.T", "Temperature [K|degC]", \
"BOP.steamTurbine.sat_out.Tsat", 1, 5, 6432, 0)
DeclareAlias2("BOP.steamTurbine.dew_out.p", "Pressure [Pa|bar]", \
"BOP.steamTurbine.sat_out.psat", 1, 5, 6431, 0)
DeclareAlias2("BOP.steamTurbine.h_fsat_in", "Saturated liquid specific enthalpy at inlet [J/kg]",\
 "BOP.steamTurbine.bubble_in.h", 1, 5, 6434, 0)
DeclareAlias2("BOP.steamTurbine.h_gsat_in", "Saturated vapor specific enthalpy  at inlet [J/kg]",\
 "BOP.steamTurbine.dew_in.h", 1, 5, 6437, 0)
DeclareAlias2("BOP.steamTurbine.h_fsat_out", "Saturated liquid specific enthalpy at outlet [J/kg]",\
 "BOP.steamTurbine.bubble_out.h", 1, 5, 6440, 0)
DeclareAlias2("BOP.steamTurbine.h_gsat_out", "Saturated vapor specific enthalpy  at outlet [J/kg]",\
 "BOP.steamTurbine.dew_out.h", 1, 5, 6443, 0)
DeclareVariable("BOP.steamTurbine.x_th_in", "Inlet thermodynamic quality [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.steamTurbine.x_abs_in", "Inlet absolute mass quality [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.steamTurbine.x_th_out", "Outlet thermodynamic quality [1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.steamTurbine.x_abs_out", "Outlet absolute mass quality [1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.steamTurbine.partialArc", "", 1.0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.steamTurbine.partialArc_nominal", "Nominal partial arc", 582,\
 1, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.steamTurbine.m_flow_nominal", "Nominal mass flowrate [kg/s]",\
 70.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.use_Stodola", "=true to use Stodola's law, i.e., infinite stages per unit [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.steamTurbine.Kt_constant", "Constant coefficient of Stodola's law [m2]",\
 583, 0.01, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.steamTurbine.use_NominalInlet", "=true then Kt is calculated from nominal inlet conditions [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.steamTurbine.p_inlet_nominal", "Nominal inlet pressure [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.p_outlet_nominal", "Nominal outlet pressure [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.steamTurbine.use_T_nominal", "=true then use temperature for Kt else density [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.steamTurbine.T_nominal", "Nominal inlet temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareVariable("BOP.steamTurbine.d_nominal", "Nominal inlet density [kg/m3|g/cm3]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.steamTurbine.Kt", "Flow area coefficient [m2]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.generator1.eta", "Mechanical to electric power conversion efficiency [1]",\
 584, 1.0, 0.0,1E+100,0.0,0,560)
DeclareVariable("BOP.generator1.J", "Moment of inertia [kg.m2]", 10000.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.generator1.nPoles", "Number of electrical poles [:#(type=Integer)]",\
 585, 2, 0.0,0.0,0.0,0,564)
DeclareParameter("BOP.generator1.f_start", "Start value of the electrical frequency [Hz]",\
 586, 60, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.generator1.momentumDynamics", "Default formulation of momentum balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.generator1.Q_mech", "Mechanical power [W]", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareAlias2("BOP.generator1.Q_elec", "Electrical Power [W]", "BOP.sensorBus.W_total", 1,\
 5, 6372, 0)
DeclareVariable("BOP.generator1.Q_loss", "Inertial power Loss [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.generator1.tau", "Torque at shaft [N.m]", "BOP.steamTurbine.shaft_b.tau", -1,\
 5, 6400, 0)
DeclareState("BOP.generator1.omega_m", "Angular velocity of the shaft [rad/s]", 54,\
 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("BOP.generator1.der(omega_m)", "der(Angular velocity of the shaft) [rad/s2]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.generator1.omega_e", "Angular velocity of the e.m.f. rotating frame [rad/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.generator1.shaft_rpm", "Shaft rotational speed [rev/min]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.generator1.f", "Electrical frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 0)
DeclareAlias2("BOP.generator1.portElec.W", "Active power [W]", "BOP.sensorBus.W_total", -1,\
 5, 6372, 132)
DeclareAlias2("BOP.generator1.portElec.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareState("BOP.generator1.shaft_a.phi", "Absolute rotation angle of flange [rad|deg]",\
 55, 0.0, 0.0,0.0,0.0,0,568)
DeclareDerivative("BOP.generator1.shaft_a.der(phi)", "der(Absolute rotation angle of flange) [rad/s]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareAlias2("BOP.generator1.shaft_a.tau", "Cut torque in the flange [N.m]", \
"BOP.steamTurbine.shaft_b.tau", -1, 5, 6400, 132)
DeclareParameter("BOP.sensorW.precision", "Number of decimals displayed [:#(type=Integer)]",\
 587, 0, 0.0,1E+100,0.0,0,564)
DeclareAlias2("BOP.sensorW.var", "Variable to be converted [W]", \
"BOP.sensorBus.W_total", 1, 5, 6372, 0)
DeclareAlias2("BOP.sensorW.y", "Icon display", "BOP.sensorBus.W_total", 1, 5, 6372,\
 0)
DeclareAlias2("BOP.sensorW.port_a.W", "Active power [W]", "BOP.sensorBus.W_total", 1,\
 5, 6372, 132)
DeclareAlias2("BOP.sensorW.port_a.f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5,\
 6393, 4)
DeclareAlias2("BOP.sensorW.port_b.W", "Active power [W]", "BOP.sensorBus.W_total", -1,\
 5, 6372, 132)
DeclareAlias2("BOP.sensorW.port_b.f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5,\
 6393, 4)
DeclareAlias2("BOP.sensorW.W", "Power flowing from port_a to port_b [W]", \
"BOP.sensorBus.W_total", 1, 5, 6372, 0)
DeclareVariable("BOP.resistance.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareAlias2("BOP.resistance.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume.medium.p", 1, 1, 57, 4)
DeclareVariable("BOP.resistance.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareAlias2("BOP.resistance.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.resistance.port_a.m_flow", -1, 5, 6465, 132)
DeclareAlias2("BOP.resistance.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.condenser.p", 1, 5, 6474, 4)
DeclareAlias2("BOP.resistance.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.volume.medium.h", 1, 1, 58, 4)
DeclareVariable("BOP.resistance.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.resistance.state.h", "Specific enthalpy [J/kg]", \
"BOP.volume.medium.h", 1, 1, 58, 0)
DeclareVariable("BOP.resistance.state.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.resistance.state.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("BOP.resistance.state.p", "Pressure [Pa|bar]", "BOP.volume.medium.p", 1,\
 1, 57, 0)
DeclareVariable("BOP.resistance.dp", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.resistance.m_flow", "[kg/s]", "BOP.resistance.port_a.m_flow", 1,\
 5, 6465, 0)
DeclareParameter("BOP.resistance.showName", "[:#(type=Boolean)]", 588, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance.showDP", "[:#(type=Boolean)]", 589, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance.precision", "Number of decimals displayed [:#(type=Integer)]",\
 590, 3, 0.0,1E+100,0.0,0,564)
DeclareVariable("BOP.resistance.R", "Hydraulic resistance [Pa/(kg/s)]", 1, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.condenser.showName", "[:#(type=Boolean)]", 591, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("BOP.condenser.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareAlias2("BOP.condenser.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.condenser.p", 1, 5, 6474, 4)
DeclareAlias2("BOP.condenser.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.resistance.port_a.h_outflow", 1, 5, 6466, 4)
DeclareAlias2("BOP.condenser.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.condenser.port_a.m_flow", -1, 5, 6472, 132)
DeclareAlias2("BOP.condenser.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.reservoir.p_start", 1, 5, 6537, 4)
DeclareVariable("BOP.condenser.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareVariable("BOP.condenser.p", "Condenser operating pressure [Pa|bar]", \
1000000.0, 611.657,100000000.0,1000000.0,0,513)
DeclareParameter("BOP.condenser.V_total", "Total volume (liquid + vapor) [m3]", 592,\
 10, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.condenser.massDynamics", "Formulation of mass balance [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.condenser.V_liquid_start", "Start value of the liquid volume [m3]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.condenser.set_m_flow", "=true to set port_b.m_flow = -port_a.m_flow [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("BOP.condenser.sat.psat", "Saturation pressure [Pa|bar]", \
"BOP.condenser.p", 1, 5, 6474, 0)
DeclareVariable("BOP.condenser.sat.Tsat", "Saturation temperature [K|degC]", 500,\
 273.15,2273.15,500.0,0,513)
DeclareAlias2("BOP.condenser.h_fsat", "Specific enthalpy of saturated liquid [J/kg]",\
 "BOP.condenser.port_b.h_outflow", 1, 5, 6473, 0)
DeclareAlias2("BOP.condenser.h_gsat", "Specific enthalpy of saturated vapor [J/kg]",\
 "BOP.resistance.port_a.h_outflow", 1, 5, 6466, 0)
DeclareVariable("BOP.condenser.rho_fsat", "Density of saturated liquid [kg/m3|g/cm3]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.condenser.rho_gsat", "Density of saturated steam [kg/m3|g/cm3]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.condenser.m_total", "Total mass, steam+liquid [kg]", 0.0, \
0.0,1E+100,0.0,0,512)
DeclareVariable("BOP.condenser.der(m_total)", "der(Total mass, steam+liquid) [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.condenser.m_liquid", "Liquid mass [kg]", 0.0, 0.0,1E+100,\
0.0,0,512)
DeclareVariable("BOP.condenser.der(m_liquid)", "der(Liquid mass) [kg/s]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.condenser.m_vapor", "Steam mass [kg]", 0.0, 0.0,1E+100,0.0,\
0,512)
DeclareVariable("BOP.condenser.der(m_vapor)", "der(Steam mass) [kg/s]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareState("BOP.condenser.V_liquid", "Liquid volume [m3]", 56, 0.0, 0.0,0.0,\
0.0,0,544)
DeclareDerivative("BOP.condenser.der(V_liquid)", "der(Liquid volume) [m3/s]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.condenser.V_vapor", "Steam volume [m3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.condenser.E", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.condenser.der(E)", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.condenser.Q_total", "Total thermal energy removed [W]", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.volume.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.steamTurbine.portHP.m_flow", 1, 5, 6395, 132)
DeclareAlias2("BOP.volume.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume.medium.p", 1, 1, 57, 4)
DeclareAlias2("BOP.volume.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.volume.medium.h", 1, 1, 58, 4)
DeclareAlias2("BOP.volume.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.resistance.port_a.m_flow", -1, 5, 6465, 132)
DeclareAlias2("BOP.volume.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume.medium.p", 1, 1, 57, 4)
DeclareAlias2("BOP.volume.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.volume.medium.h", 1, 1, 58, 4)
DeclareVariable("BOP.volume.V", "Volume [m3]", 0.01, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.volume.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume.p_start", "Pressure [Pa|bar]", 0.0, 0.0,1E+100,\
100000.0,0,513)
DeclareVariable("BOP.volume.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.volume.T_start", "Temperature [K|degC]", 293.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("BOP.volume.h_start", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareParameter("BOP.volume.X_start[1]", "Mass fraction [1]", 593, 1.0, 0.0,1.0,\
0.0,0,560)
DeclareState("BOP.volume.medium.p", "Absolute pressure of medium [Pa|bar]", 57, \
100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("BOP.volume.medium.der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("BOP.volume.medium.h", "Specific enthalpy of medium [J/kg]", 58, \
0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("BOP.volume.medium.der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume.medium.d", "Density of medium [kg/m3|g/cm3]", 0.0, \
0.0,100000.0,500.0,0,512)
DeclareVariable("BOP.volume.medium.der(d)", "der(Density of medium) [Pa.m-2.s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume.medium.T", "Temperature of medium [K|degC]", 500.0, \
273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.volume.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("BOP.volume.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("BOP.volume.medium.der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("BOP.volume.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("BOP.volume.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,644)
DeclareAlias2("BOP.volume.medium.state.h", "Specific enthalpy [J/kg]", \
"BOP.volume.medium.h", 1, 1, 58, 0)
DeclareAlias2("BOP.volume.medium.state.d", "Density [kg/m3|g/cm3]", \
"BOP.volume.medium.d", 1, 5, 6500, 0)
DeclareAlias2("BOP.volume.medium.state.T", "Temperature [K|degC]", \
"BOP.volume.medium.T", 1, 5, 6502, 0)
DeclareAlias2("BOP.volume.medium.state.p", "Pressure [Pa|bar]", "BOP.volume.medium.p", 1,\
 1, 57, 0)
DeclareVariable("BOP.volume.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.volume.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.volume.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.volume.medium.sat.psat", "Saturation pressure [Pa|bar]", \
"BOP.volume.medium.p", 1, 1, 57, 0)
DeclareVariable("BOP.volume.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("BOP.volume.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "BOP.volume.medium.state.phase", 1, 5, 6508, 66)
DeclareVariable("BOP.volume.m", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("BOP.volume.der(m)", "der(Mass) [kg/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume.U", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume.der(U)", "der(Internal energy) [W]", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareAlias2("BOP.volume.mb", "Mass flow rate source/sinks within volumes [kg/s]",\
 "BOP.volume.der(m)", 1, 5, 6515, 0)
DeclareAlias2("BOP.volume.Ub", "Energy source/sinks within volumes (e.g., ohmic heating, external convection) [W]",\
 "BOP.volume.der(U)", 1, 5, 6517, 0)
DeclareParameter("BOP.volume.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 594, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("BOP.volume.geometry.V", "Volume [m3]", 0.01, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume.geometry.angle", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("BOP.volume.geometry.dheight", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume.g_n", "Gravitational acceleration [m/s2]", 9.80665, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume.use_HeatPort", "=true to toggle heat port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.volume.Q_gen", "Internal heat generation [W]", 0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("BOP.volume.use_TraceMassPort", "=true to toggle trace mass port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.volume.showName", "[:#(type=Boolean)]", 595, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("BOP.volume.Q_flow_internal", "[W]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.reservoir.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareAlias2("BOP.reservoir.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.reservoir.p_start", 1, 5, 6537, 4)
DeclareAlias2("BOP.reservoir.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.reservoir.h", 1, 1, 60, 4)
DeclareVariable("BOP.reservoir.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareVariable("BOP.reservoir.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 5000000.0, 611.657,100000000.0,1000000.0,0,520)
DeclareAlias2("BOP.reservoir.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.reservoir.h", 1, 1, 60, 4)
DeclareParameter("BOP.reservoir.A", "Cross-sectional area [m2]", 596, 10, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.reservoir.V0", "Volume at zero level [m3]", 597, 0, \
0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.reservoir.p_surface", "Liquid surface/gas pressure [Pa|bar]",\
 "BOP.reservoir.p_start", 1, 5, 6537, 0)
DeclareVariable("BOP.reservoir.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.reservoir.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.reservoir.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.reservoir.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.reservoir.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.reservoir.g_n", "[m/s2]", 9.80665, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.reservoir.p_start", "[Pa|bar]", 1000000.0, 611.657,\
100000000.0,1000000.0,0,513)
DeclareParameter("BOP.reservoir.level_start", "Start level [m]", 598, 10, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.reservoir.h_start", "[J/kg]", 599, 100000.0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.reservoir.X_start[1]", "Mass fraction [1]", 600, 1.0, 0.0,\
1.0,0.0,0,560)
DeclareState("BOP.reservoir.level", "Level [m]", 59, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("BOP.reservoir.der(level)", "der(Level) [m/s]", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareVariable("BOP.reservoir.V", "Volume [m3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.reservoir.der(V)", "der(Volume) [m3/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.reservoir.m", "Mmass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("BOP.reservoir.der(m)", "der(Mmass) [kg/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.reservoir.U", "Liquid internal energy [J]", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareVariable("BOP.reservoir.der(U)", "der(Liquid internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareState("BOP.reservoir.h", "Specific enthalpy [J/kg]", 60, 0.0, \
-10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("BOP.reservoir.der(h)", "der(Specific enthalpy) [m2/s3]", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.reservoir.p", "Pressure [Pa|bar]", 1000000.0, 611.657,\
100000000.0,1000000.0,0,512)
DeclareVariable("BOP.reservoir.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.reservoir.state.h", "Specific enthalpy [J/kg]", \
"BOP.reservoir.h", 1, 1, 60, 0)
DeclareVariable("BOP.reservoir.state.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.reservoir.state.der(d)", "der(Density) [Pa.m-2.s]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.reservoir.state.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("BOP.reservoir.state.p", "Pressure [Pa|bar]", "BOP.reservoir.p_start", 1,\
 5, 6537, 0)
DeclareAlias2("BOP.reservoir.d", "Density [kg/m3|g/cm3]", "BOP.reservoir.state.d", 1,\
 5, 6546, 0)
DeclareAlias2("BOP.reservoir.T", "Temperature [K|degC]", "BOP.reservoir.state.T", 1,\
 5, 6548, 0)
DeclareAlias2("BOP.reservoir.mb", "Mass flow rate source/sinks within volumes [kg/s]",\
 "BOP.reservoir.der(m)", 1, 5, 6541, 0)
DeclareAlias2("BOP.reservoir.Ub", "Energy source/sinks within volumes (e.g., ohmic heating, external convection) [W]",\
 "BOP.reservoir.der(U)", 1, 5, 6543, 0)
DeclareVariable("BOP.reservoir.use_HeatPort", "=true to toggle heat port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.reservoir.Q_gen", "Internal heat generation [W]", 0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.reservoir.use_TraceMassPort", "=true to toggle trace mass port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.reservoir.showName", "[:#(type=Boolean)]", 601, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("BOP.reservoir.Q_flow_internal", "[W]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.multiPort.nPorts_b", "Number of outlet ports (mass is distributed evenly between the outlet ports [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareAlias2("BOP.multiPort.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.reservoir.port_a.m_flow", -1, 5, 6528, 132)
DeclareAlias2("BOP.multiPort.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.reservoir.p_start", 1, 5, 6537, 4)
DeclareVariable("BOP.multiPort.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,520)
DeclareAlias2("BOP.multiPort.ports_b[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.condenser.port_a.m_flow", 1, 5, 6472, 132)
DeclareAlias2("BOP.multiPort.ports_b[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.reservoir.p_start", 1, 5, 6537, 4)
DeclareAlias2("BOP.multiPort.ports_b[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.reservoir.h", 1, 1, 60, 4)
DeclareAlias2("BOP.multiPort.ports_b[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.boundary2.ports[1].m_flow", -1, 5, 6892, 132)
DeclareAlias2("BOP.multiPort.ports_b[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.reservoir.p_start", 1, 5, 6537, 4)
DeclareAlias2("BOP.multiPort.ports_b[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.reservoir.h", 1, 1, 60, 4)
DeclareAlias2("BOP.feedWaterHeater.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.reservoir.port_b.m_flow", -1, 5, 6529, 132)
DeclareAlias2("BOP.feedWaterHeater.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.feedWaterHeater.medium.p", 1, 1, 61, 4)
DeclareAlias2("BOP.feedWaterHeater.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.feedWaterHeater.medium.h", 1, 1, 62, 4)
DeclareAlias2("BOP.feedWaterHeater.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", -1, 5, 173, 132)
DeclareAlias2("BOP.feedWaterHeater.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.feedWaterHeater.medium.p", 1, 1, 61, 4)
DeclareAlias2("BOP.feedWaterHeater.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.feedWaterHeater.medium.h", 1, 1, 62, 4)
DeclareVariable("BOP.feedWaterHeater.V", "Volume [m3]", 5, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.feedWaterHeater.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.feedWaterHeater.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.feedWaterHeater.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.feedWaterHeater.p_start", "Pressure [Pa|bar]", 0.0, 0.0,\
1E+100,100000.0,0,513)
DeclareVariable("BOP.feedWaterHeater.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.feedWaterHeater.T_start", "Temperature [K|degC]", 293.15, \
0.0,1E+100,300.0,0,513)
DeclareVariable("BOP.feedWaterHeater.h_start", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.feedWaterHeater.X_start[1]", "Mass fraction [1]", 602, 1.0,\
 0.0,1.0,0.0,0,560)
DeclareState("BOP.feedWaterHeater.medium.p", "Absolute pressure of medium [Pa|bar]",\
 61, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("BOP.feedWaterHeater.medium.der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("BOP.feedWaterHeater.medium.h", "Specific enthalpy of medium [J/kg]",\
 62, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("BOP.feedWaterHeater.medium.der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.feedWaterHeater.medium.d", "Density of medium [kg/m3|g/cm3]",\
 0.0, 0.0,100000.0,500.0,0,512)
DeclareVariable("BOP.feedWaterHeater.medium.der(d)", "der(Density of medium) [Pa.m-2.s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.feedWaterHeater.medium.T", "Temperature of medium [K|degC]", \
"BOP.boundary.port.T", 1, 5, 6592, 0)
DeclareVariable("BOP.feedWaterHeater.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("BOP.feedWaterHeater.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("BOP.feedWaterHeater.medium.der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.feedWaterHeater.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("BOP.feedWaterHeater.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("BOP.feedWaterHeater.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,644)
DeclareAlias2("BOP.feedWaterHeater.medium.state.h", "Specific enthalpy [J/kg]", \
"BOP.feedWaterHeater.medium.h", 1, 1, 62, 0)
DeclareAlias2("BOP.feedWaterHeater.medium.state.d", "Density [kg/m3|g/cm3]", \
"BOP.feedWaterHeater.medium.d", 1, 5, 6564, 0)
DeclareAlias2("BOP.feedWaterHeater.medium.state.T", "Temperature [K|degC]", \
"BOP.boundary.port.T", 1, 5, 6592, 0)
DeclareAlias2("BOP.feedWaterHeater.medium.state.p", "Pressure [Pa|bar]", \
"BOP.feedWaterHeater.medium.p", 1, 1, 61, 0)
DeclareVariable("BOP.feedWaterHeater.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.feedWaterHeater.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.feedWaterHeater.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.feedWaterHeater.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.feedWaterHeater.medium.sat.psat", "Saturation pressure [Pa|bar]",\
 "BOP.feedWaterHeater.medium.p", 1, 1, 61, 0)
DeclareVariable("BOP.feedWaterHeater.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("BOP.feedWaterHeater.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "BOP.feedWaterHeater.medium.state.phase", 1, 5, 6571, 66)
DeclareVariable("BOP.feedWaterHeater.m", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("BOP.feedWaterHeater.der(m)", "der(Mass) [kg/s]", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareVariable("BOP.feedWaterHeater.U", "Internal energy [J]", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareVariable("BOP.feedWaterHeater.der(U)", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.feedWaterHeater.mb", "Mass flow rate source/sinks within volumes [kg/s]",\
 "BOP.feedWaterHeater.der(m)", 1, 5, 6578, 0)
DeclareAlias2("BOP.feedWaterHeater.Ub", "Energy source/sinks within volumes (e.g., ohmic heating, external convection) [W]",\
 "BOP.feedWaterHeater.der(U)", 1, 5, 6580, 0)
DeclareParameter("BOP.feedWaterHeater.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 603, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("BOP.feedWaterHeater.geometry.V", "Volume [m3]", 5.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.geometry.angle", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.geometry.dheight", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.g_n", "Gravitational acceleration [m/s2]", \
9.80665, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.use_HeatPort", "=true to toggle heat port [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.feedWaterHeater.Q_gen", "Internal heat generation [W]", 0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.feedWaterHeater.use_TraceMassPort", "=true to toggle trace mass port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("BOP.feedWaterHeater.heatPort.T", "Port temperature [K|degC]", \
"BOP.boundary.port.T", 1, 5, 6592, 4)
DeclareAlias2("BOP.feedWaterHeater.heatPort.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "BOP.feedWaterHeater.Q_flow_internal", 1, 5, 6590, 132)
DeclareParameter("BOP.feedWaterHeater.showName", "[:#(type=Boolean)]", 604, true,\
 0.0,0.0,0.0,0,562)
DeclareVariable("BOP.feedWaterHeater.Q_flow_internal", "[W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("BOP.boundary.use_port", "=true then use input port [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareParameter("BOP.boundary.Q_flow", "Heat flow rate at port [W]", 605, 0, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.boundary.showName", "[:#(type=Boolean)]", 606, true, \
0.0,0.0,0.0,0,562)
DeclareAlias2("BOP.boundary.Q_flow_ext", "[W]", "BOP.feedWaterHeater.Q_flow_internal", 1,\
 5, 6590, 0)
DeclareAlias2("BOP.boundary.Q_flow_int", "[W]", "BOP.feedWaterHeater.Q_flow_internal", 1,\
 5, 6590, 1024)
DeclareAlias2("BOP.boundary.port.Q_flow", "Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "BOP.feedWaterHeater.Q_flow_internal", -1, 5, 6590, 132)
DeclareVariable("BOP.boundary.port.T", "Temperature at the connection point [K|degC]",\
 300.0, 273.15,2273.15,300.0,0,520)
DeclareAlias2("BOP.PID.u_s", "Connector of setpoint input signal [K]", \
"BOP.port_b_nominal.T", 1, 5, 6382, 0)
DeclareVariable("BOP.PID.u_m", "Connector of measurement input signal [K]", 0.0,\
 0.0,1E+100,0.0,0,512)
DeclareAlias2("BOP.PID.y", "Connector of actuator output signal [W]", \
"BOP.feedWaterHeater.Q_flow_internal", 1, 5, 6590, 0)
DeclareVariable("BOP.PID.controlError", "Control error (set point - measurement) [K]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID.controllerType", "Type of controller [:#(type=Modelica.Blocks.Types.SimpleController)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID.with_FF", "enable feed-forward input signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID.derMeas", "=true avoid derivative kick [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.PID.k", "Controller gain: +/- for direct/reverse acting [1]",\
 607, 100000000.0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID.Ti", "Time constant of Integrator block [s]", 608, 0.5,\
 1E-60,1E+100,0.0,0,560)
DeclareParameter("BOP.PID.Td", "Time constant of Derivative block [s]", 609, 0.1,\
 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.PID.yb", "Output bias. May improve simulation", 610, \
100000000.0, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID.k_s", "Setpoint input scaling: k_s*u_s. May improve simulation [K-1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.k_m", "Measurement input scaling: k_m*u_m. May improve simulation [K-1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID.k_ff", "Measurement input scaling: k_ff*u_ff. May improve simulation",\
 611, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID.yMax", "Upper limit of output [W]", 612, 1E+60, \
0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID.yMin", "Lower limit of output [W]", 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID.wp", "Set-point weight for Proportional block (0..1)",\
 613, 1, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.PID.wd", "Set-point weight for Derivative block (0..1)", 614,\
 0, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.PID.Ni", "Ni*Ti is time constant of anti-windup compensation",\
 615, 0.9, 1E-13,1E+100,0.0,0,560)
DeclareParameter("BOP.PID.Nd", "The higher Nd, the more ideal the derivative block",\
 616, 10, 1E-13,1E+100,0.0,0,560)
DeclareVariable("BOP.PID.initType", "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID.xi_start", "Initial or guess value value for integrator output (= integrator state)",\
 0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID.xd_start", "Initial or guess value for state of derivative block",\
 617, 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID.y_start", "Initial value of output [W]", 618, 0, \
0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID.reset", "Type of controller output reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.PID.y_reset", "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.addP.u1", "Connector of Real input signal 1 [K]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.addP.u2", "Connector of Real input signal 2 [K]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID.addP.y", "Connector of Real output signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID.addP.k1", "Gain of input signal 1", 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID.addP.k2", "Gain of input signal 2", 619, -1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.P.k", "Gain value multiplied with input signal [1]", 620,\
 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.PID.P.u", "Input signal connector", "BOP.PID.addP.y", 1, 5, 6608,\
 0)
DeclareVariable("BOP.PID.P.y", "Output signal connector", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID.gainPID.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.gainPID.u", "Input signal connector", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareVariable("BOP.PID.gainPID.y", "Output signal connector", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareParameter("BOP.PID.addPID.k1", "Gain of input signal 1", 621, 1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.addPID.k2", "Gain of input signal 2", 622, 1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.addPID.k3", "Gain of input signal 3", 623, 1, 0.0,0.0,\
0.0,0,560)
DeclareAlias2("BOP.PID.addPID.u1", "Connector of Real input signal 1", \
"BOP.PID.P.y", 1, 5, 6610, 0)
DeclareAlias2("BOP.PID.addPID.u2", "Connector of Real input signal 2", \
"BOP.PID.Dzero.k", 1, 7, 897, 0)
DeclareAlias2("BOP.PID.addPID.u3", "Connector of Real input signal 3", \
"BOP.PID.I.y", 1, 1, 195, 0)
DeclareAlias2("BOP.PID.addPID.y", "Connector of Real output signal", \
"BOP.PID.gainPID.u", 1, 5, 6612, 0)
DeclareVariable("BOP.PID.limiter.uMax", "Upper limits of input signals [W]", 1, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.limiter.uMin", "Lower limits of input signals [W]", 0.0,\
 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.limiter.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID.limiter.homotopyType", "Simplified model for homotopy-based initialization [:#(type=Modelica.Blocks.Types.LimiterHomotopy)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID.limiter.u", "Connector of Real input signal [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.PID.limiter.y", "Connector of Real output signal [W]", \
"BOP.feedWaterHeater.Q_flow_internal", 1, 5, 6590, 0)
DeclareAlias2("BOP.PID.limiter.simplifiedExpr", "Simplified expression for homotopy-based initialization [W]",\
 "BOP.PID.limiter.u", 1, 5, 6618, 1024)
DeclareParameter("BOP.PID.Fzero.k", "Constant output value", 624, 0, 0.0,0.0,0.0,\
0,560)
DeclareAlias2("BOP.PID.Fzero.y", "Connector of Real output signal", \
"BOP.PID.Fzero.k", 1, 7, 624, 0)
DeclareParameter("BOP.PID.addFF.k1", "Gain of input signal 1", 625, 1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.addFF.k2", "Gain of input signal 2", 626, 1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.addFF.k3", "Gain of input signal 3", 627, 1, 0.0,0.0,\
0.0,0,560)
DeclareAlias2("BOP.PID.addFF.u1", "Connector of Real input signal 1", \
"BOP.PID.Fzero.k", 1, 7, 624, 0)
DeclareAlias2("BOP.PID.addFF.u2", "Connector of Real input signal 2", \
"BOP.PID.gainPID.y", 1, 5, 6613, 0)
DeclareAlias2("BOP.PID.addFF.u3", "Connector of Real input signal 3", \
"BOP.PID.null_bias.k", 1, 5, 6621, 0)
DeclareAlias2("BOP.PID.addFF.y", "Connector of Real output signal [W]", \
"BOP.PID.limiter.u", 1, 5, 6618, 0)
DeclareVariable("BOP.PID.gain_u_s.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID.gain_u_s.u", "Input signal connector [K]", \
"BOP.port_b_nominal.T", 1, 5, 6382, 0)
DeclareAlias2("BOP.PID.gain_u_s.y", "Output signal connector [K]", \
"BOP.PID.addP.u1", 1, 5, 6606, 0)
DeclareVariable("BOP.PID.gain_u_m.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID.gain_u_m.u", "Input signal connector [K]", "BOP.PID.u_m", 1,\
 5, 6593, 0)
DeclareAlias2("BOP.PID.gain_u_m.y", "Output signal connector [K]", \
"BOP.PID.addP.u2", 1, 5, 6607, 0)
DeclareVariable("BOP.PID.null_bias.k", "Constant output value", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID.null_bias.y", "Connector of Real output signal", \
"BOP.PID.null_bias.k", 1, 5, 6621, 0)
DeclareVariable("BOP.PID.unitTime", "[s]", 1, 0.0,0.0,0.0,0,1537)
DeclareVariable("BOP.PID.with_I", "[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.PID.with_D", "[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.PID.y_reset_internal", "Internal connector for controller output reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.realExpression.y", "Value of Real output [K]", \
"BOP.port_b_nominal.T", 1, 5, 6382, 0)
DeclareVariable("BOP.temperature.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.temperature.showName", "= false to hide component name [:#(type=Boolean)]",\
 628, true, 0.0,0.0,0.0,0,562)
DeclareVariable("BOP.temperature.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, -1E+60,100000.0,0.0,0,777)
DeclareAlias2("BOP.temperature.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.feedWaterHeater.medium.p", 1, 1, 61, 4)
DeclareVariable("BOP.temperature.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 84013.0581525969, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareParameter("BOP.temperature.precision", "Number of decimals displayed [:#(type=Integer)]",\
 629, 0, 0.0,1E+100,0.0,0,564)
DeclareAlias2("BOP.temperature.var", "Variable to be converted [K]", \
"BOP.PID.u_m", 1, 5, 6593, 0)
DeclareVariable("BOP.temperature.y", "Icon display", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.temperature.T", "Temperature in port medium [K|degC]", \
"BOP.PID.u_m", 1, 5, 6593, 0)
DeclareVariable("BOP.temperature.inlet_enthalpy", "[J/kg]", 84013.0581525969, \
-10000000000.0,10000000000.0,500000.0,0,512)
DeclareVariable("BOP.multiPort1.nPorts_b", "Number of outlet ports (mass is distributed evenly between the outlet ports [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareAlias2("BOP.multiPort1.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.condenser.port_a.m_flow", -1, 5, 6472, 132)
DeclareAlias2("BOP.multiPort1.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.condenser.p", 1, 5, 6474, 4)
DeclareVariable("BOP.multiPort1.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,520)
DeclareVariable("BOP.multiPort1.port_a.der(h_outflow)", "der(Specific thermodynamic enthalpy close to the connection point if m_flow < 0) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareVariable("BOP.multiPort1.ports_b[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareAlias2("BOP.multiPort1.ports_b[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.condenser.p", 1, 5, 6474, 4)
DeclareAlias2("BOP.multiPort1.ports_b[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.resistance.port_a.h_outflow", 1, 5, 6466, 4)
DeclareAlias2("BOP.multiPort1.ports_b[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.resistance.port_a.m_flow", 1, 5, 6465, 132)
DeclareAlias2("BOP.multiPort1.ports_b[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.condenser.p", 1, 5, 6474, 4)
DeclareAlias2("BOP.multiPort1.ports_b[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.resistance.port_a.h_outflow", 1, 5, 6466, 4)
DeclareAlias2("BOP.resistance1.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", 1, 5, 173, 132)
DeclareAlias2("BOP.resistance1.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.feedWaterHeater.medium.p", 1, 1, 61, 4)
DeclareAlias2("BOP.resistance1.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", 1, 1, 122, 4)
DeclareAlias2("BOP.resistance1.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", -1, 5, 173, 132)
DeclareAlias2("BOP.resistance1.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "nuScale_Tave_enthalpy.port_a.p", 1, 5, 174, 4)
DeclareAlias2("BOP.resistance1.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.port_b1.h_outflow", 1, 5, 5723, 4)
DeclareVariable("BOP.resistance1.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.resistance1.state.h", "Specific enthalpy [J/kg]", \
"EM.port_b1.h_outflow", 1, 5, 5723, 0)
DeclareVariable("BOP.resistance1.state.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.resistance1.state.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("BOP.resistance1.state.p", "Pressure [Pa|bar]", "BOP.feedWaterHeater.medium.p", 1,\
 1, 61, 0)
DeclareVariable("BOP.resistance1.dp", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.resistance1.m_flow", "[kg/s]", "nuScale_Tave_enthalpy.port_a.m_flow", 1,\
 5, 173, 0)
DeclareParameter("BOP.resistance1.showName", "[:#(type=Boolean)]", 630, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance1.showDP", "[:#(type=Boolean)]", 631, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance1.precision", "Number of decimals displayed [:#(type=Integer)]",\
 632, 3, 0.0,1E+100,0.0,0,564)
DeclareVariable("BOP.resistance1.R", "Hydraulic resistance [Pa/(kg/s)]", 1, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.pressure.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.pressure.showName", "= false to hide component name [:#(type=Boolean)]",\
 633, true, 0.0,0.0,0.0,0,562)
DeclareVariable("BOP.pressure.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, -100000.0,100000.0,0.0,0,777)
DeclareAlias2("BOP.pressure.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareVariable("BOP.pressure.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 84013.0581525969, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareParameter("BOP.pressure.precision", "Number of decimals displayed [:#(type=Integer)]",\
 634, 0, 0.0,1E+100,0.0,0,564)
DeclareAlias2("BOP.pressure.var", "Variable to be converted [Pa]", \
"BOP.header.medium.p", 1, 1, 65, 0)
DeclareVariable("BOP.pressure.y", "Icon display", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.pressure.p", "Pressure at port [Pa|bar]", "BOP.header.medium.p", 1,\
 1, 65, 0)
DeclareVariable("BOP.valve_BV.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.valve_BV.showDesignFlowDirection", "= false to hide the flow direction arrow [:#(type=Boolean)]",\
 635, true, 0.0,0.0,0.0,0,562)
DeclareParameter("BOP.valve_BV.showName", "= false to hide component name [:#(type=Boolean)]",\
 636, true, 0.0,0.0,0.0,0,562)
DeclareVariable("BOP.valve_BV.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 70.0, -100000.0,100000.0,0.0,0,776)
DeclareAlias2("BOP.valve_BV.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareAlias2("BOP.valve_BV.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.volume_bypass.medium.h", 1, 1, 64, 4)
DeclareAlias2("BOP.valve_BV.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.valve_BV.port_a.m_flow", -1, 5, 6645, 132)
DeclareAlias2("BOP.valve_BV.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume_bypass.medium.p", 1, 1, 63, 4)
DeclareAlias2("BOP.valve_BV.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareVariable("BOP.valve_BV.dp_start", "Guess value of dp = port_a.p - port_b.p [Pa|bar]",\
 5000000.0, -1E+60,100000000.0,1000000.0,0,513)
DeclareVariable("BOP.valve_BV.m_flow_start", "Guess value of m_flow = port_a.m_flow [kg/s]",\
 70.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.valve_BV.m_flow_small", "Small mass flow rate for regularization of zero flow [kg/s]",\
 0.007, -100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.valve_BV.show_T", "= true, if temperatures at port_a and port_b are computed [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.valve_BV.show_V_flow", "= true, if volume flow rate at inflowing port is computed [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("BOP.valve_BV.m_flow", "Mass flow rate in design flow direction [kg/s]",\
 "BOP.valve_BV.port_a.m_flow", 1, 5, 6645, 0)
DeclareVariable("BOP.valve_BV.dp", "Pressure difference between port_a and port_b (= port_a.p - port_b.p) [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_BV.V_flow", "Volume flow rate at inflowing port (positive when flow from port_a to port_b) [m3/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_BV.port_a_T", "Temperature close to port_a, if show_T = true [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.valve_BV.port_b_T", "Temperature close to port_b, if show_T = true [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.valve_BV.state_a.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,2565)
DeclareAlias2("BOP.valve_BV.state_a.h", "Specific enthalpy [J/kg]", \
"BOP.header.medium.h", 1, 1, 66, 1024)
DeclareVariable("BOP.valve_BV.state_a.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("BOP.valve_BV.state_a.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,2560)
DeclareAlias2("BOP.valve_BV.state_a.p", "Pressure [Pa|bar]", "BOP.header.medium.p", 1,\
 1, 65, 1024)
DeclareVariable("BOP.valve_BV.state_b.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,2565)
DeclareAlias2("BOP.valve_BV.state_b.h", "Specific enthalpy [J/kg]", \
"BOP.volume_bypass.medium.h", 1, 1, 64, 1024)
DeclareVariable("BOP.valve_BV.state_b.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("BOP.valve_BV.state_b.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,2560)
DeclareAlias2("BOP.valve_BV.state_b.p", "Pressure [Pa|bar]", "BOP.volume_bypass.medium.p", 1,\
 1, 63, 1024)
DeclareVariable("BOP.valve_BV.CvData", "Selection of flow coefficient [:#(type=Modelica.Fluid.Types.CvTypes)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.valve_BV.Av", "Av (metric) flow coefficient [m2]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.valve_BV.Kv", "Kv (metric) flow coefficient [m3/h] [1]", 637,\
 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.valve_BV.Cv", "Cv (US) flow coefficient [USG/min] [1]", 638,\
 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.valve_BV.dp_nominal", "Nominal pressure drop [Pa|bar]", 639,\
 100000, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.valve_BV.m_flow_nominal", "Nominal mass flowrate [kg/s]", \
70.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.valve_BV.rho_nominal", "Nominal inlet density [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,513)
DeclareParameter("BOP.valve_BV.opening_nominal", "Nominal opening", 640, 1, 0.0,\
1.0,0.0,0,560)
DeclareVariable("BOP.valve_BV.filteredOpening", "= true, if opening is filtered with a 2nd order CriticalDamping filter [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.valve_BV.riseTime", "Rise time of the filter (time to reach 99.6 % of an opening step) [s]",\
 641, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.valve_BV.leakageOpening", "The opening signal is limited by leakageOpening (to improve the numerics)",\
 642, 0.001, 0.0,1.0,0.0,0,560)
DeclareVariable("BOP.valve_BV.checkValve", "Reverse flow stopped [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.valve_BV.dp_small", "Regularisation of zero flow [Pa|bar]",\
 0.0, 0.0,1E+100,100000.0,0,513)
DeclareVariable("BOP.valve_BV.Kv2Av", "Conversion factor [m2]", 2.77E-05, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.valve_BV.Cv2Av", "Conversion factor [m2]", 2.4E-05, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.valve_BV.opening", "Valve position in the range 0..1", \
"BOP.actuatorBus.opening_BV", 1, 5, 6369, 0)
DeclareAlias2("BOP.valve_BV.opening_actual", "", "BOP.actuatorBus.opening_BV", 1,\
 5, 6369, 1024)
DeclareVariable("BOP.valve_BV.minLimiter.uMin", "Lower limit of input signal", \
0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.valve_BV.minLimiter.u", "Connector of Real input signal", \
"BOP.actuatorBus.opening_BV", 1, 5, 6369, 1024)
DeclareVariable("BOP.valve_BV.minLimiter.y", "Connector of Real output signal", \
0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("BOP.valve_BV.p_nominal", "Nominal inlet pressure [Pa|bar]", \
5000000.0, 611.657,100000000.0,1000000.0,0,513)
DeclareParameter("BOP.valve_BV.Fxt_full", "Fk*xt critical ratio at full opening",\
 643, 0.5, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.valve_BV.Fxt", "", "BOP.valve_BV.Fxt_full", 1, 7, 643, 0)
DeclareVariable("BOP.valve_BV.x", "Pressure drop ratio [1]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_BV.xs", "Saturated pressure drop ratio [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_BV.Y", "Compressibility factor", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_BV.p", "Inlet pressure [Pa|bar]", 5000000.0, 611.657,\
100000000.0,1000000.0,0,512)
DeclareVariable("BOP.valve_BV.Re_turbulent", "cf. straight pipe for fully open valve -- dp_turbulent increases for closing valve [1]",\
 4000, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.valve_BV.use_Re", "= true, if turbulent region is defined by Re, otherwise by m_flow_small [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("BOP.valve_BV.dp_turbulent", "[Pa|bar]", "BOP.valve_BV.dp_small", 1,\
 5, 6667, 0)
DeclareVariable("BOP.valve_BV.Fxt_nominal", "Nominal Fxt [1]", 0.0, 0.0,0.0,0.0,\
0,2561)
DeclareVariable("BOP.valve_BV.x_nominal", "Nominal pressure drop ratio [1]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.valve_BV.xs_nominal", "Nominal saturated pressure drop ratio [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.valve_BV.Y_nominal", "Nominal compressibility factor", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.volume_bypass.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.valve_BV.port_a.m_flow", 1, 5, 6645, 132)
DeclareAlias2("BOP.volume_bypass.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume_bypass.medium.p", 1, 1, 63, 4)
DeclareAlias2("BOP.volume_bypass.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.volume_bypass.medium.h", 1, 1, 64, 4)
DeclareAlias2("BOP.volume_bypass.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.multiPort1.ports_b[1].m_flow", -1, 5, 6634, 132)
DeclareAlias2("BOP.volume_bypass.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume_bypass.medium.p", 1, 1, 63, 4)
DeclareAlias2("BOP.volume_bypass.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.volume_bypass.medium.h", 1, 1, 64, 4)
DeclareVariable("BOP.volume_bypass.V", "Volume [m3]", 0.01, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.volume_bypass.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume_bypass.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume_bypass.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume_bypass.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.volume_bypass.p_start", "Pressure [Pa|bar]", 0.0, 0.0,\
1E+100,100000.0,0,513)
DeclareVariable("BOP.volume_bypass.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.volume_bypass.T_start", "Temperature [K|degC]", 293.15, 0.0,\
1E+100,300.0,0,513)
DeclareVariable("BOP.volume_bypass.h_start", "Specific enthalpy [J/kg]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.volume_bypass.X_start[1]", "Mass fraction [1]", 644, 1.0, \
0.0,1.0,0.0,0,560)
DeclareState("BOP.volume_bypass.medium.p", "Absolute pressure of medium [Pa|bar]",\
 63, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("BOP.volume_bypass.medium.der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("BOP.volume_bypass.medium.h", "Specific enthalpy of medium [J/kg]",\
 64, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("BOP.volume_bypass.medium.der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume_bypass.medium.d", "Density of medium [kg/m3|g/cm3]",\
 0.0, 0.0,100000.0,500.0,0,512)
DeclareVariable("BOP.volume_bypass.medium.der(d)", "der(Density of medium) [Pa.m-2.s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume_bypass.medium.T", "Temperature of medium [K|degC]", \
500.0, 273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.volume_bypass.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("BOP.volume_bypass.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("BOP.volume_bypass.medium.der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume_bypass.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("BOP.volume_bypass.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("BOP.volume_bypass.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,644)
DeclareAlias2("BOP.volume_bypass.medium.state.h", "Specific enthalpy [J/kg]", \
"BOP.volume_bypass.medium.h", 1, 1, 64, 0)
DeclareAlias2("BOP.volume_bypass.medium.state.d", "Density [kg/m3|g/cm3]", \
"BOP.volume_bypass.medium.d", 1, 5, 6692, 0)
DeclareAlias2("BOP.volume_bypass.medium.state.T", "Temperature [K|degC]", \
"BOP.volume_bypass.medium.T", 1, 5, 6694, 0)
DeclareAlias2("BOP.volume_bypass.medium.state.p", "Pressure [Pa|bar]", \
"BOP.volume_bypass.medium.p", 1, 1, 63, 0)
DeclareVariable("BOP.volume_bypass.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.volume_bypass.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.volume_bypass.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume_bypass.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.volume_bypass.medium.sat.psat", "Saturation pressure [Pa|bar]",\
 "BOP.volume_bypass.medium.p", 1, 1, 63, 0)
DeclareVariable("BOP.volume_bypass.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("BOP.volume_bypass.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "BOP.volume_bypass.medium.state.phase", 1, 5, 6700, 66)
DeclareVariable("BOP.volume_bypass.m", "Mass [kg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("BOP.volume_bypass.der(m)", "der(Mass) [kg/s]", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareVariable("BOP.volume_bypass.U", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.volume_bypass.der(U)", "der(Internal energy) [W]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.volume_bypass.mb", "Mass flow rate source/sinks within volumes [kg/s]",\
 "BOP.volume_bypass.der(m)", 1, 5, 6707, 0)
DeclareAlias2("BOP.volume_bypass.Ub", "Energy source/sinks within volumes (e.g., ohmic heating, external convection) [W]",\
 "BOP.volume_bypass.der(U)", 1, 5, 6709, 0)
DeclareParameter("BOP.volume_bypass.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 645, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("BOP.volume_bypass.geometry.V", "Volume [m3]", 0.01, 0.0,0.0,0.0,\
0,513)
DeclareVariable("BOP.volume_bypass.geometry.angle", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("BOP.volume_bypass.geometry.dheight", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume_bypass.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume_bypass.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume_bypass.g_n", "Gravitational acceleration [m/s2]", \
9.80665, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume_bypass.use_HeatPort", "=true to toggle heat port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
EndNonAlias(5)
PreNonAliasNew(6)
StartNonAlias(6)
DeclareVariable("BOP.volume_bypass.Q_gen", "Internal heat generation [W]", 0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.volume_bypass.use_TraceMassPort", "=true to toggle trace mass port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.volume_bypass.showName", "[:#(type=Boolean)]", 646, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("BOP.volume_bypass.Q_flow_internal", "[W]", 0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.resistance3.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.multiPort1.ports_b[1].m_flow", 1, 5, 6634, 132)
DeclareAlias2("BOP.resistance3.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.volume_bypass.medium.p", 1, 1, 63, 4)
DeclareAlias2("BOP.resistance3.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.resistance.port_a.h_outflow", 1, 5, 6466, 4)
DeclareAlias2("BOP.resistance3.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.multiPort1.ports_b[1].m_flow", -1, 5, 6634, 132)
DeclareAlias2("BOP.resistance3.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.condenser.p", 1, 5, 6474, 4)
DeclareAlias2("BOP.resistance3.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.volume_bypass.medium.h", 1, 1, 64, 4)
DeclareVariable("BOP.resistance3.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.resistance3.state.h", "Specific enthalpy [J/kg]", \
"BOP.volume_bypass.medium.h", 1, 1, 64, 0)
DeclareVariable("BOP.resistance3.state.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.resistance3.state.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("BOP.resistance3.state.p", "Pressure [Pa|bar]", "BOP.volume_bypass.medium.p", 1,\
 1, 63, 0)
DeclareVariable("BOP.resistance3.dp", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.resistance3.m_flow", "[kg/s]", "BOP.multiPort1.ports_b[1].m_flow", 1,\
 5, 6634, 0)
DeclareParameter("BOP.resistance3.showName", "[:#(type=Boolean)]", 647, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance3.showDP", "[:#(type=Boolean)]", 648, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance3.precision", "Number of decimals displayed [:#(type=Integer)]",\
 649, 3, 0.0,1E+100,0.0,0,564)
DeclareVariable("BOP.resistance3.R", "Hydraulic resistance [Pa/(kg/s)]", 1, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.W_balance1.y", "Value of Real output", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.valve_TCV.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.valve_TCV.showDesignFlowDirection", "= false to hide the flow direction arrow [:#(type=Boolean)]",\
 650, true, 0.0,0.0,0.0,0,562)
DeclareParameter("BOP.valve_TCV.showName", "= false to hide component name [:#(type=Boolean)]",\
 651, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("BOP.valve_TCV.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.steamTurbine.portHP.m_flow", 1, 5, 6395, 132)
DeclareAlias2("BOP.valve_TCV.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareAlias2("BOP.valve_TCV.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.steamTurbine.portHP.h_outflow", 1, 5, 6397, 4)
DeclareAlias2("BOP.valve_TCV.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.steamTurbine.portHP.m_flow", -1, 5, 6395, 132)
DeclareAlias2("BOP.valve_TCV.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.steamTurbine.portHP.p", 1, 5, 6396, 4)
DeclareAlias2("BOP.valve_TCV.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareVariable("BOP.valve_TCV.dp_start", "Guess value of dp = port_a.p - port_b.p [Pa|bar]",\
 5000000.0, -1E+60,100000000.0,1000000.0,0,513)
DeclareVariable("BOP.valve_TCV.m_flow_start", "Guess value of m_flow = port_a.m_flow [kg/s]",\
 70.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.valve_TCV.m_flow_small", "Small mass flow rate for regularization of zero flow [kg/s]",\
 0.007, -100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.valve_TCV.show_T", "= true, if temperatures at port_a and port_b are computed [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.valve_TCV.show_V_flow", "= true, if volume flow rate at inflowing port is computed [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("BOP.valve_TCV.m_flow", "Mass flow rate in design flow direction [kg/s]",\
 "BOP.steamTurbine.portHP.m_flow", 1, 5, 6395, 0)
DeclareVariable("BOP.valve_TCV.dp", "Pressure difference between port_a and port_b (= port_a.p - port_b.p) [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_TCV.V_flow", "Volume flow rate at inflowing port (positive when flow from port_a to port_b) [m3/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_TCV.port_a_T", "Temperature close to port_a, if show_T = true [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.valve_TCV.port_b_T", "Temperature close to port_b, if show_T = true [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.valve_TCV.state_a.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,2565)
DeclareAlias2("BOP.valve_TCV.state_a.h", "Specific enthalpy [J/kg]", \
"BOP.header.medium.h", 1, 1, 66, 1024)
DeclareVariable("BOP.valve_TCV.state_a.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("BOP.valve_TCV.state_a.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,2560)
DeclareAlias2("BOP.valve_TCV.state_a.p", "Pressure [Pa|bar]", "BOP.header.medium.p", 1,\
 1, 65, 1024)
DeclareVariable("BOP.valve_TCV.state_b.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,2565)
DeclareAlias2("BOP.valve_TCV.state_b.h", "Specific enthalpy [J/kg]", \
"BOP.steamTurbine.portHP.h_outflow", 1, 5, 6397, 1024)
DeclareVariable("BOP.valve_TCV.state_b.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,2560)
DeclareVariable("BOP.valve_TCV.state_b.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,2560)
DeclareAlias2("BOP.valve_TCV.state_b.p", "Pressure [Pa|bar]", "BOP.steamTurbine.portHP.p", 1,\
 5, 6396, 1024)
DeclareVariable("BOP.valve_TCV.CvData", "Selection of flow coefficient [:#(type=Modelica.Fluid.Types.CvTypes)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.valve_TCV.Av", "Av (metric) flow coefficient [m2]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("BOP.valve_TCV.Kv", "Kv (metric) flow coefficient [m3/h] [1]", 652,\
 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.valve_TCV.Cv", "Cv (US) flow coefficient [USG/min] [1]", 653,\
 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.valve_TCV.dp_nominal", "Nominal pressure drop [Pa|bar]", 654,\
 100000, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.valve_TCV.m_flow_nominal", "Nominal mass flowrate [kg/s]", \
70.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.valve_TCV.rho_nominal", "Nominal inlet density [kg/m3|g/cm3]",\
 150, 0.0,100000.0,500.0,0,513)
DeclareParameter("BOP.valve_TCV.opening_nominal", "Nominal opening", 655, 1, 0.0,\
1.0,0.0,0,560)
DeclareVariable("BOP.valve_TCV.filteredOpening", "= true, if opening is filtered with a 2nd order CriticalDamping filter [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.valve_TCV.riseTime", "Rise time of the filter (time to reach 99.6 % of an opening step) [s]",\
 656, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.valve_TCV.leakageOpening", "The opening signal is limited by leakageOpening (to improve the numerics)",\
 657, 0.001, 0.0,1.0,0.0,0,560)
DeclareVariable("BOP.valve_TCV.checkValve", "Reverse flow stopped [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.valve_TCV.dp_small", "Regularisation of zero flow [Pa|bar]",\
 0.0, 0.0,1E+100,100000.0,0,513)
DeclareVariable("BOP.valve_TCV.Kv2Av", "Conversion factor [m2]", 2.77E-05, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.valve_TCV.Cv2Av", "Conversion factor [m2]", 2.4E-05, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.valve_TCV.opening", "Valve position in the range 0..1", \
"BOP.actuatorBus.opening_TCV", 1, 5, 6368, 0)
DeclareAlias2("BOP.valve_TCV.opening_actual", "", "BOP.actuatorBus.opening_TCV", 1,\
 5, 6368, 1024)
DeclareVariable("BOP.valve_TCV.minLimiter.uMin", "Lower limit of input signal", \
0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.valve_TCV.minLimiter.u", "Connector of Real input signal", \
"BOP.actuatorBus.opening_TCV", 1, 5, 6368, 1024)
DeclareVariable("BOP.valve_TCV.minLimiter.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("BOP.valve_TCV.p_nominal", "Nominal inlet pressure [Pa|bar]", \
5000000.0, 611.657,100000000.0,1000000.0,0,513)
DeclareParameter("BOP.valve_TCV.Fxt_full", "Fk*xt critical ratio at full opening",\
 658, 0.5, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.valve_TCV.Fxt", "", "BOP.valve_TCV.Fxt_full", 1, 7, 658, 0)
DeclareVariable("BOP.valve_TCV.x", "Pressure drop ratio [1]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_TCV.xs", "Saturated pressure drop ratio [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_TCV.Y", "Compressibility factor", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.valve_TCV.p", "Inlet pressure [Pa|bar]", 5000000.0, 611.657,\
100000000.0,1000000.0,0,512)
DeclareVariable("BOP.valve_TCV.Re_turbulent", "cf. straight pipe for fully open valve -- dp_turbulent increases for closing valve [1]",\
 4000, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.valve_TCV.use_Re", "= true, if turbulent region is defined by Re, otherwise by m_flow_small [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("BOP.valve_TCV.dp_turbulent", "[Pa|bar]", "BOP.valve_TCV.dp_small", 1,\
 5, 6748, 0)
DeclareVariable("BOP.valve_TCV.Fxt_nominal", "Nominal Fxt [1]", 0.0, 0.0,0.0,0.0,\
0,2561)
DeclareVariable("BOP.valve_TCV.x_nominal", "Nominal pressure drop ratio [1]", \
0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.valve_TCV.xs_nominal", "Nominal saturated pressure drop ratio [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.valve_TCV.Y_nominal", "Nominal compressibility factor", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.header.nPorts_a", "Number of port_a connections [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareVariable("BOP.header.nPorts_b", "Number of port_b connections [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,517)
DeclareAlias2("BOP.header.port_a[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "EM.port_b2.m_flow", -1, 5, 5724, 132)
DeclareAlias2("BOP.header.port_a[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareAlias2("BOP.header.port_a[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareAlias2("BOP.header.port_b[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.valve_BV.port_a.m_flow", -1, 5, 6645, 132)
DeclareAlias2("BOP.header.port_b[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareAlias2("BOP.header.port_b[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareAlias2("BOP.header.port_b[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.steamTurbine.portHP.m_flow", -1, 5, 6395, 132)
DeclareAlias2("BOP.header.port_b[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareAlias2("BOP.header.port_b[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareVariable("BOP.header.port_b[3].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,777)
DeclareAlias2("BOP.header.port_b[3].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareAlias2("BOP.header.port_b[3].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareVariable("BOP.header.V", "Volume [m3]", 1, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.header.energyDynamics", "Formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.header.massDynamics", "Formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.header.substanceDynamics", "Formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.header.traceDynamics", "Formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.header.p_start", "Pressure [Pa|bar]", 0.0, 0.0,1E+100,\
100000.0,0,513)
DeclareVariable("BOP.header.use_T_start", "Use T_start if true, otherwise h_start [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.header.T_start", "Temperature [K|degC]", 293.15, 0.0,1E+100,\
300.0,0,513)
DeclareVariable("BOP.header.h_start", "Specific enthalpy [J/kg]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareParameter("BOP.header.X_start[1]", "Mass fraction [1]", 659, 1.0, 0.0,1.0,\
0.0,0,560)
DeclareState("BOP.header.medium.p", "Absolute pressure of medium [Pa|bar]", 65, \
100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("BOP.header.medium.der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("BOP.header.medium.h", "Specific enthalpy of medium [J/kg]", 66, \
0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("BOP.header.medium.der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.header.medium.d", "Density of medium [kg/m3|g/cm3]", \
"BOP.header.m", 1, 5, 6788, 0)
DeclareVariable("BOP.header.medium.T", "Temperature of medium [K|degC]", 500.0, \
273.15,2273.15,500.0,0,512)
DeclareVariable("BOP.header.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("BOP.header.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("BOP.header.medium.der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.header.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("BOP.header.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("BOP.header.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,644)
DeclareAlias2("BOP.header.medium.state.h", "Specific enthalpy [J/kg]", \
"BOP.header.medium.h", 1, 1, 66, 0)
DeclareAlias2("BOP.header.medium.state.d", "Density [kg/m3|g/cm3]", \
"BOP.header.m", 1, 5, 6788, 0)
DeclareAlias2("BOP.header.medium.state.T", "Temperature [K|degC]", \
"BOP.header.medium.T", 1, 5, 6776, 0)
DeclareAlias2("BOP.header.medium.state.p", "Pressure [Pa|bar]", "BOP.header.medium.p", 1,\
 1, 65, 0)
DeclareVariable("BOP.header.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.header.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.header.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.header.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.header.medium.sat.psat", "Saturation pressure [Pa|bar]", \
"BOP.header.medium.p", 1, 1, 65, 0)
DeclareVariable("BOP.header.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("BOP.header.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "BOP.header.medium.state.phase", 1, 5, 6782, 66)
DeclareVariable("BOP.header.m", "Mass [kg]", 0.0, 0.0,100000.0,500.0,0,512)
DeclareVariable("BOP.header.der(m)", "der(Mass) [kg/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.header.U", "Internal energy [J]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.header.der(U)", "der(Internal energy) [W]", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareAlias2("BOP.header.mb", "Mass flow rate source/sinks within volumes [kg/s]",\
 "BOP.header.der(m)", 1, 5, 6789, 0)
DeclareAlias2("BOP.header.Ub", "Energy source/sinks within volumes (e.g., ohmic heating, external convection) [W]",\
 "BOP.header.der(U)", 1, 5, 6791, 0)
DeclareParameter("BOP.header.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 660, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("BOP.header.geometry.V", "Volume [m3]", 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.header.geometry.angle", "Vertical angle from the horizontal (-pi/2 <= x <= pi/2) [rad|deg]",\
 0.0, -1.5807963267948966,1.5807963267948966,0.0,0,513)
DeclareVariable("BOP.header.geometry.dheight", "Height(port_b) - Height(port_a) [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.header.geometry.height_a", "Elevation at port_a: Reference value only. No impact on calculations. [m]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.header.geometry.height_b", "Elevation at port_b: Reference value only. No impact on calculations. [m]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.header.g_n", "Gravitational acceleration [m/s2]", 9.80665, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.header.H_flows_a[1]", "Enthalpy flow rates at port_a [W]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.header.H_flows_b[1]", "Enthalpy flow rates at port_b [W]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.header.H_flows_b[2]", "Enthalpy flow rates at port_b [W]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.header.H_flows_b[3]", "Enthalpy flow rates at port_b [W]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.header.use_HeatPort", "=true to toggle heat port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.header.Q_gen", "Internal heat generation [W]", 0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("BOP.header.use_TraceMassPort", "=true to toggle trace mass port [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.header.showName", "[:#(type=Boolean)]", 661, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("BOP.header.Q_flow_internal", "[W]", 0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.resistance4.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "EM.port_b2.m_flow", -1, 5, 5724, 132)
DeclareAlias2("BOP.resistance4.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "EM.port_b2.p", 1, 5, 5725, 4)
DeclareAlias2("BOP.resistance4.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.header.medium.h", 1, 1, 66, 4)
DeclareAlias2("BOP.resistance4.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "EM.port_b2.m_flow", 1, 5, 5724, 132)
DeclareAlias2("BOP.resistance4.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.header.medium.p", 1, 1, 65, 4)
DeclareAlias2("BOP.resistance4.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "EM.steamHeader.medium.h", 1, 1, 51, 4)
DeclareVariable("BOP.resistance4.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.resistance4.state.h", "Specific enthalpy [J/kg]", \
"EM.steamHeader.medium.h", 1, 1, 51, 0)
DeclareVariable("BOP.resistance4.state.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.resistance4.state.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("BOP.resistance4.state.p", "Pressure [Pa|bar]", "EM.port_b2.p", 1,\
 5, 5725, 0)
DeclareVariable("BOP.resistance4.dp", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.resistance4.m_flow", "[kg/s]", "EM.port_b2.m_flow", -1, 5, 5724,\
 0)
DeclareParameter("BOP.resistance4.showName", "[:#(type=Boolean)]", 662, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance4.showDP", "[:#(type=Boolean)]", 663, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance4.precision", "Number of decimals displayed [:#(type=Integer)]",\
 664, 3, 0.0,1E+100,0.0,0,564)
DeclareVariable("BOP.resistance4.R", "Hydraulic resistance [Pa/(kg/s)]", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.powerSensor.flange_a.phi", "Absolute rotation angle of flange [rad|deg]",\
 "BOP.generator1.shaft_a.phi", 1, 1, 55, 4)
DeclareAlias2("BOP.powerSensor.flange_a.der(phi)", "der(Absolute rotation angle of flange) [rad/s]",\
 "BOP.generator1.omega_m", 1, 1, 54, 4)
DeclareAlias2("BOP.powerSensor.flange_a.tau", "Cut torque in the flange [N.m]", \
"BOP.steamTurbine.shaft_b.tau", -1, 5, 6400, 132)
DeclareAlias2("BOP.powerSensor.flange_b.phi", "Absolute rotation angle of flange [rad|deg]",\
 "BOP.generator1.shaft_a.phi", 1, 1, 55, 4)
DeclareAlias2("BOP.powerSensor.flange_b.tau", "Cut torque in the flange [N.m]", \
"BOP.steamTurbine.shaft_b.tau", 1, 5, 6400, 132)
DeclareVariable("BOP.powerSensor.power", "Power in flange flange_a as output signal [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.resistance2.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.reservoir.port_b.m_flow", -1, 5, 6529, 132)
DeclareAlias2("BOP.resistance2.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.reservoir.port_b.p", 1, 5, 6530, 4)
DeclareAlias2("BOP.resistance2.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.feedWaterHeater.medium.h", 1, 1, 62, 4)
DeclareAlias2("BOP.resistance2.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "BOP.reservoir.port_b.m_flow", 1, 5, 6529, 132)
DeclareAlias2("BOP.resistance2.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "BOP.feedWaterHeater.medium.p", 1, 1, 61, 4)
DeclareAlias2("BOP.resistance2.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "BOP.reservoir.h", 1, 1, 60, 4)
DeclareVariable("BOP.resistance2.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.resistance2.state.h", "Specific enthalpy [J/kg]", \
"BOP.reservoir.h", 1, 1, 60, 0)
DeclareVariable("BOP.resistance2.state.d", "Density [kg/m3|g/cm3]", 150, 0.0,\
100000.0,500.0,0,512)
DeclareVariable("BOP.resistance2.state.T", "Temperature [K|degC]", 500, 273.15,\
2273.15,500.0,0,512)
DeclareAlias2("BOP.resistance2.state.p", "Pressure [Pa|bar]", "BOP.reservoir.port_b.p", 1,\
 5, 6530, 0)
DeclareVariable("BOP.resistance2.dp", "[Pa|bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.resistance2.m_flow", "[kg/s]", "BOP.reservoir.port_b.m_flow", -1,\
 5, 6529, 0)
DeclareParameter("BOP.resistance2.showName", "[:#(type=Boolean)]", 665, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance2.showDP", "[:#(type=Boolean)]", 666, true, \
0.0,0.0,0.0,0,562)
DeclareParameter("BOP.resistance2.precision", "Number of decimals displayed [:#(type=Integer)]",\
 667, 3, 0.0,1E+100,0.0,0,564)
DeclareVariable("BOP.resistance2.R", "Hydraulic resistance [Pa/(kg/s)]", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID1.u_s", "Connector of setpoint input signal [m]", \
"BOP.reservoir.level_start", 1, 7, 598, 0)
DeclareAlias2("BOP.PID1.u_m", "Connector of measurement input signal [m]", \
"BOP.reservoir.level", 1, 1, 59, 0)
DeclareAlias2("BOP.PID1.y", "Connector of actuator output signal [kg/s]", \
"BOP.boundary2.ports[1].m_flow", -1, 5, 6892, 0)
DeclareVariable("BOP.PID1.controllerType", "Type of controller [:#(type=Modelica.Blocks.Types.SimpleController)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID1.derMeas", "=true avoid derivative kick [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("BOP.PID1.k", "Controller gain: +/- for direct/reverse acting [1]",\
 668, 100.0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.Ti", "Time constant of Integrator block [s]", 669, \
0.5, 1E-60,1E+100,0.0,0,560)
DeclareParameter("BOP.PID1.Td", "Time constant of Derivative block [s]", 670, \
0.1, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.PID1.yb", "Output bias. May improve simulation", 671, 0, \
0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID1.k_s", "Setpoint input scaling: k_s*u_s. May improve simulation [m-1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.k_m", "Measurement input scaling: k_m*u_m. May improve simulation [m-1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID1.yMax", "Upper limit of output [kg/s]", 672, 1E+60, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.yMin", "Lower limit of output [kg/s]", 673, 0, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.wp", "Set-point weight for Proportional block (0..1)",\
 674, 1, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.PID1.wd", "Set-point weight for Derivative block (0..1)", 675,\
 0, 0.0,1E+100,0.0,0,560)
DeclareParameter("BOP.PID1.Ni", "Ni*Ti is time constant of anti-windup compensation",\
 676, 0.9, 1E-13,1E+100,0.0,0,560)
DeclareParameter("BOP.PID1.Nd", "The higher Nd, the more ideal the derivative block",\
 677, 10, 1E-13,1E+100,0.0,0,560)
DeclareVariable("BOP.PID1.initType", "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID1.xi_start", "Initial or guess value value for integrator output (= integrator state)",\
 0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID1.xd_start", "Initial or guess value for state of derivative block",\
 678, 0, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.y_start", "Initial value of output [kg/s]", 679, 0, \
0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID1.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID1.eOn", "if off and control error > eOn, switch to set point tracking",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.eOff", "if on and control error < eOff, set y=0", 0.0,\
 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID1.pre_y_start", "Value of hysteresis output at initial time [:#(type=Boolean)]",\
 680, false, 0.0,0.0,0.0,0,562)
DeclareVariable("BOP.PID1.PID.u_s", "Connector of setpoint input signal [m]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.PID1.PID.u_m", "Connector of measurement input signal [m]", \
"BOP.reservoir.level", 1, 1, 59, 0)
DeclareVariable("BOP.PID1.PID.y", "Connector of actuator output signal [kg/s]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.PID.controlError", "Control error (set point - measurement) [m]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.PID.controllerType", "Type of controller [:#(type=Modelica.Blocks.Types.SimpleController)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID1.PID.with_FF", "enable feed-forward input signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID1.PID.derMeas", "=true avoid derivative kick [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID1.PID.k", "Controller gain: +/- for direct/reverse acting [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.Ti", "Time constant of Integrator block [s]", \
1E-60, 1E-60,1E+100,0.0,0,513)
DeclareVariable("BOP.PID1.PID.Td", "Time constant of Derivative block [s]", 0.0,\
 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.PID1.PID.yb", "Output bias. May improve simulation", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.k_s", "Setpoint input scaling: k_s*u_s. May improve simulation [m-1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.k_m", "Measurement input scaling: k_m*u_m. May improve simulation [m-1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("BOP.PID1.PID.k_ff", "Measurement input scaling: k_ff*u_ff. May improve simulation",\
 681, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID1.PID.yMax", "Upper limit of output [kg/s]", 1, 0.0,0.0,\
0.0,0,513)
DeclareVariable("BOP.PID1.PID.yMin", "Lower limit of output [kg/s]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.wp", "Set-point weight for Proportional block (0..1)",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.PID1.PID.wd", "Set-point weight for Derivative block (0..1)",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareVariable("BOP.PID1.PID.Ni", "Ni*Ti is time constant of anti-windup compensation",\
 1E-13, 1E-13,1E+100,0.0,0,513)
DeclareVariable("BOP.PID1.PID.Nd", "The higher Nd, the more ideal the derivative block",\
 1E-13, 1E-13,1E+100,0.0,0,513)
DeclareVariable("BOP.PID1.PID.initType", "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID1.PID.xi_start", "Initial or guess value value for integrator output (= integrator state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.xd_start", "Initial or guess value for state of derivative block",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.y_start", "Initial value of output [kg/s]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID1.PID.reset", "Type of controller output reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.PID1.PID.y_reset", "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.addP.u1", "Connector of Real input signal 1 [m]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.PID.addP.u2", "Connector of Real input signal 2 [m]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.PID.addP.y", "Connector of Real output signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.PID.addP.k1", "Gain of input signal 1", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareParameter("BOP.PID1.PID.addP.k2", "Gain of input signal 2", 682, -1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.P.k", "Gain value multiplied with input signal [1]",\
 683, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.PID1.PID.P.u", "Input signal connector", "BOP.PID1.PID.addP.y", 1,\
 5, 6853, 0)
DeclareVariable("BOP.PID1.PID.P.y", "Output signal connector", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareVariable("BOP.PID1.PID.gainPID.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.gainPID.u", "Input signal connector", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.PID.gainPID.y", "Output signal connector", 0.0, \
0.0,0.0,0.0,0,512)
DeclareParameter("BOP.PID1.PID.addPID.k1", "Gain of input signal 1", 684, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.addPID.k2", "Gain of input signal 2", 685, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.addPID.k3", "Gain of input signal 3", 686, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.PID1.PID.addPID.u1", "Connector of Real input signal 1", \
"BOP.PID1.PID.P.y", 1, 5, 6855, 0)
DeclareAlias2("BOP.PID1.PID.addPID.u2", "Connector of Real input signal 2", \
"BOP.PID1.PID.Dzero.k", 1, 7, 903, 0)
DeclareAlias2("BOP.PID1.PID.addPID.u3", "Connector of Real input signal 3", \
"BOP.PID1.PID.I.y", 1, 1, 196, 0)
DeclareAlias2("BOP.PID1.PID.addPID.y", "Connector of Real output signal", \
"BOP.PID1.PID.gainPID.u", 1, 5, 6857, 0)
DeclareVariable("BOP.PID1.PID.limiter.uMax", "Upper limits of input signals [kg/s]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.limiter.uMin", "Lower limits of input signals [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.limiter.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID1.PID.limiter.homotopyType", "Simplified model for homotopy-based initialization [:#(type=Modelica.Blocks.Types.LimiterHomotopy)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID1.PID.limiter.u", "Connector of Real input signal [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.PID1.PID.limiter.y", "Connector of Real output signal [kg/s]",\
 "BOP.PID1.PID.y", 1, 5, 6827, 0)
DeclareAlias2("BOP.PID1.PID.limiter.simplifiedExpr", "Simplified expression for homotopy-based initialization [kg/s]",\
 "BOP.PID1.PID.limiter.u", 1, 5, 6863, 1024)
DeclareParameter("BOP.PID1.PID.Fzero.k", "Constant output value", 687, 0, \
0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.PID1.PID.Fzero.y", "Connector of Real output signal", \
"BOP.PID1.PID.Fzero.k", 1, 7, 687, 0)
DeclareParameter("BOP.PID1.PID.addFF.k1", "Gain of input signal 1", 688, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.addFF.k2", "Gain of input signal 2", 689, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.addFF.k3", "Gain of input signal 3", 690, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.PID1.PID.addFF.u1", "Connector of Real input signal 1", \
"BOP.PID1.PID.Fzero.k", 1, 7, 687, 0)
DeclareAlias2("BOP.PID1.PID.addFF.u2", "Connector of Real input signal 2", \
"BOP.PID1.PID.gainPID.y", 1, 5, 6858, 0)
DeclareAlias2("BOP.PID1.PID.addFF.u3", "Connector of Real input signal 3", \
"BOP.PID1.PID.null_bias.k", 1, 5, 6866, 0)
DeclareAlias2("BOP.PID1.PID.addFF.y", "Connector of Real output signal [kg/s]", \
"BOP.PID1.PID.limiter.u", 1, 5, 6863, 0)
DeclareVariable("BOP.PID1.PID.gain_u_s.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID1.PID.gain_u_s.u", "Input signal connector [m]", \
"BOP.PID1.PID.u_s", 1, 5, 6826, 0)
DeclareAlias2("BOP.PID1.PID.gain_u_s.y", "Output signal connector [m]", \
"BOP.PID1.PID.addP.u1", 1, 5, 6851, 0)
DeclareVariable("BOP.PID1.PID.gain_u_m.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID1.PID.gain_u_m.u", "Input signal connector [m]", \
"BOP.reservoir.level", 1, 1, 59, 0)
DeclareAlias2("BOP.PID1.PID.gain_u_m.y", "Output signal connector [m]", \
"BOP.PID1.PID.addP.u2", 1, 5, 6852, 0)
DeclareVariable("BOP.PID1.PID.null_bias.k", "Constant output value", 1, 0.0,0.0,\
0.0,0,513)
DeclareAlias2("BOP.PID1.PID.null_bias.y", "Connector of Real output signal", \
"BOP.PID1.PID.null_bias.k", 1, 5, 6866, 0)
DeclareVariable("BOP.PID1.PID.unitTime", "[s]", 1, 0.0,0.0,0.0,0,1537)
DeclareVariable("BOP.PID1.PID.with_I", "[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.PID1.PID.with_D", "[:#(type=Boolean)]", false, 0.0,0.0,0.0,\
0,1539)
DeclareVariable("BOP.PID1.PID.y_reset_internal", "Internal connector for controller output reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.PID1.hys.uLow", "If y=true and u<uLow, switch to y=false", 0,\
 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.hys.uHigh", "If y=false and u>uHigh, switch to y=true",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.hys.pre_y_start", "Value of pre(y) at initial time [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.PID1.hys.u", "[m]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.hys.y", "[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,642)
DeclareAlias2("BOP.PID1.feeBac.u1", "Commanded input [m]", "BOP.reservoir.level_start", 1,\
 7, 598, 0)
DeclareAlias2("BOP.PID1.feeBac.u2", "Feedback input [m]", "BOP.reservoir.level", 1,\
 1, 59, 0)
DeclareAlias2("BOP.PID1.feeBac.y", "[m]", "BOP.PID1.hys.u", 1, 5, 6874, 0)
DeclareAlias2("BOP.PID1.swi.u1", "Connector of first Real input signal [kg/s]", \
"BOP.PID1.PID.y", 1, 5, 6827, 1024)
DeclareAlias2("BOP.PID1.swi.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "BOP.PID1.hys.y", 1, 5, 6875, 1089)
DeclareVariable("BOP.PID1.swi.u3", "Connector of second Real input signal [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.PID1.swi.y", "Connector of Real output signal [kg/s]", \
"BOP.boundary2.ports[1].m_flow", -1, 5, 6892, 1024)
DeclareVariable("BOP.PID1.zer.k", "Constant output value [kg/s]", 0, 0.0,0.0,0.0,\
0,2561)
DeclareVariable("BOP.PID1.zer.y", "Connector of Real output signal [kg/s]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareAlias2("BOP.PID1.swi1.u1", "Connector of first Real input signal [m]", \
"BOP.reservoir.level_start", 1, 7, 598, 1024)
DeclareAlias2("BOP.PID1.swi1.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "BOP.PID1.hys.y", 1, 5, 6875, 1089)
DeclareAlias2("BOP.PID1.swi1.u3", "Connector of second Real input signal [m]", \
"BOP.reservoir.level", 1, 1, 59, 1024)
DeclareAlias2("BOP.PID1.swi1.y", "Connector of Real output signal [m]", \
"BOP.PID1.PID.u_s", 1, 5, 6826, 1024)
DeclareAlias2("BOP.level_setpoint.y", "Value of Real output [m]", \
"BOP.reservoir.level_start", 1, 7, 598, 0)
DeclareAlias2("BOP.level_measure.y", "Value of Real output [m]", \
"BOP.reservoir.level", 1, 1, 59, 0)
DeclareParameter("BOP.boundary2.showName", "[:#(type=Boolean)]", 691, true, \
0.0,0.0,0.0,0,562)
DeclareVariable("BOP.boundary2.nPorts", "Number of ports [:#(type=Integer)]", 1,\
 0.0,0.0,0.0,0,517)
DeclareAlias2("BOP.boundary2.medium.p", "Absolute pressure of medium [Pa|bar]", \
"BOP.reservoir.p_start", 1, 5, 6537, 0)
DeclareAlias2("BOP.boundary2.medium.h", "Specific enthalpy of medium [J/kg]", \
"BOP.boundary2.ports[1].h_outflow", 1, 5, 6894, 0)
DeclareVariable("BOP.boundary2.medium.d", "Density of medium [kg/m3|g/cm3]", 150,\
 0.0,100000.0,500.0,0,513)
DeclareVariable("BOP.boundary2.medium.T", "Temperature of medium [K|degC]", 500,\
 273.15,2273.15,500.0,0,513)
DeclareVariable("BOP.boundary2.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("BOP.boundary2.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("BOP.boundary2.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("BOP.boundary2.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareVariable("BOP.boundary2.medium.state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 1, 0.0,2.0,0.0,0,517)
DeclareAlias2("BOP.boundary2.medium.state.h", "Specific enthalpy [J/kg]", \
"BOP.boundary2.ports[1].h_outflow", 1, 5, 6894, 0)
DeclareAlias2("BOP.boundary2.medium.state.d", "Density [kg/m3|g/cm3]", \
"BOP.boundary2.medium.d", 1, 5, 6880, 0)
DeclareAlias2("BOP.boundary2.medium.state.T", "Temperature [K|degC]", \
"BOP.boundary2.medium.T", 1, 5, 6881, 0)
DeclareAlias2("BOP.boundary2.medium.state.p", "Pressure [Pa|bar]", \
"BOP.reservoir.p_start", 1, 5, 6537, 0)
DeclareVariable("BOP.boundary2.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.boundary2.medium.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("BOP.boundary2.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.boundary2.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.boundary2.medium.sat.psat", "Saturation pressure [Pa|bar]", \
"BOP.reservoir.p_start", 1, 5, 6537, 0)
DeclareVariable("BOP.boundary2.medium.sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,513)
DeclareAlias2("BOP.boundary2.medium.phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "BOP.boundary2.medium.state.phase", 1, 5, 6886, 66)
DeclareVariable("BOP.boundary2.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,776)
DeclareVariable("BOP.boundary2.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 5000000.0, 611.657,100000000.0,1000000.0,0,521)
DeclareVariable("BOP.boundary2.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 100000.0, -10000000000.0,10000000000.0,500000.0,0,521)
DeclareVariable("BOP.boundary2.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("BOP.boundary2.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.boundary2.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.boundary2.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.boundary2.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("BOP.boundary2.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("BOP.boundary2.T", "Fixed value of temperature [K|degC]", 298.15,\
 273.15,2273.15,500.0,0,513)
DeclareVariable("BOP.boundary2.X[1]", "Fixed value of composition [kg/kg]", 1.0,\
 0.0,1.0,0.1,0,513)
DeclareAlias2("BOP.boundary2.m_flow_in", "Prescribed mass flow rate [kg/s]", \
"BOP.boundary2.ports[1].m_flow", -1, 5, 6892, 0)
DeclareAlias2("BOP.boundary2.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "BOP.boundary2.ports[1].m_flow", -1, 5, 6892, 1024)
DeclareVariable("BOP.boundary2.T_in_internal", "Needed to connect to conditional connector [K]",\
 298.15, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.boundary2.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("SY.CS.actuatorBus.closed_BOP", "Breaker control for BOP [:#(type=Boolean)]",\
 "SY.CS.BOP_closed.k", 1, 7, 692, 69)
DeclareAlias2("SY.CS.actuatorBus.closed_ES", "Breaker control for ES [:#(type=Boolean)]",\
 "SY.CS.ES_closed.k", 1, 7, 693, 69)
DeclareAlias2("SY.CS.actuatorBus.closed_SES", "Breaker control for SES [:#(type=Boolean)]",\
 "SY.CS.SES_closed.k", 1, 7, 694, 69)
DeclareAlias2("SY.CS.actuatorBus.closed_EG", "Breaker control for EG [:#(type=Boolean)]",\
 "SY.CS.EG_closed.k", 1, 7, 695, 69)
DeclareVariable("SY.CS.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SY.CS.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareAlias2("SY.CS.sensorBus.W_subsystems[1]", "Electric power from connected subsystems (+=generated, -=consumption) [W]",\
 "BOP.sensorBus.W_total", 1, 5, 6372, 4)
DeclareAlias2("SY.CS.sensorBus.W_subsystems[2]", "Electric power from connected subsystems (+=generated, -=consumption) [W]",\
 "SY.sensorBus.W_subsystems[2]", 1, 5, 6911, 4)
DeclareParameter("SY.CS.BOP_closed.k", "Constant output value [:#(type=Boolean)]",\
 692, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("SY.CS.BOP_closed.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 "SY.CS.BOP_closed.k", 1, 7, 692, 65)
DeclareParameter("SY.CS.ES_closed.k", "Constant output value [:#(type=Boolean)]",\
 693, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("SY.CS.ES_closed.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 "SY.CS.ES_closed.k", 1, 7, 693, 65)
DeclareParameter("SY.CS.SES_closed.k", "Constant output value [:#(type=Boolean)]",\
 694, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("SY.CS.SES_closed.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 "SY.CS.SES_closed.k", 1, 7, 694, 65)
DeclareParameter("SY.CS.EG_closed.k", "Constant output value [:#(type=Boolean)]",\
 695, true, 0.0,0.0,0.0,0,562)
DeclareAlias2("SY.CS.EG_closed.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 "SY.CS.EG_closed.k", 1, 7, 695, 65)
DeclareAlias2("SY.ED.actuatorBus.closed_BOP", "Breaker control for BOP [:#(type=Boolean)]",\
 "SY.CS.BOP_closed.k", 1, 7, 692, 69)
DeclareAlias2("SY.ED.actuatorBus.closed_ES", "Breaker control for ES [:#(type=Boolean)]",\
 "SY.CS.ES_closed.k", 1, 7, 693, 69)
DeclareAlias2("SY.ED.actuatorBus.closed_SES", "Breaker control for SES [:#(type=Boolean)]",\
 "SY.CS.SES_closed.k", 1, 7, 694, 69)
DeclareAlias2("SY.ED.actuatorBus.closed_EG", "Breaker control for EG [:#(type=Boolean)]",\
 "SY.CS.EG_closed.k", 1, 7, 695, 69)
DeclareVariable("SY.ED.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SY.ED.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareAlias2("SY.ED.sensorBus.W_subsystems[1]", "Electric power from connected subsystems (+=generated, -=consumption) [W]",\
 "BOP.sensorBus.W_total", 1, 5, 6372, 4)
DeclareAlias2("SY.ED.sensorBus.W_subsystems[2]", "Electric power from connected subsystems (+=generated, -=consumption) [W]",\
 "SY.sensorBus.W_subsystems[2]", 1, 5, 6911, 4)
DeclareAlias2("SY.actuatorBus.closed_BOP", "Breaker control for BOP [:#(type=Boolean)]",\
 "SY.CS.BOP_closed.k", 1, 7, 692, 69)
DeclareAlias2("SY.actuatorBus.closed_ES", "Breaker control for ES [:#(type=Boolean)]",\
 "SY.CS.ES_closed.k", 1, 7, 693, 69)
DeclareAlias2("SY.actuatorBus.closed_SES", "Breaker control for SES [:#(type=Boolean)]",\
 "SY.CS.SES_closed.k", 1, 7, 694, 69)
DeclareAlias2("SY.actuatorBus.closed_EG", "Breaker control for EG [:#(type=Boolean)]",\
 "SY.CS.EG_closed.k", 1, 7, 695, 69)
DeclareVariable("SY.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SY.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareAlias2("SY.sensorBus.W_subsystems[1]", "Electric power from connected subsystems (+=generated, -=consumption) [W]",\
 "BOP.sensorBus.W_total", 1, 5, 6372, 4)
DeclareVariable("SY.sensorBus.W_subsystems[2]", "Electric power from connected subsystems (+=generated, -=consumption) [W]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareVariable("SY.Q_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SY.W_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SY.nPorts_a", "Number of port_a connections [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareAlias2("SY.port_a[1].W", "Active power [W]", "BOP.sensorBus.W_total", 1, 5,\
 6372, 132)
DeclareAlias2("SY.port_a[1].f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5, 6393,\
 4)
DeclareAlias2("SY.port_a[2].W", "Active power [W]", "SY.sensorBus.W_subsystems[2]", 1,\
 5, 6911, 132)
DeclareAlias2("SY.port_a[2].f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5, 6393,\
 4)
DeclareVariable("SY.port_Grid.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("SY.port_Grid.f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5, 6393,\
 4)
DeclareVariable("SY.W_balance_total", "Total electrical power not accounted in electrical ports [W]",\
 0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SY.sensorW_port_a[1].port_a.W", "Active power [W]", \
"BOP.sensorBus.W_total", 1, 5, 6372, 132)
DeclareAlias2("SY.sensorW_port_a[1].port_a.f", "Frequency [Hz]", \
"BOP.portElec_b.f", 1, 5, 6393, 4)
DeclareAlias2("SY.sensorW_port_a[1].port_b.W", "Active power [W]", \
"BOP.sensorBus.W_total", -1, 5, 6372, 132)
DeclareAlias2("SY.sensorW_port_a[1].port_b.f", "Frequency [Hz]", \
"BOP.portElec_b.f", 1, 5, 6393, 4)
DeclareAlias2("SY.sensorW_port_a[1].W", "Power flowing from port_a to port_b [W]",\
 "BOP.sensorBus.W_total", 1, 5, 6372, 0)
DeclareAlias2("SY.sensorW_port_a[2].port_a.W", "Active power [W]", \
"SY.sensorBus.W_subsystems[2]", 1, 5, 6911, 132)
DeclareAlias2("SY.sensorW_port_a[2].port_a.f", "Frequency [Hz]", \
"BOP.portElec_b.f", 1, 5, 6393, 4)
DeclareAlias2("SY.sensorW_port_a[2].port_b.W", "Active power [W]", \
"SY.sensorBus.W_subsystems[2]", -1, 5, 6911, 132)
DeclareAlias2("SY.sensorW_port_a[2].port_b.f", "Frequency [Hz]", \
"BOP.portElec_b.f", 1, 5, 6393, 4)
DeclareAlias2("SY.sensorW_port_a[2].W", "Power flowing from port_a to port_b [W]",\
 "SY.sensorBus.W_subsystems[2]", 1, 5, 6911, 0)
DeclareVariable("SY.breaker_EG.port_a.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("SY.breaker_EG.port_a.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareVariable("SY.breaker_EG.port_b.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("SY.breaker_EG.port_b.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareAlias2("SY.breaker_EG.closed", "[:#(type=Boolean)]", "SY.CS.EG_closed.k", 1,\
 7, 695, 65)
DeclareVariable("SY.sensorW_SY.port_a.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("SY.sensorW_SY.port_a.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareVariable("SY.sensorW_SY.port_b.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("SY.sensorW_SY.port_b.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareVariable("SY.sensorW_SY.W", "Power flowing from port_a to port_b [W]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SY.sensorW_EG.port_a.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("SY.sensorW_EG.port_a.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareVariable("SY.sensorW_EG.port_b.W", "Active power [W]", 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("SY.sensorW_EG.port_b.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareVariable("SY.sensorW_EG.W", "Power flowing from port_a to port_b [W]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SY.W_balanceTotal.y", "Value of Real output [W]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("SY.W_balance_load.use_W_in", "Get the power from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareParameter("SY.W_balance_load.W", "Active power [W]", 696, 0, 0.0,0.0,0.0,\
0,560)
DeclareVariable("SY.W_balance_load.portElec_a.W", "Active power [W]", 0.0, \
0.0,0.0,0.0,0,777)
DeclareAlias2("SY.W_balance_load.portElec_a.f", "Frequency [Hz]", \
"BOP.portElec_b.f", 1, 5, 6393, 4)
DeclareVariable("SY.W_balance_load.W_in", "Prescribed mass flow rate [W]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("SY.W_balance_load.W_in_internal", "Needed to connect to conditional connector [W]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("EG.Q_balance.y", "Value of Real output", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EG.W_balance.y", "Value of Real output", 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EG.portElec_a.W", "Active power [W]", "SY.port_Grid.W", -1, 5, 6915,\
 132)
DeclareAlias2("EG.portElec_a.f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5, 6393,\
 4)
DeclareParameter("EG.f_nominal", "Nominal frequency [Hz]", 697, 60, 0.0,0.0,0.0,\
0,560)
DeclareParameter("EG.Q_nominal", "Nominal power installed on the network [W]", 698,\
 100000000000.0, 0.0,0.0,0.0,0,560)
DeclareParameter("EG.droop", "Network droop [1]", 699, 0.05, 0.0,0.0,0.0,0,560)
DeclareVariable("EG.grid.n", "Number of ports [:#(type=Integer)]", 1, 0.0,0.0,\
0.0,0,517)
DeclareVariable("EG.grid.f_nominal", "Nominal frequency [Hz]", 0.0, 0.0,0.0,0.0,\
0,513)
DeclareVariable("EG.grid.Q_nominal", "Nominal power installed on the network [W]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("EG.grid.droop", "Network droop [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("EG.grid.W_total", "Total power [W]", "SY.port_Grid.W", -1, 5, 6915,\
 0)
DeclareAlias2("EG.grid.ports[1].W", "Active power [W]", "SY.port_Grid.W", -1, 5,\
 6915, 132)
DeclareAlias2("EG.grid.ports[1].f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5, 6393,\
 4)
DeclareParameter("dataCapacity.BOP_capacity", "[W|MW]", 700, 1165000000, \
0.0,0.0,0.0,0,560)
DeclareParameter("dataCapacity.IP_capacity", "[W|MW]", 701, 53303300, 0.0,0.0,\
0.0,0,560)
DeclareParameter("dataCapacity.ES_capacity", "[W.h]", 702, 20000000.0, 0.0,0.0,\
0.0,0,560)
DeclareParameter("dataCapacity.SES_capacity", "[W]", 703, 35000000.0, 0.0,0.0,\
0.0,0,560)
DeclareParameter("delayStart.k", "Constant output value [s]", 704, 0, 0.0,0.0,\
0.0,0,560)
DeclareAlias2("delayStart.y", "Connector of Real output signal [s]", \
"delayStart.k", 1, 7, 704, 0)
DeclareVariable("SC.delayStart", "Time to start tracking power profiles [s]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.timeScale", "Time scale of first table column [s]", 3600, \
0.0,0.0,0.0,0,513)
DeclareParameter("SC.W_nominal_BOP", "Nominal BOP Power [W|MW]", 705, 50000000, \
0.0,0.0,0.0,0,560)
DeclareParameter("SC.W_nominal_IP", "Nominal IP Power [W]", 706, 51145400.0, \
0.0,0.0,0.0,0,560)
DeclareParameter("SC.W_nominal_ES", "Nominal ES Power [W]", 707, 0, 0.0,0.0,0.0,\
0,560)
DeclareParameter("SC.W_nominal_SES", "Nominal SES Power [W]", 708, 35000000.0, \
0.0,0.0,0.0,0,560)
DeclareVariable("SC.W_totalSetpoint_BOP", "[W]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.W_totalSetpoint_IP", "[W]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.W_totalSetpoint_ES", "[W]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.W_totalSetpoint_SES", "[W]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.W_totalSetpoint_EG", "[W]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.demand_BOP.nout", "Number of outputs [:#(type=Integer)]", 1,\
 1.0,1E+100,0.0,0,517)
DeclareVariable("SC.demand_BOP.y[1]", "Connector of Real output signals [W]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.demand_BOP.tableOnFile", "= true, if table is defined on file or in function usertab [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SC.demand_BOP.verboseRead", "= true, if info message that file is loading is to be printed [:#(type=Boolean)]",\
 709, true, 0.0,0.0,0.0,0,562)
DeclareVariable("SC.demand_BOP.columns[1]", "Columns of table to be interpolated [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("SC.demand_BOP.smoothness", "Smoothness of table interpolation [:#(type=Modelica.Blocks.Types.Smoothness)]",\
 1, 1.0,6.0,0.0,0,517)
DeclareVariable("SC.demand_BOP.extrapolation", "Extrapolation of data outside the definition range [:#(type=Modelica.Blocks.Types.Extrapolation)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("SC.demand_BOP.timeScale", "Time scale of first table column [s]",\
 3600.0, 1E-15,1E+100,0.0,0,513)
DeclareParameter("SC.demand_BOP.offset[1]", "Offsets of output signals", 710, 0,\
 0.0,0.0,0.0,0,560)
DeclareVariable("SC.demand_BOP.startTime", "Output = offset for time < startTime [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_BOP.shiftTime", "Shift time of first table column [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SC.demand_BOP.timeEvents", "Time event handling of table interpolation [:#(type=Modelica.Blocks.Types.TimeEvents)]",\
 711, 1, 1.0,3.0,0.0,0,564)
DeclareVariable("SC.demand_BOP.verboseExtrapolation", "= true, if warning messages are to be printed if time is outside the table definition range [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SC.demand_BOP.t_min", "Minimum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_BOP.t_max", "Maximum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_BOP.t_minScaled", "Minimum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_BOP.t_maxScaled", "Maximum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_BOP.p_offset[1]", "Offsets of output signals", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("SC.demand_BOP.tableID.id", "[:#(type=Integer)]", 0, 0.0,0.0,0.0,\
0,2565)
DeclareVariable("SC.demand_BOP.nextTimeEvent", "Next time event instant [s]", 0,\
 0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_BOP.nextTimeEventScaled", "Next scaled time event instant [1]",\
 0, 0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_BOP.timeScaled", "Scaled time [1]", 0.0, 0.0,0.0,0.0,\
0,2560)
DeclareVariable("SC.greaterEqualThreshold1.threshold", "Comparison with respect to threshold [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.greaterEqualThreshold1.u", "Connector of Real input signal [s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.greaterEqualThreshold1.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,642)
DeclareAlias2("SC.switch_BOP.u1", "Connector of first Real input signal [W]", \
"SC.nominal_BOP.k", 1, 5, 6965, 0)
DeclareAlias2("SC.switch_BOP.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "SC.greaterEqualThreshold1.y", 1, 5, 6964, 65)
DeclareAlias2("SC.switch_BOP.u3", "Connector of second Real input signal [W]", \
"SC.demand_BOP.y[1]", 1, 5, 6944, 0)
DeclareAlias2("SC.switch_BOP.y", "Connector of Real output signal [W]", \
"SC.W_totalSetpoint_BOP", 1, 5, 6938, 0)
DeclareVariable("SC.nominal_BOP.k", "Constant output value [W]", 1, 0.0,0.0,0.0,\
0,513)
DeclareAlias2("SC.nominal_BOP.y", "Connector of Real output signal [W]", \
"SC.nominal_BOP.k", 1, 5, 6965, 0)
DeclareVariable("SC.demand_ES.nout", "Number of outputs [:#(type=Integer)]", 1, \
1.0,1E+100,0.0,0,517)
DeclareVariable("SC.demand_ES.y[1]", "Connector of Real output signals [W]", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareVariable("SC.demand_ES.tableOnFile", "= true, if table is defined on file or in function usertab [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SC.demand_ES.verboseRead", "= true, if info message that file is loading is to be printed [:#(type=Boolean)]",\
 712, true, 0.0,0.0,0.0,0,562)
DeclareVariable("SC.demand_ES.columns[1]", "Columns of table to be interpolated [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("SC.demand_ES.smoothness", "Smoothness of table interpolation [:#(type=Modelica.Blocks.Types.Smoothness)]",\
 1, 1.0,6.0,0.0,0,517)
DeclareVariable("SC.demand_ES.extrapolation", "Extrapolation of data outside the definition range [:#(type=Modelica.Blocks.Types.Extrapolation)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("SC.demand_ES.timeScale", "Time scale of first table column [s]",\
 3600.0, 1E-15,1E+100,0.0,0,513)
DeclareParameter("SC.demand_ES.offset[1]", "Offsets of output signals", 713, 0, \
0.0,0.0,0.0,0,560)
DeclareVariable("SC.demand_ES.startTime", "Output = offset for time < startTime [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_ES.shiftTime", "Shift time of first table column [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SC.demand_ES.timeEvents", "Time event handling of table interpolation [:#(type=Modelica.Blocks.Types.TimeEvents)]",\
 714, 1, 1.0,3.0,0.0,0,564)
DeclareVariable("SC.demand_ES.verboseExtrapolation", "= true, if warning messages are to be printed if time is outside the table definition range [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SC.demand_ES.t_min", "Minimum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_ES.t_max", "Maximum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_ES.t_minScaled", "Minimum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_ES.t_maxScaled", "Maximum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_ES.p_offset[1]", "Offsets of output signals", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("SC.demand_ES.tableID.id", "[:#(type=Integer)]", 0, 0.0,0.0,0.0,\
0,2565)
DeclareVariable("SC.demand_ES.nextTimeEvent", "Next time event instant [s]", 0, \
0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_ES.nextTimeEventScaled", "Next scaled time event instant [1]",\
 0, 0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_ES.timeScaled", "Scaled time [1]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("SC.switch_ES.u1", "Connector of first Real input signal [W]", \
"SC.nominal_ES.k", 1, 5, 6985, 0)
DeclareAlias2("SC.switch_ES.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "SC.greaterEqualThreshold1.y", 1, 5, 6964, 65)
DeclareAlias2("SC.switch_ES.u3", "Connector of second Real input signal [W]", \
"SC.demand_ES.y[1]", 1, 5, 6967, 0)
DeclareAlias2("SC.switch_ES.y", "Connector of Real output signal [W]", \
"SC.W_totalSetpoint_ES", 1, 5, 6940, 0)
DeclareVariable("SC.nominal_ES.k", "Constant output value [W]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("SC.nominal_ES.y", "Connector of Real output signal [W]", \
"SC.nominal_ES.k", 1, 5, 6985, 0)
DeclareVariable("SC.demand_SES.nout", "Number of outputs [:#(type=Integer)]", 1,\
 1.0,1E+100,0.0,0,517)
DeclareVariable("SC.demand_SES.y[1]", "Connector of Real output signals [W]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SC.demand_SES.tableOnFile", "= true, if table is defined on file or in function usertab [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SC.demand_SES.verboseRead", "= true, if info message that file is loading is to be printed [:#(type=Boolean)]",\
 715, true, 0.0,0.0,0.0,0,562)
DeclareVariable("SC.demand_SES.columns[1]", "Columns of table to be interpolated [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("SC.demand_SES.smoothness", "Smoothness of table interpolation [:#(type=Modelica.Blocks.Types.Smoothness)]",\
 1, 1.0,6.0,0.0,0,517)
DeclareVariable("SC.demand_SES.extrapolation", "Extrapolation of data outside the definition range [:#(type=Modelica.Blocks.Types.Extrapolation)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("SC.demand_SES.timeScale", "Time scale of first table column [s]",\
 3600.0, 1E-15,1E+100,0.0,0,513)
DeclareParameter("SC.demand_SES.offset[1]", "Offsets of output signals", 716, 0,\
 0.0,0.0,0.0,0,560)
DeclareVariable("SC.demand_SES.startTime", "Output = offset for time < startTime [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_SES.shiftTime", "Shift time of first table column [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SC.demand_SES.timeEvents", "Time event handling of table interpolation [:#(type=Modelica.Blocks.Types.TimeEvents)]",\
 717, 1, 1.0,3.0,0.0,0,564)
DeclareVariable("SC.demand_SES.verboseExtrapolation", "= true, if warning messages are to be printed if time is outside the table definition range [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SC.demand_SES.t_min", "Minimum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_SES.t_max", "Maximum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_SES.t_minScaled", "Minimum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_SES.t_maxScaled", "Maximum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_SES.p_offset[1]", "Offsets of output signals", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("SC.demand_SES.tableID.id", "[:#(type=Integer)]", 0, 0.0,0.0,0.0,\
0,2565)
DeclareVariable("SC.demand_SES.nextTimeEvent", "Next time event instant [s]", 0,\
 0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_SES.nextTimeEventScaled", "Next scaled time event instant [1]",\
 0, 0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_SES.timeScaled", "Scaled time [1]", 0.0, 0.0,0.0,0.0,\
0,2560)
DeclareAlias2("SC.switch_SES.u1", "Connector of first Real input signal [W]", \
"SC.nominal_SES.k", 1, 5, 7005, 0)
DeclareAlias2("SC.switch_SES.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "SC.greaterEqualThreshold1.y", 1, 5, 6964, 65)
DeclareAlias2("SC.switch_SES.u3", "Connector of second Real input signal [W]", \
"SC.demand_SES.y[1]", 1, 5, 6987, 0)
DeclareAlias2("SC.switch_SES.y", "Connector of Real output signal [W]", \
"SC.W_totalSetpoint_SES", 1, 5, 6941, 0)
DeclareVariable("SC.nominal_SES.k", "Constant output value [W]", 1, 0.0,0.0,0.0,\
0,513)
DeclareAlias2("SC.nominal_SES.y", "Connector of Real output signal [W]", \
"SC.nominal_SES.k", 1, 5, 7005, 0)
DeclareAlias2("SC.clock.y", "Connector of Real output signal [s]", \
"SC.greaterEqualThreshold1.u", 1, 5, 6963, 0)
DeclareParameter("SC.clock.offset", "Offset of output signal y [s]", 718, 0, \
0.0,0.0,0.0,0,560)
DeclareParameter("SC.clock.startTime", "Output y = offset for time < startTime [s]",\
 719, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("SC.demand_EG.nout", "Number of outputs [:#(type=Integer)]", 1, \
1.0,1E+100,0.0,0,517)
DeclareVariable("SC.demand_EG.y[1]", "Connector of Real output signals [W]", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareVariable("SC.demand_EG.tableOnFile", "= true, if table is defined on file or in function usertab [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SC.demand_EG.verboseRead", "= true, if info message that file is loading is to be printed [:#(type=Boolean)]",\
 720, true, 0.0,0.0,0.0,0,562)
DeclareVariable("SC.demand_EG.columns[1]", "Columns of table to be interpolated [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("SC.demand_EG.smoothness", "Smoothness of table interpolation [:#(type=Modelica.Blocks.Types.Smoothness)]",\
 1, 1.0,6.0,0.0,0,517)
DeclareVariable("SC.demand_EG.extrapolation", "Extrapolation of data outside the definition range [:#(type=Modelica.Blocks.Types.Extrapolation)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("SC.demand_EG.timeScale", "Time scale of first table column [s]",\
 3600.0, 1E-15,1E+100,0.0,0,513)
DeclareParameter("SC.demand_EG.offset[1]", "Offsets of output signals", 721, 0, \
0.0,0.0,0.0,0,560)
DeclareVariable("SC.demand_EG.startTime", "Output = offset for time < startTime [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_EG.shiftTime", "Shift time of first table column [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SC.demand_EG.timeEvents", "Time event handling of table interpolation [:#(type=Modelica.Blocks.Types.TimeEvents)]",\
 722, 1, 1.0,3.0,0.0,0,564)
DeclareVariable("SC.demand_EG.verboseExtrapolation", "= true, if warning messages are to be printed if time is outside the table definition range [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SC.demand_EG.t_min", "Minimum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_EG.t_max", "Maximum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_EG.t_minScaled", "Minimum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_EG.t_maxScaled", "Maximum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_EG.p_offset[1]", "Offsets of output signals", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("SC.demand_EG.tableID.id", "[:#(type=Integer)]", 0, 0.0,0.0,0.0,\
0,2565)
DeclareVariable("SC.demand_EG.nextTimeEvent", "Next time event instant [s]", 0, \
0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_EG.nextTimeEventScaled", "Next scaled time event instant [1]",\
 0, 0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_EG.timeScaled", "Scaled time [1]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("SC.switch_EG.u1", "Connector of first Real input signal [W]", \
"SC.nominal_EG.k", 1, 5, 7025, 0)
DeclareAlias2("SC.switch_EG.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "SC.greaterEqualThreshold1.y", 1, 5, 6964, 65)
DeclareAlias2("SC.switch_EG.u3", "Connector of second Real input signal [W]", \
"SC.demand_EG.y[1]", 1, 5, 7007, 0)
DeclareAlias2("SC.switch_EG.y", "Connector of Real output signal [W]", \
"SC.W_totalSetpoint_EG", 1, 5, 6942, 0)
DeclareVariable("SC.nominal_EG.k", "Constant output value [W]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("SC.nominal_EG.y", "Connector of Real output signal [W]", \
"SC.nominal_EG.k", 1, 5, 7025, 0)
DeclareVariable("SC.demand_IP.nout", "Number of outputs [:#(type=Integer)]", 1, \
1.0,1E+100,0.0,0,517)
DeclareVariable("SC.demand_IP.y[1]", "Connector of Real output signals [W]", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareVariable("SC.demand_IP.tableOnFile", "= true, if table is defined on file or in function usertab [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SC.demand_IP.verboseRead", "= true, if info message that file is loading is to be printed [:#(type=Boolean)]",\
 723, true, 0.0,0.0,0.0,0,562)
DeclareVariable("SC.demand_IP.columns[1]", "Columns of table to be interpolated [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,517)
DeclareVariable("SC.demand_IP.smoothness", "Smoothness of table interpolation [:#(type=Modelica.Blocks.Types.Smoothness)]",\
 1, 1.0,6.0,0.0,0,517)
DeclareVariable("SC.demand_IP.extrapolation", "Extrapolation of data outside the definition range [:#(type=Modelica.Blocks.Types.Extrapolation)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("SC.demand_IP.timeScale", "Time scale of first table column [s]",\
 3600.0, 1E-15,1E+100,0.0,0,513)
DeclareParameter("SC.demand_IP.offset[1]", "Offsets of output signals", 724, 0, \
0.0,0.0,0.0,0,560)
DeclareVariable("SC.demand_IP.startTime", "Output = offset for time < startTime [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_IP.shiftTime", "Shift time of first table column [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SC.demand_IP.timeEvents", "Time event handling of table interpolation [:#(type=Modelica.Blocks.Types.TimeEvents)]",\
 725, 1, 1.0,3.0,0.0,0,564)
DeclareVariable("SC.demand_IP.verboseExtrapolation", "= true, if warning messages are to be printed if time is outside the table definition range [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SC.demand_IP.t_min", "Minimum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_IP.t_max", "Maximum abscissa value defined in table [s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_IP.t_minScaled", "Minimum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_IP.t_maxScaled", "Maximum (scaled) abscissa value defined in table [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SC.demand_IP.p_offset[1]", "Offsets of output signals", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("SC.demand_IP.tableID.id", "[:#(type=Integer)]", 0, 0.0,0.0,0.0,\
0,2565)
DeclareVariable("SC.demand_IP.nextTimeEvent", "Next time event instant [s]", 0, \
0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_IP.nextTimeEventScaled", "Next scaled time event instant [1]",\
 0, 0.0,0.0,0.0,0,2704)
DeclareVariable("SC.demand_IP.timeScaled", "Scaled time [1]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("SC.switch_IP.u1", "Connector of first Real input signal [W]", \
"SC.nominal_IP.k", 1, 5, 7045, 0)
DeclareAlias2("SC.switch_IP.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "SC.greaterEqualThreshold1.y", 1, 5, 6964, 65)
DeclareAlias2("SC.switch_IP.u3", "Connector of second Real input signal [W]", \
"SC.demand_IP.y[1]", 1, 5, 7027, 0)
DeclareAlias2("SC.switch_IP.y", "Connector of Real output signal [W]", \
"SC.W_totalSetpoint_IP", 1, 5, 6939, 0)
DeclareVariable("SC.nominal_IP.k", "Constant output value [W]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("SC.nominal_IP.y", "Connector of Real output signal [W]", \
"SC.nominal_IP.k", 1, 5, 7045, 0)
DeclareAlias2("SES.CS.sensorBus.W_gen", "Generated electricity from the GT plant [W|MW]",\
 "SES.sensorBus.W_gen", 1, 5, 7061, 4)
DeclareAlias2("SES.CS.sensorBus.m_flow_fuel", "Fuel (natural gas) consumption in the GT plant [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 4)
DeclareAlias2("SES.CS.sensorBus.m_flow_CO2", "CO2 emission rate from the GT plant [kg/s]",\
 "SES.sensorBus.m_flow_CO2", 1, 5, 7062, 4)
DeclareVariable("SES.CS.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SES.CS.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareParameter("SES.CS.delayStart", "Time to start tracking power profiles", 726,\
 0, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.CS.capacityScaler", "Scaler that sizes the capacity of the overall system",\
 727, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.CS.W_SES_nom", "Nominal electrical power generation in the SES [W|MW]",\
 728, 35000000.0, 0.0,0.0,0.0,0,560)
DeclareAlias2("SES.CS.W_totalSetpoint", "Total setpoint power [W]", \
"SC.W_totalSetpoint_SES", 1, 5, 6941, 0)
DeclareVariable("SES.CS.feedback_W_gen.u1", "Commanded input [W]", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareAlias2("SES.CS.feedback_W_gen.u2", "Feedback input [W]", "SES.sensorBus.W_gen", 1,\
 5, 7061, 0)
DeclareVariable("SES.CS.feedback_W_gen.y", "[W]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.CS.FBctrl_powerGeneration.k", "Gain [1]", 0.0, 0.0,0.0,0.0,\
0,513)
DeclareParameter("SES.CS.FBctrl_powerGeneration.T", "Time Constant (T>0 required) [s]",\
 729, 1.5, 1E-60,1E+100,0.0,0,560)
DeclareVariable("SES.CS.FBctrl_powerGeneration.initType", "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareVariable("SES.CS.FBctrl_powerGeneration.x_start", "Initial or guess value of state [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SES.CS.FBctrl_powerGeneration.y_start", "Initial value of output [1]",\
 730, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("SES.CS.FBctrl_powerGeneration.u", "Connector of Real input signal [1]",\
 "SES.CS.feedback_W_gen.y", 1, 5, 7049, 0)
DeclareAlias2("SES.CS.FBctrl_powerGeneration.y", "Connector of Real output signal [1]",\
 "SES.limiter_VCE.u", 1, 5, 7842, 0)
DeclareState("SES.CS.FBctrl_powerGeneration.x", "State of block [1]", 67, 0.0, \
0.0,0.0,0.0,0,544)
DeclareDerivative("SES.CS.FBctrl_powerGeneration.der(x)", "der(State of block) [s-1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.CS.clock.y", "Connector of Real output signal [s]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareParameter("SES.CS.clock.offset", "Offset of output signal y [s]", 731, 0,\
 0.0,0.0,0.0,0,560)
DeclareParameter("SES.CS.clock.startTime", "Output y = offset for time < startTime [s]",\
 732, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.CS.lessThreshold.threshold", "Comparison with respect to threshold",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.CS.lessThreshold.u", "Connector of Real input signal [s]", \
"SES.CS.clock.y", 1, 5, 7053, 0)
DeclareVariable("SES.CS.lessThreshold.y", "Connector of Boolean output signal [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,642)
DeclareVariable("SES.CS.W_SES_nominal.k", "Constant output value [W]", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("SES.CS.W_SES_nominal.y", "Connector of Real output signal [W]", \
"SES.CS.W_SES_nominal.k", 1, 5, 7056, 0)
DeclareAlias2("SES.CS.switch.u1", "Connector of first Real input signal [W]", \
"SES.CS.W_SES_nominal.k", 1, 5, 7056, 0)
DeclareAlias2("SES.CS.switch.u2", "Connector of Boolean input signal [:#(type=Boolean)]",\
 "SES.CS.lessThreshold.y", 1, 5, 7055, 65)
DeclareVariable("SES.CS.switch.u3", "Connector of second Real input signal [W]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.CS.switch.y", "Connector of Real output signal [W]", \
"SES.CS.feedback_W_gen.u1", 1, 5, 7048, 0)
DeclareVariable("SES.CS.scaler.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.CS.scaler.u", "Input signal connector [W]", "SC.W_totalSetpoint_SES", 1,\
 5, 6941, 0)
DeclareAlias2("SES.CS.scaler.y", "Output signal connector [W]", "SES.CS.switch.u3", 1,\
 5, 7057, 0)
DeclareAlias2("SES.CS.W_totalSetpoint_SES.y", "Value of Real output [W]", \
"SC.W_totalSetpoint_SES", 1, 5, 6941, 0)
DeclareAlias2("SES.ED.sensorBus.W_gen", "Generated electricity from the GT plant [W|MW]",\
 "SES.sensorBus.W_gen", 1, 5, 7061, 4)
DeclareAlias2("SES.ED.sensorBus.m_flow_fuel", "Fuel (natural gas) consumption in the GT plant [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 4)
DeclareAlias2("SES.ED.sensorBus.m_flow_CO2", "CO2 emission rate from the GT plant [kg/s]",\
 "SES.sensorBus.m_flow_CO2", 1, 5, 7062, 4)
DeclareVariable("SES.ED.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SES.ED.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SES.sensorBus.W_gen", "Generated electricity from the GT plant [W|MW]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareAlias2("SES.sensorBus.m_flow_fuel", "Fuel (natural gas) consumption in the GT plant [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 4)
DeclareVariable("SES.sensorBus.m_flow_CO2", "CO2 emission rate from the GT plant [kg/s]",\
 0.0, 0.0,0.0,0.0,0,520)
DeclareVariable("SES.sensorBus.Q_balance", "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SES.sensorBus.W_balance", "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SES.Q_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,\
0,513)
DeclareVariable("SES.W_balance.y", "Value of Real output [W]", 0.0, 0.0,0.0,0.0,\
0,513)
DeclareAlias2("SES.portElec_b.W", "Active power [W]", "SY.sensorBus.W_subsystems[2]", -1,\
 5, 6911, 132)
DeclareAlias2("SES.portElec_b.f", "Frequency [Hz]", "BOP.portElec_b.f", 1, 5, 6393,\
 4)
DeclareParameter("SES.system.p_ambient", "Default ambient pressure [Pa|bar]", 733,\
 101325, 0.0,1E+100,100000.0,0,560)
DeclareParameter("SES.system.T_ambient", "Default ambient temperature [K|degC]",\
 734, 288.15, 0.0,1E+100,300.0,0,560)
DeclareParameter("SES.system.g", "Constant gravity acceleration [m/s2]", 735, \
9.80665, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.system.allowFlowReversal", "= false to restrict to design flow direction (port_a -> port_b) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.system.energyDynamics", "Default formulation of energy balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("SES.system.massDynamics", "Default formulation of mass balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("SES.system.substanceDynamics", "Default formulation of substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("SES.system.traceDynamics", "Default formulation of trace substance balances [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("SES.system.momentumDynamics", "Default formulation of momentum balances, if options available [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("SES.system.m_flow_start", "Default start value for mass flow rates [kg/s]",\
 736, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.system.p_start", "Default start value for pressures [Pa|bar]",\
 0.0, 0.0,1E+100,100000.0,0,513)
DeclareVariable("SES.system.T_start", "Default start value for temperatures [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareVariable("SES.system.use_eps_Re", "= true to determine turbulent region automatically using Reynolds number [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.system.m_flow_nominal", "Default nominal mass flow rate [kg/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SES.system.eps_m_flow", "Regularization of zero flow for |m_flow| < eps_m_flow*m_flow_nominal [1]",\
 737, 0.0001, 0.0,1E+100,0.0,0,560)
DeclareParameter("SES.system.dp_small", "Default small pressure drop for regularization of laminar and zero flow [Pa|bar]",\
 738, 1, 0.0,1E+100,100000.0,0,560)
DeclareParameter("SES.system.m_flow_small", "Default small mass flow rate for regularization of laminar and zero flow [kg/s]",\
 739, 0.01, 0.0,1E+100,0.0,0,560)
DeclareVariable("SES.capacity_nom", "Nominal electrical power generation [W|MW]",\
 35000000.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.capacity", "System capacity [W|MW]", 35000000.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("SES.capacityScaler", "Scaler that sizes the capacity of the GTPP [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.KG", "Gain for speed governor [1]", 30, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.TG", "Speed governor time constant [s]", 1.5, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.T_rotorAccel", "Rotor accelaration control time constant [s]",\
 0.01, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.rotorAccel_max_pu", "Upper limit on the rotor acceleration integrator [1]",\
 1.2, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.rotorAccel_min_pu", "Lower limit on the rotor acceleration integrator [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.TV", "Valve positoner time constant [s]", 0.04, 0.0,0.0,0.0,\
0,513)
DeclareVariable("SES.TF", "Fuel system time constant [s]", 0.26, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.wf_pu_max", "Upper limit on wf_pu [1]", 1.5, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.wf_pu_min", "Lower limit on wf_pu [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.TW", "Air flow control time constant [s]", 0.0, 0.0,0.0,0.0,\
0,513)
DeclareVariable("SES.IGVangleRamp_max_pu", "Maximum change allowed in IGV angle [1]",\
 0.016, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.IGVangleRamp_min_pu", "Minimum change allowed in IGV angle [1]",\
 -0.016, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.IGVangle_max_pu", "Upper limit on IGV angle [1]", 1, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.IGVangle_min_pu", "Lower limit on IGV angle [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.T_Tf", "Tf control time constant [s]", 60, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.Tr_max_pu", "Rated Te upper limit [1]", 1.01, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.Tr_min_pu", "Rated Te lower limit [1]", 0.968, 0.0,0.0,0.0,\
0,513)
DeclareVariable("SES.T_Te", "Te controller time constant [s]", 3.3, 0.0,0.0,0.0,\
0,513)
DeclareVariable("SES.TI_Te", "Integration rate for Te control [s]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.Te_max_pu", "Upper limit on Te [1]", 1.1, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.Te_min_pu", "Lower limit on Te [1]", 0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (air_in -> exhaust_out) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareParameter("SES.GTunit.PR0", "Nominal compression ratio [1]", 740, 13, \
0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.eta_mech", "Mechanical efficiency [1]", 741, 0.98, \
0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.Nrpm0", "Rated rotational speed of the shaft in rpm [rev/min]",\
 742, 3600, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.GTunit.N0", "Rated rotational speed of the shaft in rad/s [rad/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SES.GTunit.J", "Rotor inertia [kg.m2]", 743, 2648.7999999999997,\
 0.0,0.0,0.0,0,560)
DeclareVariable("SES.GTunit.explicitIsentropicEnthalpy_comp", "IsentropicEnthalpy function used [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SES.GTunit.eta0_comp", "Isentropic efficiency at nominal operating conditions",\
 744, 0.86, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.w0_comp", "Nominal gas flow rate [kg/s]", 745, \
108.408, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.V", "Inner volume [m3]", 746, 0.125, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.LHV", "Lower heating value of fuel [J/kg]", 747, \
43094000.0, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.eta0_comb", "Constant combustion efficiency [1]", 748,\
 0.99, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.GTunit.w0_comb", "Nominal fuel flow rate [kg/s]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("SES.GTunit.w_noLoad", "Fuel flow rate at W=0 (no-load condition) [kg/s]",\
 749, 0.240858, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.w_min", "Minimum fuel flow rate to maintain the flame [kg/s]",\
 750, 0.139247100000001, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.Tf0", "Rated firing temperataure [K|degC]", 751, \
1340.38, 0.0,1E+100,300.0,0,560)
DeclareVariable("SES.GTunit.explicitIsentropicEnthalpy_turb", "IsentropicEnthalpy function used [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SES.GTunit.eta0_turb", "Isentropic efficiency at nominal operating conditions [1]",\
 752, 0.89, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.w0_turb", "Nominal gas flow rate [kg/s]", 753, \
110.681076, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.Te0", "Rated exhuast gas temperature [K|degC]", 754,\
 822.1503132, 0.0,1E+100,300.0,0,560)
DeclareVariable("SES.GTunit.pstart_comp_in", "Inlet start pressure [Pa|bar]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.Tstart_comp_in", "Inlet start temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareParameter("SES.GTunit.Tstart_comp_out", "Outlet start temperature [K|degC]",\
 755, 640.036, 0.0,1E+100,300.0,0,560)
DeclareParameter("SES.GTunit.pstart_turb_out", "Outlet start pressure [Pa|bar]",\
 756, 101325.0, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.GTunit.Tstart_turb_out", "Outlet start temperature [K|degC]",\
 757, 787.62, 0.0,1E+100,300.0,0,560)
DeclareParameter("SES.GTunit.Tstart_comb", "Temperature start value [K|degC]", 758,\
 1340.378, 0.0,1E+100,300.0,0,560)
DeclareVariable("SES.GTunit.phi_start", "Shaft rotation angle start value [rad|deg]",\
 0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.GTunit.W", "Net power output from a gas turbine unit [W|MW]",\
 "SY.sensorBus.W_subsystems[2]", 1, 5, 6911, 0)
DeclareAlias2("SES.GTunit.phi", "Shaft rotation angle [rad|deg]", \
"SES.speed.phi", 1, 1, 77, 0)
DeclareAlias2("SES.GTunit.der(phi)", "der(Shaft rotation angle) [rad/s]", \
"SES.constN.k", 1, 5, 7837, 0)
DeclareVariable("SES.GTunit.tau", "Net torque acting on the turbine [N.m]", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.GTunit.omega", "Shaft angular velocity [rad/s]", \
"SES.constN.k", 1, 5, 7837, 0)
DeclareVariable("SES.GTunit.combChamber.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.combChamber.V", "Inner volume [m3]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareParameter("SES.GTunit.combChamber.S", "Inner surface [m2]", 759, 0, \
0.0,0.0,0.0,0,560)
DeclareVariable("SES.GTunit.combChamber.gamma", "Heat Transfer Coefficient [W/(m2.K)]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.combChamber.Cm", "Metal Heat Capacity [J/K]", 0, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.combChamber.Tm_start", "Metal wall start temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareVariable("SES.GTunit.combChamber.LHV", "Lower heating value of fuel [J/kg]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.combChamber.pstart", "Pressure start value [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.combChamber.Tstart", "Temperature start value [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareParameter("SES.GTunit.combChamber.Xstart[1]", "Start flue gas composition [1]",\
 760, 0.23, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.combChamber.Xstart[2]", "Start flue gas composition [1]",\
 761, 0.02, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.combChamber.Xstart[3]", "Start flue gas composition [1]",\
 762, 0.01, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.combChamber.Xstart[4]", "Start flue gas composition [1]",\
 763, 0.04, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.combChamber.Xstart[5]", "Start flue gas composition [1]",\
 764, 0.7, 0.0,1.0,0.0,0,560)
DeclareAlias2("SES.GTunit.combChamber.state_air.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareVariable("SES.GTunit.combChamber.state_air.T", "Temperature of medium [K|degC]",\
 500, 200.0,6000.0,500.0,0,512)
DeclareAlias2("SES.GTunit.combChamber.state_air.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.GTunit.combChamber.state_air.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.GTunit.combChamber.state_air.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.GTunit.combChamber.state_air.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareState("SES.GTunit.combChamber.fluegas.p", "Absolute pressure of medium [Pa|bar]",\
 68, 0.0, 0.0,100000000.0,100000.0,0,544)
DeclareDerivative("SES.GTunit.combChamber.fluegas.der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.GTunit.combChamber.fluegas.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.Xi[4]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.Xi[5]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.der(Xi[1])", "der(Structurally independent mass fractions) [s-1]",\
 "SES.GTunit.turbine.gas_in.der(X[1])", 1, 6, 70, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.der(Xi[2])", "der(Structurally independent mass fractions) [s-1]",\
 "SES.GTunit.turbine.gas_in.der(X[2])", 1, 6, 71, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.der(Xi[3])", "der(Structurally independent mass fractions) [s-1]",\
 "SES.GTunit.turbine.gas_in.der(X[3])", 1, 6, 72, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.der(Xi[4])", "der(Structurally independent mass fractions) [s-1]",\
 "SES.GTunit.turbine.gas_in.der(X[4])", 1, 6, 73, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.der(Xi[5])", "der(Structurally independent mass fractions) [s-1]",\
 "SES.GTunit.turbine.gas_in.der(X[5])", 1, 6, 74, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.h", "Specific enthalpy of medium [J/kg]",\
 "SES.GTunit.combChamber.ho", 1, 5, 7380, 0)
DeclareVariable("SES.GTunit.combChamber.fluegas.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.der(d)", "der(Density of medium) [Pa.m-2.s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("SES.GTunit.combChamber.fluegas.T", "Temperature of medium [K|degC]",\
 69, 500.0, 200.0,6000.0,500.0,0,544)
DeclareDerivative("SES.GTunit.combChamber.fluegas.der(T)", "der(Temperature of medium) [K/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.der(R_s)", "der(Gas constant (of mixture if applicable)) [W/(kg.K)]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("SES.GTunit.combChamber.fluegas.state.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.state.T", "Temperature of medium [K|degC]",\
 "SES.GTunit.combChamber.fluegas.T", 1, 1, 69, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.state.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 0)
DeclareAlias2("SES.GTunit.combChamber.fluegas.state.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 0)
DeclareVariable("SES.GTunit.combChamber.fluegas.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.combChamber.fluegas.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.combChamber.fluegas.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.fluegas.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM",\
 "Molar mass [kg/mol]", 0.0319988, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.Hf",\
 "Enthalpy of formation at 298.15K [J/kg]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.H0",\
 "H0(298.15K) - H0(0K) [J/kg]", 271263.4223783392, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.Tlimit",\
 "Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.alow[1]",\
 "Low temperature coefficients a", -34255.6342, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.alow[2]",\
 "Low temperature coefficients a", 484.700097, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.alow[3]",\
 "Low temperature coefficients a", 1.119010961, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.alow[4]",\
 "Low temperature coefficients a", 0.00429388924, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.alow[5]",\
 "Low temperature coefficients a", -6.83630052E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.alow[6]",\
 "Low temperature coefficients a", -2.0233727E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.alow[7]",\
 "Low temperature coefficients a", 1.039040018E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.blow[1]",\
 "Low temperature constants b", -3391.45487, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.blow[2]",\
 "Low temperature constants b", 18.4969947, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.ahigh[1]",\
 "High temperature coefficients a", -1037939.022, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.ahigh[2]",\
 "High temperature coefficients a", 2344.830282, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.ahigh[3]",\
 "High temperature coefficients a", 1.819732036, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.ahigh[4]",\
 "High temperature coefficients a", 0.001267847582, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.ahigh[5]",\
 "High temperature coefficients a", -2.188067988E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.ahigh[6]",\
 "High temperature coefficients a", 2.053719572E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.ahigh[7]",\
 "High temperature coefficients a", -8.193467050000001E-16, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.bhigh[1]",\
 "High temperature constants b", -16890.10929, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.bhigh[2]",\
 "High temperature constants b", 17.38716506, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.O2.R_s",\
 "Gas constant [J/(kg.K)]", 259.8369938872708, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.MM",\
 "Molar mass [kg/mol]", 0.039948, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.Hf",\
 "Enthalpy of formation at 298.15K [J/kg]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.H0",\
 "H0(298.15K) - H0(0K) [J/kg]", 155137.3785921698, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.Tlimit",\
 "Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.alow[1]",\
 "Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.alow[2]",\
 "Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.alow[3]",\
 "Low temperature coefficients a", 2.5, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.alow[4]",\
 "Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.alow[5]",\
 "Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.alow[6]",\
 "Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.alow[7]",\
 "Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.blow[1]",\
 "Low temperature constants b", -745.375, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.blow[2]",\
 "Low temperature constants b", 4.37967491, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.ahigh[1]",\
 "High temperature coefficients a", 20.10538475, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.ahigh[2]",\
 "High temperature coefficients a", -0.05992661069999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.ahigh[3]",\
 "High temperature coefficients a", 2.500069401, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.ahigh[4]",\
 "High temperature coefficients a", -3.99214116E-08, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.ahigh[5]",\
 "High temperature coefficients a", 1.20527214E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.ahigh[6]",\
 "High temperature coefficients a", -1.819015576E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.ahigh[7]",\
 "High temperature coefficients a", 1.078576636E-19, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.bhigh[1]",\
 "High temperature constants b", -744.993961, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.bhigh[2]",\
 "High temperature constants b", 4.37918011, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Ar.R_s",\
 "Gas constant [J/(kg.K)]", 208.1323720837088, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM",\
 "Molar mass [kg/mol]", 0.01801528, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Hf",\
 "Enthalpy of formation at 298.15K [J/kg]", -13423382.81725291, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.H0",\
 "H0(298.15K) - H0(0K) [J/kg]", 549760.6476280135, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Tlimit",\
 "Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow[1]",\
 "Low temperature coefficients a", -39479.6083, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow[2]",\
 "Low temperature coefficients a", 575.573102, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow[3]",\
 "Low temperature coefficients a", 0.931782653, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow[4]",\
 "Low temperature coefficients a", 0.00722271286, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow[5]",\
 "Low temperature coefficients a", -7.34255737E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow[6]",\
 "Low temperature coefficients a", 4.95504349E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow[7]",\
 "Low temperature coefficients a", -1.336933246E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.blow[1]",\
 "Low temperature constants b", -33039.7431, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.blow[2]",\
 "Low temperature constants b", 17.24205775, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh[1]",\
 "High temperature coefficients a", 1034972.096, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh[2]",\
 "High temperature coefficients a", -2412.698562, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh[3]",\
 "High temperature coefficients a", 4.64611078, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh[4]",\
 "High temperature coefficients a", 0.002291998307, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh[5]",\
 "High temperature coefficients a", -6.836830479999999E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh[6]",\
 "High temperature coefficients a", 9.426468930000001E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh[7]",\
 "High temperature coefficients a", -4.82238053E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.bhigh[1]",\
 "High temperature constants b", -13842.86509, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.bhigh[2]",\
 "High temperature constants b", -7.97814851, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R_s",\
 "Gas constant [J/(kg.K)]", 461.5233290850878, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM",\
 "Molar mass [kg/mol]", 0.0440095, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.Hf",\
 "Enthalpy of formation at 298.15K [J/kg]", -8941478.544405185, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.H0",\
 "H0(298.15K) - H0(0K) [J/kg]", 212805.6215135368, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.Tlimit",\
 "Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.alow[1]",\
 "Low temperature coefficients a", 49436.5054, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.alow[2]",\
 "Low temperature coefficients a", -626.411601, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.alow[3]",\
 "Low temperature coefficients a", 5.30172524, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.alow[4]",\
 "Low temperature coefficients a", 0.002503813816, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.alow[5]",\
 "Low temperature coefficients a", -2.127308728E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.alow[6]",\
 "Low temperature coefficients a", -7.68998878E-10, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.alow[7]",\
 "Low temperature coefficients a", 2.849677801E-13, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.blow[1]",\
 "Low temperature constants b", -45281.9846, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.blow[2]",\
 "Low temperature constants b", -7.04827944, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.ahigh[1]",\
 "High temperature coefficients a", 117696.2419, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.ahigh[2]",\
 "High temperature coefficients a", -1788.791477, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.ahigh[3]",\
 "High temperature coefficients a", 8.29152319, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.ahigh[4]",\
 "High temperature coefficients a", -9.22315678E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.ahigh[5]",\
 "High temperature coefficients a", 4.86367688E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.ahigh[6]",\
 "High temperature coefficients a", -1.891053312E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.ahigh[7]",\
 "High temperature coefficients a", 6.330036589999999E-16, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.bhigh[1]",\
 "High temperature constants b", -39083.5059, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.bhigh[2]",\
 "High temperature constants b", -26.52669281, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CO2.R_s",\
 "Gas constant [J/(kg.K)]", 188.9244822140674, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM",\
 "Molar mass [kg/mol]", 0.0280134, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.Hf",\
 "Enthalpy of formation at 298.15K [J/kg]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.H0",\
 "H0(298.15K) - H0(0K) [J/kg]", 309498.4543111511, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.Tlimit",\
 "Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.alow[1]",\
 "Low temperature coefficients a", 22103.71497, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.alow[2]",\
 "Low temperature coefficients a", -381.846182, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.alow[3]",\
 "Low temperature coefficients a", 6.08273836, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.alow[4]",\
 "Low temperature coefficients a", -0.00853091441, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.alow[5]",\
 "Low temperature coefficients a", 1.384646189E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.alow[6]",\
 "Low temperature coefficients a", -9.62579362E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.alow[7]",\
 "Low temperature coefficients a", 2.519705809E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.blow[1]",\
 "Low temperature constants b", 710.846086, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.blow[2]",\
 "Low temperature constants b", -10.76003744, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.ahigh[1]",\
 "High temperature coefficients a", 587712.406, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.ahigh[2]",\
 "High temperature coefficients a", -2239.249073, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.ahigh[3]",\
 "High temperature coefficients a", 6.06694922, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.ahigh[4]",\
 "High temperature coefficients a", -0.00061396855, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.ahigh[5]",\
 "High temperature coefficients a", 1.491806679E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.ahigh[6]",\
 "High temperature coefficients a", -1.923105485E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.ahigh[7]",\
 "High temperature coefficients a", 1.061954386E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.bhigh[1]",\
 "High temperature constants b", 12832.10415, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.bhigh[2]",\
 "High temperature constants b", -15.86640027, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.N2.R_s",\
 "Gas constant [J/(kg.K)]", 296.8033869505308, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].MM", "Molar mass [kg/mol]",\
 0.0319988, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 271263.4223783392, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].alow[1]", \
"Low temperature coefficients a", -34255.6342, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].alow[2]", \
"Low temperature coefficients a", 484.700097, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].alow[3]", \
"Low temperature coefficients a", 1.119010961, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].alow[4]", \
"Low temperature coefficients a", 0.00429388924, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].alow[5]", \
"Low temperature coefficients a", -6.83630052E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].alow[6]", \
"Low temperature coefficients a", -2.0233727E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].alow[7]", \
"Low temperature coefficients a", 1.039040018E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].blow[1]", \
"Low temperature constants b", -3391.45487, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].blow[2]", \
"Low temperature constants b", 18.4969947, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].ahigh[1]", \
"High temperature coefficients a", -1037939.022, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].ahigh[2]", \
"High temperature coefficients a", 2344.830282, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].ahigh[3]", \
"High temperature coefficients a", 1.819732036, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].ahigh[4]", \
"High temperature coefficients a", 0.001267847582, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].ahigh[5]", \
"High temperature coefficients a", -2.188067988E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].ahigh[6]", \
"High temperature coefficients a", 2.053719572E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].ahigh[7]", \
"High temperature coefficients a", -8.193467050000001E-16, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].bhigh[1]", \
"High temperature constants b", -16890.10929, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].bhigh[2]", \
"High temperature constants b", 17.38716506, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[1].R_s", "Gas constant [J/(kg.K)]",\
 259.8369938872708, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].MM", "Molar mass [kg/mol]",\
 0.039948, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 155137.3785921698, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].alow[1]", \
"Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].alow[2]", \
"Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].alow[3]", \
"Low temperature coefficients a", 2.5, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].alow[4]", \
"Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].alow[5]", \
"Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].alow[6]", \
"Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].alow[7]", \
"Low temperature coefficients a", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].blow[1]", \
"Low temperature constants b", -745.375, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].blow[2]", \
"Low temperature constants b", 4.37967491, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].ahigh[1]", \
"High temperature coefficients a", 20.10538475, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].ahigh[2]", \
"High temperature coefficients a", -0.05992661069999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].ahigh[3]", \
"High temperature coefficients a", 2.500069401, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].ahigh[4]", \
"High temperature coefficients a", -3.99214116E-08, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].ahigh[5]", \
"High temperature coefficients a", 1.20527214E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].ahigh[6]", \
"High temperature coefficients a", -1.819015576E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].ahigh[7]", \
"High temperature coefficients a", 1.078576636E-19, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].bhigh[1]", \
"High temperature constants b", -744.993961, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].bhigh[2]", \
"High temperature constants b", 4.37918011, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[2].R_s", "Gas constant [J/(kg.K)]",\
 208.1323720837088, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].MM", "Molar mass [kg/mol]",\
 0.01801528, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 -13423382.81725291, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 549760.6476280135, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].alow[1]", \
"Low temperature coefficients a", -39479.6083, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].alow[2]", \
"Low temperature coefficients a", 575.573102, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].alow[3]", \
"Low temperature coefficients a", 0.931782653, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].alow[4]", \
"Low temperature coefficients a", 0.00722271286, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].alow[5]", \
"Low temperature coefficients a", -7.34255737E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].alow[6]", \
"Low temperature coefficients a", 4.95504349E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].alow[7]", \
"Low temperature coefficients a", -1.336933246E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].blow[1]", \
"Low temperature constants b", -33039.7431, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].blow[2]", \
"Low temperature constants b", 17.24205775, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].ahigh[1]", \
"High temperature coefficients a", 1034972.096, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].ahigh[2]", \
"High temperature coefficients a", -2412.698562, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].ahigh[3]", \
"High temperature coefficients a", 4.64611078, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].ahigh[4]", \
"High temperature coefficients a", 0.002291998307, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].ahigh[5]", \
"High temperature coefficients a", -6.836830479999999E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].ahigh[6]", \
"High temperature coefficients a", 9.426468930000001E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].ahigh[7]", \
"High temperature coefficients a", -4.82238053E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].bhigh[1]", \
"High temperature constants b", -13842.86509, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].bhigh[2]", \
"High temperature constants b", -7.97814851, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[3].R_s", "Gas constant [J/(kg.K)]",\
 461.5233290850878, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].MM", "Molar mass [kg/mol]",\
 0.0440095, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 -8941478.544405185, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 212805.6215135368, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].alow[1]", \
"Low temperature coefficients a", 49436.5054, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].alow[2]", \
"Low temperature coefficients a", -626.411601, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].alow[3]", \
"Low temperature coefficients a", 5.30172524, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].alow[4]", \
"Low temperature coefficients a", 0.002503813816, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].alow[5]", \
"Low temperature coefficients a", -2.127308728E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].alow[6]", \
"Low temperature coefficients a", -7.68998878E-10, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].alow[7]", \
"Low temperature coefficients a", 2.849677801E-13, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].blow[1]", \
"Low temperature constants b", -45281.9846, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].blow[2]", \
"Low temperature constants b", -7.04827944, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].ahigh[1]", \
"High temperature coefficients a", 117696.2419, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].ahigh[2]", \
"High temperature coefficients a", -1788.791477, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].ahigh[3]", \
"High temperature coefficients a", 8.29152319, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].ahigh[4]", \
"High temperature coefficients a", -9.22315678E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].ahigh[5]", \
"High temperature coefficients a", 4.86367688E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].ahigh[6]", \
"High temperature coefficients a", -1.891053312E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].ahigh[7]", \
"High temperature coefficients a", 6.330036589999999E-16, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].bhigh[1]", \
"High temperature constants b", -39083.5059, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].bhigh[2]", \
"High temperature constants b", -26.52669281, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[4].R_s", "Gas constant [J/(kg.K)]",\
 188.9244822140674, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].MM", "Molar mass [kg/mol]",\
 0.0280134, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 309498.4543111511, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].alow[1]", \
"Low temperature coefficients a", 22103.71497, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].alow[2]", \
"Low temperature coefficients a", -381.846182, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].alow[3]", \
"Low temperature coefficients a", 6.08273836, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].alow[4]", \
"Low temperature coefficients a", -0.00853091441, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].alow[5]", \
"Low temperature coefficients a", 1.384646189E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].alow[6]", \
"Low temperature coefficients a", -9.62579362E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].alow[7]", \
"Low temperature coefficients a", 2.519705809E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].blow[1]", \
"Low temperature constants b", 710.846086, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].blow[2]", \
"Low temperature constants b", -10.76003744, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].ahigh[1]", \
"High temperature coefficients a", 587712.406, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].ahigh[2]", \
"High temperature coefficients a", -2239.249073, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].ahigh[3]", \
"High temperature coefficients a", 6.06694922, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].ahigh[4]", \
"High temperature coefficients a", -0.00061396855, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].ahigh[5]", \
"High temperature coefficients a", 1.491806679E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].ahigh[6]", \
"High temperature coefficients a", -1.923105485E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].ahigh[7]", \
"High temperature coefficients a", 1.061954386E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].bhigh[1]", \
"High temperature constants b", 12832.10415, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].bhigh[2]", \
"High temperature constants b", -15.86640027, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.FlueGas.data[5].R_s", "Gas constant [J/(kg.K)]",\
 296.8033869505308, 0.0,0.0,0.0,0,2561)
DeclareAlias2("SES.GTunit.combChamber.wf", "Fuel flow rate [kg/s]", \
"SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 0)
DeclareVariable("SES.GTunit.combChamber.M", "Gas total mass [kg]", 0.0, 0.0,\
1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(M)", "der(Gas total mass) [kg/s]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.MX[1]", "Partial flue gas masses [kg]", \
0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.MX[2]", "Partial flue gas masses [kg]", \
0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.MX[3]", "Partial flue gas masses [kg]", \
0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.MX[4]", "Partial flue gas masses [kg]", \
0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.MX[5]", "Partial flue gas masses [kg]", \
0.0, 0.0,1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(MX[1])", "der(Partial flue gas masses) [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(MX[2])", "der(Partial flue gas masses) [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(MX[3])", "der(Partial flue gas masses) [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(MX[4])", "der(Partial flue gas masses) [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(MX[5])", "der(Partial flue gas masses) [kg/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.E", "Gas total energy [J]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(E)", "der(Gas total energy) [W]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.GTunit.combChamber.Tm", "Wall temperature [K|degC]", \
"SES.GTunit.combChamber.fluegas.T", 1, 1, 69, 0)
DeclareAlias2("SES.GTunit.combChamber.Td", "Air inlet temperature [K|degC]", \
"SES.GTunit.combChamber.state_air.T", 1, 5, 7118, 0)
DeclareAlias2("SES.GTunit.combChamber.Tf", "Firing temperature [K|degC]", \
"SES.GTunit.combChamber.fluegas.T", 1, 1, 69, 0)
DeclareVariable("SES.GTunit.combChamber.hia", "Air specific enthalpy [J/kg]", 0,\
 -10000000000.0,10000000000.0,100000.0,0,512)
DeclareAlias2("SES.GTunit.combChamber.hif", "Fuel specific enthalpy [J/kg]", \
"SES.SourceFuel.ports[1].h_outflow", 1, 5, 7714, 0)
DeclareVariable("SES.GTunit.combChamber.ho", "Outlet specific enthalpy [J/kg]", 0,\
 -10000000000.0,10000000000.0,100000.0,0,512)
DeclareVariable("SES.GTunit.combChamber.der(ho)", "der(Outlet specific enthalpy) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.HR", "Heat rate [W]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.ResTime", "Residence time [s]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("SES.GTunit.combChamber.eta_comb", "Combustion efficiency [1]", \
"SES.GTunit.combChamber.eta0_comb", 1, 5, 7393, 0)
DeclareAlias2("SES.GTunit.combChamber.ina.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.air_in.m_flow", 1, 5, 7670, 132)
DeclareAlias2("SES.GTunit.combChamber.ina.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareVariable("SES.GTunit.combChamber.ina.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.GTunit.combChamber.ina.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.combChamber.ina.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.015, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.combChamber.ina.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.005, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.combChamber.ina.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.75, 0.0,1.0,0.1,0,521)
DeclareAlias2("SES.GTunit.combChamber.inf.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 132)
DeclareAlias2("SES.GTunit.combChamber.inf.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareVariable("SES.GTunit.combChamber.inf.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.GTunit.combChamber.inf.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.combChamber.inf.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.012, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.combChamber.inf.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.968, 0.0,1.0,0.1,0,521)
DeclareAlias2("SES.GTunit.combChamber.out.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.exhaust_out.m_flow", 1, 5, 7681, 132)
DeclareAlias2("SES.GTunit.combChamber.out.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareAlias2("SES.GTunit.combChamber.out.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SES.GTunit.combChamber.ho", 1, 5, 7380, 4)
DeclareAlias2("SES.GTunit.combChamber.out.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 4)
DeclareAlias2("SES.GTunit.combChamber.out.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 4)
DeclareAlias2("SES.GTunit.combChamber.out.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 4)
DeclareAlias2("SES.GTunit.combChamber.out.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 4)
DeclareAlias2("SES.GTunit.combChamber.out.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 4)
DeclareVariable("SES.GTunit.combChamber.eta0_comb", "Constant combustion efficiency [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.combChamber.wcomb", "Molar Combustion rate (CH4) [mol/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.combChamber.lambda", "Stoichiometric ratio (>1 if air flow is greater than stoichiometric)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.GTunit.combChamber.ina_X[1]", "", "SES.airSourceW.X0[1]", 1, 7,\
 787, 1024)
DeclareAlias2("SES.GTunit.combChamber.ina_X[2]", "", "SES.airSourceW.X0[2]", 1, 7,\
 788, 1024)
DeclareAlias2("SES.GTunit.combChamber.ina_X[3]", "", "SES.airSourceW.X0[3]", 1, 7,\
 789, 1024)
DeclareAlias2("SES.GTunit.combChamber.ina_X[4]", "", "SES.airSourceW.X0[4]", 1, 7,\
 790, 1024)
DeclareAlias2("SES.GTunit.combChamber.inf_X[1]", "", "SES.SourceFuel.X[1]", 1, 7,\
 776, 1024)
DeclareAlias2("SES.GTunit.combChamber.inf_X[2]", "", "SES.SourceFuel.X[2]", 1, 7,\
 777, 1024)
DeclareAlias2("SES.GTunit.combChamber.inf_X[3]", "", "SES.SourceFuel.X[3]", 1, 7,\
 778, 1024)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.MM",\
 "Molar mass [kg/mol]", 0.01604246, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.Hf",\
 "Enthalpy of formation at 298.15K [J/kg]", -4650159.63885838, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.H0",\
 "H0(298.15K) - H0(0K) [J/kg]", 624355.7409524474, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.Tlimit",\
 "Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.alow[1]",\
 "Low temperature coefficients a", -176685.0998, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.alow[2]",\
 "Low temperature coefficients a", 2786.18102, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.alow[3]",\
 "Low temperature coefficients a", -12.0257785, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.alow[4]",\
 "Low temperature coefficients a", 0.0391761929, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.alow[5]",\
 "Low temperature coefficients a", -3.61905443E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.alow[6]",\
 "Low temperature coefficients a", 2.026853043E-08, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.alow[7]",\
 "Low temperature coefficients a", -4.976705489999999E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.blow[1]",\
 "Low temperature constants b", -23313.1436, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.blow[2]",\
 "Low temperature constants b", 89.0432275, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.ahigh[1]",\
 "High temperature coefficients a", 3730042.76, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.ahigh[2]",\
 "High temperature coefficients a", -13835.01485, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.ahigh[3]",\
 "High temperature coefficients a", 20.49107091, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.ahigh[4]",\
 "High temperature coefficients a", -0.001961974759, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.ahigh[5]",\
 "High temperature coefficients a", 4.72731304E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.ahigh[6]",\
 "High temperature coefficients a", -3.72881469E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.ahigh[7]",\
 "High temperature coefficients a", 1.623737207E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.bhigh[1]",\
 "High temperature constants b", 75320.6691, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.bhigh[2]",\
 "High temperature constants b", -121.9124889, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.CH4.R_s",\
 "Gas constant [J/(kg.K)]", 518.2791167938085, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].MM", \
"Molar mass [kg/mol]", 0.0280134, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].Hf", \
"Enthalpy of formation at 298.15K [J/kg]", 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].H0", \
"H0(298.15K) - H0(0K) [J/kg]", 309498.4543111511, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].alow[1]", \
"Low temperature coefficients a", 22103.71497, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].alow[2]", \
"Low temperature coefficients a", -381.846182, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].alow[3]", \
"Low temperature coefficients a", 6.08273836, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].alow[4]", \
"Low temperature coefficients a", -0.00853091441, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].alow[5]", \
"Low temperature coefficients a", 1.384646189E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].alow[6]", \
"Low temperature coefficients a", -9.62579362E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].alow[7]", \
"Low temperature coefficients a", 2.519705809E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].blow[1]", \
"Low temperature constants b", 710.846086, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].blow[2]", \
"Low temperature constants b", -10.76003744, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].ahigh[1]", \
"High temperature coefficients a", 587712.406, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].ahigh[2]", \
"High temperature coefficients a", -2239.249073, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].ahigh[3]", \
"High temperature coefficients a", 6.06694922, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].ahigh[4]", \
"High temperature coefficients a", -0.00061396855, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].ahigh[5]", \
"High temperature coefficients a", 1.491806679E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].ahigh[6]", \
"High temperature coefficients a", -1.923105485E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].ahigh[7]", \
"High temperature coefficients a", 1.061954386E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].bhigh[1]", \
"High temperature constants b", 12832.10415, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].bhigh[2]", \
"High temperature constants b", -15.86640027, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[1].R_s", \
"Gas constant [J/(kg.K)]", 296.8033869505308, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].MM", \
"Molar mass [kg/mol]", 0.0440095, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].Hf", \
"Enthalpy of formation at 298.15K [J/kg]", -8941478.544405185, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].H0", \
"H0(298.15K) - H0(0K) [J/kg]", 212805.6215135368, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].alow[1]", \
"Low temperature coefficients a", 49436.5054, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].alow[2]", \
"Low temperature coefficients a", -626.411601, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].alow[3]", \
"Low temperature coefficients a", 5.30172524, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].alow[4]", \
"Low temperature coefficients a", 0.002503813816, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].alow[5]", \
"Low temperature coefficients a", -2.127308728E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].alow[6]", \
"Low temperature coefficients a", -7.68998878E-10, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].alow[7]", \
"Low temperature coefficients a", 2.849677801E-13, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].blow[1]", \
"Low temperature constants b", -45281.9846, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].blow[2]", \
"Low temperature constants b", -7.04827944, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].ahigh[1]", \
"High temperature coefficients a", 117696.2419, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].ahigh[2]", \
"High temperature coefficients a", -1788.791477, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].ahigh[3]", \
"High temperature coefficients a", 8.29152319, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].ahigh[4]", \
"High temperature coefficients a", -9.22315678E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].ahigh[5]", \
"High temperature coefficients a", 4.86367688E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].ahigh[6]", \
"High temperature coefficients a", -1.891053312E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].ahigh[7]", \
"High temperature coefficients a", 6.330036589999999E-16, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].bhigh[1]", \
"High temperature constants b", -39083.5059, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].bhigh[2]", \
"High temperature constants b", -26.52669281, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[2].R_s", \
"Gas constant [J/(kg.K)]", 188.9244822140674, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].MM", \
"Molar mass [kg/mol]", 0.01604246, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].Hf", \
"Enthalpy of formation at 298.15K [J/kg]", -4650159.63885838, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].H0", \
"H0(298.15K) - H0(0K) [J/kg]", 624355.7409524474, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].Tlimit", \
"Temperature limit between low and high data sets [K|degC]", 1000, 0.0,1E+100,\
300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].alow[1]", \
"Low temperature coefficients a", -176685.0998, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].alow[2]", \
"Low temperature coefficients a", 2786.18102, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].alow[3]", \
"Low temperature coefficients a", -12.0257785, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].alow[4]", \
"Low temperature coefficients a", 0.0391761929, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].alow[5]", \
"Low temperature coefficients a", -3.61905443E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].alow[6]", \
"Low temperature coefficients a", 2.026853043E-08, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].alow[7]", \
"Low temperature coefficients a", -4.976705489999999E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].blow[1]", \
"Low temperature constants b", -23313.1436, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].blow[2]", \
"Low temperature constants b", 89.0432275, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].ahigh[1]", \
"High temperature coefficients a", 3730042.76, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].ahigh[2]", \
"High temperature coefficients a", -13835.01485, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].ahigh[3]", \
"High temperature coefficients a", 20.49107091, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].ahigh[4]", \
"High temperature coefficients a", -0.001961974759, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].ahigh[5]", \
"High temperature coefficients a", 4.72731304E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].ahigh[6]", \
"High temperature coefficients a", -3.72881469E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].ahigh[7]", \
"High temperature coefficients a", 1.623737207E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].bhigh[1]", \
"High temperature constants b", 75320.6691, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].bhigh[2]", \
"High temperature constants b", -121.9124889, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.NaturalGas.data[3].R_s", \
"Gas constant [J/(kg.K)]", 518.2791167938085, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].MM", "Molar mass [kg/mol]",\
 0.0319988, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 271263.4223783392, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].Tlimit", "Temperature limit between low and high data sets [K|degC]",\
 1000, 0.0,1E+100,300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].alow[1]", "Low temperature coefficients a",\
 -34255.6342, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].alow[2]", "Low temperature coefficients a",\
 484.700097, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].alow[3]", "Low temperature coefficients a",\
 1.119010961, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].alow[4]", "Low temperature coefficients a",\
 0.00429388924, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].alow[5]", "Low temperature coefficients a",\
 -6.83630052E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].alow[6]", "Low temperature coefficients a",\
 -2.0233727E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].alow[7]", "Low temperature coefficients a",\
 1.039040018E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].blow[1]", "Low temperature constants b",\
 -3391.45487, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].blow[2]", "Low temperature constants b",\
 18.4969947, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].ahigh[1]", "High temperature coefficients a",\
 -1037939.022, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].ahigh[2]", "High temperature coefficients a",\
 2344.830282, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].ahigh[3]", "High temperature coefficients a",\
 1.819732036, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].ahigh[4]", "High temperature coefficients a",\
 0.001267847582, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].ahigh[5]", "High temperature coefficients a",\
 -2.188067988E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].ahigh[6]", "High temperature coefficients a",\
 2.053719572E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].ahigh[7]", "High temperature coefficients a",\
 -8.193467050000001E-16, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].bhigh[1]", "High temperature constants b",\
 -16890.10929, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].bhigh[2]", "High temperature constants b",\
 17.38716506, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[1].R_s", "Gas constant [J/(kg.K)]",\
 259.8369938872708, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].MM", "Molar mass [kg/mol]",\
 0.01801528, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 -13423382.81725291, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 549760.6476280135, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].Tlimit", "Temperature limit between low and high data sets [K|degC]",\
 1000, 0.0,1E+100,300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].alow[1]", "Low temperature coefficients a",\
 -39479.6083, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].alow[2]", "Low temperature coefficients a",\
 575.573102, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].alow[3]", "Low temperature coefficients a",\
 0.931782653, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].alow[4]", "Low temperature coefficients a",\
 0.00722271286, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].alow[5]", "Low temperature coefficients a",\
 -7.34255737E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].alow[6]", "Low temperature coefficients a",\
 4.95504349E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].alow[7]", "Low temperature coefficients a",\
 -1.336933246E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].blow[1]", "Low temperature constants b",\
 -33039.7431, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].blow[2]", "Low temperature constants b",\
 17.24205775, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].ahigh[1]", "High temperature coefficients a",\
 1034972.096, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].ahigh[2]", "High temperature coefficients a",\
 -2412.698562, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].ahigh[3]", "High temperature coefficients a",\
 4.64611078, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].ahigh[4]", "High temperature coefficients a",\
 0.002291998307, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].ahigh[5]", "High temperature coefficients a",\
 -6.836830479999999E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].ahigh[6]", "High temperature coefficients a",\
 9.426468930000001E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].ahigh[7]", "High temperature coefficients a",\
 -4.82238053E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].bhigh[1]", "High temperature constants b",\
 -13842.86509, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].bhigh[2]", "High temperature constants b",\
 -7.97814851, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[2].R_s", "Gas constant [J/(kg.K)]",\
 461.5233290850878, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].MM", "Molar mass [kg/mol]",\
 0.039948, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 155137.3785921698, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].Tlimit", "Temperature limit between low and high data sets [K|degC]",\
 1000, 0.0,1E+100,300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].alow[1]", "Low temperature coefficients a",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].alow[2]", "Low temperature coefficients a",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].alow[3]", "Low temperature coefficients a",\
 2.5, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].alow[4]", "Low temperature coefficients a",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].alow[5]", "Low temperature coefficients a",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].alow[6]", "Low temperature coefficients a",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].alow[7]", "Low temperature coefficients a",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].blow[1]", "Low temperature constants b",\
 -745.375, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].blow[2]", "Low temperature constants b",\
 4.37967491, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].ahigh[1]", "High temperature coefficients a",\
 20.10538475, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].ahigh[2]", "High temperature coefficients a",\
 -0.05992661069999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].ahigh[3]", "High temperature coefficients a",\
 2.500069401, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].ahigh[4]", "High temperature coefficients a",\
 -3.99214116E-08, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].ahigh[5]", "High temperature coefficients a",\
 1.20527214E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].ahigh[6]", "High temperature coefficients a",\
 -1.819015576E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].ahigh[7]", "High temperature coefficients a",\
 1.078576636E-19, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].bhigh[1]", "High temperature constants b",\
 -744.993961, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].bhigh[2]", "High temperature constants b",\
 4.37918011, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[3].R_s", "Gas constant [J/(kg.K)]",\
 208.1323720837088, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].MM", "Molar mass [kg/mol]",\
 0.0280134, 0.0,1E+100,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].Hf", "Enthalpy of formation at 298.15K [J/kg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].H0", "H0(298.15K) - H0(0K) [J/kg]",\
 309498.4543111511, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].Tlimit", "Temperature limit between low and high data sets [K|degC]",\
 1000, 0.0,1E+100,300.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].alow[1]", "Low temperature coefficients a",\
 22103.71497, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].alow[2]", "Low temperature coefficients a",\
 -381.846182, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].alow[3]", "Low temperature coefficients a",\
 6.08273836, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].alow[4]", "Low temperature coefficients a",\
 -0.00853091441, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].alow[5]", "Low temperature coefficients a",\
 1.384646189E-05, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].alow[6]", "Low temperature coefficients a",\
 -9.62579362E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].alow[7]", "Low temperature coefficients a",\
 2.519705809E-12, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].blow[1]", "Low temperature constants b",\
 710.846086, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].blow[2]", "Low temperature constants b",\
 -10.76003744, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].ahigh[1]", "High temperature coefficients a",\
 587712.406, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].ahigh[2]", "High temperature coefficients a",\
 -2239.249073, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].ahigh[3]", "High temperature coefficients a",\
 6.06694922, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].ahigh[4]", "High temperature coefficients a",\
 -0.00061396855, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].ahigh[5]", "High temperature coefficients a",\
 1.491806679E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].ahigh[6]", "High temperature coefficients a",\
 -1.923105485E-11, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].ahigh[7]", "High temperature coefficients a",\
 1.061954386E-15, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].bhigh[1]", "High temperature constants b",\
 12832.10415, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].bhigh[2]", "High temperature constants b",\
 -15.86640027, 0.0,0.0,0.0,0,2561)
DeclareVariable("_GlobalScope.NHES.Media.Air.data[4].R_s", "Gas constant [J/(kg.K)]",\
 296.8033869505308, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.GTunit.compressor.explicitIsentropicEnthalpy", \
"IsentropicEnthalpy function used [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.compressor.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.compressor.pstart_in", "Inlet start pressure [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.compressor.pstart_out", "Outlet start pressure [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.compressor.Tstart_in", "Inlet start temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareVariable("SES.GTunit.compressor.Tstart_out", "Outlet start temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareParameter("SES.GTunit.compressor.Xstart[1]", "Start gas composition [1]",\
 765, 0.23, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.compressor.Xstart[2]", "Start gas composition [1]",\
 766, 0.015, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.compressor.Xstart[3]", "Start gas composition [1]",\
 767, 0.005, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.compressor.Xstart[4]", "Start gas composition [1]",\
 768, 0.75, 0.0,1.0,0.0,0,560)
DeclareAlias2("SES.GTunit.compressor.gas_in.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.GTunit.air_in.p", 1, 5, 7671, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.Xi[4]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.h", "Specific enthalpy of medium [J/kg]",\
 "SES.airSourceW.flange.h_outflow", 1, 5, 7776, 0)
DeclareVariable("SES.GTunit.compressor.gas_in.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,512)
DeclareAlias2("SES.GTunit.compressor.gas_in.T", "Temperature of medium [K|degC]",\
 "SES.GTunit.compressor.Ti", 1, 5, 7618, 0)
DeclareVariable("SES.GTunit.compressor.gas_in.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_in.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.015, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_in.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.005, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_in.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.75, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_in.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_in.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_in.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("SES.GTunit.compressor.gas_in.state.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.GTunit.air_in.p", 1, 5, 7671, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.state.T", "Temperature of medium [K|degC]",\
 "SES.GTunit.compressor.Ti", 1, 5, 7618, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.GTunit.compressor.gas_in.state.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareVariable("SES.GTunit.compressor.gas_in.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.compressor.gas_in.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.compressor.gas_in.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_in.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.compressor.gas_iso.p", "Absolute pressure of medium [Pa|bar]",\
 100000.0, 0.0,1E+100,100000.0,0,513)
DeclareAlias2("SES.GTunit.compressor.gas_iso.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.GTunit.compressor.gas_iso.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.GTunit.compressor.gas_iso.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.GTunit.compressor.gas_iso.Xi[4]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareVariable("SES.GTunit.compressor.gas_iso.h", "Specific enthalpy of medium [J/kg]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.T", "Temperature of medium [K|degC]",\
 300, 200.0,6000.0,500.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.015, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.005, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.75, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.state.p", "Absolute pressure of medium [Pa|bar]",\
 100000.0, 0.0,100000000.0,1000000.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.state.T", "Temperature of medium [K|degC]",\
 300.0, 200.0,6000.0,500.0,0,513)
DeclareAlias2("SES.GTunit.compressor.gas_iso.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.GTunit.compressor.gas_iso.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.GTunit.compressor.gas_iso.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.GTunit.compressor.gas_iso.state.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareVariable("SES.GTunit.compressor.gas_iso.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.compressor.gas_iso.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.compressor.gas_iso.T_degC", "Temperature of medium in [degC] [degC;]",\
 26.850000000000023, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.compressor.gas_iso.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.GTunit.compressor.state_gas_out.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareVariable("SES.GTunit.compressor.state_gas_out.T", "Temperature of medium [K|degC]",\
 500, 200.0,6000.0,500.0,0,512)
DeclareAlias2("SES.GTunit.compressor.state_gas_out.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.GTunit.compressor.state_gas_out.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.GTunit.compressor.state_gas_out.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.GTunit.compressor.state_gas_out.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareVariable("SES.GTunit.compressor.hout_iso", "Outlet isentropic enthalpy [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,512)
DeclareAlias2("SES.GTunit.compressor.hout", "Outlet enthaply [J/kg]", \
"SES.GTunit.combChamber.hia", 1, 5, 7379, 0)
DeclareVariable("SES.GTunit.compressor.s_in", "Inlet specific entropy [J/(kg.K)]",\
 0, -10000000.0,10000000.0,1000.0,0,513)
DeclareAlias2("SES.GTunit.compressor.pin", "Compressor inlet pressure [Pa|bar]",\
 "SES.GTunit.air_in.p", 1, 5, 7671, 0)
DeclareAlias2("SES.GTunit.compressor.pout", "Compressor outlet pressure [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareVariable("SES.GTunit.compressor.Ti", "Compressor inlet temperature [K|degC]",\
 300.0, 200.0,6000.0,300.0,0,513)
DeclareAlias2("SES.GTunit.compressor.Td", "Compressor outlet temperature [K|degC]",\
 "SES.GTunit.compressor.state_gas_out.T", 1, 5, 7615, 0)
DeclareAlias2("SES.GTunit.compressor.w", "Gas flow rate [kg/s]", \
"SES.GTunit.air_in.m_flow", 1, 5, 7670, 0)
DeclareVariable("SES.GTunit.compressor.Wc", "Power requirement to drive a compressor [W|MW]",\
 0.0, 0.0,1E+100,0.0,0,512)
DeclareAlias2("SES.GTunit.compressor.eta", "Isentropic efficiency", \
"SES.GTunit.compressor.eta0", 1, 5, 7626, 0)
DeclareVariable("SES.GTunit.compressor.PR", "Pressure (compression) ratio [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.GTunit.compressor.inlet.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.air_in.m_flow", 1, 5, 7670, 132)
DeclareAlias2("SES.GTunit.compressor.inlet.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.air_in.p", 1, 5, 7671, 4)
DeclareVariable("SES.GTunit.compressor.inlet.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.GTunit.compressor.inlet.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.compressor.inlet.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.015, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.compressor.inlet.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.005, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.compressor.inlet.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.75, 0.0,1.0,0.1,0,521)
DeclareAlias2("SES.GTunit.compressor.outlet.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.air_in.m_flow", -1, 5, 7670, 132)
DeclareAlias2("SES.GTunit.compressor.outlet.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareAlias2("SES.GTunit.compressor.outlet.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SES.GTunit.combChamber.hia", 1, 5, 7379, 4)
DeclareAlias2("SES.GTunit.compressor.outlet.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 4)
DeclareAlias2("SES.GTunit.compressor.outlet.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 4)
DeclareAlias2("SES.GTunit.compressor.outlet.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 4)
DeclareAlias2("SES.GTunit.compressor.outlet.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 4)
DeclareVariable("SES.GTunit.compressor.eta0", "Isentropic efficiency at nominal operating conditions",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.compressor.PR0", "Nominal compression ratio [1]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.compressor.w0", "Nominal gas flow rate [kg/s]", 0.0,\
 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.turbine.explicitIsentropicEnthalpy", \
"IsentropicEnthalpy function used [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.turbine.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.turbine.pstart_in", "Inlet start pressure [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.turbine.pstart_out", "Outlet start pressure [Pa|bar]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.turbine.Tstart_in", "Inlet start temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareVariable("SES.GTunit.turbine.Tstart_out", "Outlet start temperature [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,513)
DeclareParameter("SES.GTunit.turbine.Xstart[1]", "Start gas composition [1]", 769,\
 0.23, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.turbine.Xstart[2]", "Start gas composition [1]", 770,\
 0.02, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.turbine.Xstart[3]", "Start gas composition [1]", 771,\
 0.01, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.turbine.Xstart[4]", "Start gas composition [1]", 772,\
 0.04, 0.0,1.0,0.0,0,560)
DeclareParameter("SES.GTunit.turbine.Xstart[5]", "Start gas composition [1]", 773,\
 0.7, 0.0,1.0,0.0,0,560)
DeclareAlias2("SES.GTunit.turbine.gas_in.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.Xi[4]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.Xi[5]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.h", "Specific enthalpy of medium [J/kg]",\
 "SES.GTunit.combChamber.ho", 1, 5, 7380, 0)
DeclareVariable("SES.GTunit.turbine.gas_in.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,512)
DeclareAlias2("SES.GTunit.turbine.gas_in.T", "Temperature of medium [K|degC]", \
"SES.GTunit.combChamber.fluegas.T", 1, 1, 69, 0)
DeclareState("SES.GTunit.turbine.gas_in.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 70, 0.0, 0.0,1.0,0.1,0,544)
DeclareDerivative("SES.GTunit.turbine.gas_in.der(X[1])", "der(Mass fractions (= (component mass)/total mass  m_i/m)) [s-1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("SES.GTunit.turbine.gas_in.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 71, 0.0, 0.0,1.0,0.1,0,544)
DeclareDerivative("SES.GTunit.turbine.gas_in.der(X[2])", "der(Mass fractions (= (component mass)/total mass  m_i/m)) [s-1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("SES.GTunit.turbine.gas_in.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 72, 0.0, 0.0,1.0,0.1,0,544)
DeclareDerivative("SES.GTunit.turbine.gas_in.der(X[3])", "der(Mass fractions (= (component mass)/total mass  m_i/m)) [s-1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("SES.GTunit.turbine.gas_in.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 73, 0.0, 0.0,1.0,0.1,0,544)
DeclareDerivative("SES.GTunit.turbine.gas_in.der(X[4])", "der(Mass fractions (= (component mass)/total mass  m_i/m)) [s-1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("SES.GTunit.turbine.gas_in.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 74, 0.0, 0.0,1.0,0.1,0,544)
DeclareDerivative("SES.GTunit.turbine.gas_in.der(X[5])", "der(Mass fractions (= (component mass)/total mass  m_i/m)) [s-1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_in.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_in.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_in.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("SES.GTunit.turbine.gas_in.state.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.state.T", "Temperature of medium [K|degC]",\
 "SES.GTunit.combChamber.fluegas.T", 1, 1, 69, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.state.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 0)
DeclareAlias2("SES.GTunit.turbine.gas_in.state.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 0)
DeclareVariable("SES.GTunit.turbine.gas_in.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.turbine.gas_in.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.turbine.gas_in.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_in.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.p", "Absolute pressure of medium [Pa|bar]",\
 100000.0, 0.0,1E+100,100000.0,0,513)
DeclareAlias2("SES.GTunit.turbine.gas_iso.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.Xi[4]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.Xi[5]", "Structurally independent mass fractions [1]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 0)
DeclareVariable("SES.GTunit.turbine.gas_iso.h", "Specific enthalpy of medium [J/kg]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.T", "Temperature of medium [K|degC]",\
 300, 200.0,6000.0,500.0,0,513)
DeclareVariable("SES.GTunit.turbine.gas_iso.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.01, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.04, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.7, 0.0,1.0,0.1,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareVariable("SES.GTunit.turbine.gas_iso.state.p", "Absolute pressure of medium [Pa|bar]",\
 100000.0, 0.0,100000000.0,1000000.0,0,513)
DeclareVariable("SES.GTunit.turbine.gas_iso.state.T", "Temperature of medium [K|degC]",\
 300.0, 200.0,6000.0,500.0,0,513)
DeclareAlias2("SES.GTunit.turbine.gas_iso.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.state.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 0)
DeclareAlias2("SES.GTunit.turbine.gas_iso.state.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 0)
DeclareVariable("SES.GTunit.turbine.gas_iso.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.turbine.gas_iso.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.GTunit.turbine.gas_iso.T_degC", "Temperature of medium in [degC] [degC;]",\
 26.850000000000023, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.turbine.gas_iso.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.GTunit.turbine.state_gas_out.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 0)
DeclareVariable("SES.GTunit.turbine.state_gas_out.T", "Temperature of medium [K|degC]",\
 500, 200.0,6000.0,500.0,0,512)
DeclareAlias2("SES.GTunit.turbine.state_gas_out.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 0)
DeclareAlias2("SES.GTunit.turbine.state_gas_out.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 0)
DeclareAlias2("SES.GTunit.turbine.state_gas_out.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 0)
DeclareAlias2("SES.GTunit.turbine.state_gas_out.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 0)
DeclareAlias2("SES.GTunit.turbine.state_gas_out.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 0)
DeclareVariable("SES.GTunit.turbine.s_in", "Inlet specific entropy [J/(kg.K)]", 0,\
 -10000000.0,10000000.0,1000.0,0,513)
DeclareVariable("SES.GTunit.turbine.hout_iso", "Outlet isentropic enthalpy [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,512)
DeclareVariable("SES.GTunit.turbine.hout", "Outlet enthalpy [J/kg]", 0, \
-10000000000.0,10000000000.0,100000.0,0,512)
DeclareAlias2("SES.GTunit.turbine.pin", "Turbine inlet pressure [Pa|bar]", \
"SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareAlias2("SES.GTunit.turbine.pout", "Turbine outlet pressure [Pa|bar]", \
"SES.GTunit.exhaust_out.p", 1, 5, 7682, 0)
DeclareAlias2("SES.GTunit.turbine.Tf", "Turbine firing temperature [K|degC]", \
"SES.GTunit.combChamber.fluegas.T", 1, 1, 69, 0)
DeclareAlias2("SES.GTunit.turbine.Te", "Turbine exhaust gas temperature [K|degC]",\
 "SES.GTunit.turbine.state_gas_out.T", 1, 5, 7661, 0)
DeclareAlias2("SES.GTunit.turbine.w", "Gas flow rate [kg/s]", "SES.GTunit.exhaust_out.m_flow", -1,\
 5, 7681, 0)
DeclareVariable("SES.GTunit.turbine.Wt", "Produced (mechanical) power from a turbine [W|MW]",\
 0.0, 0.0,1E+100,0.0,0,512)
DeclareAlias2("SES.GTunit.turbine.eta", "Isentropic efficiency [1]", \
"SES.GTunit.turbine.eta0", 1, 5, 7667, 0)
DeclareVariable("SES.GTunit.turbine.PR", "Pressure ratio [1]", 0.0, 0.0,0.0,0.0,\
0,512)
DeclareAlias2("SES.GTunit.turbine.inlet.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.exhaust_out.m_flow", -1, 5, 7681, 132)
DeclareAlias2("SES.GTunit.turbine.inlet.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareAlias2("SES.GTunit.turbine.inlet.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SES.GTunit.exhaust_out.h_outflow", 1, 5, 7683, 4)
DeclareAlias2("SES.GTunit.turbine.inlet.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[1]", 1, 5, 7819, 4)
DeclareAlias2("SES.GTunit.turbine.inlet.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[2]", 1, 5, 7820, 4)
DeclareAlias2("SES.GTunit.turbine.inlet.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[3]", 1, 5, 7821, 4)
DeclareAlias2("SES.GTunit.turbine.inlet.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[4]", 1, 5, 7822, 4)
DeclareAlias2("SES.GTunit.turbine.inlet.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[5]", 1, 5, 7823, 4)
DeclareAlias2("SES.GTunit.turbine.outlet.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.exhaust_out.m_flow", 1, 5, 7681, 132)
DeclareAlias2("SES.GTunit.turbine.outlet.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 4)
DeclareAlias2("SES.GTunit.turbine.outlet.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SES.GTunit.turbine.hout", 1, 5, 7664, 4)
DeclareAlias2("SES.GTunit.turbine.outlet.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[1]", 1, 5, 7121, 4)
DeclareAlias2("SES.GTunit.turbine.outlet.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[2]", 1, 5, 7122, 4)
DeclareAlias2("SES.GTunit.turbine.outlet.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[3]", 1, 5, 7123, 4)
DeclareAlias2("SES.GTunit.turbine.outlet.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[4]", 1, 5, 7124, 4)
DeclareAlias2("SES.GTunit.turbine.outlet.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.GTunit.combChamber.fluegas.X[5]", 1, 5, 7125, 4)
DeclareVariable("SES.GTunit.turbine.eta0", "Isentropic efficiency at nominal operating conditions [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.turbine.PR0", "Nominal compression ratio [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.turbine.w0", "Nominal gas flow rate [kg/s]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.GTunit.air_in.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,776)
DeclareVariable("SES.GTunit.air_in.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 0.0, 0.0,100000000.0,1000000.0,0,520)
DeclareVariable("SES.GTunit.air_in.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.GTunit.air_in.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.air_in.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.015, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.air_in.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.005, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.air_in.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.75, 0.0,1.0,0.1,0,521)
DeclareAlias2("SES.GTunit.fuel_in.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 132)
DeclareAlias2("SES.GTunit.fuel_in.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareVariable("SES.GTunit.fuel_in.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.GTunit.fuel_in.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.fuel_in.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.012, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.fuel_in.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.968, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.exhaust_out.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,0.0,0.0,0,776)
DeclareVariable("SES.GTunit.exhaust_out.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 0.0, 0.0,100000000.0,1000000.0,0,520)
DeclareVariable("SES.GTunit.exhaust_out.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,520)
DeclareAlias2("SES.GTunit.exhaust_out.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[1]", 1, 5, 7819, 4)
DeclareAlias2("SES.GTunit.exhaust_out.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[2]", 1, 5, 7820, 4)
DeclareAlias2("SES.GTunit.exhaust_out.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[3]", 1, 5, 7821, 4)
DeclareAlias2("SES.GTunit.exhaust_out.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[4]", 1, 5, 7822, 4)
DeclareAlias2("SES.GTunit.exhaust_out.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[5]", 1, 5, 7823, 4)
DeclareVariable("SES.GTunit.Te", "Turbine exhaust gas temperature [K|degC]", 0.0,\
 0.0,1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.Tf", "Turbine firing temperature [K|degC]", 0.0, 0.0,\
1E+100,0.0,0,512)
DeclareVariable("SES.GTunit.Te_mes.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, 0.0,100000.0,0.0,0,777)
DeclareAlias2("SES.GTunit.Te_mes.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 4)
DeclareVariable("SES.GTunit.Te_mes.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 -5005.251196434007, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.GTunit.Te_mes.port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Te_mes.port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Te_mes.port.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.01, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Te_mes.port.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.04, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Te_mes.port.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.7, 0.0,1.0,0.1,0,521)
DeclareAlias2("SES.GTunit.Te_mes.T", "Temperature in port medium [K|degC]", \
"SES.GTunit.Te", 1, 5, 7684, 0)
DeclareVariable("SES.GTunit.Tf_mes.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, 0.0,100000.0,0.0,0,777)
DeclareAlias2("SES.GTunit.Tf_mes.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareVariable("SES.GTunit.Tf_mes.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 -5005.251196434007, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.GTunit.Tf_mes.port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Tf_mes.port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Tf_mes.port.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.01, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Tf_mes.port.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.04, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.GTunit.Tf_mes.port.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.7, 0.0,1.0,0.1,0,521)
DeclareAlias2("SES.GTunit.Tf_mes.T", "Temperature in port medium [K|degC]", \
"SES.GTunit.Tf", 1, 5, 7685, 0)
DeclareAlias2("SES.GTunit.shaft.phi", "Absolute rotation angle of flange [rad|deg]",\
 "SES.speed.phi", 1, 1, 77, 4)
DeclareAlias2("SES.GTunit.shaft.tau", "Cut torque in the flange [N.m]", \
"SES.GTunit.tau", -1, 5, 7109, 132)
DeclareVariable("SES.SourceFuel.nPorts", "Number of ports [:#(type=Integer)]", 1,\
 0.0,0.0,0.0,0,517)
DeclareAlias2("SES.SourceFuel.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareAlias2("SES.SourceFuel.medium.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.SourceFuel.X[1]", 1, 7, 776, 0)
DeclareAlias2("SES.SourceFuel.medium.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.SourceFuel.X[2]", 1, 7, 777, 0)
DeclareAlias2("SES.SourceFuel.medium.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.SourceFuel.X[3]", 1, 7, 778, 0)
DeclareAlias2("SES.SourceFuel.medium.h", "Specific enthalpy of medium [J/kg]", \
"SES.SourceFuel.ports[1].h_outflow", 1, 5, 7714, 0)
DeclareVariable("SES.SourceFuel.medium.d", "Density of medium [kg/m3|g/cm3]", 10,\
 0.0,100000.0,10.0,0,512)
DeclareAlias2("SES.SourceFuel.medium.T", "Temperature of medium [K|degC]", \
"SES.SourceFuel.T", 1, 7, 775, 0)
DeclareVariable("SES.SourceFuel.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SourceFuel.medium.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.012, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SourceFuel.medium.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.968, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SourceFuel.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("SES.SourceFuel.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("SES.SourceFuel.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("SES.SourceFuel.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 0)
DeclareAlias2("SES.SourceFuel.medium.state.T", "Temperature of medium [K|degC]",\
 "SES.SourceFuel.T", 1, 7, 775, 0)
DeclareAlias2("SES.SourceFuel.medium.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SourceFuel.X[1]", 1, 7, 776, 0)
DeclareAlias2("SES.SourceFuel.medium.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SourceFuel.X[2]", 1, 7, 777, 0)
DeclareAlias2("SES.SourceFuel.medium.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SourceFuel.X[3]", 1, 7, 778, 0)
DeclareVariable("SES.SourceFuel.medium.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.SourceFuel.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.SourceFuel.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.SourceFuel.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.SourceFuel.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0.0, -100000.0,-0.0,0.0,0,776)
DeclareVariable("SES.SourceFuel.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 0.0, 0.0,100000000.0,1000000.0,0,520)
DeclareVariable("SES.SourceFuel.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.SourceFuel.ports[1].Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.SourceFuel.ports[1].Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.SourceFuel.ports[1].Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.SourceFuel.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("SES.SourceFuel.use_m_flow_in", "Get the mass flow rate from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("SES.SourceFuel.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("SES.SourceFuel.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("SES.SourceFuel.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareParameter("SES.SourceFuel.m_flow", "Fixed mass flow rate going out of the fluid port [kg/s]",\
 774, 2, -100000.0,100000.0,0.0,0,560)
DeclareParameter("SES.SourceFuel.T", "Fixed value of temperature [K|degC]", 775,\
 303.15, 200.0,6000.0,500.0,0,560)
DeclareParameter("SES.SourceFuel.X[1]", "Fixed value of composition [kg/kg]", 776,\
 0.02, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.SourceFuel.X[2]", "Fixed value of composition [kg/kg]", 777,\
 0.012, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.SourceFuel.X[3]", "Fixed value of composition [kg/kg]", 778,\
 0.968, 0.0,1.0,0.1,0,560)
DeclareAlias2("SES.SourceFuel.m_flow_in", "Prescribed mass flow rate [kg/s]", \
"SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 0)
DeclareAlias2("SES.SourceFuel.m_flow_in_internal", "Needed to connect to conditional connector [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 1024)
DeclareAlias2("SES.SourceFuel.T_in_internal", "Needed to connect to conditional connector [K]",\
 "SES.SourceFuel.T", 1, 7, 775, 1024)
DeclareVariable("SES.SourceFuel.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.SourceFuel.X_in_internal[2]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.SourceFuel.X_in_internal[3]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.SinkExhaustGas.nPorts", "Number of ports [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,517)
DeclareAlias2("SES.SinkExhaustGas.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.SinkExhaustGas.X[1]", 1, 7, 780, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.SinkExhaustGas.X[2]", 1, 7, 781, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.SinkExhaustGas.X[3]", 1, 7, 782, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.Xi[4]", "Structurally independent mass fractions [1]",\
 "SES.SinkExhaustGas.X[4]", 1, 7, 783, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.Xi[5]", "Structurally independent mass fractions [1]",\
 "SES.SinkExhaustGas.X[5]", 1, 7, 784, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.h", "Specific enthalpy of medium [J/kg]",\
 "SES.SinkExhaustGas.ports[1].h_outflow", 1, 5, 7740, 0)
DeclareVariable("SES.SinkExhaustGas.medium.d", "Density of medium [kg/m3|g/cm3]",\
 10, 0.0,100000.0,10.0,0,512)
DeclareAlias2("SES.SinkExhaustGas.medium.T", "Temperature of medium [K|degC]", \
"SES.SinkExhaustGas.T", 1, 7, 779, 0)
DeclareVariable("SES.SinkExhaustGas.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.01, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.04, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.7, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("SES.SinkExhaustGas.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.state.T", "Temperature of medium [K|degC]",\
 "SES.SinkExhaustGas.T", 1, 7, 779, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SinkExhaustGas.X[1]", 1, 7, 780, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SinkExhaustGas.X[2]", 1, 7, 781, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SinkExhaustGas.X[3]", 1, 7, 782, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.state.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SinkExhaustGas.X[4]", 1, 7, 783, 0)
DeclareAlias2("SES.SinkExhaustGas.medium.state.X[5]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.SinkExhaustGas.X[5]", 1, 7, 784, 0)
DeclareVariable("SES.SinkExhaustGas.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.SinkExhaustGas.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.SinkExhaustGas.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.SinkExhaustGas.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.SinkExhaustGas.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.exhaust_out.m_flow", -1, 5, 7681, 132)
DeclareAlias2("SES.SinkExhaustGas.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 4)
DeclareVariable("SES.SinkExhaustGas.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareAlias2("SES.SinkExhaustGas.ports[1].Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[1]", 1, 7, 780, 4)
DeclareAlias2("SES.SinkExhaustGas.ports[1].Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[2]", 1, 7, 781, 4)
DeclareAlias2("SES.SinkExhaustGas.ports[1].Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[3]", 1, 7, 782, 4)
DeclareAlias2("SES.SinkExhaustGas.ports[1].Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[4]", 1, 7, 783, 4)
DeclareAlias2("SES.SinkExhaustGas.ports[1].Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[5]", 1, 7, 784, 4)
DeclareVariable("SES.SinkExhaustGas.flowDirection", "Allowed flow direction [:#(type=Modelica.Fluid.Types.PortFlowDirection)]",\
 3, 1.0,3.0,0.0,0,2565)
DeclareVariable("SES.SinkExhaustGas.use_p_in", "Get the pressure from the input connector [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,1539)
DeclareVariable("SES.SinkExhaustGas.use_T_in", "Get the temperature from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("SES.SinkExhaustGas.use_X_in", "Get the composition from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("SES.SinkExhaustGas.use_C_in", "Get the trace substances from the input connector [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("SES.SinkExhaustGas.p", "Fixed value of pressure [Pa|bar]", \
1000000.0, 0.0,100000000.0,1000000.0,0,513)
DeclareParameter("SES.SinkExhaustGas.T", "Fixed value of temperature [K|degC]", 779,\
 293.15, 200.0,6000.0,500.0,0,560)
DeclareParameter("SES.SinkExhaustGas.X[1]", "Fixed value of composition [kg/kg]",\
 780, 0.23, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.SinkExhaustGas.X[2]", "Fixed value of composition [kg/kg]",\
 781, 0.02, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.SinkExhaustGas.X[3]", "Fixed value of composition [kg/kg]",\
 782, 0.01, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.SinkExhaustGas.X[4]", "Fixed value of composition [kg/kg]",\
 783, 0.04, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.SinkExhaustGas.X[5]", "Fixed value of composition [kg/kg]",\
 784, 0.7, 0.0,1.0,0.1,0,560)
DeclareAlias2("SES.SinkExhaustGas.p_in", "Prescribed boundary pressure [Pa]", \
"SES.GTunit.exhaust_out.p", 1, 5, 7682, 0)
DeclareAlias2("SES.SinkExhaustGas.p_in_internal", "Needed to connect to conditional connector [Pa]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 1024)
DeclareAlias2("SES.SinkExhaustGas.T_in_internal", "Needed to connect to conditional connector [K]",\
 "SES.SinkExhaustGas.T", 1, 7, 779, 1024)
DeclareVariable("SES.SinkExhaustGas.X_in_internal[1]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.SinkExhaustGas.X_in_internal[2]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.SinkExhaustGas.X_in_internal[3]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.SinkExhaustGas.X_in_internal[4]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.SinkExhaustGas.X_in_internal[5]", "Needed to connect to conditional connector [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("SES.airSourceW.gas.p", "Absolute pressure of medium [Pa|bar]", \
"SES.GTunit.air_in.p", 1, 5, 7671, 0)
DeclareAlias2("SES.airSourceW.gas.Xi[1]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.airSourceW.gas.Xi[2]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.airSourceW.gas.Xi[3]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.airSourceW.gas.Xi[4]", "Structurally independent mass fractions [1]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareAlias2("SES.airSourceW.gas.h", "Specific enthalpy of medium [J/kg]", \
"SES.airSourceW.flange.h_outflow", 1, 5, 7776, 0)
DeclareVariable("SES.airSourceW.gas.d", "Density of medium [kg/m3|g/cm3]", 10, \
0.0,100000.0,10.0,0,512)
DeclareAlias2("SES.airSourceW.gas.T", "Temperature of medium [K|degC]", \
"SES.airSourceW.T0", 1, 7, 786, 0)
DeclareVariable("SES.airSourceW.gas.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.airSourceW.gas.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.015, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.airSourceW.gas.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.005, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.airSourceW.gas.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 0.75, 0.0,1.0,0.1,0,513)
DeclareVariable("SES.airSourceW.gas.u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,513)
DeclareVariable("SES.airSourceW.gas.R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("SES.airSourceW.gas.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.032, 0.001,0.25,0.032,0,512)
DeclareAlias2("SES.airSourceW.gas.state.p", "Absolute pressure of medium [Pa|bar]",\
 "SES.GTunit.air_in.p", 1, 5, 7671, 0)
DeclareAlias2("SES.airSourceW.gas.state.T", "Temperature of medium [K|degC]", \
"SES.airSourceW.T0", 1, 7, 786, 0)
DeclareAlias2("SES.airSourceW.gas.state.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 0)
DeclareAlias2("SES.airSourceW.gas.state.X[2]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 0)
DeclareAlias2("SES.airSourceW.gas.state.X[3]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 0)
DeclareAlias2("SES.airSourceW.gas.state.X[4]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 0)
DeclareVariable("SES.airSourceW.gas.preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.airSourceW.gas.standardOrderComponents", "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.airSourceW.gas.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.airSourceW.gas.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("SES.airSourceW.p0", "Nominal pressure [Pa|bar]", 785, 101325.0,\
 0.0,0.0,0.0,0,560)
DeclareParameter("SES.airSourceW.T0", "Nominal temperature [K|degC]", 786, \
288.15, 200.0,6000.0,300.0,0,560)
DeclareParameter("SES.airSourceW.X0[1]", "Nominal gas composition [1]", 787, \
0.23, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.airSourceW.X0[2]", "Nominal gas composition [1]", 788, \
0.015, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.airSourceW.X0[3]", "Nominal gas composition [1]", 789, \
0.005, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.airSourceW.X0[4]", "Nominal gas composition [1]", 790, \
0.75, 0.0,1.0,0.1,0,560)
DeclareParameter("SES.airSourceW.w0", "Nominal mass flow rate [kg/s]", 791, \
108.408, 0.0,0.0,0.0,0,560)
DeclareParameter("SES.airSourceW.thetaIGV0", "Nominal IGV angle [1|deg]", 792, 85,\
 0.0,1E+100,0.0,0,560)
DeclareParameter("SES.airSourceW.N0", "Nominal angular velocity of the shaft [rad/s]",\
 793, 376.99111843077515, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.airSourceW.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.airSourceW.use_in_thetaIGV", "Use connector input for the nominal IGV angle [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.airSourceW.use_in_N", "Use connector input for the nominal frequency of the shaft [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.airSourceW.use_in_T", "Use connector input for the temperature [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.airSourceW.use_in_X", "Use connector input for the composition [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.airSourceW.thetaIGV_start", "IGV angle start value [1|deg]",\
 0.0, 0.0,1E+100,0.0,0,513)
DeclareParameter("SES.airSourceW.thetaIGVmin", "Minimum IGV angle [1|deg]", 794,\
 11.6, 0.0,1E+100,0.0,0,560)
DeclareParameter("SES.airSourceW.thetaIGVmax", "Maximum IGV angle [1|deg]", 795,\
 85, 0.0,1E+100,0.0,0,560)
DeclareParameter("SES.airSourceW.A0", "Air flow speed factor [1]", 796, 0.945, \
0.0,0.0,0.0,0,560)
DeclareParameter("SES.airSourceW.A1", "Air flow speed factor [1]", 797, -7.8, \
0.0,0.0,0.0,0,560)
DeclareParameter("SES.airSourceW.A2", "Air flow speed factor [1]", 798, 39, \
0.0,0.0,0.0,0,560)
DeclareAlias2("SES.airSourceW.w", "Mass flow rate [kg/s]", "SES.GTunit.air_in.m_flow", 1,\
 5, 7670, 0)
DeclareAlias2("SES.airSourceW.p_in", "Inlet pressure [Pa|bar]", "SES.GTunit.air_in.p", 1,\
 5, 7671, 0)
DeclareVariable("SES.airSourceW.p_in_reduced", "Reduced inlet pressure [1]", 1, \
0.0,1E+100,0.0,0,576)
DeclareVariable("SES.airSourceW.T_in_reduced", "Reduced inlet temperature [1]", \
1.0, 0.0,1E+100,0.0,0,513)
DeclareAlias2("SES.airSourceW.N", "Angular velocity (frequency) of the shaft [rad/s]",\
 "SES.constN.k", 1, 5, 7837, 0)
DeclareVariable("SES.airSourceW.N_pu", "Per unit value (normalized) of the angular velocity of the shaft [1]",\
 1, 0.0,1E+100,0.0,0,513)
DeclareVariable("SES.airSourceW.N_T_pu", "Temperature dependency of N_pu [1]", 1,\
 0.0,0.0,0.0,0,513)
DeclareVariable("SES.airSourceW.deltaN_T_pu", "Frequency dependency of N_T_pu [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.airSourceW.thetaIGV", "[1|deg]", 0.0, 0.0,1E+100,0.0,0,512)
DeclareAlias2("SES.airSourceW.in_thetaIGV", "[deg]", "SES.airSourceW.thetaIGV", 1,\
 5, 7775, 0)
DeclareAlias2("SES.airSourceW.in_N", "[rad/s]", "SES.constN.k", 1, 5, 7837, 0)
DeclareAlias2("SES.airSourceW.flange.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.air_in.m_flow", -1, 5, 7670, 132)
DeclareAlias2("SES.airSourceW.flange.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.air_in.p", 1, 5, 7671, 4)
DeclareVariable("SES.airSourceW.flange.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareAlias2("SES.airSourceW.flange.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[1]", 1, 7, 787, 4)
DeclareAlias2("SES.airSourceW.flange.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[2]", 1, 7, 788, 4)
DeclareAlias2("SES.airSourceW.flange.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[3]", 1, 7, 789, 4)
DeclareAlias2("SES.airSourceW.flange.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.airSourceW.X0[4]", 1, 7, 790, 4)
DeclareAlias2("SES.airSourceW.in_thetaIGV_internal", "[1]", "SES.airSourceW.thetaIGV", 1,\
 5, 7775, 1024)
DeclareAlias2("SES.airSourceW.in_N_internal", "[rad/s]", "SES.constN.k", 1, 5, 7837,\
 1024)
DeclareAlias2("SES.airSourceW.in_T_internal", "[K]", "SES.airSourceW.T0", 1, 7, 786,\
 1024)
DeclareAlias2("SES.airSourceW.in_X_internal[1]", "[1]", "SES.airSourceW.X0[1]", 1,\
 7, 787, 1024)
DeclareAlias2("SES.airSourceW.in_X_internal[2]", "[1]", "SES.airSourceW.X0[2]", 1,\
 7, 788, 1024)
DeclareAlias2("SES.airSourceW.in_X_internal[3]", "[1]", "SES.airSourceW.X0[3]", 1,\
 7, 789, 1024)
DeclareAlias2("SES.airSourceW.in_X_internal[4]", "[1]", "SES.airSourceW.X0[4]", 1,\
 7, 790, 1024)
DeclareVariable("SES.fuelCtrl.TV", "Valve positoner time constant [s]", 0.04, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.fuelCtrl.TF", "Fuel system time constant [s]", 0.26, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.fuelCtrl.K6", "Fuel valve lower limit [1]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("SES.fuelCtrl.K3", "Ratio of fuel adjustment [1]", 0.0, 0.0,0.0,\
0.0,0,513)
DeclareVariable("SES.fuelCtrl.Kf", "Fuel system external feedback constant [1]",\
 0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.fuelCtrl.VCE", "[1]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.fuelCtrl.wf_pu", "[1]", "SES.fuelCtrl.FuelSystem.y", 1, 1, 76,\
 0)
DeclareParameter("SES.fuelCtrl.ValvePositioner.k", "Gain [1]", 799, 1, 0.0,0.0,\
0.0,0,560)
DeclareVariable("SES.fuelCtrl.ValvePositioner.T", "Time Constant [s]", 0.04, \
0.0,0.0,0.0,0,513)
DeclareVariable("SES.fuelCtrl.ValvePositioner.initType", "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareParameter("SES.fuelCtrl.ValvePositioner.y_start", "Initial or guess value of output (= state)",\
 800, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.fuelCtrl.ValvePositioner.u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("SES.fuelCtrl.ValvePositioner.y", "Connector of Real output signal",\
 75, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("SES.fuelCtrl.ValvePositioner.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("SES.fuelCtrl.FuelSystem.k", "Gain [1]", 801, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.fuelCtrl.FuelSystem.T", "Time Constant [s]", 0.26, 0.0,0.0,\
0.0,0,513)
DeclareVariable("SES.fuelCtrl.FuelSystem.initType", "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareParameter("SES.fuelCtrl.FuelSystem.y_start", "Initial or guess value of output (= state) [1]",\
 802, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("SES.fuelCtrl.FuelSystem.u", "Connector of Real input signal", \
"SES.fuelCtrl.ValvePositioner.y", 1, 1, 75, 0)
DeclareState("SES.fuelCtrl.FuelSystem.y", "Connector of Real output signal [1]",\
 76, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("SES.fuelCtrl.FuelSystem.der(y)", "der(Connector of Real output signal) [s-1]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("SES.fuelCtrl.add.k1", "Gain of input signal 1", 803, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("SES.fuelCtrl.add.k2", "Gain of input signal 2", 804, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("SES.fuelCtrl.add.k3", "Gain of input signal 3", 805, -1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("SES.fuelCtrl.add.u1", "Connector of Real input signal 1 [1]", \
"SES.fuelCtrl.FuelValveMin.k", 1, 5, 7791, 0)
DeclareVariable("SES.fuelCtrl.add.u2", "Connector of Real input signal 2 [1]", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.fuelCtrl.add.u3", "Connector of Real input signal 3 [1]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.fuelCtrl.add.y", "Connector of Real output signal", \
"SES.fuelCtrl.ValvePositioner.u", 1, 5, 7785, 0)
DeclareVariable("SES.fuelCtrl.FuelAdjustment.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.fuelCtrl.FuelAdjustment.u", "Input signal connector [1]", \
"SES.fuelCtrl.VCE", 1, 5, 7782, 0)
DeclareAlias2("SES.fuelCtrl.FuelAdjustment.y", "Output signal connector [1]", \
"SES.fuelCtrl.add.u2", 1, 5, 7788, 0)
DeclareVariable("SES.fuelCtrl.FuelValveMin.k", "Constant output value [1]", 1, \
0.0,0.0,0.0,0,513)
DeclareAlias2("SES.fuelCtrl.FuelValveMin.y", "Connector of Real output signal [1]",\
 "SES.fuelCtrl.FuelValveMin.k", 1, 5, 7791, 0)
DeclareVariable("SES.fuelCtrl.ExternalFeedback.k", "Gain value multiplied with input signal [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.fuelCtrl.ExternalFeedback.u", "Input signal connector [1]", \
"SES.fuelCtrl.FuelSystem.y", 1, 1, 76, 0)
DeclareVariable("SES.fuelCtrl.ExternalFeedback.y", "Output signal connector [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareParameter("SES.wf.k", "Gain value multiplied with input signal [1]", 806,\
 2.273076, 0.0,0.0,0.0,0,560)
DeclareAlias2("SES.wf.u", "Input signal connector [1]", "SES.fuelCtrl.FuelSystem.y", 1,\
 1, 76, 0)
DeclareAlias2("SES.wf.y", "Output signal connector [kg/s]", "SES.SourceFuel.ports[1].m_flow", -1,\
 5, 7712, 0)
DeclareAlias2("SES.Inertia.flange_a.phi", "Absolute rotation angle of flange [rad|deg]",\
 "SES.speed.phi", 1, 1, 77, 4)
DeclareAlias2("SES.Inertia.flange_a.tau", "Cut torque in the flange [N.m]", \
"SES.GTunit.tau", 1, 5, 7109, 132)
DeclareAlias2("SES.Inertia.flange_b.phi", "Absolute rotation angle of flange [rad|deg]",\
 "SES.speed.phi", 1, 1, 77, 4)
DeclareVariable("SES.Inertia.flange_b.tau", "Cut torque in the flange [N.m]", \
0.0, 0.0,0.0,0.0,0,776)
DeclareVariable("SES.Inertia.J", "Moment of inertia [kg.m2]", 1, 0.0,1E+100,0.0,\
0,513)
DeclareVariable("SES.Inertia.stateSelect", "Priority to use phi and w as states [:#(type=StateSelect)]",\
 3, 1.0,5.0,0.0,0,1541)
DeclareAlias2("SES.Inertia.phi", "Absolute rotation angle of component [rad|rad]",\
 "SES.speed.phi", 1, 1, 77, 0)
DeclareAlias2("SES.Inertia.der(phi)", "der(Absolute rotation angle of component) [rad/s]",\
 "SES.constN.k", 1, 5, 7837, 0)
DeclareVariable("SES.Inertia.w", "Absolute angular velocity of component (= der(phi)) [rad/s]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.Inertia.der(w)", "der(Absolute angular velocity of component (= der(phi))) [rad/s2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.Inertia.a", "Absolute angular acceleration of component (= der(w)) [rad/s2]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.pExh_out_cal.y", "Value of Real output [Pa]", \
"SES.GTunit.exhaust_out.p", 1, 5, 7682, 0)
DeclareVariable("SES.Te_pu.k", "Gain value multiplied with input signal [1]", 1,\
 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.Te_pu.u", "Input signal connector [K]", "SES.GTunit.Te", 1, 5,\
 7684, 0)
DeclareVariable("SES.Te_pu.y", "Output signal connector [1]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.Tf_pu.k", "Gain value multiplied with input signal [1]", 1,\
 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.Tf_pu.u", "Input signal connector [K]", "SES.GTunit.Tf", 1, 5,\
 7685, 0)
DeclareVariable("SES.Tf_pu.y", "Output signal connector [1]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("SES.IGVangle.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("SES.IGVangle.u", "Input signal connector", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.IGVangle.y", "Output signal connector [deg]", \
"SES.airSourceW.thetaIGV", 1, 5, 7775, 0)
DeclareAlias2("SES.multiSensor.flange_a.phi", "Absolute rotation angle of flange [rad|deg]",\
 "SES.speed.phi", 1, 1, 77, 4)
DeclareAlias2("SES.multiSensor.flange_a.der(phi)", "der(Absolute rotation angle of flange) [rad/s]",\
 "SES.constN.k", 1, 5, 7837, 4)
DeclareAlias2("SES.multiSensor.flange_a.tau", "Cut torque in the flange [N.m]", \
"SES.GTunit.tau", 1, 5, 7109, 132)
DeclareAlias2("SES.multiSensor.flange_b.phi", "Absolute rotation angle of flange [rad|deg]",\
 "SES.speed.phi", 1, 1, 77, 4)
DeclareAlias2("SES.multiSensor.flange_b.tau", "Cut torque in the flange [N.m]", \
"SES.GTunit.tau", -1, 5, 7109, 132)
DeclareAlias2("SES.multiSensor.power", "Power in flange flange_a as output signal [W]",\
 "SES.sensorBus.W_gen", 1, 5, 7061, 0)
DeclareAlias2("SES.multiSensor.w", "Absolute angular velocity of flange_a as output signal [rad/s]",\
 "SES.constN.k", 1, 5, 7837, 0)
DeclareAlias2("SES.multiSensor.tau", "Torque in flange flange_a and flange_b (tau = flange_a.tau = -flange_b.tau) as output signal [N.m]",\
 "SES.GTunit.tau", 1, 5, 7109, 0)
DeclareVariable("SES.mExhaust.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("SES.mExhaust.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.exhaust_out.m_flow", -1, 5, 7681, 132)
DeclareAlias2("SES.mExhaust.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 4)
DeclareAlias2("SES.mExhaust.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SES.SinkExhaustGas.ports[1].h_outflow", 1, 5, 7740, 4)
DeclareAlias2("SES.mExhaust.port_a.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[1]", 1, 7, 780, 4)
DeclareAlias2("SES.mExhaust.port_a.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[2]", 1, 7, 781, 4)
DeclareAlias2("SES.mExhaust.port_a.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[3]", 1, 7, 782, 4)
DeclareAlias2("SES.mExhaust.port_a.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[4]", 1, 7, 783, 4)
DeclareAlias2("SES.mExhaust.port_a.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SinkExhaustGas.X[5]", 1, 7, 784, 4)
DeclareAlias2("SES.mExhaust.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.GTunit.exhaust_out.m_flow", 1, 5, 7681, 132)
DeclareAlias2("SES.mExhaust.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 4)
DeclareAlias2("SES.mExhaust.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SES.GTunit.exhaust_out.h_outflow", 1, 5, 7683, 4)
DeclareAlias2("SES.mExhaust.port_b.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[1]", 1, 5, 7819, 4)
DeclareAlias2("SES.mExhaust.port_b.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[2]", 1, 5, 7820, 4)
DeclareAlias2("SES.mExhaust.port_b.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[3]", 1, 5, 7821, 4)
DeclareAlias2("SES.mExhaust.port_b.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[4]", 1, 5, 7822, 4)
DeclareAlias2("SES.mExhaust.port_b.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.X_CO2.XiVec[5]", 1, 5, 7823, 4)
DeclareParameter("SES.mExhaust.port_a_exposesState", "= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]",\
 807, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("SES.mExhaust.port_b_exposesState", "= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]",\
 808, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("SES.mExhaust.showDesignFlowDirection", "= false to hide the arrow in the model icon [:#(type=Boolean)]",\
 809, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("SES.mExhaust.m_flow_nominal", "Nominal value of m_flow = port_a.m_flow [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("SES.mExhaust.m_flow_small", "Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareVariable("SES.mExhaust.capacityScaler", "Scaler that sizes the capacity of the overall system [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.mExhaust.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "SES.GTunit.exhaust_out.m_flow", -1, 5, 7681, 0)
DeclareVariable("SES.X_CO2.port.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 0, 0.0,100000.0,0.0,0,777)
DeclareAlias2("SES.X_CO2.port.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.GTunit.exhaust_out.p", 1, 5, 7682, 4)
DeclareVariable("SES.X_CO2.port.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 -5005.251196434007, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.X_CO2.port.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.23, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.X_CO2.port.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.X_CO2.port.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.01, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.X_CO2.port.Xi_outflow[4]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.04, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.X_CO2.port.Xi_outflow[5]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.7, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.X_CO2.Xi", "Mass fraction in port medium [1]", 0.0, \
0.0,0.0,0.0,0,512)
DeclareVariable("SES.X_CO2.ind", "Index of species in vector of independent mass fractions [:#(type=Integer)]",\
 0, 0.0,0.0,0.0,0,2565)
DeclareVariable("SES.X_CO2.XiVec[1]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("SES.X_CO2.XiVec[2]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("SES.X_CO2.XiVec[3]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("SES.X_CO2.XiVec[4]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("SES.X_CO2.XiVec[5]", "Mass fraction vector, needed because indexed argument for the operator inStream is not supported [kg/kg]",\
 0.0, 0.0,1.0,0.1,0,2560)
DeclareVariable("SES.wNatGas.allowFlowReversal", "= true to allow flow reversal, false restricts to design direction (port_a -> port_b) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareAlias2("SES.wNatGas.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 132)
DeclareAlias2("SES.wNatGas.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareVariable("SES.wNatGas.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 0.0, -10000000000.0,10000000000.0,100000.0,0,521)
DeclareVariable("SES.wNatGas.port_a.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.02, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.wNatGas.port_a.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.012, 0.0,1.0,0.1,0,521)
DeclareVariable("SES.wNatGas.port_a.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 0.968, 0.0,1.0,0.1,0,521)
DeclareAlias2("SES.wNatGas.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", 1, 5, 7712, 132)
DeclareAlias2("SES.wNatGas.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "SES.SourceFuel.ports[1].p", 1, 5, 7713, 4)
DeclareAlias2("SES.wNatGas.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "SES.SourceFuel.ports[1].h_outflow", 1, 5, 7714, 4)
DeclareAlias2("SES.wNatGas.port_b.Xi_outflow[1]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SourceFuel.X[1]", 1, 7, 776, 4)
DeclareAlias2("SES.wNatGas.port_b.Xi_outflow[2]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SourceFuel.X[2]", 1, 7, 777, 4)
DeclareAlias2("SES.wNatGas.port_b.Xi_outflow[3]", "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0 [kg/kg]",\
 "SES.SourceFuel.X[3]", 1, 7, 778, 4)
DeclareParameter("SES.wNatGas.port_a_exposesState", "= true if port_a exposes the state of a fluid volume [:#(type=Boolean)]",\
 810, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("SES.wNatGas.port_b_exposesState", "= true if port_b.p exposes the state of a fluid volume [:#(type=Boolean)]",\
 811, false, 0.0,0.0,0.0,0,2610)
DeclareParameter("SES.wNatGas.showDesignFlowDirection", "= false to hide the arrow in the model icon [:#(type=Boolean)]",\
 812, true, 0.0,0.0,0.0,0,2610)
DeclareVariable("SES.wNatGas.m_flow_nominal", "Nominal value of m_flow = port_a.m_flow [kg/s]",\
 0.0, -100000.0,100000.0,0.0,0,513)
DeclareVariable("SES.wNatGas.m_flow_small", "Regularization for bi-directional flow in the region |m_flow| < m_flow_small (m_flow_small > 0 required) [kg/s]",\
 0.0, 0.0,100000.0,0.0,0,513)
DeclareVariable("SES.wNatGas.capacityScaler", "Scaler that sizes the capacity of the overall system [1]",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.wNatGas.m_flow", "Mass flow rate from port_a to port_b [kg/s]",\
 "SES.SourceFuel.ports[1].m_flow", -1, 5, 7712, 0)
DeclareAlias2("SES.wCO2.u1", "Connector of Real input signal 1 [kg/s]", \
"SES.GTunit.exhaust_out.m_flow", -1, 5, 7681, 0)
DeclareAlias2("SES.wCO2.u2", "Connector of Real input signal 2 [1]", \
"SES.X_CO2.Xi", 1, 5, 7817, 0)
DeclareAlias2("SES.wCO2.y", "Connector of Real output signal [kg/s]", \
"SES.sensorBus.m_flow_CO2", 1, 5, 7062, 0)
DeclareParameter("SES.IGVangle_set.height", "Height of ramps", 813, 0, 0.0,0.0,\
0.0,0,560)
DeclareParameter("SES.IGVangle_set.duration", "Duration of ramp (= 0.0 gives a Step) [s]",\
 814, 0, 0.0,1E+100,0.0,0,560)
DeclareAlias2("SES.IGVangle_set.y", "Connector of Real output signal", \
"SES.IGVangle.u", 1, 5, 7805, 0)
DeclareParameter("SES.IGVangle_set.offset", "Offset of output signal y", 815, 1,\
 0.0,0.0,0.0,0,560)
DeclareParameter("SES.IGVangle_set.startTime", "Output y = offset for time < startTime [s]",\
 816, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("SES.speed.useSupport", "= true, if support flange enabled, otherwise implicitly grounded [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareAlias2("SES.speed.flange.phi", "Absolute rotation angle of flange [rad|deg]",\
 "SES.speed.phi", 1, 1, 77, 4)
DeclareAlias2("SES.speed.flange.tau", "Cut torque in the flange [N.m]", \
"SES.Inertia.flange_b.tau", -1, 5, 7794, 132)
DeclareVariable("SES.speed.phi_support", "Absolute angle of support flange [rad|deg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("SES.speed.exact", "Is true/false for exact treatment/filtering of the input signal, respectively [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareParameter("SES.speed.f_crit", "If exact=false, critical frequency of filter to filter input signal [Hz]",\
 817, 60, 0.0,0.0,0.0,0,560)
DeclareState("SES.speed.phi", "Rotation angle of flange with respect to support [rad|deg]",\
 77, 0, 0.0,0.0,0.0,0,544)
DeclareDerivative("SES.speed.der(phi)", "der(Rotation angle of flange with respect to support) [rad/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("SES.speed.w", "Angular velocity of flange with respect to support [rad/s]",\
 "SES.constN.k", 1, 5, 7837, 0)
DeclareVariable("SES.speed.a", "If exact=false, angular acceleration of flange with respect to support else dummy [rad/s2]",\
 0, 0.0,0.0,0.0,0,513)
DeclareAlias2("SES.speed.w_ref", "Reference angular velocity of flange with respect to support as input signal [rad/s]",\
 "SES.constN.k", 1, 5, 7837, 0)
DeclareVariable("SES.speed.w_crit", "Critical frequency [rad/s]", 0.0, 0.0,0.0,\
0.0,0,2561)
DeclareVariable("SES.constN.k", "Constant output value [rad/s]", 1, 0.0,1E+100,\
0.0,0,513)
DeclareAlias2("SES.constN.y", "Connector of Real output signal [rad/s]", \
"SES.constN.k", 1, 5, 7837, 0)
DeclareAlias2("SES.generator.port_b.W", "Active power [W]", "SY.sensorBus.W_subsystems[2]", -1,\
 5, 6911, 132)
DeclareAlias2("SES.generator.port_b.f", "Frequency [Hz]", "BOP.portElec_b.f", 1,\
 5, 6393, 4)
DeclareAlias2("SES.generator.P_flow", "[W|MW]", "SY.sensorBus.W_subsystems[2]", 1,\
 5, 6911, 0)
DeclareAlias2("SES.powerGen.y", "Value of Real output [W]", "SY.sensorBus.W_subsystems[2]", 1,\
 5, 6911, 0)
DeclareVariable("SES.limiter_VCE.uMax", "Upper limits of input signals [1]", 1.5,\
 0.0,0.0,0.0,0,513)
DeclareVariable("SES.limiter_VCE.uMin", "Lower limits of input signals [1]", 0.0,\
 0.0,0.0,0.0,0,513)
DeclareVariable("SES.limiter_VCE.strict", "= true, if strict limits with noEvent(..) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareVariable("SES.limiter_VCE.homotopyType", "Simplified model for homotopy-based initialization [:#(type=Modelica.Blocks.Types.LimiterHomotopy)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("SES.limiter_VCE.u", "Connector of Real input signal [1]", 1, \
0.0,0.0,0.0,0,512)
DeclareAlias2("SES.limiter_VCE.y", "Connector of Real output signal [1]", \
"SES.fuelCtrl.VCE", 1, 5, 7782, 0)
DeclareAlias2("SES.limiter_VCE.simplifiedExpr", "Simplified expression for homotopy-based initialization [1]",\
 "SES.limiter_VCE.u", 1, 5, 7842, 1024)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.CS.PID_CR.I.y", "Connector of Real output signal",\
 78, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.CS.PID_CR.I.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.k", "Integrator gain [1]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.y_reset_internal", \
"Internal connector for integrator reset", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.I.trigger_internal", \
"Needed to use conditional connector trigger [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_CR.addI.k1", "Gain of input signal 1",\
 818, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_CR.addI.k2", "Gain of input signal 2",\
 819, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_CR.addI.k3", "Gain of input signal 3",\
 820, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.addI.u1", "Connector of Real input signal 1 [K]",\
 "nuScale_Tave_enthalpy.CS.PID_CR.addP.u1", 1, 5, 45, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.addI.u2", "Connector of Real input signal 2 [K]",\
 "nuScale_Tave_enthalpy.CS.PID_CR.addP.u2", 1, 5, 46, 0)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.addI.u3", "Connector of Real input signal 3",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.addI.y", "Connector of Real output signal",\
 "nuScale_Tave_enthalpy.CS.PID_CR.I.u", 1, 5, 7843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.addSat.u1", "Connector of Real input signal 1 [1]",\
 "nuScale_Tave_enthalpy.actuatorBus.reactivity_ControlRod", 1, 5, 151, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.addSat.u2", "Connector of Real input signal 2 [1]",\
 "nuScale_Tave_enthalpy.CS.PID_CR.limiter.u", 1, 5, 57, 0)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.addSat.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_CR.addSat.k1", "Gain of input signal 1",\
 821, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_CR.addSat.k2", "Gain of input signal 2",\
 822, -1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_CR.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.gainTrack.u", "Input signal connector",\
 "nuScale_Tave_enthalpy.CS.PID_CR.addSat.y", 1, 5, 7852, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.gainTrack.y", "Output signal connector",\
 "nuScale_Tave_enthalpy.CS.PID_CR.addI.u3", 1, 5, 7851, 0)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_CR.Dzero.k", "Constant output value",\
 823, 0, 0.0,0.0,0.0,0,560)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_CR.Dzero.y", "Connector of Real output signal",\
 "nuScale_Tave_enthalpy.CS.PID_CR.Dzero.k", 1, 7, 823, 0)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.y", "Connector of Real output signal",\
 79, 1.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.der(y)", \
"der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.k", "Integrator gain [1]",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.initType", \
"Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 2, 1.0,4.0,0.0,0,517)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.y_start", \
"Initial or guess value of output (= state)", 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.reset", \
"Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]", 1, 1.0,3.0,0.0,0,517)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.y_reset", \
"Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 1.0, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.y_reset_internal", \
"Internal connector for integrator reset", 1.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.I.trigger_internal", \
"Needed to use conditional connector trigger [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.k1", \
"Gain of input signal 1", 824, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.k2", \
"Gain of input signal 2", 825, -1, 0.0,0.0,0.0,0,560)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.k3", \
"Gain of input signal 3", 826, 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.u1", "Connector of Real input signal 1 [K]",\
 "nuScale_Tave_enthalpy.CS.PID_FeedPump.addP.u1", 1, 5, 99, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.u2", "Connector of Real input signal 2 [K]",\
 "nuScale_Tave_enthalpy.CS.PID_FeedPump.addP.u2", 1, 5, 100, 0)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.u3", \
"Connector of Real input signal 3", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.y", "Connector of Real output signal",\
 "nuScale_Tave_enthalpy.CS.PID_FeedPump.I.u", 1, 5, 7854, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.addSat.u1", \
"Connector of Real input signal 1 [kg/s]", "nuScale_Tave_enthalpy.port_a.m_flow", 1,\
 5, 173, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.addSat.u2", \
"Connector of Real input signal 2 [kg/s]", "nuScale_Tave_enthalpy.CS.PID_FeedPump.limiter.u", 1,\
 5, 111, 0)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.addSat.y", \
"Connector of Real output signal", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_FeedPump.addSat.k1", \
"Gain of input signal 1", 827, 1, 0.0,0.0,0.0,0,560)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_FeedPump.addSat.k2", \
"Gain of input signal 2", 828, -1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.CS.PID_FeedPump.gainTrack.k", \
"Gain value multiplied with input signal [1]", 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.gainTrack.u", \
"Input signal connector", "nuScale_Tave_enthalpy.CS.PID_FeedPump.addSat.y", 1, 5,\
 7863, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.gainTrack.y", \
"Output signal connector", "nuScale_Tave_enthalpy.CS.PID_FeedPump.addI.u3", 1, 5,\
 7862, 0)
DeclareParameter("nuScale_Tave_enthalpy.CS.PID_FeedPump.Dzero.k", \
"Constant output value", 829, 0, 0.0,0.0,0.0,0,560)
DeclareAlias2("nuScale_Tave_enthalpy.CS.PID_FeedPump.Dzero.y", "Connector of Real output signal",\
 "nuScale_Tave_enthalpy.CS.PID_FeedPump.Dzero.k", 1, 7, 829, 0)
DeclareState("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].p", "Absolute pressure of medium [Pa|bar]",\
 80, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].h", "Specific enthalpy of medium [J/kg]",\
 81, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.Lower_Riser.statesFM[1].d", 1, 5, 255, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.Lower_Riser.statesFM[1].T", 1, 5, 257, 0)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.Lower_Riser.statesFM[1].phase", 1, 5, 254, 66)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].h", 1,\
 1, 81, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.Lower_Riser.statesFM[1].d", 1, 5,\
 255, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.Lower_Riser.statesFM[1].T", 1, 5,\
 257, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].p", 1, 1, 80,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].p", 1,\
 1, 80, 0)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[1].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.Lower_Riser.statesFM[1].phase", 1, 5, 254, 66)
DeclareState("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].p", "Absolute pressure of medium [Pa|bar]",\
 82, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,576)
DeclareState("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].h", "Specific enthalpy of medium [J/kg]",\
 83, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,576)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.Lower_Riser.statesFM[2].d", 1, 5, 259, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.Lower_Riser.statesFM[2].T", 1, 5, 261, 0)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.Lower_Riser.statesFM[2].phase", 1, 5, 258, 66)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[2].h", 1,\
 1, 83, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.Lower_Riser.statesFM[2].d", 1, 5,\
 259, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.Lower_Riser.statesFM[2].T", 1, 5,\
 261, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[2].p", 1, 1, 82,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[2].p", 1,\
 1, 82, 0)
DeclareVariable("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Lower_Riser.mediums[2].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.Lower_Riser.statesFM[2].phase", 1, 5, 258, 66)
DeclareState("nuScale_Tave_enthalpy.DownComer.mediums[1].p", "Absolute pressure of medium [Pa|bar]",\
 84, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.DownComer.mediums[1].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,576)
DeclareState("nuScale_Tave_enthalpy.DownComer.mediums[1].h", "Specific enthalpy of medium [J/kg]",\
 85, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.DownComer.mediums[1].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,576)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.DownComer.statesFM[1].d", 1, 5, 389, 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.DownComer.statesFM[1].T", 1, 5, 391, 0)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.DownComer.statesFM[1].phase", 1, 5, 388, 66)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.DownComer.mediums[1].h", 1, 1,\
 85, 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.DownComer.statesFM[1].d", 1, 5, 389,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.DownComer.statesFM[1].T", 1, 5, 391,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1, 1, 84, 0)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1,\
 1, 84, 0)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[1].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[1].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.DownComer.statesFM[1].phase", 1, 5, 388, 66)
DeclareState("nuScale_Tave_enthalpy.DownComer.mediums[2].p", "Absolute pressure of medium [Pa|bar]",\
 86, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.DownComer.mediums[2].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.DownComer.mediums[2].h", "Specific enthalpy of medium [J/kg]",\
 87, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.DownComer.mediums[2].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.DownComer.statesFM[2].d", 1, 5, 393, 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.DownComer.statesFM[2].T", 1, 5, 395, 0)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.DownComer.statesFM[2].phase", 1, 5, 392, 66)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.DownComer.mediums[2].h", 1, 1,\
 87, 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.DownComer.statesFM[2].d", 1, 5, 393,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.DownComer.statesFM[2].T", 1, 5, 395,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[2].p", 1, 1, 86, 0)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[2].p", 1,\
 1, 86, 0)
DeclareVariable("nuScale_Tave_enthalpy.DownComer.mediums[2].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.DownComer.mediums[2].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.DownComer.statesFM[2].phase", 1, 5, 392, 66)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].p", "Absolute pressure of medium [Pa|bar]",\
 "nuScale_Tave_enthalpy.Lower_Riser.mediums[2].p", 1, 1, 82, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[2].der(p)", 1,\
 6, 82, 0)
DeclareState("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].h", "Specific enthalpy of medium [J/kg]",\
 88, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,576)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.Upper_Riser.statesFM[1].d", 1, 5, 522, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.Upper_Riser.statesFM[1].T", 1, 5, 524, 0)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.Upper_Riser.statesFM[1].phase", 1, 5, 521, 66)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[1].h", 1,\
 1, 88, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.Upper_Riser.statesFM[1].d", 1, 5,\
 522, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.Upper_Riser.statesFM[1].T", 1, 5,\
 524, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[2].p", 1, 1, 82,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[2].p", 1,\
 1, 82, 0)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[1].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.Upper_Riser.statesFM[1].phase", 1, 5, 521, 66)
DeclareState("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].p", "Absolute pressure of medium [Pa|bar]",\
 89, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,576)
EndNonAlias(6)
PreNonAliasNew(7)
StartNonAlias(7)
DeclareState("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].h", "Specific enthalpy of medium [J/kg]",\
 90, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,576)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.Upper_Riser.statesFM[2].d", 1, 5, 526, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.Upper_Riser.statesFM[2].T", 1, 5, 528, 0)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.Upper_Riser.statesFM[2].phase", 1, 5, 525, 66)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[2].h", 1,\
 1, 90, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.Upper_Riser.statesFM[2].d", 1, 5,\
 526, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.Upper_Riser.statesFM[2].T", 1, 5,\
 528, 0)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[2].p", 1, 1, 89,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[2].p", 1,\
 1, 89, 0)
DeclareVariable("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.Upper_Riser.mediums[2].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.Upper_Riser.statesFM[2].phase", 1, 5, 525, 66)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].p", \
"Absolute pressure of medium [Pa|bar]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[2].p", 1,\
 1, 89, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[2].der(p)", 1,\
 6, 89, 0)
DeclareState("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].h", \
"Specific enthalpy of medium [J/kg]", 91, 0.0, -10000000000.0,10000000000.0,\
500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].der(h)",\
 "der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,576)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].d", \
"Density of medium [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[1].d", 1,\
 5, 660, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].T", \
"Temperature of medium [K|degC]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[1].T", 1,\
 5, 662, 0)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[1].phase", 1, 5, 659, 66)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].h", 1,\
 1, 91, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[1].d", 1,\
 5, 660, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[1].T", 1,\
 5, 662, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[2].p", 1, 1, 89,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.Upper_Riser.mediums[2].p", 1,\
 1, 89, 0)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].sat.Tsat",\
 "Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[1].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[1].phase", 1, 5, 659, 66)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].p", \
"Absolute pressure of medium [Pa|bar]", "nuScale_Tave_enthalpy.pressurizer_tee.medium.p", 1,\
 1, 2, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", "nuScale_Tave_enthalpy.pressurizer_tee.medium.der(p)", 1,\
 6, 2, 0)
DeclareState("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].h", \
"Specific enthalpy of medium [J/kg]", 92, 0.0, -10000000000.0,10000000000.0,\
500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].der(h)",\
 "der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,576)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].d", \
"Density of medium [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[2].d", 1,\
 5, 664, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].T", \
"Temperature of medium [K|degC]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[2].T", 1,\
 5, 666, 0)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[2].phase", 1, 5, 663, 66)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].h", 1,\
 1, 92, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[2].d", 1,\
 5, 664, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[2].T", 1,\
 5, 666, 0)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.pressurizer_tee.medium.p", 1, 1, 2, 0)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.pressurizer_tee.medium.p", 1,\
 1, 2, 0)
DeclareVariable("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].sat.Tsat",\
 "Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.PressurizerandTopper.mediums[2].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.PressurizerandTopper.statesFM[2].phase", 1, 5, 663, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[1].p", "Absolute pressure of medium [Pa|bar]",\
 93, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[1].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[1].h", "Specific enthalpy of medium [J/kg]",\
 94, 84013.0581525969, -10000000000.0,10000000000.0,500000.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[1].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].d", 1, 5, 1922, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].T", 1, 5, 1924, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].phase", 1, 5, 1921, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].h", 1, 1,\
 94, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].d", 1, 5,\
 1922, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].T", 1, 5, 1924,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].p", 1, 1, 93, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].p", 1,\
 1, 93, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[1].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[1].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[1].phase", 1, 5, 1921, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[2].p", "Absolute pressure of medium [Pa|bar]",\
 95, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[2].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[2].h", "Specific enthalpy of medium [J/kg]",\
 96, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[2].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].d", 1, 5, 1926, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].T", 1, 5, 1928, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].phase", 1, 5, 1925, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].h", 1, 1,\
 96, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].d", 1, 5,\
 1926, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].T", 1, 5, 1928,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].p", 1, 1, 95, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].p", 1,\
 1, 95, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[2].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[2].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[2].phase", 1, 5, 1925, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[3].p", "Absolute pressure of medium [Pa|bar]",\
 97, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[3].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[3].h", "Specific enthalpy of medium [J/kg]",\
 98, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[3].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].d", 1, 5, 1930, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].T", 1, 5, 1932, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].phase", 1, 5, 1929, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].h", 1, 1,\
 98, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].d", 1, 5,\
 1930, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].T", 1, 5, 1932,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].p", 1, 1, 97, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].p", 1,\
 1, 97, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[3].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[3].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[3].phase", 1, 5, 1929, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[4].p", "Absolute pressure of medium [Pa|bar]",\
 99, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[4].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[4].h", "Specific enthalpy of medium [J/kg]",\
 100, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[4].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].d", 1, 5, 1934, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].T", 1, 5, 1936, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].phase", 1, 5, 1933, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].h", 1, 1,\
 100, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].d", 1, 5,\
 1934, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].T", 1, 5, 1936,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].p", 1, 1, 99, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].p", 1,\
 1, 99, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[4].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[4].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[4].phase", 1, 5, 1933, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[5].p", "Absolute pressure of medium [Pa|bar]",\
 101, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[5].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[5].h", "Specific enthalpy of medium [J/kg]",\
 102, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[5].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].d", 1, 5, 1938, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].T", 1, 5, 1940, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].phase", 1, 5, 1937, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].h", 1, 1,\
 102, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].d", 1, 5,\
 1938, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].T", 1, 5, 1940,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].p", 1, 1, 101,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].p", 1,\
 1, 101, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[5].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[5].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[5].phase", 1, 5, 1937, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[6].p", "Absolute pressure of medium [Pa|bar]",\
 103, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[6].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[6].h", "Specific enthalpy of medium [J/kg]",\
 104, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[6].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].d", 1, 5, 1942, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].T", 1, 5, 1944, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].phase", 1, 5, 1941, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].h", 1, 1,\
 104, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].d", 1, 5,\
 1942, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].T", 1, 5, 1944,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].p", 1, 1, 103,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].p", 1,\
 1, 103, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[6].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[6].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[6].phase", 1, 5, 1941, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[7].p", "Absolute pressure of medium [Pa|bar]",\
 105, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[7].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[7].h", "Specific enthalpy of medium [J/kg]",\
 106, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[7].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].d", 1, 5, 1946, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].T", 1, 5, 1948, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].phase", 1, 5, 1945, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].h", 1, 1,\
 106, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].d", 1, 5,\
 1946, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].T", 1, 5, 1948,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].p", 1, 1, 105,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].p", 1,\
 1, 105, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[7].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[7].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[7].phase", 1, 5, 1945, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[8].p", "Absolute pressure of medium [Pa|bar]",\
 107, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[8].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[8].h", "Specific enthalpy of medium [J/kg]",\
 108, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[8].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].d", 1, 5, 1950, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].T", 1, 5, 1952, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].phase", 1, 5, 1949, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].h", 1, 1,\
 108, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].d", 1, 5,\
 1950, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].T", 1, 5, 1952,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].p", 1, 1, 107,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].p", 1,\
 1, 107, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[8].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[8].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[8].phase", 1, 5, 1949, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[9].p", "Absolute pressure of medium [Pa|bar]",\
 109, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[9].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[9].h", "Specific enthalpy of medium [J/kg]",\
 110, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[9].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].d", 1, 5, 1954, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].T", 1, 5, 1956, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].phase", 1, 5, 1953, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].h", 1, 1,\
 110, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].d", 1, 5,\
 1954, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].T", 1, 5, 1956,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].p", 1, 1, 109,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].p", 1,\
 1, 109, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[9].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[9].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[9].phase", 1, 5, 1953, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].p", "Absolute pressure of medium [Pa|bar]",\
 "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1, 1, 84, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", "nuScale_Tave_enthalpy.DownComer.mediums[1].der(p)", 1,\
 6, 84, 0)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.mediums[10].h", "Specific enthalpy of medium [J/kg]",\
 111, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.mediums[10].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,576)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].d", 1, 5, 1958, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].T", 1, 5, 1960, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].phase", 1, 5, 1957, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[10].h", 1,\
 1, 111, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].d", 1, 5,\
 1958, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].T", 1, 5,\
 1960, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1, 1, 84, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1,\
 1, 84, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.mediums[10].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.mediums[10].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.shell.statesFM[10].phase", 1, 5, 1957, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[1].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].phase", 1, 5, 1921, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[1].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].h", 1, 1,\
 94, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[1].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].d", 1, 5,\
 1922, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].T", 1, 5, 1924,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[1].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].p", 1, 1, 93, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[2].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].phase", 1, 5, 1925, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[2].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].h", 1, 1,\
 96, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[2].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].d", 1, 5,\
 1926, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].T", 1, 5, 1928,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[2].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].p", 1, 1, 95, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[3].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].phase", 1, 5, 1929, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[3].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].h", 1, 1,\
 98, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[3].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].d", 1, 5,\
 1930, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].T", 1, 5, 1932,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[3].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].p", 1, 1, 97, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[4].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].phase", 1, 5, 1933, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[4].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].h", 1, 1,\
 100, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[4].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].d", 1, 5,\
 1934, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].T", 1, 5, 1936,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[4].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].p", 1, 1, 99, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[5].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].phase", 1, 5, 1937, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[5].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].h", 1, 1,\
 102, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[5].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].d", 1, 5,\
 1938, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].T", 1, 5, 1940,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[5].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].p", 1, 1, 101,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[6].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].phase", 1, 5, 1941, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[6].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].h", 1, 1,\
 104, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[6].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].d", 1, 5,\
 1942, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].T", 1, 5, 1944,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[6].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].p", 1, 1, 103,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[7].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].phase", 1, 5, 1945, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[7].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].h", 1, 1,\
 106, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[7].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].d", 1, 5,\
 1946, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].T", 1, 5, 1948,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[7].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].p", 1, 1, 105,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[8].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].phase", 1, 5, 1949, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[8].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].h", 1, 1,\
 108, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[8].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].d", 1, 5,\
 1950, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].T", 1, 5, 1952,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[8].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].p", 1, 1, 107,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[9].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].phase", 1, 5, 1953, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[9].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].h", 1, 1,\
 110, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[9].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].d", 1, 5,\
 1954, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].T", 1, 5, 1956,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[9].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].p", 1, 1, 109,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[10].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].phase", 1, 5, 1957, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[10].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[10].h", 1,\
 1, 111, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[10].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].d", 1, 5,\
 1958, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].T", 1, 5,\
 1960, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.states[10].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1, 1, 84, 0)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[1].k",\
 "Gain [1]", 830, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[1].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[1].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[1].y_start",\
 "Initial or guess value of output (= state)", 831, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[1].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[1].y",\
 "Connector of Real output signal", 112, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[1].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[2].k",\
 "Gain [1]", 832, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[2].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[2].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[2].y_start",\
 "Initial or guess value of output (= state)", 833, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[2].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[2].y",\
 "Connector of Real output signal", 113, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[2].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[3].k",\
 "Gain [1]", 834, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[3].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[3].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[3].y_start",\
 "Initial or guess value of output (= state)", 835, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[3].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[3].y",\
 "Connector of Real output signal", 114, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[3].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[4].k",\
 "Gain [1]", 836, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[4].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[4].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[4].y_start",\
 "Initial or guess value of output (= state)", 837, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[4].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[4].y",\
 "Connector of Real output signal", 115, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[4].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[5].k",\
 "Gain [1]", 838, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[5].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[5].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[5].y_start",\
 "Initial or guess value of output (= state)", 839, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[5].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[5].y",\
 "Connector of Real output signal", 116, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[5].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[6].k",\
 "Gain [1]", 840, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[6].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[6].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[6].y_start",\
 "Initial or guess value of output (= state)", 841, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[6].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[6].y",\
 "Connector of Real output signal", 117, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[6].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[7].k",\
 "Gain [1]", 842, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[7].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[7].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[7].y_start",\
 "Initial or guess value of output (= state)", 843, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[7].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[7].y",\
 "Connector of Real output signal", 118, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[7].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[8].k",\
 "Gain [1]", 844, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[8].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[8].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[8].y_start",\
 "Initial or guess value of output (= state)", 845, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[8].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[8].y",\
 "Connector of Real output signal", 119, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[8].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[9].k",\
 "Gain [1]", 846, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[9].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[9].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[9].y_start",\
 "Initial or guess value of output (= state)", 847, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[9].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[9].y",\
 "Connector of Real output signal", 120, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.shell.flowModel.firstOrder_dps_K[9].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].phase", 1, 5, 1921, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].h", 1,\
 1, 94, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].d", 1, 5,\
 1922, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].T", 1, 5,\
 1924, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].p", 1, 1, 93,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].h", 1,\
 1, 94, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].d", 1,\
 5, 1922, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].T", 1,\
 5, 1924, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[1].p", 1, 1,\
 93, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[1]", 1,\
 5, 1417, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[1].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].phase", 1, 5, 1925, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].h", 1,\
 1, 96, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].d", 1, 5,\
 1926, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].T", 1, 5,\
 1928, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].p", 1, 1, 95,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].h", 1,\
 1, 96, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].d", 1,\
 5, 1926, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].T", 1,\
 5, 1928, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[2].p", 1, 1,\
 95, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[2]", 1,\
 5, 1418, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[2].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].phase", 1, 5, 1929, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].h", 1,\
 1, 98, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].d", 1, 5,\
 1930, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].T", 1, 5,\
 1932, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].p", 1, 1, 97,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].h", 1,\
 1, 98, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].d", 1,\
 5, 1930, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].T", 1,\
 5, 1932, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[3].p", 1, 1,\
 97, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[3]", 1,\
 5, 1419, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[3].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].phase", 1, 5, 1933, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].h", 1,\
 1, 100, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].d", 1, 5,\
 1934, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].T", 1, 5,\
 1936, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].p", 1, 1, 99,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].h", 1,\
 1, 100, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].d", 1,\
 5, 1934, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].T", 1,\
 5, 1936, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[4].p", 1, 1,\
 99, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[4]", 1,\
 5, 1420, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[4].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].phase", 1, 5, 1937, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].h", 1,\
 1, 102, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].d", 1, 5,\
 1938, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].T", 1, 5,\
 1940, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].p", 1, 1, 101,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].h", 1,\
 1, 102, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].d", 1,\
 5, 1938, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].T", 1,\
 5, 1940, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[5].p", 1, 1,\
 101, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[5]", 1,\
 5, 1421, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[5].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].phase", 1, 5, 1941, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].h", 1,\
 1, 104, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].d", 1, 5,\
 1942, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].T", 1, 5,\
 1944, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].p", 1, 1, 103,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].h", 1,\
 1, 104, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].d", 1,\
 5, 1942, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].T", 1,\
 5, 1944, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[6].p", 1, 1,\
 103, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[6]", 1,\
 5, 1422, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[6].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].phase", 1, 5, 1945, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].h", 1,\
 1, 106, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].d", 1, 5,\
 1946, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].T", 1, 5,\
 1948, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].p", 1, 1, 105,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].h", 1,\
 1, 106, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].d", 1,\
 5, 1946, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].T", 1,\
 5, 1948, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[7].p", 1, 1,\
 105, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[7]", 1,\
 5, 1423, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[7].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].phase", 1, 5, 1949, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].h", 1,\
 1, 108, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].d", 1, 5,\
 1950, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].T", 1, 5,\
 1952, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].p", 1, 1, 107,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].h", 1,\
 1, 108, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].d", 1,\
 5, 1950, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].T", 1,\
 5, 1952, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[8].p", 1, 1,\
 107, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[8]", 1,\
 5, 1424, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[8].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].phase", 1, 5, 1953, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].h", 1,\
 1, 110, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].d", 1, 5,\
 1954, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].T", 1, 5,\
 1956, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].p", 1, 1, 109,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].h", 1,\
 1, 110, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].d", 1,\
 5, 1954, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].T", 1,\
 5, 1956, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.shell.mediums[9].p", 1, 1,\
 109, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[9]", 1,\
 5, 1425, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[9].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].phase", 1, 5, 1957, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[10].h", 1,\
 1, 111, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].d", 1, 5,\
 1958, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].T", 1, 5,\
 1960, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1, 1, 84, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.shell.mediums[10].h", 1,\
 1, 111, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].d", 1,\
 5, 1958, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].T", 1,\
 5, 1960, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[1].p", 1, 1,\
 84, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_b[9]", 1,\
 5, 1426, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.mediaProps[10].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[1]", 1, 5, 1961,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[1].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[2]", 1, 5, 1962,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[2].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[3]", 1, 5, 1963,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[3].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[4]", 1, 5, 1964,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[4].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[5]", 1, 5, 1965,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[5].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[6]", 1, 5, 1966,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[6].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[7]", 1, 5, 1967,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[7].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[8]", 1, 5, 1968,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[8].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.STHX.geometry.dimensions_shell[1]", 1,\
 5, 785, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_shell[1]", 1,\
 5, 786, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.shell.dlengthsFM[9]", 1, 5, 1969,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_con[9].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[1].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[1].d", 1,\
 5, 1922, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[1].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].d", 1,\
 5, 1926, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[1].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[1]", 1,\
 5, 1417, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[1].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[2]", 1,\
 5, 1418, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[2].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[2].d", 1,\
 5, 1926, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[2].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].d", 1,\
 5, 1930, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[2].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[2]", 1,\
 5, 1418, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[2].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[3]", 1,\
 5, 1419, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[3].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[3].d", 1,\
 5, 1930, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[3].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].d", 1,\
 5, 1934, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[3].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[3]", 1,\
 5, 1419, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[3].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[4]", 1,\
 5, 1420, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[4].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[4].d", 1,\
 5, 1934, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[4].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].d", 1,\
 5, 1938, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[4].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[4]", 1,\
 5, 1420, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[4].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[5]", 1,\
 5, 1421, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[5].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[5].d", 1,\
 5, 1938, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[5].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].d", 1,\
 5, 1942, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[5].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[5]", 1,\
 5, 1421, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[5].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[6]", 1,\
 5, 1422, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[6].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[6].d", 1,\
 5, 1942, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[6].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].d", 1,\
 5, 1946, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[6].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[6]", 1,\
 5, 1422, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[6].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[7]", 1,\
 5, 1423, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[7].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[7].d", 1,\
 5, 1946, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[7].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].d", 1,\
 5, 1950, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[7].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[7]", 1,\
 5, 1423, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[7].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[8]", 1,\
 5, 1424, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[8].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[8].d", 1,\
 5, 1950, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[8].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].d", 1,\
 5, 1954, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[8].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[8]", 1,\
 5, 1424, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[8].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[9]", 1,\
 5, 1425, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[9].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[9].d", 1,\
 5, 1954, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[9].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.shell.statesFM[10].d", 1,\
 5, 1958, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[9].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_a[9]", 1,\
 5, 1425, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.shell.flowModel.IN_var[9].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.shell.flowModel.mus_b[9]", 1,\
 5, 1426, 0)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", "Absolute pressure of medium [Pa|bar]",\
 121, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[1].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", "Specific enthalpy of medium [J/kg]",\
 122, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[1].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].d", 1, 5, 3118, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].T", 1, 5, 3120, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].phase", 1, 5, 3117, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", 1, 1,\
 122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].d", 1, 5, 3118,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].T", 1, 5, 3120,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1, 1, 121, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1,\
 1, 121, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[1].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[1].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[1].phase", 1, 5, 3117, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[2].p", "Absolute pressure of medium [Pa|bar]",\
 123, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[2].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[2].h", "Specific enthalpy of medium [J/kg]",\
 124, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[2].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].d", 1, 5, 3122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].T", 1, 5, 3124, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].phase", 1, 5, 3121, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].h", 1, 1,\
 124, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].d", 1, 5, 3122,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].T", 1, 5, 3124,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].p", 1, 1, 123, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].p", 1,\
 1, 123, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[2].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[2].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[2].phase", 1, 5, 3121, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[3].p", "Absolute pressure of medium [Pa|bar]",\
 125, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[3].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[3].h", "Specific enthalpy of medium [J/kg]",\
 126, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[3].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].d", 1, 5, 3126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].T", 1, 5, 3128, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].phase", 1, 5, 3125, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].h", 1, 1,\
 126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].d", 1, 5, 3126,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].T", 1, 5, 3128,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].p", 1, 1, 125, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].p", 1,\
 1, 125, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[3].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[3].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[3].phase", 1, 5, 3125, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[4].p", "Absolute pressure of medium [Pa|bar]",\
 127, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[4].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[4].h", "Specific enthalpy of medium [J/kg]",\
 128, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[4].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].d", 1, 5, 3130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].T", 1, 5, 3132, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].phase", 1, 5, 3129, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].h", 1, 1,\
 128, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].d", 1, 5, 3130,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].T", 1, 5, 3132,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].p", 1, 1, 127, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].p", 1,\
 1, 127, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[4].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[4].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[4].phase", 1, 5, 3129, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[5].p", "Absolute pressure of medium [Pa|bar]",\
 129, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[5].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[5].h", "Specific enthalpy of medium [J/kg]",\
 130, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[5].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].d", 1, 5, 3134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].T", 1, 5, 3136, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].phase", 1, 5, 3133, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].h", 1, 1,\
 130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].d", 1, 5, 3134,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].T", 1, 5, 3136,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].p", 1, 1, 129, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].p", 1,\
 1, 129, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[5].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[5].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[5].phase", 1, 5, 3133, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[6].p", "Absolute pressure of medium [Pa|bar]",\
 131, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[6].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[6].h", "Specific enthalpy of medium [J/kg]",\
 132, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[6].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].d", 1, 5, 3138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].T", 1, 5, 3140, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].phase", 1, 5, 3137, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].h", 1, 1,\
 132, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].d", 1, 5, 3138,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].T", 1, 5, 3140,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].p", 1, 1, 131, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].p", 1,\
 1, 131, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[6].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[6].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[6].phase", 1, 5, 3137, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[7].p", "Absolute pressure of medium [Pa|bar]",\
 133, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[7].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[7].h", "Specific enthalpy of medium [J/kg]",\
 134, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[7].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].d", 1, 5, 3142, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].T", 1, 5, 3144, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].phase", 1, 5, 3141, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].h", 1, 1,\
 134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].d", 1, 5, 3142,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].T", 1, 5, 3144,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].p", 1, 1, 133, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].p", 1,\
 1, 133, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[7].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[7].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[7].phase", 1, 5, 3141, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[8].p", "Absolute pressure of medium [Pa|bar]",\
 135, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[8].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[8].h", "Specific enthalpy of medium [J/kg]",\
 136, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[8].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].d", 1, 5, 3146, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].T", 1, 5, 3148, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].phase", 1, 5, 3145, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].h", 1, 1,\
 136, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].d", 1, 5, 3146,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].T", 1, 5, 3148,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].p", 1, 1, 135, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].p", 1,\
 1, 135, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[8].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[8].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[8].phase", 1, 5, 3145, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[9].p", "Absolute pressure of medium [Pa|bar]",\
 137, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[9].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[9].h", "Specific enthalpy of medium [J/kg]",\
 138, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[9].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].d", 1, 5, 3150, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].T", 1, 5, 3152, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].phase", 1, 5, 3149, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].h", 1, 1,\
 138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].d", 1, 5, 3150,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].T", 1, 5, 3152,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].p", 1, 1, 137, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].p", 1,\
 1, 137, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[9].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[9].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[9].phase", 1, 5, 3149, 66)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", "Absolute pressure of medium [Pa|bar]",\
 139, 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[10].der(p)", \
"der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.mediums[10].h", "Specific enthalpy of medium [J/kg]",\
 140, 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.mediums[10].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].d", "Density of medium [kg/m3|g/cm3]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].d", 1, 5, 3154, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].T", "Temperature of medium [K|degC]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].T", 1, 5, 3156, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].der(u)", \
"der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].state.phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].phase", 1, 5, 3153, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].state.h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].h", 1, 1,\
 140, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].state.d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].d", 1, 5,\
 3154, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].T", 1, 5, 3156,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].state.p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1, 1, 139,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].T_degC", \
"Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].p_bar", \
"Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].sat.psat", \
"Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1,\
 1, 139, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.mediums[10].sat.Tsat", \
"Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.mediums[10].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.STHX.tube.statesFM[10].phase", 1, 5, 3153, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[1].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].phase", 1, 5, 3117, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[1].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", 1, 1,\
 122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[1].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].d", 1, 5, 3118,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].T", 1, 5, 3120,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[1].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1, 1, 121, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[2].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].phase", 1, 5, 3121, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[2].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].h", 1, 1,\
 124, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[2].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].d", 1, 5, 3122,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].T", 1, 5, 3124,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[2].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].p", 1, 1, 123, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[3].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].phase", 1, 5, 3125, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[3].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].h", 1, 1,\
 126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[3].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].d", 1, 5, 3126,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].T", 1, 5, 3128,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[3].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].p", 1, 1, 125, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[4].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].phase", 1, 5, 3129, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[4].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].h", 1, 1,\
 128, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[4].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].d", 1, 5, 3130,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].T", 1, 5, 3132,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[4].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].p", 1, 1, 127, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[5].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].phase", 1, 5, 3133, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[5].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].h", 1, 1,\
 130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[5].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].d", 1, 5, 3134,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].T", 1, 5, 3136,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[5].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].p", 1, 1, 129, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[6].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].phase", 1, 5, 3137, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[6].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].h", 1, 1,\
 132, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[6].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].d", 1, 5, 3138,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].T", 1, 5, 3140,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[6].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].p", 1, 1, 131, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[7].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].phase", 1, 5, 3141, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[7].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].h", 1, 1,\
 134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[7].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].d", 1, 5, 3142,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].T", 1, 5, 3144,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[7].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].p", 1, 1, 133, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[8].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].phase", 1, 5, 3145, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[8].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].h", 1, 1,\
 136, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[8].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].d", 1, 5, 3146,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].T", 1, 5, 3148,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[8].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].p", 1, 1, 135, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[9].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].phase", 1, 5, 3149, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[9].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].h", 1, 1,\
 138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[9].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].d", 1, 5, 3150,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].T", 1, 5, 3152,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[9].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].p", 1, 1, 137, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[10].phase", \
"Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].phase", 1, 5, 3153, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[10].h", \
"Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].h", 1, 1,\
 140, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[10].d", \
"Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].d", 1, 5,\
 3154, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].T", 1, 5, 3156,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.states[10].p", \
"Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1, 1, 139,\
 0)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[1].k",\
 "Gain [1]", 848, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[1].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[1].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[1].y_start",\
 "Initial or guess value of output (= state)", 849, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[1].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[1].y", \
"Connector of Real output signal", 141, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[1].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[2].k",\
 "Gain [1]", 850, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[2].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[2].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[2].y_start",\
 "Initial or guess value of output (= state)", 851, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[2].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[2].y", \
"Connector of Real output signal", 142, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[2].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[3].k",\
 "Gain [1]", 852, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[3].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[3].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[3].y_start",\
 "Initial or guess value of output (= state)", 853, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[3].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[3].y", \
"Connector of Real output signal", 143, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[3].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[4].k",\
 "Gain [1]", 854, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[4].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[4].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[4].y_start",\
 "Initial or guess value of output (= state)", 855, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[4].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[4].y", \
"Connector of Real output signal", 144, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[4].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[5].k",\
 "Gain [1]", 856, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[5].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[5].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[5].y_start",\
 "Initial or guess value of output (= state)", 857, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[5].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[5].y", \
"Connector of Real output signal", 145, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[5].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[6].k",\
 "Gain [1]", 858, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[6].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[6].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[6].y_start",\
 "Initial or guess value of output (= state)", 859, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[6].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[6].y", \
"Connector of Real output signal", 146, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[6].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[7].k",\
 "Gain [1]", 860, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[7].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[7].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[7].y_start",\
 "Initial or guess value of output (= state)", 861, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[7].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[7].y", \
"Connector of Real output signal", 147, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[7].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[8].k",\
 "Gain [1]", 862, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[8].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[8].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[8].y_start",\
 "Initial or guess value of output (= state)", 863, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[8].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[8].y", \
"Connector of Real output signal", 148, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[8].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[9].k",\
 "Gain [1]", 864, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[9].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[9].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[9].y_start",\
 "Initial or guess value of output (= state)", 865, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[9].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[9].y", \
"Connector of Real output signal", 149, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tube.flowModel.firstOrder_dps_K[9].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].phase", 1, 5, 3117, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", 1, 1,\
 122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].d", 1, 5,\
 3118, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].T", 1, 5, 3120,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1, 1, 121,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].h", 1,\
 1, 122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].d", 1,\
 5, 3118, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].T", 1,\
 5, 3120, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[1].p", 1, 1,\
 121, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[1]", 1,\
 5, 2321, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[1].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].phase", 1, 5, 3121, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].h", 1, 1,\
 124, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].d", 1, 5,\
 3122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].T", 1, 5, 3124,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].p", 1, 1, 123,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].h", 1,\
 1, 124, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].d", 1,\
 5, 3122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].T", 1,\
 5, 3124, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[2].p", 1, 1,\
 123, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[2]", 1,\
 5, 2322, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[2].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].phase", 1, 5, 3125, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].h", 1, 1,\
 126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].d", 1, 5,\
 3126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].T", 1, 5, 3128,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].p", 1, 1, 125,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].h", 1,\
 1, 126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].d", 1,\
 5, 3126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].T", 1,\
 5, 3128, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[3].p", 1, 1,\
 125, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[3]", 1,\
 5, 2323, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[3].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].phase", 1, 5, 3129, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].h", 1, 1,\
 128, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].d", 1, 5,\
 3130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].T", 1, 5, 3132,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].p", 1, 1, 127,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].h", 1,\
 1, 128, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].d", 1,\
 5, 3130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].T", 1,\
 5, 3132, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[4].p", 1, 1,\
 127, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[4]", 1,\
 5, 2324, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[4].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].phase", 1, 5, 3133, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].h", 1, 1,\
 130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].d", 1, 5,\
 3134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].T", 1, 5, 3136,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].p", 1, 1, 129,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].h", 1,\
 1, 130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].d", 1,\
 5, 3134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].T", 1,\
 5, 3136, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[5].p", 1, 1,\
 129, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[5]", 1,\
 5, 2325, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[5].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].phase", 1, 5, 3137, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].h", 1, 1,\
 132, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].d", 1, 5,\
 3138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].T", 1, 5, 3140,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].p", 1, 1, 131,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].h", 1,\
 1, 132, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].d", 1,\
 5, 3138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].T", 1,\
 5, 3140, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[6].p", 1, 1,\
 131, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[6]", 1,\
 5, 2326, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[6].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].phase", 1, 5, 3141, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].h", 1, 1,\
 134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].d", 1, 5,\
 3142, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].T", 1, 5, 3144,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].p", 1, 1, 133,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].h", 1,\
 1, 134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].d", 1,\
 5, 3142, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].T", 1,\
 5, 3144, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[7].p", 1, 1,\
 133, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[7]", 1,\
 5, 2327, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[7].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].phase", 1, 5, 3145, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].h", 1, 1,\
 136, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].d", 1, 5,\
 3146, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].T", 1, 5, 3148,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].p", 1, 1, 135,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].h", 1,\
 1, 136, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].d", 1,\
 5, 3146, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].T", 1,\
 5, 3148, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[8].p", 1, 1,\
 135, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[8]", 1,\
 5, 2328, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[8].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].phase", 1, 5, 3149, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].h", 1, 1,\
 138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].d", 1, 5,\
 3150, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].T", 1, 5, 3152,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].p", 1, 1, 137,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].h", 1,\
 1, 138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].d", 1,\
 5, 3150, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].T", 1,\
 5, 3152, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[9].p", 1, 1,\
 137, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[9]", 1,\
 5, 2329, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[9].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].phase", 1, 5, 3153, 66)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].h", 1,\
 1, 140, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].d", 1, 5,\
 3154, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].T", 1, 5,\
 3156, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1, 1, 139,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].h", \
"Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].h", 1,\
 1, 140, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].d", \
"Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].d", 1,\
 5, 3154, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].T", \
"Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].T", 1,\
 5, 3156, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].p", \
"Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.STHX.tube.mediums[10].p", 1, 1,\
 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].mu", \
"Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_b[9]", 1,\
 5, 2330, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.mediaProps[10].cp", \
"Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[1]", 1, 5, 3157,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[1].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[2]", 1, 5, 3158,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[2].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[3]", 1, 5, 3159,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[3].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[4]", 1, 5, 3160,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[4].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[5]", 1, 5, 3161,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[5].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[6]", 1, 5, 3162,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[6].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[7]", 1, 5, 3163,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[7].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[8]", 1, 5, 3164,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[8].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].diameter_a", \
"Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].diameter_b", \
"Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.data.d_steamGenerator_tube_inner", 1,\
 5, 139, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.STHX.geometry.crossAreas_tube[1]", 1,\
 5, 843, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].length", \
"Length of pipe [m]", "nuScale_Tave_enthalpy.STHX.tube.dlengthsFM[9]", 1, 5, 3165,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_con[9].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[1].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[1].d", 1,\
 5, 3118, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[1].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].d", 1,\
 5, 3122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[1].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[1]", 1,\
 5, 2321, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[1].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[2]", 1,\
 5, 2322, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[2].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[2].d", 1,\
 5, 3122, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[2].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].d", 1,\
 5, 3126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[2].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[2]", 1,\
 5, 2322, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[2].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[3]", 1,\
 5, 2323, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[3].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[3].d", 1,\
 5, 3126, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[3].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].d", 1,\
 5, 3130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[3].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[3]", 1,\
 5, 2323, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[3].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[4]", 1,\
 5, 2324, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[4].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[4].d", 1,\
 5, 3130, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[4].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].d", 1,\
 5, 3134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[4].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[4]", 1,\
 5, 2324, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[4].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[5]", 1,\
 5, 2325, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[5].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[5].d", 1,\
 5, 3134, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[5].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].d", 1,\
 5, 3138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[5].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[5]", 1,\
 5, 2325, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[5].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[6]", 1,\
 5, 2326, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[6].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[6].d", 1,\
 5, 3138, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[6].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].d", 1,\
 5, 3142, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[6].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[6]", 1,\
 5, 2326, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[6].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[7]", 1,\
 5, 2327, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[7].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[7].d", 1,\
 5, 3142, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[7].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].d", 1,\
 5, 3146, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[7].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[7]", 1,\
 5, 2327, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[7].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[8]", 1,\
 5, 2328, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[8].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[8].d", 1,\
 5, 3146, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[8].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].d", 1,\
 5, 3150, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[8].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[8]", 1,\
 5, 2328, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[8].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[9]", 1,\
 5, 2329, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[9].rho_a", \
"Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[9].d", 1,\
 5, 3150, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[9].rho_b", \
"Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.STHX.tube.statesFM[10].d", 1,\
 5, 3154, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[9].mu_a", \
"Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_a[9]", 1,\
 5, 2329, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tube.flowModel.IN_var[9].mu_b", \
"Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.STHX.tube.flowModel.mus_b[9]", 1,\
 5, 2330, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].T", \
"Temperature [K|degC]", 150, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].h", 1,\
 5, 8294, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].T", \
"Temperature [K|degC]", 151, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].h", 1,\
 5, 8299, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1, 5, 3080,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].T", \
"Temperature [K|degC]", 152, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].h", 1,\
 5, 8304, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 3].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1, 5, 3081,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].T", \
"Temperature [K|degC]", 153, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].h", 1,\
 5, 8309, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 4].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1, 5, 3082,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].T", \
"Temperature [K|degC]", 154, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].h", 1,\
 5, 8314, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 5].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1, 5, 3083,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].T", \
"Temperature [K|degC]", 155, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].h", 1,\
 5, 8319, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 6].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1, 5, 3084,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].T", \
"Temperature [K|degC]", 156, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].h", 1,\
 5, 8324, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 7].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1, 5, 3085,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].T", \
"Temperature [K|degC]", 157, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].h", 1,\
 5, 8329, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 8].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1, 5, 3086,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].T", \
"Temperature [K|degC]", 158, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].h", 1,\
 5, 8334, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 9].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1, 5, 3087,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].T", \
"Temperature [K|degC]", 159, 300.0, 273.15,1773.15,300.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].der(T)",\
 "der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].h", 1,\
 5, 8339, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[1, 10].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5, 3088,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].T", \
"Temperature [K|degC]", 160, 558.31341553, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].h", 1,\
 5, 8344, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 1].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].T", \
"Temperature [K|degC]", 161, 562.8692627, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].h", 1,\
 5, 8349, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 2].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1, 5, 1891,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].T", \
"Temperature [K|degC]", 162, 568.02947998, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].h", 1,\
 5, 8354, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 3].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1, 5, 1890,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].T", \
"Temperature [K|degC]", 163, 572.29638672, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].h", 1,\
 5, 8359, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 4].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1, 5, 1889,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].T", \
"Temperature [K|degC]", 164, 576.52716064, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].h", 1,\
 5, 8364, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 5].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1, 5, 1888,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].T", \
"Temperature [K|degC]", 165, 580.78710938, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].h", 1,\
 5, 8369, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 6].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1, 5, 1887,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].T", \
"Temperature [K|degC]", 166, 585.11022949, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].h", 1,\
 5, 8374, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 7].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1, 5, 1886,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].T", \
"Temperature [K|degC]", 167, 589.5078125, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].h", 1,\
 5, 8379, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 8].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1, 5, 1885,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].T", \
"Temperature [K|degC]", 168, 593.97235107, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].der(T)", \
"der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].h", 1,\
 5, 8384, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 9].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1, 5, 1884,\
 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,515)
DeclareState("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].T", \
"Temperature [K|degC]", 169, 596.58215332, 273.15,1773.15,300.0,0,560)
DeclareDerivative("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].der(T)",\
 "der(Temperature) [K/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].h", \
"Specific enthalpy of medium [J/kg]", 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].der(h)", \
"der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].d", \
"Density of medium [kg/m3|g/cm3]", 8030, 0.0,100000.0,1.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].u", \
"Specific internal energy of medium [J/kg]", "nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].h", 1,\
 5, 8389, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.1, 0.0,1E+100,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.materials[2, 10].state.T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5, 1883,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 1].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 2].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1, 5, 3080,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 3].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1, 5, 3081,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 4].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1, 5, 3082,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 5].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1, 5, 3083,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 6].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1, 5, 3084,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 7].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1, 5, 3085,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 8].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1, 5, 3086,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 9].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1, 5, 3087,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[1, 10].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5,\
 3088, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 1].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 2].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1, 5,\
 1891, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 3].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1, 5,\
 1890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 4].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1, 5,\
 1889, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 5].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1, 5,\
 1888, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 6].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1, 5,\
 1887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 7].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1, 5,\
 1886, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 8].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1, 5,\
 1885, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 9].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1, 5,\
 1884, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_1[2, 10].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5,\
 1883, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 1].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 2].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1, 5, 3080,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 3].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1, 5, 3081,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 4].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1, 5, 3082,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 5].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1, 5, 3083,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 6].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1, 5, 3084,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 7].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1, 5, 3085,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 8].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1, 5, 3086,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 9].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1, 5, 3087,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[1, 10].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5,\
 3088, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 1].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 2].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1, 5,\
 1891, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 3].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1, 5,\
 1890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 4].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1, 5,\
 1889, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 5].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1, 5,\
 1888, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 6].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1, 5,\
 1887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 7].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1, 5,\
 1886, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 8].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1, 5,\
 1885, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 9].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1, 5,\
 1884, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.conductionModel.states_2[2, 10].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5,\
 1883, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 1].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 2].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1, 5, 3080,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 3].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1, 5, 3081,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 4].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1, 5, 3082,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 5].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1, 5, 3083,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 6].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1, 5, 3084,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 7].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1, 5, 3085,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 8].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1, 5, 3086,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 9].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1, 5, 3087,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[1, 10].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5,\
 3088, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 1].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 2].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1, 5,\
 1891, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 3].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1, 5,\
 1890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 4].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1, 5,\
 1889, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 5].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1, 5,\
 1888, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 6].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1, 5,\
 1887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 7].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1, 5,\
 1886, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 8].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1, 5,\
 1885, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 9].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1, 5,\
 1884, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.internalHeatModel.states[2, 10].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5,\
 1883, 0)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[1].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1,\
 5, 3079, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[2].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[2].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1,\
 5, 3080, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[3].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[3].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1,\
 5, 3081, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[4].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[4].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1,\
 5, 3082, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[5].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[5].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1,\
 5, 3083, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[6].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[6].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1,\
 5, 3084, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[7].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[7].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1,\
 5, 3085, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[8].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[8].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1,\
 5, 3086, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[9].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[9].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1,\
 5, 3087, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[10].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,776)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a1[10].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1,\
 5, 3088, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[1].Q_flow", -1, 5, 1095, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[1].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1,\
 5, 1892, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[2].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[2].Q_flow", -1, 5, 1096, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[2].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1,\
 5, 1891, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[3].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[3].Q_flow", -1, 5, 1097, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[3].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1,\
 5, 1890, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[4].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[4].Q_flow", -1, 5, 1098, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[4].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1,\
 5, 1889, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[5].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[5].Q_flow", -1, 5, 1099, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[5].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1,\
 5, 1888, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[6].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[6].Q_flow", -1, 5, 1100, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[6].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1,\
 5, 1887, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[7].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[7].Q_flow", -1, 5, 1101, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[7].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1,\
 5, 1886, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[8].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[8].Q_flow", -1, 5, 1102, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[8].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1,\
 5, 1885, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[9].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[9].Q_flow", -1, 5, 1103, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[9].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1,\
 5, 1884, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[10].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 "nuScale_Tave_enthalpy.STHX.counterFlow.port_a[10].Q_flow", -1, 5, 1104, 132)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b1[10].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1,\
 5, 1883, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a2[1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a2[1].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1,\
 5, 3079, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_a2[2].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_a2[2].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1,\
 5, 1892, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_b2[1].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b2[1].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1,\
 5, 3088, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_b2[2].Q_flow", \
"Heat flow rate. Flow from the connection point into the component is positive. [W]",\
 0.0, 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_b2[2].T", \
"Temperature at the connection point [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1,\
 5, 1883, 4)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 1].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1,\
 5, 3079, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 1].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 2].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1,\
 5, 3080, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 2].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 3].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1,\
 5, 3081, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 3].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 4].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1,\
 5, 3082, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 4].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 5].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1,\
 5, 3083, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 5].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 6].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1,\
 5, 3084, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 6].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 7].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1,\
 5, 3085, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 7].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 8].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1,\
 5, 3086, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 8].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 9].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1,\
 5, 3087, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 9].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 10].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1,\
 5, 3088, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[1, 10].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 1].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1,\
 5, 1892, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 1].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 2].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1,\
 5, 1891, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 2].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 3].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1,\
 5, 1890, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 3].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 4].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1,\
 5, 1889, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 4].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 5].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1,\
 5, 1888, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 5].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 6].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1,\
 5, 1887, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 6].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 7].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1,\
 5, 1886, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 7].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 8].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1,\
 5, 1885, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 8].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 9].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1,\
 5, 1884, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 9].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 10].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1,\
 5, 1883, 4)
DeclareVariable("nuScale_Tave_enthalpy.STHX.tubeWall.port_external[2, 10].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1, 5, 3080,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1, 5, 3081,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1, 5, 3082,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1, 5, 3083,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1, 5, 3084,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1, 5, 3085,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1, 5, 3086,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1, 5, 3087,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a1[10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5, 3088,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1, 5, 1891,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1, 5, 1890,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1, 5, 1889,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1, 5, 1888,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1, 5, 1887,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1, 5, 1886,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1, 5, 1885,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1, 5, 1884,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b1[10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5, 1883,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a2[1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_a2[2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b2[1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5, 3088,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.state_b2[2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5, 1883,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1, 5, 3080,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1, 5, 3081,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1, 5, 3082,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1, 5, 3083,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1, 5, 3084,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1, 5, 3085,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1, 5, 3086,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1, 5, 3087,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[1, 10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5, 3088,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1, 5, 1891,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1, 5, 1890,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1, 5, 1889,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1, 5, 1888,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1, 5, 1887,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1, 5, 1886,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1, 5, 1885,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1, 5, 1884,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_1[2, 10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5, 1883,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[1, 1]", 1, 5, 3079,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[2, 1]", 1, 5, 3080,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[3, 1]", 1, 5, 3081,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[4, 1]", 1, 5, 3082,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[5, 1]", 1, 5, 3083,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[6, 1]", 1, 5, 3084,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[7, 1]", 1, 5, 3085,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[8, 1]", 1, 5, 3086,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[9, 1]", 1, 5, 3087,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[1, 10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.tube.Ts_wall[10, 1]", 1, 5, 3088,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 1].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[10, 1]", 1, 5,\
 1892, 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 2].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[9, 1]", 1, 5, 1891,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 3].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[8, 1]", 1, 5, 1890,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 4].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[7, 1]", 1, 5, 1889,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 5].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[6, 1]", 1, 5, 1888,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 6].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[5, 1]", 1, 5, 1887,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 7].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[4, 1]", 1, 5, 1886,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 8].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[3, 1]", 1, 5, 1885,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 9].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[2, 1]", 1, 5, 1884,\
 1024)
DeclareAlias2("nuScale_Tave_enthalpy.STHX.tubeWall.statesFM_2[2, 10].T", \
"Temperature [K|degC]", "nuScale_Tave_enthalpy.STHX.shell.Ts_wall[1, 1]", 1, 5, 1883,\
 1024)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].p", \
"Absolute pressure of medium [Pa|bar]", 170, 100000.0, 611.657,100000000.0,\
100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].der(p)",\
 "der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].h", \
"Specific enthalpy of medium [J/kg]", 171, 0.0, -10000000000.0,10000000000.0,\
500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].der(h)",\
 "der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].d", \
"Density of medium [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].d", 1,\
 5, 4887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].T", \
"Temperature of medium [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 1]", 1,\
 5, 5504, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].der(u)",\
 "der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].phase", 1, 5, 4886, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].h", 1,\
 1, 171, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].d", 1,\
 5, 4887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 1]", 1,\
 5, 5504, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].p", 1,\
 1, 170, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].T_degC",\
 "Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].p_bar",\
 "Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].sat.psat",\
 "Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].p", 1,\
 1, 170, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].sat.Tsat",\
 "Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].phase", 1, 5, 4886, 66)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].p", \
"Absolute pressure of medium [Pa|bar]", 172, 100000.0, 611.657,100000000.0,\
100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].der(p)",\
 "der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].h", \
"Specific enthalpy of medium [J/kg]", 173, 0.0, -10000000000.0,10000000000.0,\
500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].der(h)",\
 "der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].d", \
"Density of medium [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].d", 1,\
 5, 4890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].T", \
"Temperature of medium [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 2]", 1,\
 5, 5505, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].der(u)",\
 "der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].phase", 1, 5, 4889, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].h", 1,\
 1, 173, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].d", 1,\
 5, 4890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 2]", 1,\
 5, 5505, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].p", 1,\
 1, 172, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].T_degC",\
 "Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].p_bar",\
 "Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].sat.psat",\
 "Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].p", 1,\
 1, 172, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].sat.Tsat",\
 "Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].phase", 1, 5, 4889, 66)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].p", \
"Absolute pressure of medium [Pa|bar]", 174, 100000.0, 611.657,100000000.0,\
100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].der(p)",\
 "der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].h", \
"Specific enthalpy of medium [J/kg]", 175, 0.0, -10000000000.0,10000000000.0,\
500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].der(h)",\
 "der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].d", \
"Density of medium [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].d", 1,\
 5, 4893, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].T", \
"Temperature of medium [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 3]", 1,\
 5, 5506, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].der(u)",\
 "der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].phase", 1, 5, 4892, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].h", 1,\
 1, 175, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].d", 1,\
 5, 4893, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 3]", 1,\
 5, 5506, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].p", 1,\
 1, 174, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].T_degC",\
 "Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].p_bar",\
 "Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].sat.psat",\
 "Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].p", 1,\
 1, 174, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].sat.Tsat",\
 "Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].phase", 1, 5, 4892, 66)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].p", \
"Absolute pressure of medium [Pa|bar]", 176, 100000.0, 611.657,100000000.0,\
100000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].der(p)",\
 "der(Absolute pressure of medium) [Pa/s]", 0.0, 0.0,0.0,0.0,0,512)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].h", \
"Specific enthalpy of medium [J/kg]", 177, 0.0, -10000000000.0,10000000000.0,\
500000.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].der(h)",\
 "der(Specific enthalpy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].d", \
"Density of medium [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].d", 1,\
 5, 4896, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].T", \
"Temperature of medium [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 4]", 1,\
 5, 5507, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].X[1]", \
"Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]", 1.0, 0.0,1.0,\
0.1,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].u", \
"Specific internal energy of medium [J/kg]", 0.0, -100000000.0,100000000.0,\
1000000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].der(u)",\
 "der(Specific internal energy of medium) [m2/s3]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].R_s", \
"Gas constant (of mixture if applicable) [J/(kg.K)]", 461.5231157345669, 0.0,\
10000000.0,1000.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].MM", \
"Molar mass (of mixture or single fluid) [kg/mol]", 0.018015268, 0.001,0.25,\
0.032,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].phase", 1, 5, 4895, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].h", 1,\
 1, 177, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].d", 1,\
 5, 4896, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 4]", 1,\
 5, 5507, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].p", 1,\
 1, 176, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].preferredMediumStates",\
 "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].standardOrderComponents",\
 "If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].T_degC",\
 "Temperature of medium in [degC] [degC;]", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].p_bar",\
 "Absolute pressure of medium in [bar] [bar]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].sat.psat",\
 "Saturation pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].p", 1,\
 1, 176, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].sat.Tsat",\
 "Saturation temperature [K|degC]", 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].phase", \
"2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]", \
"nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].phase", 1, 5, 4895, 66)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[1].phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[1].h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.DownComer.mediums[2].h", 1, 1,\
 87, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[1].d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_a.d", 1,\
 5, 4850, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[1].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_a.T", 1,\
 5, 4851, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[1].p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[2].p", 1, 1, 86, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[2].phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].phase", 1, 5, 4886, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[2].h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].h", 1,\
 1, 171, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[2].d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].d", 1,\
 5, 4887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[2].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 1]", 1,\
 5, 5504, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[2].p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].p", 1,\
 1, 170, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[3].phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].phase", 1, 5, 4889, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[3].h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].h", 1,\
 1, 173, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[3].d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].d", 1,\
 5, 4890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[3].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 2]", 1,\
 5, 5505, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[3].p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].p", 1,\
 1, 172, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[4].phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].phase", 1, 5, 4892, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[4].h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].h", 1,\
 1, 175, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[4].d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].d", 1,\
 5, 4893, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[4].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 3]", 1,\
 5, 5506, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[4].p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].p", 1,\
 1, 174, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[5].phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].phase", 1, 5, 4895, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[5].h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].h", 1,\
 1, 177, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[5].d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].d", 1,\
 5, 4896, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[5].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 4]", 1,\
 5, 5507, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[5].p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].p", 1,\
 1, 176, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[6].phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[6].h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].h", 1,\
 1, 81, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[6].d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_b.d", 1,\
 5, 4853, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[6].T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_b.T", 1,\
 5, 4854, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.states[6].p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].p", 1, 1, 80,\
 0)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[1].k",\
 "Gain [1]", 866, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[1].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[1].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[1].y_start",\
 "Initial or guess value of output (= state)", 867, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[1].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[1].y",\
 "Connector of Real output signal", 178, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[1].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[2].k",\
 "Gain [1]", 868, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[2].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[2].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[2].y_start",\
 "Initial or guess value of output (= state)", 869, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[2].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[2].y",\
 "Connector of Real output signal", 179, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[2].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[3].k",\
 "Gain [1]", 870, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[3].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[3].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[3].y_start",\
 "Initial or guess value of output (= state)", 871, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[3].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[3].y",\
 "Connector of Real output signal", 180, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[3].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[4].k",\
 "Gain [1]", 872, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[4].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[4].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[4].y_start",\
 "Initial or guess value of output (= state)", 873, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[4].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[4].y",\
 "Connector of Real output signal", 181, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[4].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[5].k",\
 "Gain [1]", 874, 1, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[5].T",\
 "Time Constant [s]", 1, 0.0,0.0,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[5].initType",\
 "Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[5].y_start",\
 "Initial or guess value of output (= state)", 875, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[5].u",\
 "Connector of Real input signal", 0.0, 0.0,0.0,0.0,0,513)
DeclareState("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[5].y",\
 "Connector of Real output signal", 182, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.firstOrder_dps_K[5].der(y)",\
 "der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.DownComer.mediums[2].h", 1, 1,\
 87, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_a.d", 1,\
 5, 4850, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_a.T", 1,\
 5, 4851, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[2].p", 1, 1, 86, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].h",\
 "Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.DownComer.mediums[2].h", 1,\
 1, 87, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].d",\
 "Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_a.d", 1,\
 5, 4850, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].T",\
 "Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_a.T", 1,\
 5, 4851, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].p",\
 "Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.DownComer.mediums[2].p", 1, 1,\
 86, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].mu",\
 "Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[1]", 1,\
 5, 4676, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[1].cp",\
 "Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].phase", 1, 5, 4886, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].h", 1,\
 1, 171, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].d", 1,\
 5, 4887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 1]", 1,\
 5, 5504, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].p", 1,\
 1, 170, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].h",\
 "Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].h", 1,\
 1, 171, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].d",\
 "Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].d", 1,\
 5, 4887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].T",\
 "Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 1]", 1,\
 5, 5504, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].p",\
 "Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[1].p", 1,\
 1, 170, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].mu",\
 "Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[2]", 1,\
 5, 4677, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[2].cp",\
 "Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].phase", 1, 5, 4889, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].h", 1,\
 1, 173, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].d", 1,\
 5, 4890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 2]", 1,\
 5, 5505, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].p", 1,\
 1, 172, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].h",\
 "Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].h", 1,\
 1, 173, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].d",\
 "Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].d", 1,\
 5, 4890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].T",\
 "Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 2]", 1,\
 5, 5505, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].p",\
 "Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[2].p", 1,\
 1, 172, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].mu",\
 "Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[3]", 1,\
 5, 4678, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[3].cp",\
 "Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].phase", 1, 5, 4892, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].h", 1,\
 1, 175, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].d", 1,\
 5, 4893, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 3]", 1,\
 5, 5506, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].p", 1,\
 1, 174, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].h",\
 "Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].h", 1,\
 1, 175, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].d",\
 "Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].d", 1,\
 5, 4893, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].T",\
 "Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 3]", 1,\
 5, 5506, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].p",\
 "Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[3].p", 1,\
 1, 174, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].mu",\
 "Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[4]", 1,\
 5, 4679, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[4].cp",\
 "Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].phase", 1, 5, 4895, 66)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].h", 1,\
 1, 177, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].d", 1,\
 5, 4896, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 4]", 1,\
 5, 5507, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].p", 1,\
 1, 176, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].h",\
 "Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].h", 1,\
 1, 177, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].d",\
 "Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].d", 1,\
 5, 4896, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].T",\
 "Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 4]", 1,\
 5, 5507, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].p",\
 "Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.core.coolantSubchannel.mediums[4].p", 1,\
 1, 176, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].mu",\
 "Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[5]", 1,\
 5, 4680, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[5].cp",\
 "Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].state.phase",\
 "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 0, 0.0,2.0,0.0,0,517)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].state.h",\
 "Specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].h", 1,\
 1, 81, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].state.d",\
 "Density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_b.d", 1,\
 5, 4853, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].state.T",\
 "Temperature [K|degC]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_b.T", 1,\
 5, 4854, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].state.p",\
 "Pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].p", 1, 1, 80,\
 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].h",\
 "Fluid specific enthalpy [J/kg]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].h", 1,\
 1, 81, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].d",\
 "Fluid density [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_b.d", 1,\
 5, 4853, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].T",\
 "Fluid temperature [K|degC]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_b.T", 1,\
 5, 4854, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].p",\
 "Fluid pressure [Pa|bar]", "nuScale_Tave_enthalpy.Lower_Riser.mediums[1].p", 1,\
 1, 80, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].mu",\
 "Dynamic viscosity [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_b[5]", 1,\
 5, 4681, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].lambda",\
 "Thermal conductivity [W/(m.K)]", 1, 0.0,500.0,1.0,0,512)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mediaProps[6].cp",\
 "Specific heat capacity [J/(kg.K)]", 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[1]", 1,\
 5, 4911, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[1]", 1,\
 5, 4911, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].length",\
 "Length of pipe [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dlengthsFM[1]", 1,\
 5, 4901, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[1].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[1]", 1,\
 5, 4911, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[3]", 1,\
 5, 4912, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].length",\
 "Length of pipe [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dlengthsFM[2]", 1,\
 5, 4902, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[2].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[3]", 1,\
 5, 4912, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[4]", 1,\
 5, 4913, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].length",\
 "Length of pipe [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dlengthsFM[3]", 1,\
 5, 4903, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[3].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[4]", 1,\
 5, 4913, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[5]", 1,\
 5, 4914, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].length",\
 "Length of pipe [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dlengthsFM[4]", 1,\
 5, 4904, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[4].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].diameter_a",\
 "Inner (hydraulic) diameter at port_a [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[5]", 1,\
 5, 4914, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].diameter_b",\
 "Inner (hydraulic) diameter at port_b [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dimensionsFM[5]", 1,\
 5, 4914, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].crossArea_a",\
 "Inner cross section area at port_a [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].crossArea_b",\
 "Inner cross section area at port_b [m2]", "nuScale_Tave_enthalpy.core.geometry.crossArea", 1,\
 5, 3959, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].length",\
 "Length of pipe [m]", "nuScale_Tave_enthalpy.core.coolantSubchannel.dlengthsFM[5]", 1,\
 5, 4905, 0)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].roughness_a",\
 "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].roughness_b",\
 "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_con[5].Re_turbulent",\
 "Turbulent transition point if Re >= Re_turbulent [1]", 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[1].rho_a",\
 "Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_a.d", 1,\
 5, 4850, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[1].rho_b",\
 "Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].d", 1,\
 5, 4887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[1].mu_a",\
 "Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[1]", 1,\
 5, 4676, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[1].mu_b",\
 "Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[2]", 1,\
 5, 4677, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[2].rho_a",\
 "Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[2].d", 1,\
 5, 4887, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[2].rho_b",\
 "Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].d", 1,\
 5, 4890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[2].mu_a",\
 "Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[2]", 1,\
 5, 4677, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[2].mu_b",\
 "Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[3]", 1,\
 5, 4678, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[3].rho_a",\
 "Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[3].d", 1,\
 5, 4890, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[3].rho_b",\
 "Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].d", 1,\
 5, 4893, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[3].mu_a",\
 "Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[3]", 1,\
 5, 4678, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[3].mu_b",\
 "Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[4]", 1,\
 5, 4679, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[4].rho_a",\
 "Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[4].d", 1,\
 5, 4893, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[4].rho_b",\
 "Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].d", 1,\
 5, 4896, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[4].mu_a",\
 "Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[4]", 1,\
 5, 4679, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[4].mu_b",\
 "Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[5]", 1,\
 5, 4680, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[5].rho_a",\
 "Density at port_a [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.statesFM[5].d", 1,\
 5, 4896, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[5].rho_b",\
 "Density at port_b [kg/m3|g/cm3]", "nuScale_Tave_enthalpy.core.coolantSubchannel.state_b.d", 1,\
 5, 4853, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[5].mu_a",\
 "Dynamic viscosity at port_a [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_a[5]", 1,\
 5, 4680, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.IN_var[5].mu_b",\
 "Dynamic viscosity at port_b [Pa.s]", "nuScale_Tave_enthalpy.core.coolantSubchannel.flowModel.mus_b[5]", 1,\
 5, 4681, 0)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD2.port[1].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_1.solutionMethod.Ts[3, 4]", 1,\
 1, 37, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD2.port[1].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0, \
0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD2.port[2].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_2.solutionMethod.Ts[2, 4]", 1,\
 1, 41, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD2.port[2].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0, \
0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD2.port[3].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_2.solutionMethod.Ts[3, 4]", 1,\
 1, 45, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD2.port[3].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0, \
0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD4.port[1].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_2.solutionMethod.Ts[3, 4]", 1,\
 1, 45, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD4.port[1].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0, \
0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD4.port[2].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[2, 4]", 1,\
 1, 49, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD4.port[2].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0, \
0.0,0.0,0.0,0,777)
DeclareAlias2("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD4.port[3].T", \
"Port temperature [K|degC]", "nuScale_Tave_enthalpy.core.fuelModel.region_3.solutionMethod.Ts[3, 4]", 1,\
 5, 5507, 4)
DeclareVariable("nuScale_Tave_enthalpy.core.fuelModel.adiabatic_FD4.port[3].Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0, \
0.0,0.0,0.0,0,777)
DeclareState("EM.pipe_b2.mediums[1].p", "Absolute pressure of medium [Pa|bar]", 183,\
 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("EM.pipe_b2.mediums[1].der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("EM.pipe_b2.mediums[1].h", "Specific enthalpy of medium [J/kg]", 184,\
 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("EM.pipe_b2.mediums[1].der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_b2.mediums[1].d", "Density of medium [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.mediums[1].T", "Temperature of medium [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareVariable("EM.pipe_b2.mediums[1].X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("EM.pipe_b2.mediums[1].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("EM.pipe_b2.mediums[1].der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.mediums[1].R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("EM.pipe_b2.mediums[1].MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareAlias2("EM.pipe_b2.mediums[1].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.mediums[1].state.h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.mediums[1].state.d", "Density [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.mediums[1].state.T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.mediums[1].state.p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareVariable("EM.pipe_b2.mediums[1].preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.mediums[1].standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.mediums[1].T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.mediums[1].p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_b2.mediums[1].sat.psat", "Saturation pressure [Pa|bar]", \
"EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareVariable("EM.pipe_b2.mediums[1].sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_b2.mediums[1].phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareState("EM.pipe_b2.mediums[2].p", "Absolute pressure of medium [Pa|bar]", 185,\
 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("EM.pipe_b2.mediums[2].der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("EM.pipe_b2.mediums[2].h", "Specific enthalpy of medium [J/kg]", 186,\
 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("EM.pipe_b2.mediums[2].der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_b2.mediums[2].d", "Density of medium [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.mediums[2].T", "Temperature of medium [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareVariable("EM.pipe_b2.mediums[2].X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("EM.pipe_b2.mediums[2].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("EM.pipe_b2.mediums[2].der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.mediums[2].R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("EM.pipe_b2.mediums[2].MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareAlias2("EM.pipe_b2.mediums[2].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.mediums[2].state.h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.mediums[2].state.d", "Density [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.mediums[2].state.T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.mediums[2].state.p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareVariable("EM.pipe_b2.mediums[2].preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.mediums[2].standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_b2.mediums[2].T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_b2.mediums[2].p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_b2.mediums[2].sat.psat", "Saturation pressure [Pa|bar]", \
"EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareVariable("EM.pipe_b2.mediums[2].sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_b2.mediums[2].phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.flowModel.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.flowModel.states[1].h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.flowModel.states[1].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.flowModel.states[1].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.flowModel.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.flowModel.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.flowModel.states[2].h", "Specific enthalpy [J/kg]", \
"EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.flowModel.states[2].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.flowModel.states[2].T", "Temperature [K|degC]", \
"EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.flowModel.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareParameter("EM.pipe_b2.flowModel.firstOrder_dps_K[1].k", "Gain [1]", 876, 1,\
 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_b2.flowModel.firstOrder_dps_K[1].T", "Time Constant [s]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.firstOrder_dps_K[1].initType", \
"Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("EM.pipe_b2.flowModel.firstOrder_dps_K[1].y_start", \
"Initial or guess value of output (= state)", 877, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_b2.flowModel.firstOrder_dps_K[1].u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareState("EM.pipe_b2.flowModel.firstOrder_dps_K[1].y", "Connector of Real output signal",\
 187, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("EM.pipe_b2.flowModel.firstOrder_dps_K[1].der(y)", \
"der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[1].phase", 1, 5, 6033, 66)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].state.T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[1].h", 1, 1, 184, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].T", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[1, 1]", 1, 5, 6019, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[1].p", 1, 1, 183, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[1].mu", "Dynamic viscosity [Pa.s]",\
 "EM.pipe_b2.flowModel.mus_a[1]", 1, 5, 5906, 0)
DeclareVariable("EM.pipe_b2.flowModel.mediaProps[1].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_b2.flowModel.mediaProps[1].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_b2.statesFM[2].phase", 1, 5, 6036, 66)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].state.T", "Temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_b2.mediums[2].h", 1, 1, 186, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].T", "Fluid temperature [K|degC]",\
 "EM.pipe_b2.Ts_wall[2, 1]", 1, 5, 6020, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_b2.mediums[2].p", 1, 1, 185, 0)
DeclareAlias2("EM.pipe_b2.flowModel.mediaProps[2].mu", "Dynamic viscosity [Pa.s]",\
 "EM.pipe_b2.flowModel.mus_b[1]", 1, 5, 5907, 0)
DeclareVariable("EM.pipe_b2.flowModel.mediaProps[2].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_b2.flowModel.mediaProps[2].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_b2.flowModel.IN_con[1].diameter_a", "Inner (hydraulic) diameter at port_a [m]",\
 "EM.pipe_b2.dimensionsFM[1]", 1, 5, 6041, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_con[1].diameter_b", "Inner (hydraulic) diameter at port_b [m]",\
 "EM.pipe_b2.dimensionsFM[2]", 1, 5, 6042, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_con[1].crossArea_a", "Inner cross section area at port_a [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_con[1].crossArea_b", "Inner cross section area at port_b [m2]",\
 "EM.pipe_b2.crossAreasFM[1]", 1, 5, 6043, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_con[1].length", "Length of pipe [m]", \
"EM.pipe_b2.dlengthsFM[1]", 1, 5, 6039, 0)
DeclareVariable("EM.pipe_b2.flowModel.IN_con[1].roughness_a", "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.IN_con[1].roughness_b", "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_b2.flowModel.IN_con[1].Re_turbulent", "Turbulent transition point if Re >= Re_turbulent [1]",\
 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var[1].rho_a", "Density at port_a [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[1].d", 1, 5, 6034, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var[1].rho_b", "Density at port_b [kg/m3|g/cm3]",\
 "EM.pipe_b2.statesFM[2].d", 1, 5, 6037, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var[1].mu_a", "Dynamic viscosity at port_a [Pa.s]",\
 "EM.pipe_b2.flowModel.mus_a[1]", 1, 5, 5906, 0)
DeclareAlias2("EM.pipe_b2.flowModel.IN_var[1].mu_b", "Dynamic viscosity at port_b [Pa.s]",\
 "EM.pipe_b2.flowModel.mus_b[1]", 1, 5, 5907, 0)
EndNonAlias(7)
PreNonAliasNew(8)
StartNonAlias(8)
DeclareState("EM.pipe_a2.mediums[1].p", "Absolute pressure of medium [Pa|bar]", 188,\
 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("EM.pipe_a2.mediums[1].der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("EM.pipe_a2.mediums[1].h", "Specific enthalpy of medium [J/kg]", 189,\
 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("EM.pipe_a2.mediums[1].der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_a2.mediums[1].d", "Density of medium [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.mediums[1].T", "Temperature of medium [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareVariable("EM.pipe_a2.mediums[1].X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("EM.pipe_a2.mediums[1].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("EM.pipe_a2.mediums[1].der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.mediums[1].R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("EM.pipe_a2.mediums[1].MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareAlias2("EM.pipe_a2.mediums[1].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.mediums[1].state.h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.mediums[1].state.d", "Density [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.mediums[1].state.T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.mediums[1].state.p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareVariable("EM.pipe_a2.mediums[1].preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.mediums[1].standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.mediums[1].T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.mediums[1].p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_a2.mediums[1].sat.psat", "Saturation pressure [Pa|bar]", \
"EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareVariable("EM.pipe_a2.mediums[1].sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_a2.mediums[1].phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareState("EM.pipe_a2.mediums[2].p", "Absolute pressure of medium [Pa|bar]", 190,\
 100000.0, 611.657,100000000.0,100000.0,0,544)
DeclareDerivative("EM.pipe_a2.mediums[2].der(p)", "der(Absolute pressure of medium) [Pa/s]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareState("EM.pipe_a2.mediums[2].h", "Specific enthalpy of medium [J/kg]", 191,\
 0.0, -10000000000.0,10000000000.0,500000.0,0,544)
DeclareDerivative("EM.pipe_a2.mediums[2].der(h)", "der(Specific enthalpy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_a2.mediums[2].d", "Density of medium [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.mediums[2].T", "Temperature of medium [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareVariable("EM.pipe_a2.mediums[2].X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,513)
DeclareVariable("EM.pipe_a2.mediums[2].u", "Specific internal energy of medium [J/kg]",\
 0.0, -100000000.0,100000000.0,1000000.0,0,512)
DeclareVariable("EM.pipe_a2.mediums[2].der(u)", "der(Specific internal energy of medium) [m2/s3]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.mediums[2].R_s", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 461.5231157345669, 0.0,10000000.0,1000.0,0,513)
DeclareVariable("EM.pipe_a2.mediums[2].MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.001,0.25,0.032,0,513)
DeclareAlias2("EM.pipe_a2.mediums[2].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.mediums[2].state.h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.mediums[2].state.d", "Density [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.mediums[2].state.T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.mediums[2].state.p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareVariable("EM.pipe_a2.mediums[2].preferredMediumStates", "= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.mediums[2].standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareVariable("EM.pipe_a2.mediums[2].T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("EM.pipe_a2.mediums[2].p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_a2.mediums[2].sat.psat", "Saturation pressure [Pa|bar]", \
"EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareVariable("EM.pipe_a2.mediums[2].sat.Tsat", "Saturation temperature [K|degC]",\
 500, 273.15,2273.15,500.0,0,512)
DeclareAlias2("EM.pipe_a2.mediums[2].phase", "2 for two-phase, 1 for one-phase, 0 if not known [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.flowModel.states[1].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.flowModel.states[1].h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.flowModel.states[1].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.flowModel.states[1].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.flowModel.states[1].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.flowModel.states[2].phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.flowModel.states[2].h", "Specific enthalpy [J/kg]", \
"EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.flowModel.states[2].d", "Density [kg/m3|g/cm3]", \
"EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.flowModel.states[2].T", "Temperature [K|degC]", \
"EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.flowModel.states[2].p", "Pressure [Pa|bar]", \
"EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareParameter("EM.pipe_a2.flowModel.firstOrder_dps_K[1].k", "Gain [1]", 878, 1,\
 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_a2.flowModel.firstOrder_dps_K[1].T", "Time Constant [s]",\
 1, 0.0,0.0,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.firstOrder_dps_K[1].initType", \
"Type of initialization (1: no init, 2: steady state, 3/4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 4, 1.0,4.0,0.0,0,517)
DeclareParameter("EM.pipe_a2.flowModel.firstOrder_dps_K[1].y_start", \
"Initial or guess value of output (= state)", 879, 0, 0.0,0.0,0.0,0,560)
DeclareVariable("EM.pipe_a2.flowModel.firstOrder_dps_K[1].u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareState("EM.pipe_a2.flowModel.firstOrder_dps_K[1].y", "Connector of Real output signal",\
 192, 0.0, 0.0,0.0,0.0,0,544)
DeclareDerivative("EM.pipe_a2.flowModel.firstOrder_dps_K[1].der(y)", \
"der(Connector of Real output signal)", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[1].phase", 1, 5, 6273, 66)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].state.T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[1].h", 1, 1, 189, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].T", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[1, 1]", 1, 5, 6259, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[1].p", 1, 1, 188, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[1].mu", "Dynamic viscosity [Pa.s]",\
 "EM.pipe_a2.flowModel.mus_a[1]", 1, 5, 6146, 0)
DeclareVariable("EM.pipe_a2.flowModel.mediaProps[1].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_a2.flowModel.mediaProps[1].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].state.phase", "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use [:#(type=Integer)]",\
 "EM.pipe_a2.statesFM[2].phase", 1, 5, 6276, 66)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].state.h", "Specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].state.d", "Density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].state.T", "Temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].state.p", "Pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].h", "Fluid specific enthalpy [J/kg]",\
 "EM.pipe_a2.mediums[2].h", 1, 1, 191, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].d", "Fluid density [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].T", "Fluid temperature [K|degC]",\
 "EM.pipe_a2.Ts_wall[2, 1]", 1, 5, 6260, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].p", "Fluid pressure [Pa|bar]",\
 "EM.pipe_a2.mediums[2].p", 1, 1, 190, 0)
DeclareAlias2("EM.pipe_a2.flowModel.mediaProps[2].mu", "Dynamic viscosity [Pa.s]",\
 "EM.pipe_a2.flowModel.mus_b[1]", 1, 5, 6147, 0)
DeclareVariable("EM.pipe_a2.flowModel.mediaProps[2].lambda", "Thermal conductivity [W/(m.K)]",\
 1, 0.0,500.0,1.0,0,512)
DeclareVariable("EM.pipe_a2.flowModel.mediaProps[2].cp", "Specific heat capacity [J/(kg.K)]",\
 1000.0, 0.0,10000000.0,1000.0,0,512)
DeclareAlias2("EM.pipe_a2.flowModel.IN_con[1].diameter_a", "Inner (hydraulic) diameter at port_a [m]",\
 "EM.pipe_a2.dimensionsFM[1]", 1, 5, 6281, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_con[1].diameter_b", "Inner (hydraulic) diameter at port_b [m]",\
 "EM.pipe_a2.dimensionsFM[2]", 1, 5, 6282, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_con[1].crossArea_a", "Inner cross section area at port_a [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_con[1].crossArea_b", "Inner cross section area at port_b [m2]",\
 "EM.pipe_a2.crossAreasFM[1]", 1, 5, 6283, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_con[1].length", "Length of pipe [m]", \
"EM.pipe_a2.dlengthsFM[1]", 1, 5, 6279, 0)
DeclareVariable("EM.pipe_a2.flowModel.IN_con[1].roughness_a", "Absolute roughness of pipe at port_a, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.IN_con[1].roughness_b", "Absolute roughness of pipe at port_b, with a default for a smooth steel pipe [m]",\
 2.5E-05, 0.0,1E+100,0.0,0,513)
DeclareVariable("EM.pipe_a2.flowModel.IN_con[1].Re_turbulent", "Turbulent transition point if Re >= Re_turbulent [1]",\
 4000, 0.0,0.0,0.0,0,513)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var[1].rho_a", "Density at port_a [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[1].d", 1, 5, 6274, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var[1].rho_b", "Density at port_b [kg/m3|g/cm3]",\
 "EM.pipe_a2.statesFM[2].d", 1, 5, 6277, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var[1].mu_a", "Dynamic viscosity at port_a [Pa.s]",\
 "EM.pipe_a2.flowModel.mus_a[1]", 1, 5, 6146, 0)
DeclareAlias2("EM.pipe_a2.flowModel.IN_var[1].mu_b", "Dynamic viscosity at port_b [Pa.s]",\
 "EM.pipe_a2.flowModel.mus_b[1]", 1, 5, 6147, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.I.u", "Connector of Real input signal", \
0.0, 0.0,0.0,0.0,0,512)
DeclareState("BOP.CS.PID_TCV_opening.I.y", "Connector of Real output signal", 193,\
 0.0, 0.0,0.0,0.0,0,560)
DeclareDerivative("BOP.CS.PID_TCV_opening.I.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_TCV_opening.I.k", "Integrator gain [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_TCV_opening.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_TCV_opening.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_TCV_opening.I.y_reset_internal", "Internal connector for integrator reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.CS.PID_TCV_opening.I.trigger_internal", "Needed to use conditional connector trigger [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("BOP.CS.PID_TCV_opening.addI.k1", "Gain of input signal 1", 880,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.addI.k2", "Gain of input signal 2", 881,\
 -1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.addI.k3", "Gain of input signal 3", 882,\
 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_TCV_opening.addI.u1", "Connector of Real input signal 1 [Pa]",\
 "BOP.CS.PID_TCV_opening.addP.u1", 1, 5, 6311, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addI.u2", "Connector of Real input signal 2 [Pa]",\
 "BOP.CS.PID_TCV_opening.addP.u2", 1, 5, 6312, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.addI.u3", "Connector of Real input signal 3",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.CS.PID_TCV_opening.addI.y", "Connector of Real output signal",\
 "BOP.CS.PID_TCV_opening.I.u", 1, 5, 8579, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addSat.u1", "Connector of Real input signal 1",\
 "BOP.CS.PID_TCV_opening.y", 1, 5, 6299, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.addSat.u2", "Connector of Real input signal 2",\
 "BOP.CS.PID_TCV_opening.limiter.u", 1, 5, 6323, 0)
DeclareVariable("BOP.CS.PID_TCV_opening.addSat.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("BOP.CS.PID_TCV_opening.addSat.k1", "Gain of input signal 1", 883,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_TCV_opening.addSat.k2", "Gain of input signal 2", 884,\
 -1, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.PID_TCV_opening.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_TCV_opening.gainTrack.u", "Input signal connector", \
"BOP.CS.PID_TCV_opening.addSat.y", 1, 5, 8588, 0)
DeclareAlias2("BOP.CS.PID_TCV_opening.gainTrack.y", "Output signal connector", \
"BOP.CS.PID_TCV_opening.addI.u3", 1, 5, 8587, 0)
DeclareParameter("BOP.CS.PID_TCV_opening.Dzero.k", "Constant output value", 885,\
 0, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_TCV_opening.Dzero.y", "Connector of Real output signal",\
 "BOP.CS.PID_TCV_opening.Dzero.k", 1, 7, 885, 0)
DeclareVariable("BOP.CS.PID_BV_opening.I.u", "Connector of Real input signal", \
0.0, 0.0,0.0,0.0,0,512)
DeclareState("BOP.CS.PID_BV_opening.I.y", "Connector of Real output signal", 194,\
 0.0, 0.0,0.0,0.0,0,560)
DeclareDerivative("BOP.CS.PID_BV_opening.I.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.CS.PID_BV_opening.I.k", "Integrator gain [1]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_BV_opening.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.CS.PID_BV_opening.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.CS.PID_BV_opening.I.y_reset_internal", "Internal connector for integrator reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.CS.PID_BV_opening.I.trigger_internal", "Needed to use conditional connector trigger [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("BOP.CS.PID_BV_opening.addI.k1", "Gain of input signal 1", 886,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.addI.k2", "Gain of input signal 2", 887,\
 -1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.addI.k3", "Gain of input signal 3", 888,\
 1, 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_BV_opening.addI.u1", "Connector of Real input signal 1 [W]",\
 "BOP.CS.PID_BV_opening.addP.u1", 1, 5, 6345, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addI.u2", "Connector of Real input signal 2 [W]",\
 "BOP.CS.PID_BV_opening.addP.u2", 1, 5, 6346, 0)
DeclareVariable("BOP.CS.PID_BV_opening.addI.u3", "Connector of Real input signal 3",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.CS.PID_BV_opening.addI.y", "Connector of Real output signal",\
 "BOP.CS.PID_BV_opening.I.u", 1, 5, 8590, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addSat.u1", "Connector of Real input signal 1",\
 "BOP.CS.switch_BV.u1", 1, 5, 6291, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.addSat.u2", "Connector of Real input signal 2",\
 "BOP.CS.PID_BV_opening.limiter.u", 1, 5, 6357, 0)
DeclareVariable("BOP.CS.PID_BV_opening.addSat.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareParameter("BOP.CS.PID_BV_opening.addSat.k1", "Gain of input signal 1", 889,\
 1, 0.0,0.0,0.0,0,560)
DeclareParameter("BOP.CS.PID_BV_opening.addSat.k2", "Gain of input signal 2", 890,\
 -1, 0.0,0.0,0.0,0,560)
DeclareVariable("BOP.CS.PID_BV_opening.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.CS.PID_BV_opening.gainTrack.u", "Input signal connector", \
"BOP.CS.PID_BV_opening.addSat.y", 1, 5, 8599, 0)
DeclareAlias2("BOP.CS.PID_BV_opening.gainTrack.y", "Output signal connector", \
"BOP.CS.PID_BV_opening.addI.u3", 1, 5, 8598, 0)
DeclareParameter("BOP.CS.PID_BV_opening.Dzero.k", "Constant output value", 891, 0,\
 0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.CS.PID_BV_opening.Dzero.y", "Connector of Real output signal",\
 "BOP.CS.PID_BV_opening.Dzero.k", 1, 7, 891, 0)
DeclareVariable("BOP.PID.I.u", "Connector of Real input signal", 0.0, 0.0,0.0,\
0.0,0,512)
DeclareState("BOP.PID.I.y", "Connector of Real output signal", 195, 0.0, \
0.0,0.0,0.0,0,560)
DeclareDerivative("BOP.PID.I.der(y)", "der(Connector of Real output signal)", \
0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID.I.k", "Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.PID.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID.I.y_reset_internal", "Internal connector for integrator reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.PID.I.trigger_internal", "Needed to use conditional connector trigger [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("BOP.PID.addI.k1", "Gain of input signal 1", 892, 1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.addI.k2", "Gain of input signal 2", 893, -1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.addI.k3", "Gain of input signal 3", 894, 1, 0.0,0.0,\
0.0,0,560)
DeclareAlias2("BOP.PID.addI.u1", "Connector of Real input signal 1 [K]", \
"BOP.PID.addP.u1", 1, 5, 6606, 0)
DeclareAlias2("BOP.PID.addI.u2", "Connector of Real input signal 2 [K]", \
"BOP.PID.addP.u2", 1, 5, 6607, 0)
DeclareVariable("BOP.PID.addI.u3", "Connector of Real input signal 3", 0.0, \
0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.PID.addI.y", "Connector of Real output signal", "BOP.PID.I.u", 1,\
 5, 8601, 0)
DeclareAlias2("BOP.PID.addSat.u1", "Connector of Real input signal 1 [W]", \
"BOP.feedWaterHeater.Q_flow_internal", 1, 5, 6590, 0)
DeclareAlias2("BOP.PID.addSat.u2", "Connector of Real input signal 2 [W]", \
"BOP.PID.limiter.u", 1, 5, 6618, 0)
DeclareVariable("BOP.PID.addSat.y", "Connector of Real output signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareParameter("BOP.PID.addSat.k1", "Gain of input signal 1", 895, 1, 0.0,0.0,\
0.0,0,560)
DeclareParameter("BOP.PID.addSat.k2", "Gain of input signal 2", 896, -1, \
0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID.gainTrack.u", "Input signal connector", "BOP.PID.addSat.y", 1,\
 5, 8610, 0)
DeclareAlias2("BOP.PID.gainTrack.y", "Output signal connector", "BOP.PID.addI.u3", 1,\
 5, 8609, 0)
DeclareParameter("BOP.PID.Dzero.k", "Constant output value", 897, 0, 0.0,0.0,0.0,\
0,560)
DeclareAlias2("BOP.PID.Dzero.y", "Connector of Real output signal", \
"BOP.PID.Dzero.k", 1, 7, 897, 0)
DeclareVariable("BOP.PID1.PID.I.u", "Connector of Real input signal", 0.0, \
0.0,0.0,0.0,0,512)
DeclareState("BOP.PID1.PID.I.y", "Connector of Real output signal", 196, 0.0, \
0.0,0.0,0.0,0,560)
DeclareDerivative("BOP.PID1.PID.I.der(y)", "der(Connector of Real output signal)",\
 0.0, 0.0,0.0,0.0,0,512)
DeclareVariable("BOP.PID1.PID.I.k", "Integrator gain [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.I.initType", "Type of initialization (1: no init, 2: steady state, 3,4: initial output) [:#(type=Modelica.Blocks.Types.Init)]",\
 1, 1.0,4.0,0.0,0,517)
DeclareVariable("BOP.PID1.PID.I.y_start", "Initial or guess value of output (= state)",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.I.reset", "Type of integrator reset [:#(type=TRANSFORM.Types.Reset)]",\
 1, 1.0,3.0,0.0,0,517)
DeclareVariable("BOP.PID1.PID.I.y_reset", "Value to which integrator is reset, used if reset = TRANSFORM.Types.Reset.Parameter",\
 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("BOP.PID1.PID.I.y_reset_internal", "Internal connector for integrator reset",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("BOP.PID1.PID.I.trigger_internal", "Needed to use conditional connector trigger [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("BOP.PID1.PID.addI.k1", "Gain of input signal 1", 898, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.addI.k2", "Gain of input signal 2", 899, -1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.addI.k3", "Gain of input signal 3", 900, 1, \
0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.PID1.PID.addI.u1", "Connector of Real input signal 1 [m]", \
"BOP.PID1.PID.addP.u1", 1, 5, 6851, 0)
DeclareAlias2("BOP.PID1.PID.addI.u2", "Connector of Real input signal 2 [m]", \
"BOP.PID1.PID.addP.u2", 1, 5, 6852, 0)
DeclareVariable("BOP.PID1.PID.addI.u3", "Connector of Real input signal 3", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareAlias2("BOP.PID1.PID.addI.y", "Connector of Real output signal", \
"BOP.PID1.PID.I.u", 1, 5, 8612, 0)
DeclareAlias2("BOP.PID1.PID.addSat.u1", "Connector of Real input signal 1 [kg/s]",\
 "BOP.PID1.PID.y", 1, 5, 6827, 0)
DeclareAlias2("BOP.PID1.PID.addSat.u2", "Connector of Real input signal 2 [kg/s]",\
 "BOP.PID1.PID.limiter.u", 1, 5, 6863, 0)
DeclareVariable("BOP.PID1.PID.addSat.y", "Connector of Real output signal", 0.0,\
 0.0,0.0,0.0,0,512)
DeclareParameter("BOP.PID1.PID.addSat.k1", "Gain of input signal 1", 901, 1, \
0.0,0.0,0.0,0,560)
DeclareParameter("BOP.PID1.PID.addSat.k2", "Gain of input signal 2", 902, -1, \
0.0,0.0,0.0,0,560)
DeclareVariable("BOP.PID1.PID.gainTrack.k", "Gain value multiplied with input signal [1]",\
 1, 0.0,0.0,0.0,0,513)
DeclareAlias2("BOP.PID1.PID.gainTrack.u", "Input signal connector", \
"BOP.PID1.PID.addSat.y", 1, 5, 8621, 0)
DeclareAlias2("BOP.PID1.PID.gainTrack.y", "Output signal connector", \
"BOP.PID1.PID.addI.u3", 1, 5, 8620, 0)
DeclareParameter("BOP.PID1.PID.Dzero.k", "Constant output value", 903, 0, \
0.0,0.0,0.0,0,560)
DeclareAlias2("BOP.PID1.PID.Dzero.y", "Connector of Real output signal", \
"BOP.PID1.PID.Dzero.k", 1, 7, 903, 0)
DeclareAlias2("nuScale_Tave_enthalpy.CS.actuatorBus.mfeedpump", "Connector of actuator output signal [kg/s]",\
 "nuScale_Tave_enthalpy.port_a.m_flow", 1, 5, 173, 4)
DeclareAlias2("nuScale_Tave_enthalpy.CS.sensorBus.T_exit_SG", "Connector of second Real input signal [K]",\
 "nuScale_Tave_enthalpy.temperature3.T", 1, 5, 3890, 4)
DeclareAlias2("nuScale_Tave_enthalpy.actuatorBus.mfeedpump", "[kg/s]", \
"nuScale_Tave_enthalpy.port_a.m_flow", 1, 5, 173, 4)
DeclareAlias2("nuScale_Tave_enthalpy.sensorBus.SG_Inlet_Enthalpy", \
"Specific enthalpy in port medium [J/kg]", "nuScale_Tave_enthalpy.Feed_Enthalpy.h_out", 1,\
 5, 5679, 4)
DeclareAlias2("nuScale_Tave_enthalpy.sensorBus.SG_Outlet_enthalpy", \
"Specific enthalpy in port medium [J/kg]", "nuScale_Tave_enthalpy.Steam_exit_enthalpy.h_out", 1,\
 5, 5676, 4)
DeclareAlias2("nuScale_Tave_enthalpy.sensorBus.T_exit_SG", "Temperature in port medium [K|degC]",\
 "nuScale_Tave_enthalpy.temperature3.T", 1, 5, 3890, 4)
DeclareVariable("SY.sensorBus.W_EG", "Power flowing from port_a to port_b [W]", \
0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SY.sensorBus.W_SY", "Power flowing from port_a to port_b [W]", \
0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("EG.sensorBus.Q_balance", "Value of Real output", 0.0, 0.0,0.0,\
0.0,0,521)
DeclareVariable("EG.sensorBus.W_balance", "Value of Real output", 0.0, 0.0,0.0,\
0.0,0,521)
DeclareAlias2("SES.CS.actuatorBus.GTPP.m_flow_fuel_pu", "Connector of Real output signal [1]",\
 "SES.limiter_VCE.u", 1, 5, 7842, 4)
DeclareAlias2("SES.actuatorBus.GTPP.m_flow_fuel_pu", "Connector of Real input signal [1]",\
 "SES.limiter_VCE.u", 1, 5, 7842, 4)
DeclareAlias2("SES.ED.actuatorBus.GTPP.m_flow_fuel_pu", "Connector of Real input signal [1]",\
 "SES.limiter_VCE.u", 1, 5, 7842, 4)
DeclareVariable("EG.CS.sensorBus.Q_balance", "Value of Real output", 0.0, \
0.0,0.0,0.0,0,521)
DeclareVariable("EG.CS.sensorBus.W_balance", "Value of Real output", 0.0, \
0.0,0.0,0.0,0,521)
DeclareVariable("EG.ED.sensorBus.Q_balance", "Value of Real output", 0.0, \
0.0,0.0,0.0,0,521)
DeclareVariable("EG.ED.sensorBus.W_balance", "Value of Real output", 0.0, \
0.0,0.0,0.0,0,521)
DeclareVariable("SY.CS.sensorBus.W_EG", "Power flowing from port_a to port_b [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SY.CS.sensorBus.W_SY", "Power flowing from port_a to port_b [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SY.ED.sensorBus.W_EG", "Power flowing from port_a to port_b [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareVariable("SY.ED.sensorBus.W_SY", "Power flowing from port_a to port_b [W]",\
 0.0, 0.0,0.0,0.0,0,521)
DeclareAlias2("nuScale_Tave_enthalpy.ED.actuatorBus.mfeedpump", "[kg/s]", \
"nuScale_Tave_enthalpy.port_a.m_flow", 1, 5, 173, 4)
DeclareAlias2("nuScale_Tave_enthalpy.CS.sensorBus.SG_Inlet_Enthalpy", \
"Specific enthalpy in port medium [J/kg]", "nuScale_Tave_enthalpy.Feed_Enthalpy.h_out", 1,\
 5, 5679, 4)
DeclareAlias2("nuScale_Tave_enthalpy.CS.sensorBus.SG_Outlet_enthalpy", \
"Specific enthalpy in port medium [J/kg]", "nuScale_Tave_enthalpy.Steam_exit_enthalpy.h_out", 1,\
 5, 5676, 4)
DeclareAlias2("nuScale_Tave_enthalpy.ED.sensorBus.SG_Inlet_Enthalpy", \
"Specific enthalpy in port medium [J/kg]", "nuScale_Tave_enthalpy.Feed_Enthalpy.h_out", 1,\
 5, 5679, 4)
DeclareAlias2("nuScale_Tave_enthalpy.ED.sensorBus.SG_Outlet_enthalpy", \
"Specific enthalpy in port medium [J/kg]", "nuScale_Tave_enthalpy.Steam_exit_enthalpy.h_out", 1,\
 5, 5676, 4)
DeclareAlias2("nuScale_Tave_enthalpy.ED.sensorBus.T_exit_SG", "Temperature in port medium [K|degC]",\
 "nuScale_Tave_enthalpy.temperature3.T", 1, 5, 3890, 4)
EndNonAlias(8)
PreNonAliasNew(9)
