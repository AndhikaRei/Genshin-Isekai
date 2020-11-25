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

/* base stats enemy di level 1 */
/* baseEnemy(X,             HP, ATK, SAtk, DEF, Exp, MinGoldGiven, MaxGoldGiven) */
baseEnemy(smallSlime,       80,  30,   50,   5,   2,  50, 150).
baseEnemy(bigSlime,        120,  40,   70,  10,   2, 100, 200).
baseEnemy(recruitGoblin,   160,  50,   80,  10,   4, 200, 300).
baseEnemy(berserkerGoblin, 220,  75,  120,  15,   4, 200, 400).
baseEnemy(standardWolf,    245,  70,  130,  20,   6, 300, 500).
baseEnemy(direWolf,        300, 100,  200,  25,   6, 300, 600).

/* enemy naik level tiap player naik level */
/* growthRate(X,             HP, ATK, SAtk, DEF, exp given */
growthEnemy(smallSlime,      25,   9,    7,   8,  7).
growthEnemy(bigSlime,        35,  10,   12,  12,  9).
growthEnemy(recruitGoblin,   40,  11,   12,   8,  7).
growthEnemy(berserkerGoblin, 40,  16,   15,  14, 10).
growthEnemy(standardWolf,    40,  12,   14,   9,  7).
growthEnemy(direWolf,        50,  20,   20,  15, 11).
	
/* boss(X, Level, HP, Max HP, ATK, Special ATK, DEF, EXPGAIN, MINGOLDGAIN, MAXGOLDGAIN) */
/* X adalah nama boss dengan atribut level, HP, Max HP, ATK, Special ATK, dan DEF yang sudah didefinisi */
boss(hypostasis, 20, 5000, 5000, 1000, 1000, 200, 6000, 50000, 50000).
boss(andrius, 30, 10000, 10000, 2000, 1400, 300, 15000, 100000, 100000).

