program P1_ej3;

const
	dimF = 6;
type
	
	rango = 1..dimF;
	
	producto = record
		cod_pruducto: integer;
		cod_rubro : rango;
		precio: integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: producto;
		sig: lista;
	end;
	
	vector = array[1..dimF] of lista;
	vectorTres = array[1..30] of producto;
	
	{Lea los datos de los productos y los almacene ordenados por código de producto y 
	agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos 
	finaliza cuando se lee el precio -1}
	
	procedure leerProducto (var p : producto);
	begin
		writeln ('Ingrese el precio');
		readln (p.precio);
		if (p.precio <> -1) then begin
			p.cod_pruducto := Random (50);
			p.cod_rubro := Random (6)+1;
		end;
	end;
	
	procedure insertar (var l : lista; p : producto);
	var
		ant,act,nue: lista;
	begin
		new (nue);
		nue^.dato := p;
		nue^.sig := nil;
		if (l = nil) then
			l := nue
		else begin
			act:= l; ant :=l;
			while ( (act<> nil) and (act^.dato.cod_pruducto < nue^.dato.cod_pruducto) ) do begin
				ant:= act;
				act:= act^.sig;
				end;
			if (ant = act) then begin
				nue^.sig:= l;
				l:=nue
			end else begin
				ant^.sig:= act;
				nue^.sig := act;
			end;
		end;
	end;
	
	procedure crearVector (var v : vector);
	var
		p: producto;
	begin
		leerProducto(p);
		while (p.precio <> -1) do begin
			insertar (v[p.cod_rubro],p);
			leerProducto(p);
		end;
		
	end;
	
	{Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que 
	puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro
	3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.}
	
	procedure vectorRubroTres (v : vector; var v3 : vectorTres; var dimL: integer);
	begin
		while ( (dimL < 30) and (v[3] <> nil) ) do begin
			dimL := dimL+1;
			v3[dimL] := v[3]^.dato; 
			v[3] := v[3]^.sig;
		end;
	end;
	
	//Ordene, por precio, los elementos del vector generado 
	Procedure ordenarInsercion ( var v: vectorTres; dimL : integer);
	var 
		i, j: integer; 
		actual: producto;			
	begin
	 for i:=2 to dimL do begin 
		 actual:= v[i];
		 j:= i-1; 
		 while (j > 0) and (v[j].precio > actual.precio) do begin
			 v[j+1]:= v[j];
			 j:= j - 1;                  
		   end;  
		 v[j+1]:= actual; 
	 end;
	end;
	
	
	
	
	//Muestre los precios del vector ordenado.
	// ---------------------------------------------------------------------IMPRIMO VECTOR CON LISTA DE PELICULAS
	procedure imprimirLista (l : lista);
	begin
		while (l <> nil) do begin
			writeln ('Codigo producto: ' , l^.dato.cod_pruducto,' Codigo rubro: ' , l^.dato.cod_rubro,' Precio: ' , l^.dato.precio);
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
	procedure imprimir2 (v : vectorTres; dimL :integer);
	var
		i : integer;
	begin
		for i:=1 to dimL do 
			writeln (' Precio: ', v[i].precio);
	end;
	
	//---------------------------------------------------INICIALZIAR VECTOR
	procedure inicializarVector (var v: vector);
	var
		i : integer;
	begin
		for i:=1 to dimF do
			v[i]:=nil;
	end;
	
	//-------------------------------------------PROGRAMA PRINCIPAL
	var
		v : vector;
		v3 : vectorTres;
		dimL : integer;
	begin
		Randomize;
		dimL :=0;
		inicializarVector (v);
		crearVector (v);
		writeln ('--------------------------------- VECTOR CREADO---------------------------------');
		imprimir (v);
		vectorRubroTres (v,v3,dimL);
		writeln ('--------------------------------- VECTOR MAXIMOS PUNTAJES---------------------------------');
		imprimir2 (v3,dimL);
		writeln ('--------------------------------- VECTOR ORDENADO---------------------------------');
		ordenarInsercion (v3,dimL);
		imprimir2 (v3,dimL);
	end.
	
