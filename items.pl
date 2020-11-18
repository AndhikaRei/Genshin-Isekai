/* item(X, Y) berarti item bernama X dengan id Y, id dikelompokkan berdasarkan rarity */
/* Common */
item('Wooden Sword', 1) :- !.
item('Wooden Bow', 2) :- !.
item('Wooden Staff', 3) :- !.
/* Rare */
item('Iron Sword', 4) :- !.
item('Iron Bow', 5) :- !.
item('Iron Staff', 6) :- !.
/* Legendary */
item('Skyward Blade', 7) :- !.
item('Skyward Harp', 8) :- !.
item('Skyward Atlas', 9) :- !.
/* Potion */
item('Health Potion', 10) :- !.

/* equipment(X, Y, Z, W) berarti X adalah equipment yang hanya dapat digunakan oleh job Y yang menambah stat Z sebesar W */
equipment('Wooden Sword', swordsman, atk, 10).
equipment('Iron Sword', swordsman, atk, 40).
equipment('Skyward Blade', swordsman, atk, 80).
equipment('Wooden Bow', archer, atk, 10).
equipment('Iron Bow', archer, atk, 40).
equipment('Skyward Harp', archer, atk, 80).
equipment('Wooden Staff', sorcerer, atk, 10).
equipment('Iron Staff', sorcerer, atk, 40).
equipment('Skyward Atlas', sorcerer, atk, 80).

/* potion(X, Y) berarti X adalah potion yang menambah HP sebesar Y */
potion('Health Potion', 100).