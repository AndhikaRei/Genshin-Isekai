:- dynamic(inBattleEnemy/10).
/* diassert pas encounter */
/* pas diserang, dia diretract & diassert */
/* kalau udah selesai battle, di retract lagi */


/* btw kayaknya ini kalau selesai battle, pertambahan exp nya juga belum deh */
/* Jadi kayaknya itu diperlukan juga */

/* id unik enemy */
idEnemy(1, smallSlime) :- !.
idEnemy(2, bigSlime) :- !.
idEnemy(3, recruitGoblin) :- !.
idEnemy(4, berserkerGoblin) :- !.
idEnemy(5, standardWolf) :- !.
idEnemy(6, direWolf) :- !.
idEnemy(7, hypostasis) :- !.
idEnemy(8, andrius) :- !.

/* baseEnemy(X, HP, ATK, Special ATK, DEF, exp given, MinGoldGiven, MaxGoldGiven) */
/* base stats enemy di level 1 */
baseEnemy(smallSlime, 75, 30, 50, 5, 1, 50, 150).
baseEnemy(bigSlime, 100, 40, 70, 10, 2, 100, 200).
baseEnemy(recruitGoblin, 125, 50, 80, 10, 3, 200, 300).
baseEnemy(berserkerGoblin, 200, 75, 120, 15, 4, 200, 400).
baseEnemy(standardWolf, 180, 70, 130, 20, 5, 300, 500).
baseEnemy(direWolf, 260, 100, 200, 25, 6, 300, 600).

/* growthRate(X, Max HP, ATK, Special ATK, DEF, exp given*/
/* enemy naik level tiap player naik level */
growthEnemy(smallSlime, 10, 5, 7, 2, 4).
growthEnemy(bigSlime, 15, 10, 12, 3, 6).
growthEnemy(recruitGoblin, 15, 8, 10, 2, 4).
growthEnemy(berserkerGoblin, 20, 13, 15, 4, 7).
growthEnemy(standardWolf, 20, 12, 14, 3, 4).
growthEnemy(direWolf, 30, 15, 19, 5, 8).
	
/* boss(X, Level, HP, Max HP, ATK, Special ATK, DEF, EXPGAIN, GOLDGAIN) */
/* X adalah nama boss dengan atribut level, HP, Max HP, ATK, Special ATK, dan DEF yang sudah didefinisi */
boss(hypostasis, 20, 4000, 4000, 600, 1000, 60, 5000, 50000, 50000).
boss(andrius, 30, 9000, 9000, 900, 1500, 70, 12000, 100000, 100000).

printGBEnemy(IdEnemy) :-
    !,
	(IdEnemy =:= 1 -> printSlime
	;IdEnemy =:= 2 -> printSlime
	;IdEnemy =:= 3 -> printGoblin
	;IdEnemy =:= 4 -> printGoblin
	;IdEnemy =:= 5 -> printWolf
	;IdEnemy =:= 6 -> printWolf
    ;true
	).

printSlime :-
	write('           -dddddd:                          '), nl,
    write('         :hhmmmmdhhhhhs                      '), nl,
    write('         ./oNNddhhddddhyyyy.                 '), nl,
    write('           `++NNddhhhyyddddys-               '), nl,
    write('              MMmdddhyyyyyyhdso:             '), nl,
    write('              MMmdddhyyyyyysohdy++++         '), nl,
    write('           `:/NNdddhhyyyyssooooymmmm//`      '), nl,
    write('         `-/NNdddhyyyyyssooooooooooomm/-`    '), nl,
    write('       `.oMNddddyyyyyysooooooooooooooomNo.`  '), nl,
    write('       yMNddddyyyyyysooooooooooooooooooodMy  '), nl,
    write('       yMNddyyyyyysooooooooooooooooooooodMy  '), nl,
    write('     dMmdhyyyyyysooooo+..oooooooo+..oooooohMd'), nl,
    write('     mMmdhyyyyyysooo/-...--+ooo/-...--+ooohMm'), nl,
    write('     mMmdhyyyyyysooo/......+ooo/......+ooohMm'), nl,
    write('     mMmdhyyyyyysooo/......+ooo/......+ooohMm'), nl,
    write('     mMmdhyyyyyysoooo//..//ooooo//..//oooohMm'), nl,
    write('     mMmdhyyyyyysoooooo//ooooooooo//oooooohMm'), nl,
    write('     +ohNdhhyyyysssoooooooooooooooooooooydyo+'), nl,
    write('       yMNddhhyyyysssooooooooooooooooooodMy  '), nl,
    write('       +yhmmddhhyyyysssoooooooooooooooyhyy+  '), nl,
    write('         :hdmmmmhhhhhhhyyyyyyyyyyyyyyyhh:    '), nl,
    write('           -mmmmmmmmmmmmmmmmmmmmmmmmmm-      '), nl.

