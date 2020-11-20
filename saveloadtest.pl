/*save() = Menyimpan data permainan*/
save:-
    open('saveData',write,S),
    set_output(S),
		playerFact,
        mapFact,
        killedBossFact,
	close(S), !.

playerFact :-
    playerPos(X,Y), write(playerPos(X,Y)),write('.'),nl,
	inventory(Inv), write(inventory(Inv)),write('.'), nl,
    playerEquipment(Weap, Armor, Acc), write(playerEquipment(Weap, Armor, Acc)),write('.'), nl,
    player(Class, Lvl, HP, MaxHP, Att, Def, Exp, Gold), write(player(Class, Lvl, HP, MaxHP, Att, Def, Exp, Gold)),write('.'), nl,
    exp(G,H,I), write(exp(G,H,I)),write('.'),nl.

questFact :-
    (quest(A,B,C,D,E,F) -> (write(quest(A,B,C,D,E,F)),write('.'),nl)).

mapFact :-
    questRemaining(A,B,C,D),
    ( A=:=1 -> (write(elmtPeta(3,8,'Q')),write('.'),nl); write('')),
    ( B=:=1 -> (write(elmtPeta(12,3,'Q')),write('.'),nl); write('')),
    ( C=:=1 -> (write(elmtPeta(13,17,'Q')),write('.'),nl); write('')),
    ( D=:=1 -> (write(elmtPeta(2,12,'Q')),write('.'),nl); write('')).

killedBossFact :-
    write(test).

/*load() = Memasukkan data permainan yang telah disimpan sebelumnya*/
loads:-
    ((\+file_exists('saveData')) ->
	write('File tersebut tidak ada.'), nl, ! ;
    open('saveData', read, Str),
    read_file(Str,Lines),
    close(Str), assertaList(Lines), !).

/* Membaca file menjadi list of lines */
read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).

/* 	assertaList(ListFakta) = meng-asserta semua fakta dalam ListFakta  */
    assertaList([]) :- !.

    assertaList([X|L]):- assertz(X),
	                     assertaList(L), !.