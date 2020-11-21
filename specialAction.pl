:- include('inventory.pl').
:- include('peta.pl').
:- include('enemy.pl').

/* Pemain 60% menemukan musuh Enemy dalam perjalanannya */
encounter(Enemy) :- playerPos(A, B), \+elmtPeta(A, B, _),
				random(1, 11, X),
				(X < 7 ->
					assertz(inBattle),
					randomEnemy(Enemy),
					write('Anda menemukan '),
					write(Enemy),
					write('!'),
					player(_, Lvl, _, _, _, _, _, _),
					baseEnemy(Enemy, HP, Atk, SAtk, Def),
					growthEnemy(Enemy, GHP, GAtk, GSAtk, GDef),
					GLvl is Lvl - 1,
					/* semua stats adalah base stat + growthrate * pertambahan level */
					THP is HP + (GHP * GLvl), TMaxHP is THP,
					TAtk is Atk + (GAtk * GLvl), TSAtk is SAtk + (GSAtk * GLvl),
					TDef is Def + (GDef * GLvl),
					assertz(inBattleEnemy(Enemy, Lvl, THP, TMaxHP, TAtk, TSAtk, TDef)),
					
					battle,
					/* Ngeprint stats musuh */
					nl
				;	
					write('Anda tidak menemukan musuh'),
					nl
				).

/* merandom musuh yang ditemukan berdasarkan habitat */				
randomEnemy(Enemy) :- playerPos(A, B),
					  habitat(A, B, Musuh),
					  encounterHabitat(Musuh, Enemy).
					  
/* posisi pemain bukanlah habitat musuh siapapun */
/* 50% ? slime */
/* 30% ? goblin */
/* 20% ? wolf */
randomEnemy(Enemy) :- playerPos(A, B),
					  \+ habitat(A, B, _),
					  random(1, 11, X),
					  (X < 6 ->
						  randomSlime(Enemy);
						  (X < 9 -> randomGoblin(Enemy);
							randomWolf(Enemy)
						  )
					  ).

/* encounter di habitat slime akan memiliki persentase encounter dengan */
/* 70% ? slime */
/* 15% ? wolf */
/* 15% ? goblin */
encounterHabitat(slime, Enemy) :- random(1, 21, X),
					(X < 15 -> randomSlime(Enemy);
						(X < 18 -> randomGoblin(Enemy);
							randomWolf(Enemy)
						)
					).

/* encounter di habitat goblin akan memiliki persentase encounter dengan */
/* 70% ? goblin */
/* 15% ? wolf */
/* 15% ? slime */
encounterHabitat(goblin, Enemy) :- random(1, 21, X),
					(X < 15 -> randomGoblin(Enemy);
						(X < 18 -> randomSlime(Enemy);
							randomWolf(Enemy)
						)
					).
					
/* encounter di habitat wolf akan memiliki persentase encounter dengan */
/* 70% ? wolf */
/* 15% ? slime */
/* 15% ? goblin */
encounterHabitat(wolf, Enemy) :- random(1, 21, X),
					(X < 15 -> randomWolf(Enemy);
						(X < 18 -> randomGoblin(Enemy);
							randomSlime(Enemy)
						)
					).

randomSlime(Enemy) :- random(1, 3, X),
					  (X < 2 -> Enemy is smallSlime; /* X = 1 */
						  Enemy is bigSlime
					  ).

randomGoblin(Enemy) :- random(1, 3, X),
					  (X < 2 -> Enemy is recruitGoblin; /* X = 1 */
						  Enemy is berserkerGoblin
					  ).

randomWolf(Enemy) :- random(1, 3, X),
					  (X < 2 -> Enemy is standardWolf; /* X = 1 */
						  Enemy is direWolf
					  ).