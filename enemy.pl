/* baseEnemy(X, Level, HP, Max HP, ATK, Special ATK, DEF) */
/* base stats enemy di level 1 */
baseEnemy(smallSlime, 1, 75, 75, 30, 50, 5).
baseEnemy(bigSlime, 1, 100, 100, 40, 70, 10).
baseEnemy(recruitGoblin, 1, 125, 125, 50, 80, 10).
baseEnemy(berserkerGoblin, 1, 200, 200, 75, 120, 15).
baseEnemy(standardWolf, 1, 180, 180, 70, 130, 20).
baseEnemy(direWolf, 1, 260, 260, 100, 200, 25).

/* growthRate(X, Level, Max HP, ATK, Special ATK, DEF) */
/* enemy naik level tiap player naik level */
growthEnemy(smallSlime, 1, 5, 7, 2).
growthEnemy(bigSlime, 1, 10, 12, 3).
growthEnemy(recruitGoblin, 1, 8, 10, 2).
growthEnemy(berserkerGoblin, 1, 13, 15, 4).
growthEnemy(standardWolf, 1, 12, 14, 3).
growthEnemy(direWolf, 1, 15, 19, 5).

/* boss(X, Level, HP, Max HP, ATK, Special ATK, DEF) */
/* X adalah nama boss dengan atribut level, HP, Max HP, ATK, Special ATK, dan DEF yang sudah didefinisi */
boss(regisvine, 10, 2000, 2000, 350, 700, 45).
boss(hypostasis, 20, 4000, 4000, 600, 1000, 60).
boss(andrius, 30, 9000, 9000, 900, 1500, 70).
boss(dvalin, 40, 13000, 13000, 1100, 2000, 80).