program exFunction;
var
   a, b: integer;

(*function definition *)
procedure printMax;
var
   (* local variable declaration *)
   num1, num2, result: integer;

begin
   num1 := 1;
   num2 := 2;
   if (num1 > num2) then
      result := num1
   
   else
      result := num2;
   writeln( 'PROCEDURE: Max value is : ', result );
end;
(* End of procedure *)

begin
   a := 100;
   b := 200;
   (* calling a procedure to print max value *)
   printMax();
   
end.
