program ej6;
const
	dimF =20;
type
	
	vector = array [1..dimF] of integer;
	
procedure crearVector (var v: vector);
var
	i:integer;
begin
	for i:=1 to dimF do
		v[i] := Random (100);
end;
//-------------------------------------------------------BUSQUEDA DICOTOMICA RECURSIVA
procedure busquedaDicotomica (v: vector; ini,fin: integer; dato:integer; var pos: integer);
var
	medio: integer;
begin
	if (ini > fin) then
	 pos:=-1
	else begin
		medio := (ini + fin) div 2;
		if (v[medio] = dato) then
			pos := medio
		else
			if (dato < v[medio]) then
				busquedaDicotomica (v, ini, medio-1,dato,pos)
			else
				busquedaDicotomica (v, medio+1, fin, dato,pos);
	end;
end;


//-------------------------------------------------------BUSQUEDA DICOTOMICA ITERATIVO
procedure busquedaDicotomicaIterativa (v: vector; x: integer; var pos: integer);
var
	pri,ult,medio : integer;
begin
	pri :=1;	
	ult:= dimF;
	medio := (pri + ult) div 2;
	while ( (pri < ult) and (v[medio] <> x) ) do begin
		if (x < v[medio]) then 
			ult := medio-1
		else
			pri := medio +1;
		medio := (pri + ult) div 2;
	end;
	if (pri <> ult) then
		pos:= medio
	else
		pos :=-1;
	
end;

Procedure Ordenar ( var v: vector);
var i, j, p: integer; item : integer;			
begin
 for i:=1 to dimF-1 do begin {busca el mínimo y guarda en p la posición}
          p := i;
          for j := i+1 to dimF do
             if v[ j ] < v[ p ] then p:=j;

         {intercambia v[i] y v[p]}
         item := v[ p ];   
         v[ p ] := v[ i ];   
         v[ i ] := item;
      end;
end;

procedure imprimirVector (v : vector);
var
	i:integer;
begin
	for i:=1 to dimF do
		writeln (' posicion ',i,' : ',v[i]);
end;

var
	v: vector;
	dato,ini,pos : integer;
begin
	crearVector (v);
	Ordenar (v);
	imprimirVector (v);
	ini:=1; 
	readln (dato);
	busquedaDicotomica (v,ini,dimF,dato,pos);
	busquedaDicotomicaIterativa (v,dato,pos);
	writeln ('Posicion del dato: ',pos);
end.


