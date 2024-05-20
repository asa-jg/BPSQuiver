mainfunc[] := 
 Module[{q, z1, z2, z3, z4, z5, gridPoints, combinations, 
   totalCombinations, result = 0, progressSteps, checkPoints, i, l, 
   sumExponent, zTerm, denominator, 
   expr},(*Define symbolic variables*){q, z1, z2, z3, z4, z5} = 
   Symbol /@ {"q", "z1", "z2", "z3", "z4", "z5"};
  (*Create grid points and all combinations*)
  gridPoints = Tuples[Range[0, 2], 8];
  totalCombinations = Length[gridPoints];
  (*Set up progress display*)Print["Progress: ["];
  progressSteps = 3;
  checkPoints = Subdivide[1, totalCombinations, progressSteps + 1];
  (*Process each combination*)Do[l = gridPoints[[i]];
   If[l[[4]] + l[[3]] == l[[8]] + l[[7]] && 
     l[[2]] + l[[1]] == l[[6]] + l[[5]], 
    sumExponent = 
     1/2*Total[l] + l[[5]]*l[[3]] + l[[5]]*l[[4]] + l[[6]]*l[[3]] + 
      l[[6]]*l[[4]];
    zTerm = z1^(l[[1]] - l[[5]])*z2^(l[[3]] - l[[7]]);
    denominator = Times @@ (qPochhammer[q, #] & /@ l);
    expr = (q^sumExponent)*zTerm/denominator;
    result += (-1)^Total[l]*expr];
   If[MemberQ[Round[checkPoints], i], Print["="]], {i, 1, 
    totalCombinations}];
  Print["] 100% Complete"];
  res = Simplify[result];
  taylor = Series[res, {q, 0, 5}];
  Print[taylor]]

mainfunc[]
Print["Hello from Mathematica!"]
