%> \file
%> Runs Algorithm 27.3 on example 27.3 of \cite Bier15-book, solving the TSP with local search (Figure 27.11, Table 27.7, Figure 27.12)
%>
%> @note Calls \ref tspLocalSearch
%>
%> @ingroup Running
%> @author Michel Bierlaire
%> @date Tue Apr 14 16:16:28 2015
%> @ingroup chap27

coord = [3.9168352575438883 9.137342270173304;
1.1699050319257487 18.455418341069745;
9.721881077629464 28.346794704912273;
7.390077284252903 39.41399505514082;
10.330134350013772 8.872575373705086;
17.54844435443345 12.555248083372415;
13.973337600200706 27.293670391120408;
10.780367650957938 32.30890310240921;
27.537494117722936 3.405255742784993;
22.109051040277585 13.629868632672725;
22.104604981898312 24.4082789143701;
22.642443138528456 39.900926037817364;
30.483507633842855 3.3699397182036805;
39.342134080320214 14.52455206463652;
37.63893123807275 21.751973125910553;
30.059401007763743 32.48285416836698;
];

[n two] = size(coord) ;
dist = zeros(n,n) ;

for i=1:n
  for j=1:n
    if (i != j)
      dist(i,j) = sqrt((coord(i,1) - coord(j,1))**2 + (coord(i,2) - coord(j,2))**2) ;
    endif
  endfor
endfor

firstSolution = [
    1
    7
   10
    3
   16
   15
   11
    4
    6
   14
    8
    2
   12
   13
    5
    9] ;

tour = tspLocalSearch(firstSolution,dist)
printf("Tour length: %f\n",tspTourLength(tour,dist)) ;

firstSolution = [    1
    5
    6
   10
   11
    7
    3
    8
    4
   12
   16
   15
   14
   13
    9
    2] ;

tour = tspLocalSearch(firstSolution,dist)
printf("Tour length: %f\n",tspTourLength(tour,dist)) ;
