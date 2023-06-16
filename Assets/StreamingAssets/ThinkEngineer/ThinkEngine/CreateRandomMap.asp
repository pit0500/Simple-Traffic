#const n = 10.

waypoint(0..n, 0..n).

vicini(X, Z1, X, Z2) :- waypoint(X, Z1), waypoint(X, Z2), |Z1-Z2| == 1.
vicini(X1, Z, X2, Z) :- waypoint(X1, Z), waypoint(X2, Z), |X1-X2| == 1.

connArco(0, Z, 0, Z1) :- waypoint(0, Z), waypoint(0, Z1), vicini(0, Z, 0, Z1).
connArco(X, 0, X1, 0) :- waypoint(X, 0), waypoint(X1, 0), vicini(X, 0, X1, 0).

connArco(n, Z, n, Z1) :- waypoint(n, Z), waypoint(n, Z1), vicini(n, Z, n, Z1).
connArco(X, n, X1, n) :- waypoint(X, n), waypoint(X1, n), vicini(X, n, X1, n).

{connArco(X1, Z1, X2, Z2) : vicini(X1, Z1, X2, Z2)}.

% #show connArco/4.

:- connArco(X, Z, X1, Z1), not connArco(X1, Z1, X, Z).

totArchi(X, Z, Tot) :- Tot = #count{X1, Z1 : connArco(X, Z, X1, Z1)}, connArco(X, Z, _, _).

#show incrocioQuattroVie/2.

#show incrocioTreVie/2.

% #show randomWaypoint/2.

incrocio(X, Z) :- totArchi(X, Z, Tot), Tot > 2.

incrocioTreVie(X, Z) :- totArchi(X, Z, 3).

incrocioQuattroVie(X, Z) :- totArchi(X, Z, 4).

:- n/2 > #count{X, Z : incrocioTreVie(X, Z)}.

:- n/4 > #count{X, Z : incrocioQuattroVie(X, Z)}.

waypointIsolati(X, Z) :- totArchi(X, Z, 1).

:- waypointIsolati(X, Z).

:- incrocio(X, Z), not randomWaypoint(X, Z).

randomWaypoint(@getRandomWaypoint(N, I, 0), @getRandomWaypoint(N, I, 1)) :- N = n+1, waypoint(I, _), I < N.

#script (python)

from clingo.symbol import Number
from random import randint, seed
from time import time

waypointList = []

def generateWaypointList(n):
    seed(time())
    while len(waypointList) < n:
        x = Number(randint(1, n-1))
        z = Number(randint(1, n-1))
        if (x, z) not in waypointList:
            waypointList.append((x, z))

def getRandomWaypoint(n, i, j):
    n = n.number
    i = i.number
    j = j.number
    generateWaypointList(n)
    return waypointList[i][j]

#end.

