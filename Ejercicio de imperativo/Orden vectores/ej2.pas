program P1_ej2;

const 
	dimF = 8;
type
	
	pelicula = record
		cod_pelicula : integer;
		cod_genero: integer;
		puntaje: real;
	end;
	
	maximo = record
		cod: integer;
		puntaje: real;
	end;
	
	
	lista = ^nodo;
	nodo = record
		dato: pelicula;
		sig : lista;
	end;
	
	vector = array [1..dimF] of lista;
	vectorPuntaje = array [1..dimF] of maximo;
	
	{Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, 
	en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de película -1.}
	
	
	procedure leerPelicula (var p : pelicula);
	begin
		writeln('Ingrese el codigo de la pelicula');
		readln (p.cod_pelicula);
		if (p.cod_pelicula <> -1) then begin
			p.cod_genero:= Random (8)+1;
			p.puntaje := Random (15);
		end;
	end;
	
	procedure agregar (var l: lista; p : pelicula);
	var
		nuevo: lista;
	begin
		new (nuevo);
		nuevo^.dato := p;
		nuevo^.sig := l;
		l := nuevo;
	end;
	
	
	procedure crearVector (var v : vector);
	var
		p: pelicula;
	begin
		leerPelicula (p);
		while (p.cod_pelicula <> -1) do begin
			agregar(v[p.cod_genero],p);
			leerPelicula (p);
		end;
	end;
	
	procedure inicializarVector (var v: vector);
	var
		i : integer;
	begin
		for i:=1 to dimF do
			v[i]:=nil;
	end;


	{Una vez almacenada la información, genere un vector que guarde, 
	 para cada género, el código de película con mayor puntaje obtenido entre todas las críticas.}
	 
	 procedure maximoGenero (v : vector; var vP : vectorPuntaje);
	 var
		i :integer;
		pun:  maximo;
		max: real;
	begin
		for i:=1 to dimF do begin
			max:= -1;
			pun.cod := 0;
			pun.puntaje := 0;
			while (v[i] <> nil) do begin
				if (v[i]^.dato.puntaje > max) then begin
					pun.cod := v[i]^.dato.cod_pelicula;
					pun.puntaje := v[i]^.dato.puntaje;
					max := v[i]^.dato.puntaje;
				end;
				v[i] := v[i]^.sig;
			end;
				vP[i]:= pun;
		end;
	end;
	
	//Ordene los elementos del vector generado en b) por puntaje.
	Procedure ordenarInsercion ( var v: vectorPuntaje);
	var 
		i, j: integer; 
		actual: maximo;			
	begin
	 for i:=2 to dimF do begin 
		 actual:= v[i];
		 j:= i-1; 
		 while (j > 0) and (v[j].puntaje > actual.puntaje) do begin
			 v[j+1]:= v[j];
			 j:= j - 1;                  
		   end;  
		 v[j+1]:= actual; 
	 end;
	end;
	
	// ---------------------------------------------------------------------IMPRIMO VECTOR CON LISTA DE PELICULAS
	procedure imprimirLista (l : lista);
	begin
		while (l <> nil) do begin
			writeln ('Codigo Pelicula: ' , l^.dato.cod_pelicula,' Codigo genero: ' , l^.dato.cod_genero,' Puntaje: ' , l^.dato.puntaje:2:2);
			writeln();
			l:= l^.sig;
		end;
	
	end;
	
	procedure imprimir (v: vector);
	var
		i : integer;
	begin
		for i :=1 to dimF do begin
			imprimirLista (v[i]);
			writeln();
		end;
	end;


	// ---------------------------------------------------------------------IMPRIMO VECTOR CON PUNTAJES
	procedure imprimir2 (v : vectorPuntaje);
	var
		i : integer;
	begin
		for i:=1 to dimF do 
			writeln (' Puntaje: ', v[i].puntaje:2:2, ' codigo: ', v[i].cod);
	end;
	
	var
		v : vector;
		vP : vectorPuntaje;
	begin
		Randomize;
		inicializarVector (v);
		crearVector (v);
		writeln ('--------------------------------- VECTOR CREADO---------------------------------');
		imprimir (v);
		maximoGenero (v,vP);
		writeln ('--------------------------------- VECTOR MAXIMOS PUNTAJES---------------------------------');
		imprimir2 (vP);
		writeln ('--------------------------------- VECTOR ORDENADO---------------------------------');
		ordenarInsercion (vP);
		imprimir2 (vP);
	end.
