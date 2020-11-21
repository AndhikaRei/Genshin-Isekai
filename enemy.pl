:- dynamic(inBattleEnemy/8).
/* diassert pas encounter */
/* pas diserang, dia diretract & diassert */
/* kalau udah selesai battle, di retract lagi */


/* btw kayaknya ini kalau selesai battle, pertambahan exp nya juga belum deh */
/* Jadi kayaknya itu diperlukan juga */

/* id unik enemy */
idEnemy(1,smallSlime).
idEnemy(2,bigSlime).
idEnemy(3,recruitGoblin).
idEnemy(4,berserkerGoblin).
idEnemy(5,standardWolf).
idEnemy(6,direWolf).

/* baseEnemy(X, HP, ATK, Special ATK, DEF, exp given) */
/* base stats enemy di level 1 */
baseEnemy(smallSlime, 75, 30, 50, 5, 1).
baseEnemy(bigSlime, 100, 40, 70, 10, 1).
baseEnemy(recruitGoblin, 125, 50, 80, 10, 1).
baseEnemy(berserkerGoblin, 200, 75, 120, 15, 1).
baseEnemy(standardWolf, 180, 70, 130, 20, 1).
baseEnemy(direWolf, 260, 100, 200, 25, 1).

/* growthRate(X, Max HP, ATK, Special ATK, DEF, exp given) */
/* enemy naik level tiap player naik level */
growthEnemy(smallSlime, 5, 7, 2, 1, 1).
growthEnemy(bigSlime, 10, 12, 3, 1, 2).
growthEnemy(recruitGoblin, 8, 10, 2, 1, 3).
growthEnemy(berserkerGoblin, 13, 15, 4, 1, 4).
growthEnemy(standardWolf, 12, 14, 3, 1, 5).
growthEnemy(direWolf, 15, 19, 5, 1, 6).

statsEnemy(X) :-
		  inBattleEnemy(X, Level, HP, MaxHP, Atk, SAtk, Def, _),
		  write('Enemy : '), write(X), nl,
		  write('Level : '), write(Level), nl,
		  write('HP : '), write(HP), write('/'), write(MaxHP), nl,
          write('Attack : '), write(Atk), nl,
		  write('Special Attack : '), write(SAtk), nl,
		  write('Defense : '), write(Def), nl.
	
/* boss(X, Level, HP, Max HP, ATK, Special ATK, DEF) */
/* X adalah nama boss dengan atribut level, HP, Max HP, ATK, Special ATK, dan DEF yang sudah didefinisi */
boss(hypostasis, 20, 4000, 4000, 600, 1000, 60).
boss(andrius, 30, 9000, 9000, 900, 1500, 70).

printGBEnemy(IdEnemy) :-
	(IdEnemy =:= 1 -> printSlime
	;IdEnemy =:= 2 -> printSlime
	;IdEnemy =:= 3 -> printGoblin
	;IdEnemy =:= 4 -> printGoblin
	;IdEnemy =:= 5 -> printWolf
	;IdEnemy =:= 6 -> printWolf
	).

printSlime :-
	write('           -dddddd:                               '), nl,
    write('         :hhmmmmdhhhhhs                           '), nl,
    write('         ./oNNddhhddddhyyyy.                      '), nl,
    write('           `++NNddhhhyyddddys-                    '), nl,
    write('              MMmdddhyyyyyyhdso:                  '), nl,
    write('              MMmdddhyyyyyysohdy++++              '), nl,
    write('           `:/NNdddhhyyyyssooooymmmm//`           '), nl,
    write('         `-/NNdddhyyyyyssooooooooooomm/-`         '), nl,
    write('       `.oMNddddyyyyyysooooooooooooooomNo.`       '), nl,
    write('       yMNddddyyyyyysooooooooooooooooooodMy       '), nl,
    write('       yMNddyyyyyysooooooooooooooooooooodMy       '), nl,
    write('     dMmdhyyyyyysooooo+..oooooooo+..oooooohMd     '), nl,
    write('     mMmdhyyyyyysooo/-...--+ooo/-...--+ooohMm     '), nl,
    write('     mMmdhyyyyyysooo/......+ooo/......+ooohMm     '), nl,
    write('     mMmdhyyyyyysooo/......+ooo/......+ooohMm     '), nl,
    write('     mMmdhyyyyyysoooo//..//ooooo//..//oooohMm     '), nl,
    write('     mMmdhyyyyyysoooooo//ooooooooo//oooooohMm     '), nl,
    write('     +ohNdhhyyyysssoooooooooooooooooooooydyo+     '), nl,
    write('       yMNddhhyyyysssooooooooooooooooooodMy       '), nl,
    write('       +yhmmddhhyyyysssoooooooooooooooyhyy+       '), nl,
    write('         :hdmmmmhhhhhhhyyyyyyyyyyyyyyyhh:         '), nl,
    write('           -mmmmmmmmmmmmmmmmmmmmmmmmmm-           '), nl.

