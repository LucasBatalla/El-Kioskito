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
    between(0, 24, Horario),
    atiende(_,Dia,_),
    findall(Persona, atencion(Persona,Dia,Horario), Personas).
    


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
    forall(vendio(Persona,Dia),(primeraVentaDelDia(Persona,Dia,PrimerVenta), ventaImportante(PrimerVenta))).
  

vendio(Persona, dia(Dia, Nro, Mes)):-
    ventas(Persona, dia(Dia,Nro,Mes), _).

primeraVentaDelDia(Persona, dia(Dia,Nro,Mes), PrimerVenta):-
    vendio(Persona, dia(Dia, Nro,Mes)),
    findall(Venta, ventas(Persona, dia(Dia,Nro,Mes), Venta), Ventas),
    primerVenta(Ventas, PrimerVenta).

primerVenta(Ventas, Venta):-
     Ventas = [PrimerVenta |_],
     Venta = PrimerVenta.
ventaImportante(golosinas(Precio)):-
    Precio > 100.

ventaImportante(cigarillos(Vendidos)):-
    length(Vendidos, Cant),
    Cant > 2.

ventaImportante(bebidas(Cant,no)):-
    Cant > 5.

ventaImportante(bebidas(_,si)).







    