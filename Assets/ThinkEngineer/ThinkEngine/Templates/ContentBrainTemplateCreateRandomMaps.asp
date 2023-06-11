%For runtime instantiated GameObject, only the prefab mapping is provided. Use that one substituting the gameobject name accordingly.
 %Sensors.
%For ASP programs:
% Facts assiociated with instantiable DCS Prefab
%prefabName(Index,Name).
%asset(Index).
%has_property(Index,dangerous).
%has_property(Index,walkable).
%has_property(Index,obstacle).
%has_property(Index,canFloat).
%has_property(Index,stackable).
%compatible(Index1,Index2,direction(D1,D2)).
%preference(Index1,Index2,direction(D1,D2),Priority).
% Predicates for Prefab instantiation. PrefabListIndex is the index of the Prefabs list of the Brain, PX PY PZ reflect the position of the instantiation while RX RY RZ RW represent the rotation.
% instantiatePrefab(PrefabListIndex,PX,PY,PZ, RX, RY, RZ, RW).