printWolf :-
	write('                          /s+`                                                             '), nl,     
    write('                        sNMMMy                                                             '), nl,     
    write('                    .-` MMMMMN.                                                            '), nl,     
    write('                  `hNMy:MMMMMM+                                                            '), nl,     
    write('                  .yMMMMMMMMMMNo`                                                          '), nl,     
    write('                   `MMMMMMMMMMMMNs.                                                        '), nl,     
    write('                    yMMMMMMMMMMMMMNo                                                       '), nl,     
    write('                    sMMMMMMMMMMMMMMM:                                                      '), nl,     
    write('                  `+NMMMMMMMMMMMMMMMs                                                      '), nl,     
    write('                  /NMMMMMMMMMMMMMMMMy`                                                     '), nl,     
    write('                .hNMMMMMMMMMMMMMMMMMh`                                                     '), nl,     
    write('              -yNMMMMMMMMMMMMMMMMMMMMd-                                                    '), nl,     
    write('             .+dMMMMMMMMMMMMMMMMMMMMMMm/                                                   '), nl,     
    write('              .NMMMMMMMMMMMMMMMMMMMMmmNm+                                                  '), nl,     
    write('              .mMMMMMMMMMMMMMMMMMMMMNh:.                                                   '), nl,     
    write('              -mMMMMMMMMMMMMMMMMMMMMMd-                                                    '), nl,     
    write('             `hMMMMMMMMMMMMMMMMMMMMMMMmh:                                                  '), nl,     
    write('             sMMMMMMMMMMMMMMMMMMMMMMMMMMd.                                                 '), nl,     
    write('            `dMMMMMMMMMMMMMMMMMMMMMMMMMMMh:                                                '), nl,     
    write('            :sMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo`                                              '), nl,     
    write('            `sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMy.                                             '), nl,     
    write('            `yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd:`                                           '), nl,     
    write('            .yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmy+-`                                       '), nl,     
    write('            `dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNdo:`                      `-:+y:        '), nl,     
    write('            /MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd:                  `:+dNMMN/-       '), nl,     
    write('            .yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNs.               `+NMMMMMNs`       '), nl,     
    write('             `oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMy:`            `smMMMMMMN:        '), nl,     
    write('               +mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo.           :MMMMMMMMm.        '), nl,     
    write('                +mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm:`         .+MMMMMMMMN:.       '), nl,     
    write('                `sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo.         sMMMMMMMMMmy:`     '), nl,     
    write('                 :NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmo.`      `hMMMMMMMMMMN/     '), nl,     
    write('                 -NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh+.       oMMMMMMMMMMMy     '), nl,     
    write('                 -MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmy+.    `sMMMMMMMMMMh     '), nl,     
    write('                 /MMMMMMMMMMMMMMdsshMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd+`   -mMMMMMMMMMs     '), nl,     
    write('                 +MMMMMMMMMMMMMMd`  yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm+`  -mMMMMMMMMMs     '), nl,     
    write('                 oMMMMMMMMMMMMMMd- `hMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd- /NMMMMMMMMh-     '), nl,     
    write('                 oMMMMMMMMMMMMMN/ .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMy`+MMMMMMMMh.      '), nl,     
    write('                `dMMMMMMMMMMNoh:`  oMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+ oMMMMMMMN/       '), nl,     
    write('                +MMMMMMMMMMM+ `     yNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM-omMMMMMMd-        '), nl,     
    write('               -MMMMMMMMMMMy        `-ddyNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN.NMMMMMMm:         '), nl,     
    write('              `mMMMMMMMMMMN.           - -mMMMMMMMMMMMMMMMMMMMMMMMMMMMMydMMMMMNy:          '), nl,     
    write('             `yMMMMMMMMMMMh               .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMds:           '), nl,     
    write('         `-/-sMMMMMMMMMMMm.       `.`      `dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh+-`            '), nl,     
    write('      -ydmMMMMMMMMMMMMMMMd     -sdNMMmyo:.` .dMMMMMMMMMMMMMMMMMMMMMMMMMMMm+                '), nl,     
    write('     `dMMMMMMMMMMMMMMMMMMd    -NMMMMMMMMMMNmdNMMMMMMMMMMMMMMMMMMMMMMNmdy/`                 '), nl,     
    write('      /oooooooooooooooooo/    -ssssssssssssssssssssssssssssssssssso.                       '), nl.                                                                                          

