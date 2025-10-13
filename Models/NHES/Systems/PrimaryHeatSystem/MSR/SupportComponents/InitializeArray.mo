within NHES.Systems.PrimaryHeatSystem.MSR.SupportComponents;
function InitializeArray
  input Integer n "Size of output array";
  input Real valNominal "Nominal value of array";
  input Integer iNonNominal[:] "Indices not equal to the nominal value";
  input Real valNonNominal[size(iNonNominal,1)] "Indice values not equal to the nominal value";
  output Real y[n] "Output array";
protected
  Integer nNonNominal = size(iNonNominal,1);

algorithm

  y :=fill(valNominal, n);
  for i in 1:nNonNominal loop
  y[iNonNominal[i]] :=valNonNominal[i];
  end for;

  annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">InitializeArray(5,&nbsp;1,&nbsp;{2,4},&nbsp;{3,8});</span></p>
<p><span style=\"font-family: Courier New;\">&nbsp;=&nbsp;{1.0,&nbsp;3.0,&nbsp;1.0,&nbsp;8.0,&nbsp;1.0}</span></p>
</html>"));
end InitializeArray;
