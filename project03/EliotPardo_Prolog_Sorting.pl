%------------------------------
%          Exercise 1
%------------------------------

%------------
% randval/2
%------------

randval(R,Z) :-
  random(X),
  Y is X * R,
  Z is floor(Y).

%------------
% randlist/3
% randlist/4
%-------------

randlist(N,R,X) :-
  randlist(N,R,[],X).

randlist(0,_,X,X).
randlist(N,R,A,X) :-
  N > 0,
  randval(R,RV),
  append([RV],A,Anew),
  NM1 is N - 1,
  randlist(NM1,R,Anew,X).

%--------------
% is_sorted/2
%--------------

is_sorted([_]).
is_sorted([H|T]) :-
  T=[HT|_],
  H=<HT,
  is_sorted(T).

%------------
% badsort/2
%------------

badsort([X],[X]).
badsort(X,Y) :-
  permutation(X,Y),
  is_sorted(Y).


%------------------------------
%          Exercise 2
%------------------------------

%-------------
% minindex/3
%-------------

minindex(L,S,MI) :-
  length(L,LL),
  minindex(L,S,S,LL,MI).

%-------------
% minindex/5
%-------------

minindex(L,C,A,B,MI) :-
  nth0(C,L,CV),
  nth0(A,L,AV),
  CV =< AV,  
  AP1 is A+1,
  minindex(L,C,AP1,B,MI).

minindex(L,C,A,B,MI) :-
  nth0(C,L,CV),
  nth0(A,L,AV),
  AV =< CV,  
  AP1 is A+1,
  minindex(L,A,AP1,B,MI).

minindex(_,CM,B,B,MI) :-
  MI = CM.

%---------
% swap/4
%---------

swap(L,A,B,M) :-
  nth0(A,L,AV),
  nth0(B,L,BV),
  nth0(A,L,AV,L2),
  nth0(A,L3,BV,L2),
  nth0(B,L3,BV,L4),
  nth0(B,M,AV,L4).

%------------
% selsort/2
%------------

selsort([_],[_]).
selsort(X,Y) :-
  length(X,XL),
  XM2 is XL-2,
  selsort(X,0,XM2,Y).
selsort(X,A,B,Y) :-
  A > B,
  Y = X.
selsort(X,A,B,Y) :-
  A =< B,
  minindex(X,A,MI),
  swap(X,A,MI,X2),
  AP1 is A+1,
  selsort(X2,AP1,B,Y).


%------------------------------
%          Exercise 3
%------------------------------

%----------
% split/3
%----------

split([X],[X],[]).
split([X,Y],[X],[Y]).
split(L,A,B) :-
  length(L,LL),
  LA is LL // 2,
  append(A,B,L),
  length(A,LA).

%-------------
% merge/3
%-------------

merge([],L,L).
merge(L,[],L).
merge([A|AT],[B|BT],L) :-
  (A =< B  ->
    (merge(AT,[B|BT],L2),
     append([A],L2,L));
    (merge(BT,[A|AT],L2),
     append([B],L2,L))).

%------------
% mergesort
%------------

mergesort([X],[X]).
mergesort(L,SL) :-
  split(L,L1,L2),
  mergesort(L1,SL1),
  mergesort(L2,SL2),
  merge(SL1,SL2,SL).


%-----------------------------------
%              TESTING
%-----------------------------------

badsorttest(N,R) :-
  writeln("bad sort test"),
  N =< 10, 
  randlist(N,R,X),
  badsort(X,Y), 
  writeln(X),
  writeln(Y).

selsorttest(N,R) :-
  writeln("selsort test"),
  randlist(N,R,X), selsort(X,Y),
  writeln(X),writeln(Y).

testmerge :-
  writeln("merge test"),
  randlist(5,1000,RL1),
  randlist(5,1000,RL2),
  sort(RL1,SRL1),
  sort(RL2,SRL2),
  merge(SRL1,SRL2,L),
  writeln(SRL1),
  writeln(SRL2),
  writeln(L).

mergesorttest(N,R) :-
  writeln("mergesort test"),
  randlist(N,R,X),
  mergesort(X,Y),
  writeln(X),writeln(Y).

fulltest(N,R) :-
  writeln("full test"),
  randlist(N,R,L1),
  selsort(L1,L2),
  writeln("selection sort"),writeln(L1),writeln(L2),
  randlist(N,R,L3),
  mergesort(L3,L4),
  writeln("merge sort"),writeln(L3),writeln(L4). 