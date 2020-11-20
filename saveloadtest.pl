/*save() = Menyimpan data permainan*/

save :-
    (\+ gameStarted -> 
        write('The game has not started, type "start." to play the game')
    ; inBattle -> 
        write('You are currently in battle, please type "help." to see the command while in battle')
    ; inStore -> 
        write('You are in store, type "help." to see command in store')
    ;   
        tell(savefile),
		playerFact,
        questFact,
        mapFact,
        killedBossFact,
	told, !
    ).
    
playerFact :-
    playerPos(X,Y), write(playerPos(X,Y)),write('.'),nl,
	inventory(Inv), write(inventory(Inv)),write('.'), nl,
    playerEquipment(Weap, Armor, Acc), write(playerEquipment(Weap, Armor, Acc)),write('.'), nl,
    player(Class, Lvl, HP, MaxHP, Att, Def, Exp, Gold), write(player(Class, Lvl, HP, MaxHP, Att, Def, Exp, Gold)),write('.'), nl,
    exp(G,H,I), write(exp(G,H,I)),write('.'),nl.

questFact :-
    (quest(A,B,C,D,E,F) -> (write(quest(A,B,C,D,E,F)),write('.'),nl); write('')).

mapFact :-
    questRemaining(A,B,C,D), write(questRemaining(A,B,C,D)),write('.'),nl,
    ( A=:=1 -> (write(elmtPeta(3,8,'Q')),write('.'),nl); write('')),
    ( B=:=1 -> (write(elmtPeta(12,3,'Q')),write('.'),nl); write('')),
    ( C=:=1 -> (write(elmtPeta(13,17,'Q')),write('.'),nl); write('')),
    ( D=:=1 -> (write(elmtPeta(2,12,'Q')),write('.'),nl); write('')).

killedBossFact :-
    livingBosses(A,B), write(livingBosses(A,B)),write('.'),nl,
    ( A=:=1 -> (write(elmtPeta(3,17,'H')),write('.'),nl); write('')),
    ( B=:=1 -> (write(elmtPeta(3,19,'A')),write('.'),nl); write('')).

deleteData :-
    retractall(inventory(_)), 
    retractall(player(_,_,_,_,_,_,_,_)), 
    retractall(playerEquipment(_,_,_)),
    retractall(exp(_,_,_)),
    retractall(playerPos(_,_)),
    retractall(questRemaining(_,_,_,_)), 
    retractall(elmtPeta(_,_,'Q')), 
    retractall(quest(_,_,_,_,_,_)),
    retractall(livingBosses(_,_)).
    
/*load() = Me load data berupa fakta fakta khusus */
load:-
    ( gameStarted -> 
        write('You can only load game data before the gamse started')
    ; inBattle -> 
        write('You can only load game data before the gamse started')
    ; inStore -> 
        write('You can only load game data before the gamse started')
    ;   
        ((\+file_exists(savefile)) ->
        write('File tersebut tidak ada.'), nl, ! ;
        open('savefile', read, Str),
        read_file(Str,Lines),
        close(Str), assertz(gameStarted), assertFakta(Lines), !)
    ).

/* Membaca file data per line */
read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).

/* 	assertaFakta(Kumpulan Fakta) = meng-asserta semua fakta  */
    assertFakta([]) :- !.
    assertFakta([X|L]):- assertz(X),
	                     assertFakta(L), !.

/* 	Exit  */
finish :-
    !, deleteData, retractall(gameStarted).