printWolf :-
    write('                                          :yy    '), nl,
    write('                                      .:ymMdMy   '), nl,
    write('                                   :odMdo:---M   '), nl,
    write('                         :odmdyhNMsdMMh-....-M   '), nl,
    write('                      /ymMhdh-/hNmMMMMN-....y/   '), nl,
    write('                    /mMdNNo:+oo+/sNMMMm....s:    '), nl,
    write('                  .mMMM//:oNMNoyN/NMMd`....M :yh.'), nl,
    write('                 oMMMMM.:NModMsossMMM/.....yMmmM-'), nl,
    write('               .dMMMMMd:sMh/MMh-::MMM.`.....`+d- '), nl,
    write('             /yMMN/...hh+MMoNdM:--+MM...../so.   '), nl,
    write('          odMMMMMdo:hsssdoNMs.dh---dM--.-d/      '), nl,
    write('          /mMMMMMMMh:.:odNooMNMN--hy+-++m.       '), nl,
    write('            :dMMMMNdmmmdyhdh+hMy::N::sdM:        '), nl,
    write('          :yMMMMMMMMhsoo++/+so/o+:sm:yMM/        '), nl,
    write('       ./mMMMMMMMMMNyssoo+++//:NM::mNhM/m.       '), nl,
    write('         /mMMMMMMMhMMmhyody+++oMMsoh:/ym/.       '), nl,
    write('       /mMMMMMMNo/hMh/N:.oMNdyNMMh/sMy           '), nl,
    write('     /mmMMMMMNo:hMMN/NMNo./NMMMMMN+odMm:         '), nl,
    write('      :mMMMMh/NMMMMdMMNodNo.ohNMMMhsyM.m:        '), nl,
    write('     yMMMMNohMMMMMMMMMdy-oMh:.sMMmhmsM..m        '), nl,
    write('    dMMMMMNMMMMMMMddddodd-/NN::MMNoddMo .        '), nl,
    write('    MMMMMMMMMNdddMMdssshMo-:MM/MMMmMMMo          '), nl,
    write('    MMNsMMMMMMddy+-:////--:hMMMMMMMm.mm          '), nl,
    write('    Mo:MMNdhddNMMMNdhsshdNMd:/MMMMm. oo          '), nl,
    write('    :odo---...-hMNhss/oNMh:..-MMNo.  :           '), nl.

printGoblin :-                                                                             
    write('                                         .:+hNh`                 '), nl,
    write('                              `/oo+- .+hNMMMd-                   '), nl,
    write('                           `./NMMMMMMMMMMMd/                     '), nl,
    write('                       /hhmMMMMMMMMMMMMMN/                       '), nl,
    write('                        `.-:oNMMMMMMMMMMmhs+:.                   '), nl,
    write('                           .dMMMMMMMMMMMMMMMmNms:             `  '), nl,
    write('                           ho.hMMMMMMMMMMMMMMNNMMNo.       -sdNm-'), nl,
    write('                              `:sMMMMMMMMMMMMMMMMMMMNy/`-omMmho. '), nl,
    write('                                 mMMMMMMMMMMMMM+-/oymMMMNs:`     '), nl,
    write('                                 NMMmdNMMMMMMMMd-/yNmNMMd        '), nl,
    write('                               `hMMs`  /yMMMMMMMMd/. oMMMy-      '), nl,
    write('                              `mMMh     +MMMMMMMMh  `mNdMMMy`    '), nl,
    write('                             -dMMo   -odMMMMMMMMMMm/:y. y:mMd    '), nl,
    write('                            /MMMo-+hNMMMMMMMMMMMMMMMm/  ` -hd`   '), nl,
    write('                           yMMMMMMMMMMMMNyNMMMy-hMMMMN.    ..    '), nl,
    write('                          -mMNds/mMMNs/.  oMNm`  -hMMMs          '), nl,
    write('                    -/oydmy+.    sMMh     -NMs     +NMMh`        '), nl,
    write('               ./ymMMMMmo.       `MMM-     hM-      .NMMm.       '), nl,
    write('            -smMMNysmMd           dMM-     /m.       -NMMm`      '), nl,
    write('        `:yNMMMh:   `:            mMM`     ``         .dMMh`     '), nl,
    write('     `/yNMMNh/`                 `sMMM+                 +MMMd-    '), nl,
    write('   `sNMmho-                :yhhmMMMMMm                 `NMMMMd+` '), nl,
    write('                          :ddmdhss+/:`                  :NMNNNm/ '), nl,
    write('                                                          ``     '), nl.
    