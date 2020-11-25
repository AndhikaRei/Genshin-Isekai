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
item('Health Potion (S)', 39) :- !.
item('Health Potion (M)', 40) :- !.
item('Health Potion (L)', 41) :- !.
item('Attack Potion', 42) :- !.
item('Defense Potion', 43) :- !.

/* equipment(X, Y, Z, W) berarti X adalah equipment yang hanya dapat digunakan oleh job Y yang menambah stat Z sebesar W */
equipment('Wooden Sword', swordsman, atk, 20).
equipment('Knight Sword', swordsman, atk, 40).
equipment('Metal Splitter', swordsman, atk, 80).
equipment('Holy Edge', swordsman, atk, 140).
equipment('Dragon Slayer', swordsman, atk, 200).
equipment('Excalibur', swordsman, atk, 280).
equipment('Wooden Armor', swordsman, def, 60).
equipment('Knight Breastplate', swordsman, def, 100).
equipment('Paladin Breastplate', swordsman, def, 140).
equipment('Dragonic Breastplate', swordsman, def, 200).
equipment('Legendary Warrior Plating', swordsman, def, 260).

equipment('Wooden Bow', archer, atk, 30).
equipment('Hunter Bow', archer, atk, 70).
equipment('Gaea Bow', archer, atk, 110).
equipment('Bow of Tempest', archer, atk, 180).
equipment('Sacred Wind', archer, atk, 260).
equipment('Star Crosser', archer, atk, 320).
equipment('Windy Cape', archer, def, 20).
equipment('Nature Cape', archer, def, 50).
equipment('Typhoon Cape', archer, def, 90).
equipment('Guardian of Nature', archer, def, 100).
equipment('Interstellar Cape', archer, def, 160).

equipment('Wooden Staff', sorcerer, atk, 40).
equipment('Sorcerer Staff', sorcerer, atk, 100).
equipment('Ember Staff', sorcerer, atk, 160).
equipment('Dark Magus Staff', sorcerer, atk, 240).
equipment('Phantom Seeker', sorcerer, atk, 320).
equipment('Cursed Lucifer Staff', sorcerer, atk, 420).
equipment('Silk Robe', sorcerer, def, 10).
equipment('Magus Robe', sorcerer, def, 40).
equipment('Dark Robes', sorcerer, def, 60).
equipment('Robes of Archfiend', sorcerer, def, 80).
equipment('Terror of The Immortal', sorcerer, def, 110).

equipment('Necklace', universal, hp, 100).
equipment('Slime Heart', universal, hp, 300).
equipment('Goblin Heart', universal, hp, 600).
equipment('Wolf Heart', universal, hp, 900).
equipment('Dragonic Core', universal, hp, 1200).
equipment('Orb of Destiny', universal, hp, 1500).

/* potion(X, Y) berarti X adalah potion yang menambah stats sebesar Y */
potion('Health Potion (S)', 500).
potion('Health Potion (M)', 1000).
potion('Health Potion (L)', 2000).
potion('Attack Potion', 400).
potion('Defense Potion', 200).