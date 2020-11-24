/* include modul lain */
:- include('items.pl').

/* Deklarasi predikat inventory() sebagai dynamic */
/* inventory(X) berarti player memiliki inventory X yang berisi nama dan jumlah item */
:- dynamic(inventory/1).

/* Menuliskan isi inventory pada layar */
inventory :- inventory(Inv), printInventory(Inv).
printInventory([]) :- !.
printInventory([[Name, Count]|T]) :-
    write(Count), write(' '), write(Name),
    (equipment(Name, Job, _, _) -> 
        write(' ('), write(Job), write(')'), nl, printInventory(T)
    ; 
        nl, printInventory(T)
    ).

/* itemCount(X, Y) berarti dalam inventory X terdapat Y item */
itemCount([], 0).
itemCount([[_, Count]|T], Total) :-
    itemCount(T, Temp),
    Total is Count + Temp.

/* drop(X, Y) membuang X sebanyak Y dari inventory jika ada */
drop(Item) :- drop(Item, 1).
drop(_, Count) :- Count =< 0, !, write('Item count must be more than 0'), fail.
drop(Item, Count) :-
    inventory(Inv),
    (member([Item, CountInv], Inv) ->
        (CountInv > Count ->
            NewCount is CountInv - Count,
            delete(Inv, [Item, CountInv], TempInv),
            append(TempInv, [[Item, NewCount]], NewInv),
            retract(inventory(Inv)),
            assertz(inventory(NewInv))
        ; CountInv =:= Count ->
            delete(Inv, [Item, CountInv], NewInv),
            retract(inventory(Inv)),
            assertz(inventory(NewInv))
        ;
            write('You do not have that many item in your inventory')
        )
    ;
        write('You do not have that item in your inventory')
    ).
     
/* addItem(X, Y) menambahkan X sebanyak Y ke dalam inventory */
addItem(_, Count) :- Count =< 0, !, write('Item count must be more than 0'), fail.
addItem(Item, Count) :-
    item(Item, _),
    inventory(Inv),
    itemCount(Inv, IC),
    (Count + IC =< 100 ->
        (member([Item, CountInv], Inv) ->
            NewCount is CountInv + Count,
            delete(Inv, [Item, CountInv], TempInv),
            append(TempInv, [[Item, NewCount]], NewInv),
            retract(inventory(Inv)),
            assertz(inventory(NewInv))
        ;
            append(Inv, [[Item, Count]], NewInv),
            retract(inventory(Inv)),
            assertz(inventory(NewInv))
        )
    ;
        write('Failed to add item, inventory full')
    ).

eqStatus(Item) :- equipmentStatus(Item).
equipmentStatus(Item) :-
	item(Item, IDItem),
	equipment(Item, Job, Stats, _),
	write('Rarity : '),
	(
	IDItem < 18 -> write('Common')
	;
	IDItem < 32 -> write('Rare')
	;
	IDItem < 39 -> write('Legendary')
	),
	nl,
	write('Class  : '), write(Job), nl,
	write('Slot   : '),
	(
	Stats == atk -> write('Weapon')
	;
	Stats == def -> write('Armor')
	;
	Stats == hp -> write('Accessory')
	),
	nl,
	!.