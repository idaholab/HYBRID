
Train ARMA
========================================
 see ./Train_Arma/00README.txt


Problem 1
========================================

The published study showed sensitivities to
  - the economy of scale for the IP: 1.0 and 0.64 
    (<X> for the cash flows belongoing to the IP in file Cash_Flow_input.xml)
  - The CO tax: 0, 15, 20, 50 amd 75 $/ton 
    (Cash Flow 'IP_CO2' in file Cash_Flow_input.xml)

 => The only file stored here is for X=1.0 and CO2 = 0 $/ton
 HYBRun.xml runs a grid evaluation for the 'IP capacity' and the H2 price.

Optimisations of the 'IP capacity' have been shown in the report for differen
   - H2 prices: 1.25, 1.5, 1.75, 2.0 and 3.0 $/kg
     (constant name "PriceH2" in HYBRun_opt_H2_2.xml)
 => The only file stored here is for PriceH2 = 2.0 $/kg
 HYBRun_opt_H2_2.xml runs an optimisation of the IRR variing the 'IP capacity'


Problem 2
========================================

The published study showed sensitivities to
  - the economy of scale for the IP: 1.0 and 0.64 
    (<X> for the cash flows belongoing to the IP in file Cash_Flow_input.xml)
  - The CO tax: 0, 15, 20, 50 amd 75 $/ton 
    (Cash Flow 'IP_CO2' in file Cash_Flow_input.xml)

 => The only file stored here is for X=1.0 and CO2 = 0 $/ton
 HYBRun.xml runs a grid evaluation for the 'IP capacity', the 'Nuclear capacity' and the H2 price.
                (The actual sampled variables are the 'Total CAPEX' and the 'CAPEX split' between the 
                 Nuclear plant and the IP. That is equivalent of sampling 'IP capacity' and 'Nuclear capacity', 
                 but allows for easy implementation of maximum CAPEX)

Optimisations of the 'IP capacity' and 'Nuclear capacity' have been shown in the report for differen
   - H2 prices: 1.25, 1.5, 1.75, 2.0 and 3.0 $/kg
     (constant name "PriceH2" in HYBRun_opt_H2_2.xml)
 => The only file stored here is for PriceH2 = 2.0 $/kg
 HYBRun_opt_H2_2.xml runs an optimisation of the NPV variing the 'Maximum CAPEX' and the 'CAPEX split', 
 i.e. the 'IP capacity' and the 'Nuclear capacity'



