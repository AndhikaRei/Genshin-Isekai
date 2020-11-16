:- include('inventory.pl').

/* ngerandom Y nya masih tentatif tergantung jenis weapon ada berapa */
gacha :- random(1, 4, X), (X =:= 1), random(1, 11, Y), idItem(Y, Weapon), addItem(Weapon, 1).
gacha :- random(1, 4, X), (X =:= 2), random(11, 21, Y), idItem(Y, Weapon), addItem(Weapon, 1).
gacha :- random(1, 4, X), (X =:= 3), random(21, 31, Y), idItem(Y, Weapon), addItem(Weapon, 1).