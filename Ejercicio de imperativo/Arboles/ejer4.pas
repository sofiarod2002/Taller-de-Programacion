program ej4;

type
	
	lista = ^nodo;
	nodo = record
		dato : integer;
		sig: lista;
	end;

	procedure agregar (var l: lista; dato : integer);
	var
		nuevo: lista;
	begin
		new (nuevo);
		nuevo^.dato := dato;
		nuevo^.sig := l;
		l := nuevo;
	end;
	

//a. Implemente un módulo que genere una lista a partir de la lectura de números enteros. La lectura finaliza con el número 0.
procedure crearLista (var l : lista);
var
	num:integer;
begin
	writeln ('Ingrese un numero');
	readln (num);
	if (num <> 0) then begin
		agregar (l,num);
		crearLista (l);
	end;
end;
//b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
procedure minimo (var min:integer; l :lista);
begin
	if  (l <> nil) then begin
		if(l^.dato < min) then 
			min := l^.dato;
		minimo (min,l^.sig);
	end;

end;
//c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
procedure maximo (var max:integer; l :lista);
begin
	if (l <> nil) then begin
		if (l^.dato > max) then
			max := l^.dato;
		maximo (max,l^.sig);
	end;
	end;

//d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario.
procedure buscar (l:lista; x: integer; var esta : boolean);
begin
	if (l <> nil) then begin
		if (l^.dato = x) then
			esta:= true;
		buscar (l^.sig,x,esta);
	end;
end;



	// ---------------------------------------------------------------------IMPRIMO 
	procedure imprimirLista (l : lista);
	begin
		while (l <> nil) do begin
			writeln (l^.dato);
			writeln();
			l:= l^.sig;
		end;
	
	end;
	
var
	l : lista;
	min,max : integer;
	esta: boolean;
begin
	l:=nil;
	crearLista(l);
	imprimirLista(l);
	min := 9999; 	max:=-1;
	minimo (min,l);
	maximo (max,l);
	buscar (l,5,esta);
	writeln ('MINIMO: ',min, ' MAXIMO: ',max, ' SE ENCONTRO EL NUMERO: ',esta )
end.
