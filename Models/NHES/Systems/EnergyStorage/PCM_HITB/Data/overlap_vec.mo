within NHES.Systems.EnergyStorage.PCM_HITB.Data;
function overlap_vec
  "Calculates the normalized overlap vector of two positional vectors. This algorithm assumes vectors describe a space of nodes I with a vector length I+1. Entry 1 thus indicates left-edge of first cell (would be 0 to describe an object extending from origin)"
//  input Integer n_1;
//  input Integer n_2;
  input Real length_1[:];
  input Real length_2[:];
  input Real multiplier = 1;
  output Real overlap[n_1-1,n_2-1];

/*

For location vectors in x-coordinates in the form: | left edge | x_1 | x_2 | .... x_nX | where x_nX is the right edge position

There should be 6 cases when comparing for vector one, nodes i...nI and vector two, nodes j...nJ

1) if j > i+1, then vector 2 is fully to the right of vector 1, and therefore no overlap occurs
2) if i > j+1, then vector 1 is fully to the left of vector 2, and therefore no overlap occurs

3) if j<i AND j+1 > i+1, then i is fully encompassed by j, and therefore overlap is equal to i+1 - i
4) if i<j AND i+1 > j+1, then j is fully encompassed by i, and therefore overlap is equal to j+1 - j

5) if i<j AND i+1<j+1, then j starts in the middle of i but exceeds i's right edge, and therefore we need i+1 - j
6) if j<i AND j+1<i+1, then i starts in the middle of j but exceeds j's right edge, and therefore we need j+1 - i

These should be all the cases. If not, default value is 0 overlap.

>= and <= are used after the 0 cases to make sure that equally placed and differentiated vectors will calculate entire overlap. 


*/
protected
  constant Integer n_1 = size(length_1,1);
  constant Integer n_2 = size(length_2,1);
  Real normal_lengths[n_2-1] = ones(n_2-1);
algorithm

  for j in 1:n_2-1 loop
    normal_lengths[j] :=length_2[j + 1] - length_2[j];
  end for;

for i in 1:n_1-1 loop
  for j in 1:n_2-1 loop

      if length_2[j] > length_1[i+1] then
        overlap[i,j] := 0;
      elseif length_2[j+1] < length_1[i] then
        overlap[i,j] := 0;
      elseif length_2[j] <= length_1[i] and length_2[j+1] <= length_1[i+1] then
        overlap[i,j] := length_2[j+1] - length_1[i];
        overlap[i,j] := overlap[i,j]/normal_lengths[j];
      elseif length_2[j] >= length_1[i] and length_2[j+1] >= length_1[i+1] then
        overlap[i,j] := length_1[i+1] - length_2[j];
        overlap[i,j] := overlap[i,j]/normal_lengths[j];
      elseif length_2[j] >= length_1[i] and length_2[j+1] <= length_1[i+1] then
        overlap[i,j] := length_2[j+1]-length_2[j];
        overlap[i,j] := overlap[i,j]/normal_lengths[j];
      elseif length_2[j] <= length_1[i] and length_2[j+1] >= length_1[i+1] then
        overlap[i,j] := length_1[j+1]-length_1[j];
        overlap[i,j] := overlap[i,j]/normal_lengths[j];
      else
        overlap[i,j] := 0;
      end if;
  end for;
end for;
overlap := overlap*multiplier;

end overlap_vec;
