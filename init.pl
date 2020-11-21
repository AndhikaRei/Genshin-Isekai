/* Inisialisasi Game */
:- include('peta.pl').
:- include('quest.pl').
:- include('player.pl').
:- include('store.pl').
:- include('inventory.pl').
:- include('saveloadtest.pl').
:- include('battle.pl').
:- include('enemy.pl').


:- dynamic(gameStarted/0).
:- dynamic(inBattle/0).
aku(3).
aku(2).

test :-
    (aku(1) ->write('1'); write('')),
    (aku(2) ->write('2')).
/* Start Game */
start :-
    \+ gameStarted,!,
    write('**************************************************************************************************'),nl,
    format('Welcome to Genshin Asik. Choose your job ~n 1. Swordsman ~n 2. Archer ~n 3. Sorcerer ~n > ',[]),
    read(A), chooseJob(A), replenishQuest, initialExp, initPpos, replenishBoss.

start :-
    !, write('Game sudah dimulai, ketik "help." untuk melihat aksi yang bisa dilakukan').

/* chooseJob : memilih job */
chooseJob(A) :-
    A =\= 1, A =\= 2, A =\= 3, !,write('Invalid input, please write start. again '), fail.

chooseJob(A) :-
    A =:= 1,
    baseStat('swordsman',C,D,E,F,G),
    assertz(player('swordsman',1,C,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Sword', 1], ['Health Potion', 5]])),
    !,
    write('You choose swordsman, let\'s explore the world'), nl,
    write('**************************************************************************************************'),nl.

chooseJob(A) :-
    A =:= 2,
    baseStat('archer',C,D,E,F,G),
    assertz(player('archer',1,C,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Bow', 1], ['Health Potion', 5]])),
    !,
    write('You choose archer, let\'s explore the world'), nl,
    write('**************************************************************************************************'),nl.

chooseJob(A) :-
    A =:= 3,
    baseStat('sorcerer',C,D,E,F,G),
    assertz(player('sorcerer',1,C,C,D,E,F,G)),
    assertz(gameStarted),
    assertz(playerEquipment(none, none, none)),
    assertz(inventory([['Wooden Staff', 1], ['Health Potion', 5]])),
    !,
    write('You choose sorcerer, let\'s explore the world'), nl,
    write('**************************************************************************************************'),nl.

/* help : menampilkan menu bantuan */
help :-
    inBattle,!,
    write('**************************************************************************************************'),nl,
    write('*                                    Welcome to Battle Menu                                      *'),nl,
    write('**************************************************************************************************'),nl,
    write('*                                 Menu List Here                                                 *'),nl,
    write('**************************************************************************************************'),nl.
help :-
    inStore,!,
    write('**************************************************************************************************'),nl,
    write('*                                    Welcome to Store Menu                                       *'),nl,
    write('**************************************************************************************************'),nl,
    write('*                                 Menu List Here                                                 *'),nl,
    write('**************************************************************************************************'),nl.
help :-
    gameStarted,!,
    write('**************************************************************************************************'),nl,
    write('*                                 Welcome to Adventure Menu                                      *'),nl,
    write('**************************************************************************************************'),nl,
    write('*    1. Movement = | w.-> up | a.-> left | s.-> down | d.-> right | t.-> teleport |              *'),nl,
    write('*    2. Quest = | tq.-> take a quest | pq.-> print quest status | fq.-> finish quest |           *'),nl,
    write('*    3. Inventory = | inventory.-> show inventory | drop(item,count).-> drop item *count |       *'),nl,
    write('*    4. Equipment = | equip(item).-> equip item | unequip(item).-> unequip item |                *'),nl,
    write('*    5. Dll.                                                                                     *'),nl,
    write('**************************************************************************************************'),nl.

/* Pengganti Sementaara Battle */
% battle :-
%     \+ inBattle, ! , assertz(inBattle),
%     write('           -dddddd:                               '), nl,
%     write('         :hhmmmmdhhhhhs                           '), nl,
%     write('         ./oNNddhhddddhyyyy.                      '), nl,
%     write('           `++NNddhhhyyddddys-                    '), nl,
%     write('              MMmdddhyyyyyyhdso:                  '), nl,
%     write('              MMmdddhyyyyyysohdy++++              '), nl,
%     write('           `:/NNdddhhyyyyssooooymmmm//`           '), nl,
%     write('         `-/NNdddhyyyyyssooooooooooomm/-`         '), nl,
%     write('       `.oMNddddyyyyyysooooooooooooooomNo.`       '), nl,
%     write('       yMNddddyyyyyysooooooooooooooooooodMy       '), nl,
%     write('       yMNddyyyyyysooooooooooooooooooooodMy       '), nl,
%     write('     dMmdhyyyyyysooooo+..oooooooo+..oooooohMd     '), nl,
%     write('     mMmdhyyyyyysooo/-...--+ooo/-...--+ooohMm     '), nl,
%     write('     mMmdhyyyyyysooo/......+ooo/......+ooohMm     '), nl,
%     write('     mMmdhyyyyyysooo/......+ooo/......+ooohMm     '), nl,
%     write('     mMmdhyyyyyysoooo//..//ooooo//..//oooohMm     '), nl,
%     write('     mMmdhyyyyyysoooooo//ooooooooo//oooooohMm     '), nl,
%     write('     +ohNdhhyyyysssoooooooooooooooooooooydyo+     '), nl,
%     write('       yMNddhhyyyysssooooooooooooooooooodMy       '), nl,
%     write('       +yhmmddhhyyyysssoooooooooooooooyhyy+       '), nl,
%     write('         :hdmmmmhhhhhhhyyyyyyyyyyyyyyyhh:         '), nl,
%     write('           -mmmmmmmmmmmmmmmmmmmmmmmmmm-           '), nl,
%     write('Anda menenukan slime'),                                                                                             
                                                                                                    
%     write('                          /s+`                                                             '), nl,     
%     write('                        sNMMMy                                                             '), nl,     
%     write('                    .-` MMMMMN.                                                            '), nl,     
%     write('                  `hNMy:MMMMMM+                                                            '), nl,     
%     write('                  .yMMMMMMMMMMNo`                                                          '), nl,     
%     write('                   `MMMMMMMMMMMMNs.                                                        '), nl,     
%     write('                    yMMMMMMMMMMMMMNo                                                       '), nl,     
%     write('                    sMMMMMMMMMMMMMMM:                                                      '), nl,     
%     write('                  `+NMMMMMMMMMMMMMMMs                                                      '), nl,     
%     write('                  /NMMMMMMMMMMMMMMMMy`                                                     '), nl,     
%     write('                .hNMMMMMMMMMMMMMMMMMh`                                                     '), nl,     
%     write('              -yNMMMMMMMMMMMMMMMMMMMMd-                                                    '), nl,     
%     write('             .+dMMMMMMMMMMMMMMMMMMMMMMm/                                                   '), nl,     
%     write('              .NMMMMMMMMMMMMMMMMMMMMmmNm+                                                  '), nl,     
%     write('              .mMMMMMMMMMMMMMMMMMMMMNh:.                                                   '), nl,     
%     write('              -mMMMMMMMMMMMMMMMMMMMMMd-                                                    '), nl,     
%     write('             `hMMMMMMMMMMMMMMMMMMMMMMMmh:                                                  '), nl,     
%     write('             sMMMMMMMMMMMMMMMMMMMMMMMMMMd.                                                 '), nl,     
%     write('            `dMMMMMMMMMMMMMMMMMMMMMMMMMMMh:                                                '), nl,     
%     write('            :sMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo`                                              '), nl,     
%     write('            `sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMy.                                             '), nl,     
%     write('            `yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd:`                                           '), nl,     
%     write('            .yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmy+-`                                       '), nl,     
%     write('            `dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNdo:`                      `-:+y:        '), nl,     
%     write('            /MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd:                  `:+dNMMN/-       '), nl,     
%     write('            .yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNs.               `+NMMMMMNs`       '), nl,     
%     write('             `oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMy:`            `smMMMMMMN:        '), nl,     
%     write('               +mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo.           :MMMMMMMMm.        '), nl,     
%     write('                +mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm:`         .+MMMMMMMMN:.       '), nl,     
%     write('                `sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo.         sMMMMMMMMMmy:`     '), nl,     
%     write('                 :NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmo.`      `hMMMMMMMMMMN/     '), nl,     
%     write('                 -NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh+.       oMMMMMMMMMMMy     '), nl,     
%     write('                 -MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmy+.    `sMMMMMMMMMMh     '), nl,     
%     write('                 /MMMMMMMMMMMMMMdsshMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd+`   -mMMMMMMMMMs     '), nl,     
%     write('                 +MMMMMMMMMMMMMMd`  yMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm+`  -mMMMMMMMMMs     '), nl,     
%     write('                 oMMMMMMMMMMMMMMd- `hMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd- /NMMMMMMMMh-     '), nl,     
%     write('                 oMMMMMMMMMMMMMN/ .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMy`+MMMMMMMMh.      '), nl,     
%     write('                `dMMMMMMMMMMNoh:`  oMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+ oMMMMMMMN/       '), nl,     
%     write('                +MMMMMMMMMMM+ `     yNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM-omMMMMMMd-        '), nl,     
%     write('               -MMMMMMMMMMMy        `-ddyNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN.NMMMMMMm:         '), nl,     
%     write('              `mMMMMMMMMMMN.           - -mMMMMMMMMMMMMMMMMMMMMMMMMMMMMydMMMMMNy:          '), nl,     
%     write('             `yMMMMMMMMMMMh               .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMds:           '), nl,     
%     write('         `-/-sMMMMMMMMMMMm.       `.`      `dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh+-`            '), nl,     
%     write('      -ydmMMMMMMMMMMMMMMMd     -sdNMMmyo:.` .dMMMMMMMMMMMMMMMMMMMMMMMMMMMm+                '), nl,     
%     write('     `dMMMMMMMMMMMMMMMMMMd    -NMMMMMMMMMMNmdNMMMMMMMMMMMMMMMMMMMMMMNmdy/`                 '), nl,     
%     write('      /oooooooooooooooooo/    -ssssssssssssssssssssssssssssssssssso.                       '), nl,     
%     write('Anda menenukan wolf'),                                                                                           

%     write('                                                                 `/sdNN-                            '), nl,
%     write('                                                           `-+shmNNNm+`                             '), nl,
%     write('                                             -+sso/-    -odNNNNNNNNs.                               '), nl,
%     write('                                           +mNNNNNNmNyymNNNNNNNNNy.                                 '), nl,
%     write('                                      `.-:yNNNNNNNNNNNNNNNNNNNNs+                                   '), nl,
%     write('                                .+oosdNNNNNNNNNNNNNNNNNNNNNNNd:                                     '), nl,
%     write('                                +yhhdmNNNNNNNNNNNNNNNNNNNNNNy`                                      '), nl,
%     write('                                   ````-+yNNNNNNNNNNNNNNNNNNNmdys+:.                                '), nl,
%     write('                                        :yNNNNNNNNNNNNNNNNNNNNmNNNNNmy+-                            '), nl,
%     write('                                       smNNmNNNNNNNNNNNNNNNNNNmNNNNNNNNNdo-                     -.  '), nl,
%     write('                                      :Nd/./NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNh/`              .+hhNdd/'), nl,
%     write('                                      -s`  .hNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNms/.        `/hNNNNNNs`'), nl,
%     write('                                            `.-yNNNNNNNNNNNNNNNNNNNNNNNNNNNNmNNNmdo:` ./smNNNmdyo-  '), nl,
%     write('                                                mNNNNNNNNNNNNNNNNNNNNNNyoyshddNNNNNNddmNNdy/.``     '), nl,
%     write('                                                oNNmNNNNNNNNNNNNNNNNNNms  ``.-/yNNNNNNN+.`          '), nl,
%     write('                                                hNNNNNNNNNNNNNNNNNNNNNdh. `-/ymNNNNNNNN             '), nl,
%     write('                                               .NNNNNo.-/smNNNNNNNNNNNNNmydNNmho:oNNNNM/            '), nl,
%     write('                                              /mNNNm/     .+yNNNNNNNNNNNNNNs:.   +NNNNNNs:          '), nl,
%     write('                                             oNNNNN/        -NNNNNNNNNNNNNN-     hNNNNNNNNy-        '), nl,
%     write('                 `                          /NNNNN+        `yMmNNNNNNNNNNNNy.   -NNm/yNNNNNN+       '), nl,
%     write('                                          `+mNNNm:     `./ydNNNNNNNNNNNNNNNNmo. yd+. `hy:NNNNo      '), nl,
%     write('                                         -dNNNNh.   .:sdNNNNNNNNNNNNNNNNNNNNNNmo++    /- :dNNN.     '), nl,
%     write('                                        :mNNNNN-.:ohmNNNNNNNNNNNNNNNNNNNNNNNNNNNd/    .   /mdm`     '), nl,
%     write('                                      `+NNNNNNNhmNNNNNNNNNNNNNNNNNNNNNh/dNNNNNNNNm-        --:      '), nl,
%     write('                                      sNNNNNNNNNmNNmNNNNNNNmy/-dNNNNNN- `/hNNNNNNNd        `        '), nl,
%     write('                                     `sNNNNNmdy/hNNNNNmho/-`   +NNNNNs    `+dNNNNNN:                '), nl,
%     write('                                `../sdNNds/:-   yNNNNd-        .NNNNN`      `yNNNNNd:               '), nl,
%     write('                          `.-/ssdNNNmy+-`       -NNNNN-         hmNNs         /dNNNNNo`             '), nl,
%     write('                     `./oydNNNNNNNmo`            sNNNNh         -mmN-          `yNNNNNy`            '), nl,
%     write('                 `./ydNNNNNNNNNmy:`    `         .NNNNN          mNm            .mNNNmNh`           '), nl,
%     write('              `-ohNNNNNmddmNNNN+                  mNNNN          sNm`            .dNNNNNy           '), nl,
%     write('           `:sdNNNNNNd+.  `:mms`                  mNNNm          :s-              `hNNNNN+          '), nl,
%     write('        `:smNNNNNNms:       .`                   .NNNNy           `                `sNNNNN/         '), nl,
%     write('     `:ymNNNNNNmy/`                              yNNNNm`                            `NNNNNNo`       '), nl,
%     write('  `:ymmNNNNNms:`                             ``/hNNmNNNh                             mNNNNNNd:`     '), nl,
%     write('.omNNNNNmy+-                           .+syyhdNNNNNNNNNN.                            :NNNNNNNNdo-`  '), nl,
%     write(':ooo+/-`                             `yNNNNNNNNNNNNNNNd/                              hNNNNNNNNNNd  '), nl,
%     write('                                     +hdhmmmdyso+/-..`                                `hNNNNNNNNds  '), nl,                                     
%     write('Anda menenukan goblin').  
% battle :-
%     !, retract(inBattle), write('Anda menang').