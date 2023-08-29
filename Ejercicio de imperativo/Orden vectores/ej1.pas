program p1_ej1;

const
	dimF = 300;

type
	
	oficina = record
		cod: integer;
		dni: integer;
		valor: real;
	end;
	
	vector = array [1..dimF] of oficina;
	
	{Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. 
	* De cada oficina se ingresa el código de identificación, DNI del propietario 
	* y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación
	*  -1, el cual no se procesa.
	}
	
	procedure leerOficina (var ofi : oficina);
	begin
		writeln ('Ingrese el codigo de identificacion');
		readln (ofi.cod);
		if (ofi.cod <> -1) then begin
			ofi.dni := Random (30);
			ofi.valor:= Random (20);
			writeln (ofi.dni,'   ',ofi.valor);
		end;
	end;
	
	procedure crearVector (var v : vector; var dimL: integer);
	var
		ofi : oficina;
	begin
		leerOficina (ofi);
		while ( (dimL < dimF) and (ofi.cod <> -1)) do begin
			diml:= dimL+1;
			v[dimL] := ofi;
			leerOficina(ofi);
		end;
	
	end;
	
	//Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
	
	Procedure ordenarInsercion ( var v: vector; dimL: integer );
	var 
		i, j: integer; 
		actual: oficina;			
	begin
	 for i:=2 to dimL do begin 
		 actual:= v[i];
		 j:= i-1; 
		 while (j > 0) and (v[j].cod > actual.cod) do begin
			 v[j+1]:= v[j];
			 j:= j - 1;                  
		   end;  
		 v[j+1]:= actual; 
	 end;
	end;
	
	procedure imprimir (v: vector; dimL : integer);
	var
		i : integer;
	begin
		for i :=1 to dimL do begin
			writeln ('Codigo: ',v[i].cod,' dni: ',v[i].dni, ' valor: ',v[i].valor:2:2);
			writeln();
		end;
	end;

	
	var
		v: vector;
		dimL : integer;
	begin
		Randomize;
		dimL:=0;
		crearVector (v,dimL);
		imprimir (v,dimL);
		writeln ('---------------------------------------------------------');
		ordenarInsercion (v,dimL);
		imprimir (v,dimL);
	
	end.
