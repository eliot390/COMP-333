%--------
%  nc/1
%--------

nc([]).
nc([_]).
nc([H|T]) :-
  nc(H,T,1).

%--------
%  nc/3
%--------

nc(_,[],_).
nc(P,[H|T],D) :-
  P \= H,
  RDIFF is abs(P-H),
  RDIFF \= D,
  DP1 is D+1,
  nc(P,T,DP1).

%-----------
%  solve/2
%-----------

solve(N,X) :-
  solve(N,[],X).

%-----------
%  solve/3
%-----------

solve(N,X,X) :-
  length(X,N).

solve(N,T,X) :-
  NM1 is N-1,
  between(0,NM1,P),
  append([P],T,T2),
  nc(T2),
  solve(N,T2,X).


%--------------
%  bruteforce
%--------------

bruteforce(Y) :-
  permutation([0,1,2,3,4,5,6,7],Y),
  nc(Y,0,1),
  nc(Y,0,2),nc(Y,1,2),
  nc(Y,0,3),nc(Y,1,3),nc(Y,2,3),
  nc(Y,0,4),nc(Y,1,4),nc(Y,2,4),nc(Y,3,4),
  nc(Y,0,5),nc(Y,1,5),nc(Y,2,5),nc(Y,3,5),nc(Y,4,5),
  nc(Y,0,6),nc(Y,1,6),nc(Y,2,6),nc(Y,3,6),nc(Y,4,6),nc(Y,5,6),
  nc(Y,0,7),nc(Y,1,7),nc(Y,2,7),nc(Y,3,7),nc(Y,4,7),nc(Y,5,7),nc(Y,6,7).