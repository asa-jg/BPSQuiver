(*Define symbolic variables*)ClearAll[q, z1, z2, z3, z4, z5, result]
q = Symbol["q"];
z1 = Symbol["z1"];
z2 = Symbol["z2"];
z3 = Symbol["z3"];
z4 = Symbol["z4"];
z5 = Symbol["z5"];

(*Define memoized q-Pochhammer function*)
ClearAll[qPochhammer];
qPochhammer[q_, n_] := 
 qPochhammer[q, n] = If[n == 0, 1, Product[(1 - q^k), {k, 1, n}]]

(*Range for summation indices*)
range = Range[0, 4];

(*Generate all valid combinations recursively*)
ClearAll[generateCombinations];
generateCombinations[n_, max_, sumLimit_, prefix_ : {}] := 
  If[n == 0, {prefix}, 
   Flatten[Table[
     If[Total[prefix] + i < sumLimit, 
      generateCombinations[n - 1, max, sumLimit, 
       Append[prefix, i]], {}], {i, 0, max}], 1]];

combinations = generateCombinations[12, 4, 10];

(*Compute the sum using Table for efficiency and memoized calculations*)
terms = Table[
   Module[{l, sumExponent, zTerm, denominator, expr}, l = comb;
    (*Check the conditions*)
    If [ l[[5]] + l[[4]] + 2*l[[6]] == l[[11]] + l[[10]] + 2*l[[12]] && l[[1]] == l[[7]] && l[[11]] + l[[12]] + l[[2]] == l[[5]] + l[[6]] + l[[8]] && l[[5]] + 2*l[[6]] + l[[3]] == l[[11]] + 2*l[[12]] + l[[9]],
    sumExponent = 1/2 (Total[l]) + l[[8]]*l[[1]] + l[[9]]*l[[1]] + l[[7]]*l[[4]] + l[[9]]*l[[2]] + l[[7]]*l[[5]] + l[[8]]*l[[4]] + l[[7]]*l[[6]] + l[[9]]*l[[4]] + l[[9]]*l[[6]] + l[[12]]*l[[4]] - (2*l[[12]] - 2*l[[6]])^2 + (l[[7]] - l[[1]])*(l[[12]] - l[[6]]) - (l[[8]] - l[[2]])*(l[[11]] - l[[5]]) + (l[[11]] - l[[5]])*(l[[12]] - l[[6]]) - (l[[7]] - l[[1]])*(2*l[[12]] - 2*l[[6]]) - (l[[8]] - l[[2]])*(2*l[[12]] - 2*l[[6]]) + (l[[12]] - l[[6]])*(2*l[[12]] - 2*l[[6]]) + (l[[11]] - l[[5]])^2/2 + 2*(l[[12]] - l[[6]])^2;
    zTerm = z1^(l[[5]] - l[[11]])*z2^(l[[6]] - l[[12]]);
     denominator = Times @@ (qPochhammer[q, #] & /@ l);
     expr = (q^sumExponent)*zTerm/denominator;
     (-1)^Total[l]*expr, 0]], {comb, combinations}];

(*Sum all terms together*)
result = Total[terms];

taylorSeries = Series[result, {q, 0, 4}];

(*Convert the series to normal polynomial form, truncating higher-order terms*)
truncatedResult = Normal[taylorSeries];

qinf[q_] = 
  1 - 2*q - q^2 + 2*q^3 + q^4 + 2*q^5 - 2*q^6 - 2*q^8 - 2*q^9 + q^10;
series2 = qinf[q]^2;
product = truncatedResult*series2;
expandedProduct = Expand[product];
truncatedResult2 = Normal[Series[expandedProduct, {q, 0, 4}]];
Print[truncatedResult2];
coeffs = CoefficientList[truncatedResult2, q];

countTerms[expr_] := 
  Total[If[Head[#] === Times && IntegerQ[First[FactorTermsList[#]]], 
      First[FactorTermsList[#]], If[IntegerQ[#], #, 1]] & /@ 
    List @@ expr];
termCounts = countTerms /@ coeffs;

result = 
  Total[coeffs[[1]]] + 
   Plus @@ Table[
     termCounts[[i]]*q^(i - 1), {i, 2, Length[termCounts]}];

Print[result];
