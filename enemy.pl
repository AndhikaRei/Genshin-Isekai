:- dynamic(inBattleEnemy/7).
/* diassert pas encounter */
/* pas diserang, dia diretract & diassert */
/* kalau udah selesai battle, di retract lagi */


/* btw kayaknya ini kalau selesai battle, pertambahan exp nya juga belum deh */
/* Jadi kayaknya itu diperlukan juga */

/* baseEnemy(X, HP, ATK, Special ATK, DEF) */
/* base stats enemy di level 1 */
baseEnemy(smallSlime, 75, 30, 50, 5).
baseEnemy(bigSlime, 100, 40, 70, 10).
baseEnemy(recruitGoblin, 125, 50, 80, 10).
baseEnemy(berserkerGoblin, 200, 75, 120, 15).
baseEnemy(standardWolf, 180, 70, 130, 20).
baseEnemy(direWolf, 260, 100, 200, 25).

/* growthRate(X, Max HP, ATK, Special ATK, DEF) */
/* enemy naik level tiap player naik level */
growthEnemy(smallSlime, 5, 7, 2).
growthEnemy(bigSlime, 10, 12, 3).
growthEnemy(recruitGoblin, 8, 10, 2).
growthEnemy(berserkerGoblin, 13, 15, 4).
growthEnemy(standardWolf, 12, 14, 3).
growthEnemy(direWolf, 15, 19, 5).

statsEnemy(X) :-
		  inBattleEnemy(X, Level, HP, MaxHP, Atk, SAtk, Def),
		  write('Enemy : '), write(X), nl,
		  write('Level : '), write(Level), nl,
		  write('HP : '), write(HP), write('/'), write(MaxHP), nl,
          write('Attack : '), write(Atk), nl,
		  write('Special Attack : '), write(SAtk), nl,
		  write('Defense : '), write(Def), nl.
	
/* boss(X, Level, HP, Max HP, ATK, Special ATK, DEF) */
/* X adalah nama boss dengan atribut level, HP, Max HP, ATK, Special ATK, dan DEF yang sudah didefinisi */
boss(regisvine, 10, 2000, 2000, 350, 700, 45).
boss(hypostasis, 20, 4000, 4000, 600, 1000, 60).
boss(andrius, 30, 9000, 9000, 900, 1500, 70).
boss(dvalin, 40, 13000, 13000, 1100, 2000, 80).