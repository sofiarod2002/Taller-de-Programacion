program ej10;

type
	
	alumno = record
		legajo : integer;
		dni: integer;
		nombre : string [20];
		apellido : string [20];
		anio : integer;
	end;
	
	arbol = ^nodo;
	nodo = record 
		dato: alumno;
		hd : arbol;
		hi: arbol;
	end;

{Un módulo que lea información de alumnos de Taller de Programación y almacene 
en una estructura de datos sólo a aquellos alumnos que posean año de ingreso 
posterior al 2000. Esta estructura debe estar ordenada por legajo y debe ser 
eficiente para la búsqueda por dicho criterio. De cada alumno se lee legajo, apellido, nombre, DNI y año de ingreso.}

procedure leerAlumno (var a : alumno);
begin
	writeln ('Ingrese año');
	readln (a.anio);
	if (a.anio > 2000) then begin
		writeln ('Ingrese nombre y apellido');
		readln (a.nombre);
		readln (a.apellido);
		readln (a.legajo);
		a.dni := Random (100);
	end;
end;

	//	 ------ AGREGAR DATOS A LA ESTRUCTURA ------
	procedure agregarAlArbol(var a:arbol; dato: alumno);
	begin
		 if (a = nil) then begin
			 new(a);
			 a^.dato:= dato;
			 a^.HI:= nil;
			 a^.HD:= nil;
		 end
		 else
			 if (a^.dato.legajo > dato.legajo) then
				 agregarAlArbol(a^.HI, dato)
			 else begin
				 if (a^.dato.legajo < dato.legajo) then
					 agregarAlArbol(a^.HD, dato)
			 end;
	end;
	
	//--------------Un módulo que reciba la nueva estructura e informe el nombre y apellido de aquellos alumnos cuyo legajo sea superior a 12803.
	procedure informar (a : arbol);
	begin
		if (a <> nil) then begin
			if (a^.dato.legajo >= 12803) then begin
				writeln ('Nombre: ', a^.dato.nombre, ' Legajo:', a^.dato.apellido);
				informar (a^.hd);
			end else begin
				informar (a^.hd);
				informar (a^.hi);
			end;
		end;
	end;
	
	procedure crearArbol (var a: arbol);
	var
		alum: alumno;
	begin
		leerAlumno (alum);
		while (alum.anio > 2000) do begin
			agregarAlArbol (a,alum);
			leerAlumno(alum);
		end;
	end;
		
	
	//-----------------------------Un módulo que reciba la nueva estructura e informe el nombre 
	//y apellido de aquellos alumnos cuyo legajo este comprendido entre 2803 y 6982.
	
	procedure informar2 (a : arbol);
	begin
		if (a <> nil) then begin
			if ( (a^.dato.legajo >= 2803) and (a^.dato.legajo <= 6982 ) ) then 
				writeln ('Nombre: ', a^.dato.nombre, ' Legajo:', a^.dato.apellido);
			informar2 (a^.hd);
			informar2 (a^.hi);
			end;
	end;
	
	var
		a: arbol;
	begin
		crearArbol (a);
		writeln ('---------------------INFORMAR 1---------------------');
		informar (a);
		writeln ('---------------------INFORMAR 2---------------------');
		informar2 (a);
	end.
		
