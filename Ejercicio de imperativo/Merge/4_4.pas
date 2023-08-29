program p4_4;
const 
	dimf = 7;
	valor_alto = 9999;

type

	entrada = record
		dia : integer;
		cod: integer;
		asiento : integer;
		monto : real;
	end;
	
	lista = ^nodo;
	nodo = record 
		dato : entrada;
		sig : lista;
	end;
	
	entradaMerge = record
		cod : integer;
		total : integer;
	end;
	
	listaMerge = ^nodoMerge;
	nodoMerge = record 
		dato : entradaMerge;
		sig : listaMerge;
	end;
	
	vector = array [1..dimf] of lista;
	
	procedure leer (var e: entrada);
	begin
		writeln ('Ingrese el codigo');
		readln (e.cod);
		if (e.cod <> 0) then begin 
			writeln ('Ingrese el dia');
			readln (e.dia);
			writeln ('Ingrese el asiento');
			readln (e.asiento);
			writeln ('Ingrese el monto');
			readln (e.monto);
		end;
	end;

	procedure insertar (var l: lista; e: entrada);
	var
		nuevo, act, ant: lista;
	begin
		new(nuevo);
		nuevo^.dato:= e;
		nuevo^.sig:= nil;
		if (l = nil) then
			l:= nuevo
		else begin
			ant:= l;
			act:= l;
			while (act <> nil) and (act^.dato.cod < nuevo^.dato.cod) do begin
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
		dato: entrada;
	begin
		leer(dato);
		while (dato.cod <> 0) do begin
			insertar(v[dato.dia],dato);
			leer(dato);
		end;
	end;

	procedure inicializar(var v:vector);
	var
		i: integer;
	begin
		for i:= 1 to dimf do begin
			v[i]:= nil;
		end;
	end;


	procedure agregarAtras(var l: listaMerge; v: entradaMerge);
	var
		nuevo, act: listaMerge;
	begin
		new(nuevo);
		nuevo^.dato:= v;
		nuevo^.sig:= nil;
		if (l = nil) then
			l:= nuevo
		else begin
			act:= l;
			while (act^.sig <> nil) do
				act:= act^.sig;
			act^.sig:= nuevo;
		end;
	end;

	procedure minimo (var v: vector; var min: entrada);
	var
		pos, i: integer;
	begin
		pos:= 0;
		min.cod := valor_alto;
		for i:= 1 to dimf do begin
			if (v[i] <> nil) and (v[i]^.dato.cod < min.cod) then begin
				min.cod:= v[i]^.dato.cod;
				min.monto:= v[i]^.dato.monto;
				pos:= i;
			end;
		end;
		if (pos <> 0) then begin
			v[pos]:= v[pos]^.sig;
		end;
	end;

	procedure merge (var l: listaMerge; var v: vector);
	var
		min: entrada;
		aux: entradaMerge;
	begin
		minimo(v,min);
		while (min.cod <> valor_alto) do begin
			aux.cod:= min.cod;
			aux.total:= 0;
			while (aux.cod = min.cod) do begin
				aux.total:= aux.total + 1;
				minimo(v,min);
			end;
			agregarAtras(l,aux);
		end; 
	end;

	procedure imprimirMerge(l: listaMerge);
	begin
		if (l <> nil) then begin
			writeln('Codigo: ',l^.dato.cod, ' Total: ', l^.dato.total);
			imprimirMerge(l^.sig);
		end;	
	end;
	
	var
		v : vector;
		l: listaMerge;
	begin
		inicializar(v);
		cargar(v);
		merge(l,v);
		imprimirMerge(l);
	end.
