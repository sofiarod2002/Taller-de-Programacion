program p4_1;
const
	dimf = 12;
	valor_alto = 9999;
type
	prestamo = record
		isbn: integer;
		num: integer;
		dia: integer;
		mes: integer;
		cant: integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: prestamo;
		sig: lista;
	end;
	
	vector = array [1..dimf] of lista;
	
	prestamoMerge = record
		isbn: integer;
		num: integer;
		dia: integer;
		mes: integer;
		cant: integer;
	end;
	
	listaMerge = ^nodoMerge;
	nodoMerge = record
		dato: prestamoMerge;
		sig: listaMerge;
	end;
	
	prestamoAcumulador = record
		isbn: integer;
		total: integer;
	end;
	
	listaAcumulador = ^nodoAcumulador;
	nodoAcumulador = record
		dato: prestamoAcumulador;
		sig: listaAcumulador;
	end;
	

procedure leer (var p: prestamo);
begin
	write('ISBN: ');
	readln(p.isbn);
	if (p.isbn <> -1) then begin
		write('Numero de socio: ');
		readln(p.num);
		write('Dia: ');
		readln(p.dia);
		write('Mes: ');
		readln(p.mes);
		write('Cantidad de dias prestados: ');
		readln(p.cant);
	end;
end;

procedure insertar (var l:lista; p: prestamo);
var
	nuevo, ant, act: lista;
begin
	new(nuevo);
	nuevo^.dato:= p;
	nuevo^.sig:= nil;
	if (l = nil) then
		l:= nuevo
	else begin
		ant:= l;
		act:= l;
		while ((act <> nil) and (act^.dato.isbn < nuevo^.dato.isbn)) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if (act = ant) then begin
			nuevo^.sig:= l;
			l:= nuevo;
		end
		else begin
			ant^.sig:= nuevo;
			nuevo^.sig:= act;
		end;
	end;
end;

procedure cargar (var v: vector);
var
	p: prestamo;
begin
	leer(p);
	while (p.isbn <> -1) do begin
		insertar(v[p.mes],p);
		leer(p);
	end;
end;

procedure imprimir_recursivo (l: lista);
begin
	if (l <> nil) then begin
		writeln('Isbn: ', l^.dato.isbn, ' numero de socio: ', l^.dato. num);
		imprimir_recursivo(l^.sig);
	end;
end;

procedure imprimir(v: vector);
var
	i: integer;
begin
	for i:= 1 to dimf do begin
		writeln('Mes ',i);
		imprimir_recursivo(v[i]);
	end;
end;

procedure agregar_atras(var l:listaMerge; dato: prestamoMerge);
var
	act: listaMerge;
begin
	new(act);
	act^.dato:= dato;
	act^.sig:= l;
	l:= act;
end;

procedure marge_minimo_den(var v: vector; var min: prestamoMerge);
var
	pos,i:integer; 
begin
	min.isbn := valor_alto;
	pos := 0;
	for i:= 1 to dimf do
		if (v[i] <> nil) and (v[i]^.dato.isbn < min.isbn) then begin
			min.isbn:= v[i]^.dato.isbn;
			min.num:= v[i]^.dato.num;
			min.dia:= v[i]^.dato.dia;
			min.mes:= v[i]^.dato.mes;
			min.cant:= v[i]^.dato.cant;
			pos := i;
		end;
	if (pos <> 0) then
		v[pos]:= v[pos]^.sig;
end;

procedure marge_deN (var v: vector; var l:listaMerge);
var 
	min: prestamoMerge;
begin
	l:= nil;
	marge_minimo_den(v,min);
	while (min.isbn <> valor_alto) do begin
		agregar_atras(l,min);
		marge_minimo_den(v,min);
	end;
end;

procedure imprimirMerge(l: listaMerge);
begin
	if (l <> nil) then begin
		writeln('ISBN: ',l^.dato.isbn, ' Numero de socio: ', l^.dato.num);
		imprimirMerge(l^.sig);
	end;	
end;


procedure agregarAtrasAcumulador(var l:listaAcumulador; dato: prestamoAcumulador);
var
	act: listaAcumulador;
begin
	new(act);
	act^.dato:= dato;
	act^.sig:= l;
	l:= act;
end;


procedure margeAcumulador (var v: vector; var l:listaAcumulador);
var 
	min: prestamoMerge;
	aux: prestamoAcumulador;
begin
	l:= nil;
	marge_minimo_den(v,min);
	while (min.isbn <> valor_alto) do begin
		aux.isbn:= min.isbn;
		aux.total:= 0;
		while (min.isbn = aux.isbn) do begin
			aux.total:= aux.total + min.cant;
			marge_minimo_den(v,min);
		end;
		agregarAtrasAcumulador(l,aux);
	end;
end;


procedure imprimirAcumulador(l: listaAcumulador);
begin
	if (l <> nil) then begin
		writeln('ISBN: ',l^.dato.isbn, ' Cantidad: ', l^.dato.total);
		imprimirAcumulador(l^.sig);
	end;	
end;


var
	v,aux: vector;
	lm: listaMerge;
	la: listaAcumulador;
begin
	cargar(v);
	aux:= v;
	write('------- ESTRUCTURA 1 ----------');
	imprimir(v);
	marge_deN(v,lm);
	write('------- ESTRUCTURA 2 ----------');
	imprimirMerge(lm);
	margeAcumulador(aux,la);
	write('------- ESTRUCTURA 3 ----------');
	imprimirAcumulador(la);
end.
