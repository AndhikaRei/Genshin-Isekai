/* item(X) berarti X adalah item */
item('Wooden Sword').
item('Wooden Bow').
item('Wooden Staff').
item('Health Potion').

/* equipment(X, Y) berarti X adalah equipment yang hanya dapat digunakan oleh job Y */
equipment('Wooden Sword', swordsman).
equipment('Wooden Bow', archer).
equipment('Wooden Staff', sorcerer).

/* potion(X, Y) berarti X adalah potion yang menambah HP sebesar Y */
potion('Health Potion', 50).