within NHES.Math.Interpolation;
function TrilinearInterp
  input Real x;
  input Real y;
  input Real z;
  input Math.Interpolation.PropTable_3 I;
  output Real C;
protected
  Math.Interpolation.TableSolverVars_3 T;
algorithm
  T.x_i := Media.Common.FindIndexI(x, I.pr_1);
  T.y_i := Media.Common.FindIndexI(y, I.pr_2);
  T.z_i := Media.Common.FindIndexI(z, I.pr_3);
  T.x_ul := {I.pr_1[T.x_i[1]],I.pr_1[T.x_i[2]]};
  T.y_ul := {I.pr_2[T.y_i[1]],I.pr_2[T.y_i[2]]};
  T.z_ul := {I.pr_3[T.z_i[1]],I.pr_3[T.z_i[2]]};
  T.xm := {T.x_ul[1],T.x_ul[2],T.x_ul[1],T.x_ul[2],T.x_ul[1],T.x_ul[2],T.x_ul[
    1],T.x_ul[2]};
  T.ym := {T.y_ul[1],T.y_ul[1],T.y_ul[2],T.y_ul[2],T.y_ul[1],T.y_ul[1],T.y_ul[
    2],T.y_ul[2]};
  T.zm := {T.z_ul[1],T.z_ul[1],T.z_ul[1],T.z_ul[1],T.z_ul[2],T.z_ul[2],T.z_ul[
    2],T.z_ul[2]};

  T.xyz := transpose({ones(8),T.xm,T.ym,T.zm,T.xm .* T.ym,T.xm .* T.zm,T.ym .*
    T.zm,T.xm .* T.ym .* T.zm});

  T.c := {I.table[T.x_i[1], T.y_i[1], T.z_i[1]],I.table[T.x_i[2], T.y_i[1],
    T.z_i[1]],I.table[T.x_i[1], T.y_i[2], T.z_i[1]],I.table[T.x_i[2], T.y_i[
    2], T.z_i[1]],I.table[T.x_i[1], T.y_i[1], T.z_i[2]],I.table[T.x_i[2], T.y_i[
    1], T.z_i[2]],I.table[T.x_i[1], T.y_i[2], T.z_i[2]],I.table[T.x_i[2], T.y_i[
    2], T.z_i[2]]};
  T.a := Modelica.Math.Matrices.solve(T.xyz, T.c);
  C := T.a*{1,x,y,z,x*y,x*z,y*z,x*y*z};
end TrilinearInterp;
