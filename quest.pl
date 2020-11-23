/* quest(A,A1,B,B1,C,C1) membunuh slime sejumlah A, goblin sejumlah B, dan wolf sejumlah C1, tanpa mempedulikan jenisnya (?) */
:- dynamic(quest/6).

/* questRemaining(A,B,C,D) A,B,C,D menyimbolkan 4 quest yang ada di map dan nilainya akan satu jika quest nya masih ada */
:- dynamic(questRemaining/4).

/* replenishQuest : merefresh quest yang ada */
replenishQuest :-
    retractall(questRemaining(_,_,_,_)), retractall(elmtPeta(_,_,'Q')), retractall(quest(_,_,_,_,_,_)),
    assertz(elmtPeta(3,8,'Q')),assertz(elmtPeta(12,3,'Q')), assertz(elmtPeta(13,17,'Q')), assertz(elmtPeta(2,12,'Q')),
    assertz(questRemaining(1,1,1,1)).

/* livingBosses(A,B) A menandakan apakah hypostatis masih hidup, B menandakan apakah Adrius masih hidup atau tidak */
:- dynamic(livingBosses/2).

/* replenishBoss : merefresh boss yang ada */
replenishBoss :-
    retractall(livingBosses(_,_)),
    assertz(elmtPeta(3,17,'H')),assertz(elmtPeta(1,17,'A')), assertz(livingBosses(1,1)).

/* tq : takeQuest di tempat dimana simbol 'Q' berada, quest tidak bisa dicancel dan setelah quest diambil maka quest hilang */
tq :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
tq :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
tq :- 
    quest(_,_,_,_,_,_) ,!, write('You cant take multiple quest at once').
tq :- 
    playerPos(A,B),elmtPeta(A,B,'Q'),!, random(3, 13, A1), random(6, 15, B1), random(3, 10, C1),
    assertz(quest(A1,A1,B1,B1,C1,C1)),!, 
    questRemaining(W,X,Y,Z),
    ( (A=:=3,B=:=8)->
        retract(questRemaining(W,X,Y,Z)),
		ExpGain is (A1*15 + B1*25 +C1*40), GoldGain is (A1*200 + B1*300 + C1*500),
		write('You\'ve come to a house in the village'), nl,
		write('It was heard that the owner is not that brave to go outside the village'), nl,
		write('You went inside'), nl,
		write('You found the owner\'s phone number written on a wrinkled paper'), nl,
		write('and,'), nl,
		write('a request from the owner.'), nl,
		write('**************************************************************************************************'),nl,
		write('*                                             Quest                                              *'),nl,
		write('**************************************************************************************************'),nl,
	    write('* Slay :                                                                                         *'),nl,
	    (A1 < 10 ->
	   format('* ~d Slime                                                                                        *', [A1]),nl
	    ;
	   format('* ~d Slime                                                                                       *', [A1]),nl),
	    (B1 < 10 ->
	   format('* ~d Goblin                                                                                       *', [B1]),nl	
	    ;
	   format('* ~d Goblin                                                                                      *', [B1]),nl),
	   format('* ~d Wolf                                                                                         *', [C1]),nl,
	    write('**************************************************************************************************'),nl,
		write('* The reward is :                                                                                *'),nl,
	   format('* ~d Exp                                                                                        *', [ExpGain]), nl,
	    ((GoldGain < 10000) ->
	   format('* ~d Gold                                                                                      *', [GoldGain]), nl
		;
	   format('* ~d Gold                                                                                     *', [GoldGain]), nl),
	    write('* Call me when you have finished the quest by entering \'tq.\'. Thank you so much.                 *'),nl,
		write('**************************************************************************************************'),nl,
    
		assertz(questRemaining(0,X,Y,Z))
    ; (A=:=12,B=:=3)->
        retract(questRemaining(W,X,Y,Z)),
		ExpGain is (A1*15 + B1*25 +C1*40), GoldGain is (A1*200 + B1*300 + C1*500),
		write('When you first became an adventurer, someone told you to look for the wizard in a monster habitat.'), nl,
		write('And now....'), nl,
		write('You are in front of a house in the woods, believed to be the home of the wizard.'), nl,
		write('You opened the door.'), nl,
		write('You become frozen while standing because you\'re surprised.'), nl,
		write('No one is inside.'), nl,
		write('The house is filled in a very deep darkness.'), nl,
		write('When you take your first step inside, you are drown into the abyss.'), nl,
		write('You are now standing in front of a tall man with pointy hat.'), nl,
		write('He introduced himself as Merlin the great magician.'), nl,
		write('He told you the story of a great adventurer that once saved this land.'), nl,
		write('You are inspired by the story and the character.'), nl,
		write('You want to become stronger and richer.'), nl,
		write('He give you a paper believed to be the adventurer\'s training montage.'), nl,
		write('You believed and accepted the offer.'), nl,
		write('**************************************************************************************************'),nl,
		write('*                                             Quest                                              *'),nl,
		write('**************************************************************************************************'),nl,
	    write('* Slay :                                                                                         *'),nl,
	    (A1 < 10 ->
	   format('* ~d Slime                                                                                        *', [A1]),nl
	    ;
	   format('* ~d Slime                                                                                       *', [A1]),nl),
	    (B1 < 10 ->
	   format('* ~d Goblin                                                                                       *', [B1]),nl	
	    ;
	   format('* ~d Goblin                                                                                      *', [B1]),nl),
	   format('* ~d Wolf                                                                                         *', [C1]),nl,
	    write('**************************************************************************************************'),nl,
		write('* What you get :                                                                                 *'),nl,
	   format('* ~d Exp                                                                                        *', [ExpGain]), nl,
	    ((GoldGain < 10000) ->
	   format('* ~d Gold                                                                                      *', [GoldGain]), nl
		;
	   format('* ~d Gold                                                                                     *', [GoldGain]), nl),
		write('**************************************************************************************************'),nl,
		assertz(questRemaining(W,0,Y,Z))
    ; (A=:=13,B=:=17)->
        retract(questRemaining(W,X,Y,Z)), assertz(questRemaining(W,X,0,Z))
    ; (A=:=2,B=:=12)->
        retract(questRemaining(W,X,Y,Z)), assertz(questRemaining(W,X,Y,0))
    ),
    retract(elmtPeta(A, B,'Q')).
