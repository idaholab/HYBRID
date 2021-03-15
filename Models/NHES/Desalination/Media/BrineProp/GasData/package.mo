within NHES.Desalination.Media.BrineProp;
package GasData "Molar masses and ion numbers of gases"
  //TODO: Limits mit in den Record
  /*replaceable record GasConstants
                    extends Modelica.Icons.Record;
                    SI.MolarMass M_salt "Molar Mass in kg/mol";
                    annotation(Documentation(info="<html></html>"));
                  end GasConstants;*/
  //  constant Real[:] MM_gas;
constant Modelica.Units.SI.MolarMass M_CO2=Modelica.Media.IdealGases.SingleGases.CO2.data.MM
  "0.0440095 [kg/mol]";
  constant Integer nM_CO2 = 1 "number of ions per molecule";
constant Modelica.Units.SI.MolarMass M_N2=Modelica.Media.IdealGases.SingleGases.N2.data.MM
  "0.0280134 [kg/mol]";
  constant Integer nM_N2 = 1 "number of ions per molecule";
constant Modelica.Units.SI.MolarMass M_CH4=Modelica.Media.IdealGases.SingleGases.CH4.data.MM
  "0.01604246 [kg/mol]";
  constant Integer nM_CH4 = 1 "number of ions per molecule";
  /*    constant SI.MolarMass M_CO2 = 0.0440095 "[kg/mol]";
                   constant SI.MolarMass M_N2 = 0.0280134 "[kg/mol]";
                 */
  //TODO braucht man die Variablen direkt oder nur indirekt via MM(CO2)
  /* passiert in PartialBrine_Multi_TwoPhase_xgas 
                 if gasNames{1} == "carbondioxide" then
                      constant Real[:] MM_gas = {M_CO2};
                  elseif gasNames{1} == "nitrogen" then
                      constant Real[:] MM_gas = {M_N2};
                  end if;
                  
                 constant Real[:] MM_gas = {
                    M_CO2,M_N2};*/



























  annotation(Documentation(info = ""));
end GasData;