printGoblin :-                                                                             
    write('                                                                 `/sdNN-                            '), nl,
    write('                                                           `-+shmNNNm+`                             '), nl,
    write('                                             -+sso/-    -odNNNNNNNNs.                               '), nl,
    write('                                           +mNNNNNNmNyymNNNNNNNNNy.                                 '), nl,
    write('                                      `.-:yNNNNNNNNNNNNNNNNNNNNs+                                   '), nl,
    write('                                .+oosdNNNNNNNNNNNNNNNNNNNNNNNd:                                     '), nl,
    write('                                +yhhdmNNNNNNNNNNNNNNNNNNNNNNy`                                      '), nl,
    write('                                   ````-+yNNNNNNNNNNNNNNNNNNNmdys+:.                                '), nl,
    write('                                        :yNNNNNNNNNNNNNNNNNNNNmNNNNNmy+-                            '), nl,
    write('                                       smNNmNNNNNNNNNNNNNNNNNNmNNNNNNNNNdo-                     -.  '), nl,
    write('                                      :Nd/./NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNh/`              .+hhNdd/'), nl,
    write('                                      -s`  .hNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNms/.        `/hNNNNNNs`'), nl,
    write('                                            `.-yNNNNNNNNNNNNNNNNNNNNNNNNNNNNmNNNmdo:` ./smNNNmdyo-  '), nl,
    write('                                                mNNNNNNNNNNNNNNNNNNNNNNyoyshddNNNNNNddmNNdy/.``     '), nl,
    write('                                                oNNmNNNNNNNNNNNNNNNNNNms  ``.-/yNNNNNNN+.`          '), nl,
    write('                                                hNNNNNNNNNNNNNNNNNNNNNdh. `-/ymNNNNNNNN             '), nl,
    write('                                               .NNNNNo.-/smNNNNNNNNNNNNNmydNNmho:oNNNNM/            '), nl,
    write('                                              /mNNNm/     .+yNNNNNNNNNNNNNNs:.   +NNNNNNs:          '), nl,
    write('                                             oNNNNN/        -NNNNNNNNNNNNNN-     hNNNNNNNNy-        '), nl,
    write('                 `                          /NNNNN+        `yMmNNNNNNNNNNNNy.   -NNm/yNNNNNN+       '), nl,
    write('                                          `+mNNNm:     `./ydNNNNNNNNNNNNNNNNmo. yd+. `hy:NNNNo      '), nl,
    write('                                         -dNNNNh.   .:sdNNNNNNNNNNNNNNNNNNNNNNmo++    /- :dNNN.     '), nl,
    write('                                        :mNNNNN-.:ohmNNNNNNNNNNNNNNNNNNNNNNNNNNNd/    .   /mdm`     '), nl,
    write('                                      `+NNNNNNNhmNNNNNNNNNNNNNNNNNNNNNh/dNNNNNNNNm-        --:      '), nl,
    write('                                      sNNNNNNNNNmNNmNNNNNNNmy/-dNNNNNN- `/hNNNNNNNd        `        '), nl,
    write('                                     `sNNNNNmdy/hNNNNNmho/-`   +NNNNNs    `+dNNNNNN:                '), nl,
    write('                                `../sdNNds/:-   yNNNNd-        .NNNNN`      `yNNNNNd:               '), nl,
    write('                          `.-/ssdNNNmy+-`       -NNNNN-         hmNNs         /dNNNNNo`             '), nl,
    write('                     `./oydNNNNNNNmo`            sNNNNh         -mmN-          `yNNNNNy`            '), nl,
    write('                 `./ydNNNNNNNNNmy:`    `         .NNNNN          mNm            .mNNNmNh`           '), nl,
    write('              `-ohNNNNNmddmNNNN+                  mNNNN          sNm`            .dNNNNNy           '), nl,
    write('           `:sdNNNNNNd+.  `:mms`                  mNNNm          :s-              `hNNNNN+          '), nl,
    write('        `:smNNNNNNms:       .`                   .NNNNy           `                `sNNNNN/         '), nl,
    write('     `:ymNNNNNNmy/`                              yNNNNm`                            `NNNNNNo`       '), nl,
    write('  `:ymmNNNNNms:`                             ``/hNNmNNNh                             mNNNNNNd:`     '), nl,
    write('.omNNNNNmy+-                           .+syyhdNNNNNNNNNN.                            :NNNNNNNNdo-`  '), nl,
    write(':ooo+/-`                             `yNNNNNNNNNNNNNNNd/                              hNNNNNNNNNNd  '), nl,
    write('                                     +hdhmmmdyso+/-..`                                `hNNNNNNNNds  '), nl.