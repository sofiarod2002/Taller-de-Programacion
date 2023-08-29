program ej5;

const
	dimF =20;
type
	
	vector = array [1..dimF] of integer;
	
//a. Implemente un módulo que genere un vector de 20 números enteros.
procedure crearVector (var v: vector);
var
	i:integer;
begin
	for i:=1 to dimF do
		v[i] := Random (100);
end;

//b. Implemente un módulo recursivo que devuelva el máximo valor del vector.
procedure maximo (v: vector; var i,max : integer);
begin
	if (i <= dimF) then begin
		if (v[i] > max) then
			max:= v[i];
		i:= i+1;
		maximo (v,i,max);
	end; 
end;

//c. Implementar un módulo recursivo que devuelva la suma de los valores contenidos en el vector.
procedure totalRec (v: vector; var i,total : integer);
begin
	if (i <= dimF) then begin
		total:= total + v[i];
		i := i + 1;
		totalRec (v,i,total);
	end; 
end;

procedure imprimirVector (v : vector);
var
	i:integer;
begin
	for i:=1 to dimF do
		writeln (v[i]);
end;



var
	v: vector;
	max,total,x : integer;
begin
	crearVector (v);
	imprimirVector (v);
	max:=-1; total:=0; x:=1;
	maximo (v,x,max);
	x:=1;
	totalRec (v,x,total);
	writeln ('Valor maximo: ',max, ' total: ', total);
end.
