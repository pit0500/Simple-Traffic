% The encoding for the random creation of the map will handle the formation of a graph that represents the traffic system map.

% In the encoding, we will have several predicates, including:
%     - waypoint(X, Z)
%     - connArco(X1, Z1, X2, Z2)
%     - vicini(X1, Z1, X2, Z2)
%
% In addition to these, there will also be support predicates for the map generation itself.

% The predicates will have different functionalities. Specifically:

% waypoint(X, Z): These predicates represent the nodes of the resulting graph, which also have the coordinates X and Z.

% vicini(X, Z1, X, Z2): This rule defines that two waypoints with the same X coordinate are neighbors if their Z coordinates differ by 1.

% vicini(X1, Z, X2, Z): This rule defines that two waypoints with the same Z coordinate are neighbors if their X coordinates differ by 1.

#const n = 3.

waypoint(0..n, 0..n).

% Here we define the neighbors of the waypoints

vicini(X, Z1, X, Z2) :- waypoint(X, Z1), waypoint(X, Z2), |Z1-Z2| == 1.
vicini(X1, Z, X2, Z) :- waypoint(X1, Z), waypoint(X2, Z), |X1-X2| == 1.
% vicini(X1, Z1, X2, Z2) :- waypoint(X1, Z1), waypoint(X2, Z2), |X1-X2| == 1, |Z1-Z2| == 1.

% Connection between waypoints

connArco(0, Z, 0, Z1) :- vicini(0, Z, 0, Z1).
connArco(X, 0, X1, 0) :- vicini(X, 0, X1, 0).

connArco(n, Z, n, Z1) :- vicini(n, Z, n, Z1).
connArco(X, n, X1, n) :- vicini(X, n, X1, n).

{connArco(X1, Z1, X2, Z2) : vicini(X1, Z1, X2, Z2)}.

:- connArco(X, Z, X1, Z1), not connArco(X1, Z1, X, Z).

% Here we define the number of arcs that connect a waypoint to another

totArchi(X, Z, Tot) :- Tot = #count{X1, Z1 : connArco(X, Z, X1, Z1)}, connArco(X, Z, _, _).

curva(0, 0).
curva(0, n).
curva(n, 0).
curva(n, n).

curva(X, Z) :- connArco(X1, Z1, X, Z), connArco(X, Z, X2, Z2), |X1-X2| == 1, |Z1-Z2| == 1, not incrocio(X, Z).

curvaNord(X, Z) :- curva(X, Z), connArco(X+1, Z, X, Z), connArco(X, Z, X, Z+1).

curvaSud(X, Z) :- curva(X, Z), connArco(X-1, Z, X, Z), connArco(X, Z, X, Z-1).

curvaEst(X, Z) :- curva(X, Z), connArco(X, Z-1, X, Z), connArco(X, Z, X+1, Z).

curvaOvest(X, Z) :- curva(X, Z), connArco(X, Z+1, X, Z), connArco(X, Z, X-1, Z).

% Intersections

incrocio(X, Z) :- totArchi(X, Z, Tot), Tot > 2.

% Three-way intersection has different types

incrocioTreVie(X, Z) :- totArchi(X, Z, 3).

incrocioTreVieOvest(X, Z) :- incrocioTreVie(X, Z), 2 = #count{Z1 : connArco(X, Z1, X, Z)}, connArco(X1, Z, X, Z), X1-X=1.

incrocioTreVieEst(X, Z) :- incrocioTreVie(X, Z), 2 = #count{Z1 : connArco(X, Z1, X, Z)}, connArco(X1, Z, X, Z), X-X1=1.

incrocioTreVieNord(X, Z) :- incrocioTreVie(X, Z), 2 = #count{X1 : connArco(X1, Z, X, Z)}, connArco(X, Z1, X, Z), Z-Z1=1.

incrocioTreVieSud(X, Z) :- incrocioTreVie(X, Z), 2 = #count{X1 : connArco(X1, Z, X, Z)}, connArco(X, Z1, X, Z), Z1-Z=1.

% Only one type of four-way intersection

incrocioQuattroVie(X, Z) :- totArchi(X, Z, 4).

% straight road

straightRoadStessaX(X, Z, Z1) :- connArco(X, Z, X, Z1), Z < Z1, not incrocio(X, Z), not curva(X, Z1).

straightRoadStessaX(X, Z, Z1) :- connArco(X, Z, X, Z1), Z < Z1, not incrocio(X, Z1), not curva(X, Z).

straightRoadStessaZ(X, Z, X1) :- connArco(X, Z, X1, Z), X < X1, not incrocio(X, Z), not curva(X1, Z).

