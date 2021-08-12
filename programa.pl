% Aquí va el código.

atiende(dodain, lunes, horario(9,15)).
atiende(dodain, miercoles, horario(9,15)).
atiende(dodain, viernes, horario(9,15)).
atiende(lucas, martes, horario(10,20)).
atiende(juanC, sabados, horario(18,22)).
atiende(juanC, domingos, horario(18,22)).
atiende(juanFdS, jueves, horario(10,20)).
atiende(juanFdS, viernes, horario(12,20)).
atiende(leoC, lunes, horario(14,18)).
atiende(leoC, miercoles, horario(14,18)).
atiende(martu, miercoles, horario(23,24)).


atiende(vale, Dia, horario(Inicio, Fin)):-
    atiende(dodain, Dia, horario(Inicio, Fin)).

atiende(vale, Dia, horario(Inicio, Fin)):-
    atiende(juanC, Dia, horario(Inicio, Fin)).

atencion(Persona, Dia, Hora):-
    atiende(Persona, Dia, horario(Inicio, Fin)),
    Hora >= Inicio,
    Hora =< Fin.


foreverAlone(Persona, Dia, Hora):-
    atencion(Persona, Dia, Hora),
    not(atiende(_,Dia, horario(Hora,_))).

foreverAlone(Persona, Dia, Hora):-
    atencion(Persona, Dia, Hora),
    not(atiende(_,Dia, horario(_,Hora))).


posibilidadesDeAtencion(Dia, Personas):-
    atiende(_,Dia,_),
    findall(Persona, atiende(Persona, Dia, _), Personas).



puedenAtenderJuntos(Persona,Persona1):-
    atiende(Persona,Dia,horario(Inicio,Fin)),
    atiende(Persona1,Dia, horario(Inicio1,_)),
    Inicio1 >= Inicio,
    Inicio1 =< Fin.

puedenAtenderJuntos(Persona,Persona1):-
    atiende(Persona,Dia,horario(Inicio,Fin)),
    atiende(Persona1,Dia, horario(_,Fin1)),
    Fin1 >= Inicio,
    Fin1 =< Fin.



ventas(dodain, dia(lunes,10,agosto), golosinas(1200)).
ventas(dodain, dia(lunes,10,agosto), golosinas(50)).
ventas(dodain, dia(lunes,10,agosto), cigarillos([jockey])).

ventas(dodain, dia(miercoles,12,agosto), bebidas(8, si)).
ventas(dodain, dia(miercoles,12,agosto), bebidas(1, no)).
ventas(dodain, dia(miercoles,12,agosto), golosinas(10)).

ventas(martu, dia(miercoles,12,agosto), golosinas(1000)).
ventas(martu, dia(miercoles,12,agosto), cigarillos([chesterfield,colorado,parisiennes])).


ventas(lucas, dia(martes,11,agosto), golosinas(600)).
ventas(lucas, dia(martes,11,agosto), bebidas(2, no)).
ventas(lucas, dia(martes,11,agosto), cigarillos([derby])).


suertuda(Persona):-
    atiende(Persona,_,_),
    forall(primeraVentaDelDia(Persona, dia(Dia,_,_),Venta), ventaImportante(Venta)).



primeraVentaDelDia(Persona, dia(Dia, Nro, Mes), Venta):-
    primeraVentaDeGolosina(Persona, dia(Dia,Nro,Mes), Venta).


primeraVentaDelDia(Persona, dia(Dia, Nro, Mes), Venta):-
    primeraVentaDeCigarillo(Persona, dia(Dia,Nro,Mes), Venta).

primeraVentaDelDia(Persona, dia(Dia, Nro, Mes), Venta):-
    primeraVentaDeBebida(Persona, dia(Dia,Nro,Mes), Venta).

primeraVentaDelDia(Persona, dia(Dia, Nro, Mes), Venta):-
    primeraVentaDeBebidaAlcoholica(Persona, dia(Dia,Nro,Mes), Venta).

primeraVentaDeGolosina(Persona, dia(Dia,Nro,Mes), Monto):-
    ventas(Persona, dia(Dia,Nro,Mes), _),
    findall(Venta, ventas(Persona, dia(Dia,Nro,Mes),golosinas(Venta)), Ventas),
    member(Monto, Ventas).

primeraVentaDeCigarillo(Persona, dia(Dia,Nro,Mes), Cigarillos):-
    ventas(Persona, dia(Dia,Nro,Mes), _),
    findall(Cigarillo, ventas(Persona, dia(Dia,Nro,Mes),cigarillos(Cigarillo)), Ventas),
    member(Cigarillos, Ventas).

primeraVentaDeBebidaAlcoholica(Persona, dia(Dia,Nro,Mes), Bebidas):-
    ventas(Persona, dia(Dia,Nro,Mes), _),
    findall(Bebida,ventas(Persona, dia(Dia,Nro,Mes),bebidas(Bebida,si)), Ventas),
    member(Bebidas, Ventas).

primeraVentaDeBebida(Persona, dia(Dia,Nro,Mes), Bebidas):-
    ventas(Persona, dia(Dia,Nro,Mes), _),
    findall(Bebida,ventas(Persona, dia(Dia,Nro,Mes),bebidas(Bebida,no)), Ventas),
    member(Bebidas, Ventas).

ventaImportante(cigarillos(Venta)):-
    length(Venta, Cant),
    Cant > 2.

ventaImportante(golosinas(Venta)):-
    Venta > 100.

ventaImportante(Bebida):-
    member(Cant, Bebida),
    Cant > 5.
    
podrianEstarAtendiendo(Persona,OtraPersona,Dia):-
    atiendenEnElMismoDia(Persona,OtraPersona,Dia).
    
    
atiendenEnElMismoDia(Persona,OtraPersona,Dia):-
    atiende(Persona,Dia,_),
    atiende(OtraPersona,Dia,_),
    Persona \= OtraPersona.


    