tq :-
    !,write('You cant take quest here ').

/* pq : print quest status (remaining enemies to be killed) */
pq :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
pq :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
pq :-
    \+ quest(_,_,_,_,_,_) ,!, write('You dont have quest right now!!').
pq :-
    quest(A,A1,B,B1,C,C1) ,!, format('Quest status  slime: ~d/~d, goblin : ~d/~d, wolf : ~d/~d',[A1,A,B1,B,C1,C]).

/* fq : finish the quest) */
fq :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
fq :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
fq :-
    \+ quest(_,_,_,_,_,_) ,!, write('You dont have quest right now!!').
fq :-
    quest(_,A1,_,B1,_,C1), A1 =\= 0, B1 =\= 0, C1 =\= 0 ,!, 
    write('You cannot finish your quest right now').
fq :-
    quest(A,0,B,0,C,0) ,!, retract(quest(A,0,B,0,C,0)), 
    ExpGain is (A*15 + B*25 +C*40), addExp(ExpGain), GoldGain is (A*200 + B*300 + C*500), addGold(GoldGain),
    write('Congratulation for finishing the quest').

/* Fungsi untuk ngeprogress quest nya (kalau kill suatu monster maka fungsi ini dijalakan dan menambah progress dengan mengurangi jumlah monster yang dibunuh(+penanganan kasus negatif)), nunggu battle */
progressById(IdEnemy):-
	(IdEnemy =:= 1 -> progressQuest(slime)
	;IdEnemy =:= 2 -> progressQuest(slime)
	;IdEnemy =:= 3 -> progressQuest(goblin)
	;IdEnemy =:= 4 -> progressQuest(goblin)
	;IdEnemy =:= 5 -> progressQuest(wolf)
	;IdEnemy =:= 6 -> progressQuest(wolf)
    ; true
	).

progressQuest(X) :-
    quest(A,A1,B,B1,C,C1),
    (X == slime ->
        (A1 =:= 0 ->
            format('You have killed many slimes, try killing another ~d goblin and ~d wolf ~n to complete your quest',[B1,C1])
            ;
            A2 is A1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A2,B,B1,C,C1))
        )
    ; X == goblin ->
        (B1 =:= 0 ->
            format('You have killed many goblin, try killing another ~d slime and ~d wolf ~n to complete your quest',[A1,C1])
            ;
            B2 is B1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A1,B,B2,C,C1))
        )
    ; X == wolf ->
        (C1 =:= 0 ->
            format('You have killed many wolf, try killing another ~d slime and ~d goblin ~n to complete your quest',[A1,B1])
            ;
            C2 is C1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A1,B,B1,C,C2))
        )
    ).