program ej8;

type
    arbol= ^nodo;
    nodo = record
        dato:integer;
        hi:arbol;
        hd:arbol;
     end;

	//	 ------ AGREGAR DATOS A LA ESTRUCTURA ------
	procedure agregarAlArbol(var a:arbol; dato:integer);
	begin
		 if (a = nil) then begin
			 new(a);
			 a^.dato:= dato;
			 a^.HI:= nil;
			 a^.HD:= nil;
		 end
		 else
			 if (a^.dato > dato) then
				 agregarAlArbol(a^.HI, dato)
			 else begin
				 if (a^.dato < dato) then
					 agregarAlArbol(a^.HD, dato)
			 end;
	end;
	
	procedure crearArbol (var a : arbol);
	var
		num : integer;
	begin
		readln (num);
		while (num <> -1) do begin
			agregarAlArbol (a,num);
			readln (num);
			
		end;
	end;
	
	//--------------Obtener el número más grande.
	procedure maximo (a : arbol; var max: integer);
	begin
		if (a <> nil) then begin
			maximo(a^.HD,max);
			if (a^.dato > max) then
				max := a^.dato;
			end;
		end;
	
	//--------------Obtener el número minimo
	procedure minimo (a : arbol; var min: integer);
	begin
		if (a <> nil) then begin
			minimo(a^.HI,min);
			if (a^.dato < min) then
				min := a^.dato;
			end;
	end;
	
	//--------------Total de numeros
	procedure totalRec (a : arbol; var total: integer);
	begin
		if (a <> nil) then begin
			total:= (total + a^.dato);
			totalRec(a^.hi,total);
			totalRec(a^.HD,total);
		end;
	end;
	
	
	//---------------------------Informar los números en orden creciente.
	Procedure creciente ( a : arbol );
	begin
	   if ( a<> nil ) then begin
		creciente (a^.HI);
		writeln (a^.dato);
		creciente (a^.HD);
	   end;
	end;


	//-----------------------------------Informar los números pares en orden decreciente.
	Procedure decreciente ( a : arbol );
	begin
	   if ( a<> nil ) then begin
		decreciente(a^.HD);
		writeln (a^.dato);
		decreciente (a^.HI);
	   end;
	end;
	
	
	//-------------------------------------------------- tipo ejer 9
	function buscar (a: arbol; x: integer): boolean;
	begin
	if (a = nil) then 
		buscar:= false
	else if (a^.dato = x) then
			buscar := true
		else begin
		if (a^.dato > x) then 
			buscar:= buscar (a^.hi, x)
		else
			buscar:= buscar(a^.hd,x);
		end;
	end;
	
	var
		a: arbol;
		max,min,total: integer;
	begin
		max:=-1;	min:=9999;	total:=0;
		crearArbol (a);
		maximo (a,max);
		minimo (a,min);
		totalRec (a,total);
		writeln ('MAXIMO: ',max,' MINIMO: ',min, ' TOTAL: ',total);
		writeln (buscar(a,6));
	end.
