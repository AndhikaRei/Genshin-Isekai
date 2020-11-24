/* quest(A,A1,B,B1,C,C1) membunuh slime sejumlah A, goblin sejumlah B, dan wolf sejumlah C, tanpa mempedulikan jenisnya (?) */
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
    inStore,!,write('You are in store, type "help." to see command in store').
tq :- 
    quest(_,_,_,_,_,_) ,!, write('You cant take multiple quest at once').
tq :- 
    playerPos(A,B),elmtPeta(A,B,'Q'),!, random(3, 13, A1), random(6, 15, B1), random(3, 10, C1),
    assertz(quest(A1,A1,B1,B1,C1,C1)),!, 
    questRemaining(W,X,Y,Z),
    ( (A=:=3,B=:=8)->
        retract(questRemaining(W,X,Y,Z)),
		ExpGain is (A1*25 + B1*40 +C1*55), GoldGain is (A1*400 + B1*700 + C1*1000),
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
		((ExpGain < 1000) ->
	   format('* ~d Exp                                                                                        *', [ExpGain]), nl
	    ;
	   format('* ~d Exp                                                                                       *', [ExpGain]), nl
	   ),
	    ((GoldGain < 10000) ->
	   format('* ~d Gold                                                                                      *', [GoldGain]), nl
		;
	   format('* ~d Gold                                                                                     *', [GoldGain]), nl),
	    write('* Call me when you have finished the quest by entering \'fq.\'. Thank you so much.                 *'),nl,
		write('**************************************************************************************************'),nl,
    
		assertz(questRemaining(0,X,Y,Z))
    ; (A=:=12,B=:=3)->
        retract(questRemaining(W,X,Y,Z)),
		ExpGain is (A1*25 + B1*40 +C1*55), GoldGain is (A1*400 + B1*700 + C1*1000),
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
		write('He told you to contact him if you finish your training by coming to the abyss.'), nl,
		write('You come to abyss by invoking a magic that he gives you. However...'), nl,
		write('He also said "The next time you come to abyss, it will be the last, and you can no longer return to abyss".'), nl,
		write('You can go cast the magic to go to the abyss by entering \'fq.\'. '), nl,
		write('But the magic won\'t be activated if you haven\'t finished your training montage.'), nl,
		write('You put your faith in him and accepted the offer with a happy smile.'), nl,
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
	   ((ExpGain < 1000) ->
	   format('* ~d Exp                                                                                        *', [ExpGain]), nl
	    ;
	   format('* ~d Exp                                                                                       *', [ExpGain]), nl
	   ),
	    ((GoldGain < 10000) ->
	   format('* ~d Gold                                                                                      *', [GoldGain]), nl
		;
	   format('* ~d Gold                                                                                     *', [GoldGain]), nl),
		write('**************************************************************************************************'),nl,
		assertz(questRemaining(W,0,Y,Z))
    ; (A=:=13,B=:=17)->
        retract(questRemaining(W,X,Y,Z)),
		ExpGain is (A1*25 + B1*40 +C1*55), GoldGain is (A1*400 + B1*700 + C1*1000),
		write('There is a mysterious goblin here.'), nl,
		write('The goblin is neither recruitGoblin nor berserkerGoblin.'), nl,
		write('The goblin can probably be called queenGoblin.'), nl,
		write('She gave birth to almost all goblin existed in monster habitats.'), nl,
		write('She find out that some goblins that she gave birth to is not on the goblin habitat.'), nl,
		write('She wants you to find the goblins.'), nl,
		write('But you were interrupted by a report from recruitGoblin.'), nl,
		write('The report is that some goblin has been found lifeless in monster habitats, including goblin habitats.'), nl,
		write('It was identified that their lives are taken by the slimes and wolves.'), nl,
		write('The queen ask you to find the lifeless bodies and take revenge.'), nl,
		write('She doesn\'t know what adventurers do, so she just assumed that you are friendly to them.'), nl,
		write('She doesn\'t know the soul of an impostor inside you.'), nl,
		write('In your heart, you laughed so hard.'), nl,
		write('Well, no. The last three lines are only a reference to a trending game. They have no meaning.'), nl,
		write('Anyway, here\'s what the queen asked you to do.'), nl,
		write('Find the lifeless goblin bodies and avenge the goblins.'), nl,
		write('In your mind, you realize that the queen is not smart.'), nl,
		write('You have a thought.'), nl,
		write('If I don\'t find the lifeless bodies, then I can make some lifeless bodies.'), nl,
		write('So, you change the quest to look like the one below.'), nl,
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
	   ((ExpGain < 1000) ->
	   format('* ~d Exp                                                                                        *', [ExpGain]), nl
	    ;
	   format('* ~d Exp                                                                                       *', [ExpGain]), nl
	   ),
	    ((GoldGain < 10000) ->
	   format('* ~d Gold                                                                                      *', [GoldGain]), nl
		;
	   format('* ~d Gold                                                                                     *', [GoldGain]), nl),
		write('**************************************************************************************************'),nl,
		assertz(questRemaining(W,X,0,Z))
    ; (A=:=2,B=:=12)->
        retract(questRemaining(W,X,Y,Z)),
		ExpGain is (A1*25 + B1*40 +C1*55), GoldGain is (A1*400 + B1*700 + C1*1000),
		write('Wolves have a legend that has been passed from generation to generation.'), nl,
		write('            The ALPHA WOLF'), nl,
		write('The ALPHA WOLF is the strongest wolf existed.'), nl,
		write('The ALPHA WOLF is considered adult once it reaches 900 years old.'), nl,
		write('It is said that The ALPHA WOLF is stronger than even Hypostasis and Andrius.'), nl,
		write('There are two reasons.'), nl,
		nl,
		write('The first reason is simple, The ALPHA WOLF have a complete advantage in numbers.'), nl,
		write('Why is that?'), nl,
		write('The ALPHA WOLF work together to defeat a common enemy.'), nl,
		write('Moreover, The ALPHA WOLF has a special ability to turn any corpse it has bitten to another ALPHA WOLF, but so much younger.'), nl,
		write('In example, if a 15 years old direWolf is bitten by ALPHA WOLF, it turns into a 1 year old ALPHA WOLF.'), nl,
		write('It can even turn the corpses of slimes, goblins, and even humans into ALPHA WOLVES.'), nl,
		write('But it cannot turn the corpses of The ALPHA WOLF into another The ALPHA WOLF.'), nl,
		write('"WHAT A MAGIC!", you thought.'), nl,
		write('Continuing the story,'), nl,
		write('The number of ALPHA WOLVES is declining. Why is that?'), nl,
		write('They live in peace, so they have no common enemy.'), nl,
		write('It causes them to be bored and caused internal disputes in them.'), nl,
		write('The dispute causes war between The ALPHA WOLF. Until only one was left.'), nl,
		write('That is why there is no ALPHA WOLF found in the wild.'), nl,
		nl,
		write('The second reason is that The ALPHA WOLF is "immortal".'), nl,
		write('At least, according to what other monsters said.'), nl,
		write('The truth is that they have a body core.'), nl,
		write('The core is why they can turn another monster into An ALPHA WOLF.'), nl,
		write('If its core is destroyed, it will die.'), nl,
		write('Only The ALPHA WOLVES knows about the core. No one else knows.'), nl,
		write('Except you, the adventurer who just read the story, and the story creator, of course. :)'), nl,
		write('            ***  THE END  ***'), nl,
		nl,
		write('You somehow went to the temple hidden in wolf habitat to know the story.'), nl,
		write('And you meet the remaining ALPHA WOLF.'), nl,
		write('Because you doesn\'t want to be dead and turn into ALPHA WOLF,'), nl,
		write('You negotiate with The ALPHA WOLF, and it accepts your negotiation.'), nl,
		write('The negotiation is given below as a quest.'), nl,
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
	   ((ExpGain < 1000) ->
	   format('* ~d Exp                                                                                        *', [ExpGain]), nl
	    ;
	   format('* ~d Exp                                                                                       *', [ExpGain]), nl
	   ),
	    ((GoldGain < 10000) ->
	   format('* ~d Gold                                                                                      *', [GoldGain]), nl
		;
	   format('* ~d Gold                                                                                     *', [GoldGain]), nl),
		write('**************************************************************************************************'),nl,
		assertz(questRemaining(W,X,Y,0))
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
    inStore,!,write('You are in store, type "help." to see command in store').
pq :-
    quest(_,A1,_,B1,_,C1) ,!, 
	write('**************************************************************************************************'),nl,
	write('*                                       Quest Status                                             *'),nl,
	write('**************************************************************************************************'),nl,
	write('* Slay :                                                                                         *'),nl,
	    (A1 < 10 ->
	format('* ~d more Slime                                                                                   *', [A1]),nl
	    ;
	format('* ~d more Slime                                                                                  *', [A1]),nl),
	    (B1 < 10 ->
	format('* ~d more Goblin                                                                                  *', [B1]),nl	
	    ;
	format('* ~d more Goblin                                                                                 *', [B1]),nl),
	format('* ~d more Wolf                                                                                    *', [C1]),nl,
	write('**************************************************************************************************'),nl,
	!.

/* fq : finish the quest) */
fq :-
    \+gameStarted,!, write('The game has not started, type "start." to play the game').
fq :-
    inBattle,!, write('You are currently in battle, please type "help." to see the command while in battle').
fq :-
    inStore,!,write('You are in store, type "help." to see command in store').
fq :-
    \+ quest(_,_,_,_,_,_) ,!, write('You dont have quest right now!!').
fq :-
    quest(_,A1,_,B1,_,C1), A1 =\= 0, B1 =\= 0, C1 =\= 0 ,!, 
    write('You cannot finish your quest right now').
fq :-
    quest(A,0,B,0,C,0) ,!, retract(quest(A,0,B,0,C,0)), 
    ExpGain is (A*25 + B*40 +C*55), addExp(ExpGain), GoldGain is (A*400 + B*700 + C*1000), addGold(GoldGain),
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
	),
	pq,!.

progressQuest(X) :-
    quest(A,A1,B,B1,C,C1),
    (X == slime ->
        (A1 =:= 0 ->
			write('')
/*            format('You have killed many slimes, try killing another ~d goblin and ~d wolf ~n to complete your quest',[B1,C1]) */
            ;
            A2 is A1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A2,B,B1,C,C1))
        )
    ; X == goblin ->
        (B1 =:= 0 ->
			write('')
/*            format('You have killed many goblin, try killing another ~d slime and ~d wolf ~n to complete your quest',[A1,C1]) */
            ;
            B2 is B1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A1,B,B2,C,C1))
        )
    ; X == wolf ->
        (C1 =:= 0 ->
			write('')
/*            format('You have killed many wolf, try killing another ~d slime and ~d goblin ~n to complete your quest',[A1,B1]) */
            ;
            C2 is C1-1,
            retract(quest(A,A1,B,B1,C,C1)),
            assertz(quest(A,A1,B,B1,C,C2))
        )
    ).