program p4_2;
const
	dimf = 8;
	valor_alto = 9999;
type 
	pelicula = record
		cod: integer;
		gen: 1..dimf;
		prom: real;
	end;
	
	peliculaMerge = record
		cod: integer;
		gen: 1..dimf;
		prom: real;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: pelicula;
		sig: lista;
	end;
	
	listaMerge = ^nodoMerge;
	nodoMerge = record
		dato: peliculaMerge;
		sig: listaMerge;
	end;
	
	
	vector = array [1..dimf] of lista;
	
	
procedure insertar (var l:lista; p: pelicula);
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
		while ((act <> nil) and (act^.dato.cod < nuevo^.dato.cod)) do begin
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


procedure leerPelicula(var p : pelicula);
begin
	writeln ('Ingrese el codigo');
	readln (p.cod);
	if (p.cod <> -1) then begin
		writeln ('Ingrese genero');
		readln (p.gen);
		writeln ('Ingrese puntaje promedio');
		readln (p.prom);
	end;
end;

procedure agregar_atras(var l:listaMerge; dato: peliculaMerge);
var
	act: listaMerge;
begin
	new(act);
	act^.dato:= dato;
	act^.sig:= l;
	l:= act;
end;

procedure cargar (var v : vector);
var
	p: pelicula;
begin
	leerPelicula (p);
	while (p.cod <> -1) do begin
		insertar (v[p.gen],p);
		leerPelicula (p);
	end;
end;

procedure marge_minimo(var v: vector; var min: peliculaMerge);
var
	pos,i:integer; 
begin
	min.cod := valor_alto;
	pos := 0;
	for i:= 1 to dimf do
		if (v[i] <> nil) and (v[i]^.dato.cod < min.cod) then begin
			min.cod:= v[i]^.dato.cod;
			min.gen:= v[i]^.dato.gen;
			min.prom:= v[i]^.dato.prom;
			pos := i;
		end;
	if (pos <> 0) then
		v[pos]:= v[pos]^.sig;
end;

procedure marge_deN (var v: vector; var l:listaMerge);
var 
	min: peliculaMerge;
begin
	l:= nil;
	marge_minimo(v,min);
	while (min.cod <> valor_alto) do begin
		agregar_atras(l,min);
		marge_minimo(v,min);
	end;
end;

procedure imprimirMerge(l: listaMerge);
begin
	if (l <> nil) then begin
		writeln('Codigo: ',l^.dato.cod, ' Genero: ', l^.dato.gen, ' Promedio: ', l^.dato.prom);
		imprimirMerge(l^.sig);
	end;	
end;

var
	v: vector;
	l: listaMerge;
	
begin
	cargar (v);
	marge_deN (v,l);
	imprimirMerge(l);

end.
