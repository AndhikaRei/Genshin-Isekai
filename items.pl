/* item(X, Y) berarti item bernama X dengan id Y, id dikelompokkan berdasarkan rarity */
/* Common */
item('Necklace', 0) :- !.
item('Wooden Sword', 1) :- !.
item('Wooden Bow', 2) :- !.
item('Wooden Staff', 3) :- !.
item('Knight Sword', 4) :- !.
item('Hunter Bow', 5) :- !.
item('Sorcerer Staff', 6) :- !.
item('Metal Splitter', 7) :- !.
item('Gaea Bow', 8) :- !.
item('Ember Staff', 9) :- !.
item('Wooden Armor', 10) :- !.
item('Windy Cape', 11) :- !.
item('Silk Robe', 12) :- !.
item('Knight Breastplate', 13) :- !.
item('Nature Cape', 14) :- !.
item('Magus Robe', 15) :- !.
item('Slime Heart', 16) :- !.
item('Goblin Heart', 17) :- !.

/* Rare */
item('Holy Edge', 18) :- !.
item('Bow of Tempest', 19) :- !.
item('Dark Magus Staff', 20) :- !.
item('Dragon Slayer', 21) :- !.
item('Sacred Wind', 22) :- !.
item('Phantom Seeker', 23) :- !.
item('Paladin Breastplate', 24) :- !.
item('Typhoon Cape', 25) :- !.
item('Dark Robes', 26) :- !.
item('Dragonic Breastplate', 27) :- !.
item('Guardian of Nature', 28) :- !.
item('Robes of Archfiend', 29) :- !.
item('Wolf Heart', 30) :- !.
item('Dragonic Core', 31) :- !.

/* Legendary */
item('Excalibur', 32) :- !.
item('Star Crosser', 33) :- !.
item('Cursed Lucifer Staff', 34) :- !.
item('Legendary Warrior Plating', 35) :- !.
item('Interstelar Cape', 36) :- !.
item('Terror of The Immortal', 37) :- !.
item('Orb of Destiny', 38) :- !.

/* Potion */
item('Health Potion', 39) :- !.

/* equipment(X, Y, Z, W) berarti X adalah equipment yang hanya dapat digunakan oleh job Y yang menambah stat Z sebesar W */
equipment('Wooden Sword', swordsman, atk, 10).
equipment('Knight Sword', swordsman, atk, 20).
equipment('Metal Splitter', swordsman, atk, 40).
equipment('Holy Edge', swordsman, atk, 70).
equipment('Dragon Slayer', swordsman, atk, 100).
equipment('Excalibur', swordsman, atk, 140).
equipment('Wooden Armor', swordsman, def, 30).
equipment('Knight Breastplate', swordsman, def, 50).
equipment('Paladin Breastplate', swordsman, def, 70).
equipment('Dragonic Breastplate', swordsman, def, 100).
equipment('Legendary Warrior Plating', swordsman, def, 130).

equipment('Wooden Bow', archer, atk, 15).
equipment('Hunter Bow', archer, atk, 35).
equipment('Gaea Bow', archer, atk, 55).
equipment('Bow of Tempest', archer, atk, 90).
equipment('Sacred Wind', archer, atk, 130).
equipment('Star Crosser', archer, atk, 160).
equipment('Windy Cape', archer, def, 10).
equipment('Nature Cape', archer, def, 25).
equipment('Typhoon Cape', archer, def, 40).
equipment('Guardian of Nature', archer, def, 50).
equipment('Interstelar Cape', archer, def, 80).

equipment('Wooden Staff', sorcerer, atk, 20).
equipment('Sorcerer Staff', sorcerer, atk, 50).
equipment('Ember Staff', sorcerer, atk, 80).
equipment('Dark Magus Staff', sorcerer, atk, 120).
equipment('Phantom Seeker', sorcerer, atk, 160).
equipment('Cursed Lucifer Staff', sorcerer, atk, 210).
equipment('Silk Robe', sorcerer, def, 5).
equipment('Magus Robe', sorcerer, def, 20).
equipment('Dark Robes', sorcerer, def, 30).
equipment('Robes of Archfiend', sorcerer, def, 40).
equipment('Terror of The Immortal', sorcerer, def, 55).

equipment('Necklace', universal, hp, 30).
equipment('Slime Heart', universal, hp, 30).
equipment('Goblin Heart', universal, hp, 60).
equipment('Wolf Heart', universal, hp, 120).
equipment('Dragonic Core', universal, hp, 240).
equipment('Orb of Destiny', universal, hp, 480).

/* potion(X, Y) berarti X adalah potion yang menambah HP sebesar Y */
potion('Health Potion', 100).