straightRoadStessaZ(X, Z, X1) :- connArco(X, Z, X1, Z), X < X1, not incrocio(X1, Z), not curva(X, Z).

% Two types of waypoint-roads

waypointRoadStessaX(X, Z) :- straightRoadStessaX(X, Z, Z1).

waypointRoadStessaX(X, Z1) :- straightRoadStessaX(X, Z, Z1).

waypointRoadStessaZ(X, Z) :- straightRoadStessaZ(X, Z, X1).

waypointRoadStessaZ(X1, Z) :- straightRoadStessaZ(X, Z, X1).

% Constraints on the number of intersections and intersections position

:- n/2 > #count{X, Z : incrocioTreVie(X, Z)} < n.

:- n/4 > #count{X, Z : incrocioQuattroVie(X, Z)} < n/2.

waypointIsolati(X, Z) :- totArchi(X, Z, 1).

:- waypointIsolati(X, Z).

:- incrocio(X, Z), not randomWaypoint(X, Z).

:- incrocio(X, Z), incrocio(X1, Z1), vicini(X, Z, X1, Z1).

:- incrocio(X, Z), incrocio(X1, Z1), |X-X1| == 1, |Z-Z1| == 1.

randomWaypoint(@getRandomWaypoint(n+1, I, 0), @getRandomWaypoint(n+1, I, 1)) :- waypoint(I, _), I < n.

#script (python)

from clingo.symbol import Number
from random import randint, seed
from time import time

waypointList = []
waypointSet = set()

def generateWaypointList(n):
    if len(waypointList) == 0:
        seed(time())
        while len(waypointSet) < n:
            x = Number(randint(1, n-1))
            z = Number(randint(1, n-1))
            waypointSet.add((x, z))

def getRandomWaypoint(n, i, j):
    n = n.number
    i = i.number
    j = j.number
    generateWaypointList(n)
    waypointList = list(waypointSet)
    return waypointList[i][j]

#end.

custom_instantiation(straightRoad(Index, X, Z, Z1, 0)) :- straightRoadStessaX(X, Z, Z1),
                        prefabName(Index, "Road_Straight"), not curva(X, Z1).

custom_instantiation(straightRoad(Index, X, Z, X1, 90)) :- straightRoadStessaZ(X, Z, X1),
                        prefabName(Index, "Road_Straight"), not curva(X1, Z), not incrocio(X1, Z).

custom_instantiation(threeWayIntersection(Index, X, Z, 0)) :- incrocioTreVieEst(X, Z),
                        prefabName(Index, "Road_TJunction").

custom_instantiation(threeWayIntersection(Index, X, Z, 90)) :- incrocioTreVieSud(X, Z),
                        prefabName(Index, "Road_TJunction").

custom_instantiation(threeWayIntersection(Index, X, Z, 180)) :- incrocioTreVieOvest(X, Z),
                        prefabName(Index, "Road_TJunction").

custom_instantiation(threeWayIntersection(Index, X, Z, 270)) :- incrocioTreVieNord(X, Z),
                        prefabName(Index, "Road_TJunction").

custom_instantiation(fourWayIntersection(Index, X, Z)) :- incrocioQuattroVie(X, Z),
                        prefabName(Index, "Road_Crossroad").

custom_instantiation(turn(Index, 0, 0, 0)) :- prefabName(Index, "Road_Corner").

custom_instantiation(turn(Index, n, 0, 270)) :- prefabName(Index, "Road_Corner").

custom_instantiation(turn(Index, 0, n, 90)) :- prefabName(Index, "Road_Corner").

custom_instantiation(turn(Index, n, n, 180)) :- prefabName(Index, "Road_Corner").

custom_instantiation(turn(Index, X, Z, 0)) :- prefabName(Index, "Road_Corner"), curvaNord(X, Z).

custom_instantiation(turn(Index, X, Z, 90)) :- prefabName(Index, "Road_Corner"), curvaEst(X, Z).

custom_instantiation(turn(Index, X, Z, 180)) :- prefabName(Index, "Road_Corner"), curvaSud(X, Z).

custom_instantiation(turn(Index, X, Z, 270)) :- prefabName(Index, "Road_Corner"), curvaOvest(X, Z).

custom_instantiation(waypointFill(Index, X, Z, 0)) :- prefabName(Index, "Road_StraightShort"),
                        waypointRoadStessaX(X, Z).

custom_instantiation(waypointFill(Index, X, Z, 90)) :- prefabName(Index, "Road_StraightShort"),
                        waypointRoadStessaZ(X, Z).

#show custom_instantiation/1.