printGBEnemy(IdEnemy) :-
    !,
	(IdEnemy =:= 1 -> printSlime, write('You found a small slime'), nl
	;IdEnemy =:= 2 -> printSlime, write('You found a big slime'), nl
	;IdEnemy =:= 3 -> printGoblin, write('You found a recruit goblin'), nl
	;IdEnemy =:= 4 -> printGoblin, write('You found a berserker goblin'), nl
	;IdEnemy =:= 5 -> printWolf, write('You found a standard wolf'), nl
	;IdEnemy =:= 6 -> printWolf, write('You found a dire wolf'), nl
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

printHipostasis :-
write('    `+.      /:                          '), nl,
write('    .sy+.//-ohs`                         '), nl,
write('     +dNdddhNNm/                         '), nl,
write('      .hddddmmmh`                        '), nl,
write('       yhmdmhdmmo                        '), nl,
write('       :hdmdhhdmy                        '), nl,
write('       -shdmysyyh`                       '), nl,
write('      -ys+yyoosyyy+:.                    '), nl,
write('     /o//+ooosysooosyo                   '), nl,
write('    `oyso+///+ooo++ssh.                  '), nl,
write('    ++o+/:::/+yhhhsyydo                  '), nl,
write('    -ysoooosshyhyd+yyyy`                 '), nl,
write('   `osssssssssyhd/ :ooso`-               '), nl,
write('   :++yso+oooshdo   +ysssy++/++:.`       '), nl,
write('  `sss/ss+/+oydd/--.:osshsyyhyhdhs.      '), nl,
write(' `osh-.oo//+syhdddddhyyshsyyhyhmNdy/.    '), nl,
write(' oyhh`.s+:/oyhhdhddddhyyyshdhhysooooh`   '), nl,
write(' -//- -hssyyhhhmmmdddysosoyyyyyoooohh    '), nl,
write('      :yssyyhyhdmddddhssyosyyhhyhhmdo    '), nl,
write('      yhyshyyhhhddddmmdysohdd/sdddmdo    '), nl,
write('      +dhhhhhhhhyyhmmmdysyddh:shdmmms.   '), nl,
write('       shhhyyyhhddmmdmdhhyhNs-/`.:omh+   '), nl,
write('       `:yhyyyyhmmdmNNh/. mm-      hNo   '), nl,
write('         `+oddddNmmmNN:  -ds       :ms   '), nl,
write('           :mNmmNmmmm:   odd       `dh/  '), nl,
write('           omNdmNmdm+   -sho       `ydo  '), nl,
write('           `yNyyNmmh    yhh:       +yh/  '), nl,
write('            /md/mmm-    `.`        -:-   '), nl,
write('            .mmyNmy                      '), nl,
write('           `odm:mdy                      '), nl,
write('           ymmdommd                      '), nl,
write('           ..` `mmm                      '), nl,
write('               `hdh                      '), nl,
write('              -ddmmo                     '), nl,
write('              :sdy/                      '), nl.

printAndrius :-
write('          .h//sh/.///-``                          '), nl,
write('        -sNMMMMMNMMMMMNdo.                        '), nl,
write('      `dMMMMMMMMMMMMMMMMMmdy/                     '), nl,
write('    ./hMMMMMMMMMMMMMMMMMMMMMMm+`                  '), nl,
write('  :dNMMMMMMMMMMMMMMMMMMMMMMMMMMh                  '), nl,
write('   +hhsssNMMMMMMMMMMMMMMMMMMMMMM+`                '), nl,
write('     ./smhhNMMMMMMMMMMMMMMMMMMMMMms-   -          '), nl,
write('     `/-```.+MMMMMMMMMMMMMMMMMMMMMMNd+-o-         '), nl,
write('            hMMMMMMMMMMMMMMMMMMhhdmmmMNMh         '), nl,
write('            hMMMMMMMMMMMMMMMMMs` ````dMMM/        '), nl,
write('            `hMMMMMMMMMMMMMMMy`      dMMMN`       '), nl,
write('         `-:+hMMhhMMMMMMMMMMM.       dMMMMy       '), nl,
write('      ./smNMMMMMm++NMMMMMMMMN        -hNMMm`      '), nl,
write('    .ymNMMMMNh/-.` :NMMMMMMMM:         /MMM/      '), nl,
write('   /mMMNmhy+-       hMMMMMMMMm/     ..:/NMMs      '), nl,
write(' -yNMMMm.          `+MMMMMMMMMN+  `:s+yMMMN:      '), nl,
write('/NNMMs:d+        -odNMMMMMMMMMMN- ` `:yMMMo       '), nl,
write('syN+M- -o      `oNMMMMMMMMMMMMMMo`-+yydNMm`       '), nl,
write('.`m.h: `      /mMMMMMMMMMMMMMMMMm. `ossdm-        '), nl,
write('  . ``      `oNMMMMMMMNNMMMNMMMMMm+.` ..`         '), nl,
write('           `yMMMMMMMmh/:mNm+dMMMMMMd-             '), nl,
write('           oMMMMMNmo`   .-.``hMMMMMMN:            '), nl,
write('           sMMMMN+`          `+mMMMMMd`           '), nl,
write('           `+dMMNs.`           `:smMMMs`          '), nl,
write('             `sNMMNds:`           `sNMMms-`       '), nl,
write('               -dMMMMMs             -dMMMMmy`     '), nl,
write('                `NMMMMs              `hMMMMM:     '), nl,
write('                 oMMM+.               .yNMMMs     '), nl,
write('                 dMMM.                  -hMMN:    '), nl,
write('                 MMMM:                    sMMMo`  '), nl,
write('                /MMMMo                     yMMMm: '), nl,
write('             `ymMMMMM+                     +MMMMM/'), nl,
write('             +dMMMNMh-                   `mMMMMMMd'), nl,
write('             `.-.-``                     -+dhdhho`'), nl,
write('The Died ALPHA WOLF that received mighty powers from Merlin.'), nl.
