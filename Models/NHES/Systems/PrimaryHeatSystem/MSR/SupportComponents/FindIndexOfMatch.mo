within NHES.Systems.PrimaryHeatSystem.MSR.SupportComponents;
function FindIndexOfMatch
  input Integer value "Search value";
  input Integer list[:] "List to be searched";
  output Integer y "Index of value in list. Return = 0 indicats not found";

protected
  Integer n=size(list, 1);
  Integer i=1;
algorithm

  y := 0;

  while i <= n loop
    if value == list[i] then
      y := i;
    end if;
    i := i + 1;
  end while;

end FindIndexOfMatch;
