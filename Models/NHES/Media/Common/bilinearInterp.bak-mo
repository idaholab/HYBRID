within NHES.Media.Common;
function BilinearInterp
  input Real x;
  input Real y;
  input PropTable_2 I;
  output Real C;
protected
  TableSolverVars_2 T;
algorithm
  T.x_i :=FindIndexI(x, I.pr_1);
  T.y_i :=FindIndexI(y, I.pr_2);
  T.x_ul := {I.pr_1[T.x_i[1]],I.pr_1[T.x_i[2]]};
  T.y_ul := {I.pr_2[T.y_i[1]],I.pr_2[T.y_i[2]]};
  T.xm := {T.x_ul[1],T.x_ul[1],T.x_ul[2],T.x_ul[2]};
  T.ym := {T.y_ul[1],T.y_ul[2],T.y_ul[1],T.y_ul[2]};
  T.xy := transpose({ones(4),T.xm,T.ym,T.xm .* T.ym});
  T.c := {I.table[T.x_i[1], T.y_i[1]],I.table[T.x_i[1], T.y_i[2]],I.table[T.x_i[
    2], T.y_i[1]],I.table[T.x_i[2], T.y_i[2]]};
  T.a := Modelica.Math.Matrices.solve(T.xy, T.c);
  C := T.a*{1,x,y,x*y};
end BilinearInterp;
