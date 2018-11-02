package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;

%%

%class Lexer
%implements sym
%public
%unicode
%line
%column
%cup
%char
%{
	

    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    	throw new RuntimeException("Fatal Lexical Error");
    }
    public String current_lexeme(){
    	int l = yyline+1;
    	int c = yycolumn+1;
    	return " (line: "+l+" , column: "+c+" , lexeme: '"+yytext()+"')";
  	}
  	
  	public int current_line() {
  		return yyline+1;
  	}
%}

Newline    = \r | \n | \r\n
Whitespace = [ \t\f] | {Newline}

/* Literals */
IntegerLiteral = [0-9]+
FloatLiteral = [0-9]+"."[0-9]+
BooleanLiteral = "false" | "true"
StringLiteral = [\'][a-zA-Z_0-9]*[\']
/* comments */

ident = ([:jletter:] | "_" ) ([:jletterdigit:] | [:jletter:] | "_" )*

Identifier = [a-zA-Z_][a-zA-Z_0-9]*


DigSeq = [0-9]+

NQUOTE = [^']

CharacterString = '({NQUOTE}|'')+' | ''

Comment = "(*" [^*] ~"*)" | "{" [^*] ~"}"

A = [aA]
B = [bB]
C = [cC]
D = [dD]
E = [eE]
F = [fF]
G = [gG]
H = [hH]
I = [iI]
J = [jJ]
K = [kK]
L = [lL]
M = [mM]
N = [nN]
O = [oO]
P = [pP]
Q = [qQ]
R = [rR]
S = [sS]
T = [tT]
U = [uU]
V = [vV]
W = [wW]
X = [xX]
Y = [yY]
Z = [zZ]

%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG

%%  

<YYINITIAL> {
  {Comment}       {}
  {F}{O}{R}         { return symbolFactory.newSymbol("FOR", FOR); }
  {T}"o"          { return symbolFactory.newSymbol("TO", TO); } 
  {D}"ownto"      { return symbolFactory.newSymbol("DOWNTO", DOWNTO); }
  {P}"rogram"     { return symbolFactory.newSymbol("PROGRAM", PROGRAM); }
  {P}"rocedure"   { return symbolFactory.newSymbol("PROCEDURE", PROCEDURE); }
  {F}"unction"   { return symbolFactory.newSymbol("FUNCTION", FUNCTION); }
  {Whitespace}    {                              }
  ";"             { return symbolFactory.newSymbol("SEMI", SEMI); }
  "+"             { return symbolFactory.newSymbol("PLUS", PLUS); }
  "-"             { return symbolFactory.newSymbol("MINUS", MINUS); }
  "*"             { return symbolFactory.newSymbol("TIMES", TIMES); }
  "/"             { return symbolFactory.newSymbol("DIVIDE", DIVIDE); }
  {D}"iv"         { return symbolFactory.newSymbol("DIVIDE", DIVIDE); }
  {M}"od"         { return symbolFactory.newSymbol("MOD", MOD); }
  "("             { return symbolFactory.newSymbol("LPAREN", LPAREN); }
  ")"             { return symbolFactory.newSymbol("RPAREN", RPAREN); }
  {IntegerLiteral} { return symbolFactory.newSymbol("INTEGER_LITERAL", INTEGER_LITERAL, Integer.parseInt(yytext())); }
  {FloatLiteral}  { return symbolFactory.newSymbol("FLOAT_LITERAL", FLOAT_LITERAL, Float.parseFloat(yytext())); }
  {BooleanLiteral} { return symbolFactory.newSymbol("BOOLEAN_LITERAL", BOOLEAN_LITERAL, Boolean.valueOf(yytext())); }
  {StringLiteral} { return symbolFactory.newSymbol("STRING_LITERAL", STRING_LITERAL, yytext()); }
  {V}{A}{R}       { return symbolFactory.newSymbol("VAR", VAR); }
  {C}{O}{N}{S}{T} { return symbolFactory.newSymbol("CONST", CONST); }
  {C}"har"        { return symbolFactory.newSymbol("CHAR", CHAR); }
  {I}"nteger"     { return symbolFactory.newSymbol("INT", INT); }
  {B}"oolean"     { return symbolFactory.newSymbol("BOOL", BOOL); }
  {E}"nd"         { return symbolFactory.newSymbol("END", END); }
  {B}"egin"       { return symbolFactory.newSymbol("BEGIN", BEGIN); }
  ":"             { return symbolFactory.newSymbol("COLON", COLON); }
  ","		      { return symbolFactory.newSymbol("COMMA", COMMA); }
  "="		      { return symbolFactory.newSymbol("EQUAL", EQUAL); }
  "."		      { return symbolFactory.newSymbol("FULLSTOP", FULLSTOP); }
  {Newline}       { return symbolFactory.newSymbol("NEWLINE", NEWLINE); }
  ">"             { return symbolFactory.newSymbol("GT", GT); }
  "<"             { return symbolFactory.newSymbol("LT", LT);}
  "<="            { return symbolFactory.newSymbol("LE", LE); }
  ">="            { return symbolFactory.newSymbol("GE", GE); }
  "<>"            { return symbolFactory.newSymbol("DIFF", DIFF); }
  {N}{O}{T}       { return symbolFactory.newSymbol("NOT", NOT); }
  {A}{N}{D}       { return symbolFactory.newSymbol("AND", AND); }
  {O}{R}          { return symbolFactory.newSymbol("OR", OR); }
  {X}{O}{R}       { return symbolFactory.newSymbol("XOR", XOR); } 
  {D}"o"          { return symbolFactory.newSymbol("DO", DO); } 
  {Identifier}    { return symbolFactory.newSymbol("IDENTIFIER", IDENTIFIER, yytext()); }
}



// error fallback
.|\n          { emit_error("Unrecognized character '" +yytext()+"'"); }
