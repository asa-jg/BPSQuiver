ClearAll[q, result]
q = Symbol["q"];
ClearAll[qPochhammer];
qPochhammer[q_, n_] := 
 qPochhammer[q, n] = If[n == 0, 1, Product[(1 - q^k), {k, 1, n}]]

range = Range[0, 5];


(*Compute the sum using Table for efficiency and memoized calculations*)
terms = Table[
   Module[{l,sumExponent, denominator, expr},
    l = {l1, l2, l3, l4, l5, l6};
     sumExponent = (Total[l]) + l[[2]]*l[[1]] + l[[2]]*l[[3]] + l[[4]]*l[[1]] + l[[5]]*l[[1]] + l[[1]]*l[[6]] + l[[2]]*l[[5]] + l[[4]]*l[[3]] + l[[2]]*l[[6]] + l[[5]]*l[[4]] + l[[4]]*l[[6]];
     denominator = Times @@ ((qPochhammer[q, #])^2 & /@ l);
     expr = (q^sumExponent)/denominator;
     expr
    ], {l1, range}, {l2, range}, {l3, range}, {l4, range}, {l5, range}, {l6, range}];
result = Total[Flatten[terms]];

taylorSeries = Series[result, {q, 0, 5}];

(*Convert the series to normal polynomial form, truncating higher-order terms*)
truncatedResult = Normal[taylorSeries];

qinf[q_] = 
  1 - 2*q - q^2 + 2*q^3 + q^4 + 2*q^5 - 2*q^6 - 2*q^8 - 2*q^9 + q^10 + 2*q^13 + 3*q^14 - 2*q^15 + 2*q^16 - 2*q^19 - 2*q^20;
series2 = qinf[q]^3;
product = truncatedResult*series2;
expandedProduct = Expand[product];
truncatedResult2 = Normal[Series[expandedProduct, {q, 0, 5}]];
Print[truncatedResult2];
