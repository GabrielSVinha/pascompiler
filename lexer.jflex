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
    }
%}

Newline    = \r | \n | \r\n
Whitespace = [ \t\f] | {Newline}
Number     = [0-9]+

/* comments */

ident = ([:jletter:] | "_" ) ([:jletterdigit:] | [:jletter:] | "_" )*

Identifier = [a-zA-Z_][a-zA-Z_0-9]*

RealNumber = [0-9]+"."[0-9]+

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

  {Whitespace}    {                              }
  ";"             { return symbolFactory.newSymbol("SEMI", SEMI); }
  "+"             { return symbolFactory.newSymbol("PLUS", PLUS); }
  "-"             { return symbolFactory.newSymbol("MINUS", MINUS); }
  "*"             { return symbolFactory.newSymbol("TIMES", TIMES); }
  "n"             { return symbolFactory.newSymbol("UMINUS", UMINUS); }
  "("             { return symbolFactory.newSymbol("LPAREN", LPAREN); }
  ")"             { return symbolFactory.newSymbol("RPAREN", RPAREN); }
  {Number}        { return symbolFactory.newSymbol("NUMBER", NUMBER, Integer.parseInt(yytext())); }
  {V}{A}{R}       { return symbolFactory.newSymbol("VAR", VAR); }
  {C}{O}{N}{S}{T} { return symbolFactory.newSymbol("CONST", CONST); }
  "char"          { return symbolFactory.newSymbol("CHAR", CHAR); }
  "integer"       { return symbolFactory.newSymbol("INT", INT); }
  "boolean"       { return symbolFactory.newSymbol("BOOL", BOOL); }
  ":"             { return symbolFactory.newSymbol("COLON", COLON); }
  ","		      { return symbolFactory.newSymbol("COMMA", COMMA); }
  "="		      { return symbolFactory.newSymbol("EQUAL", EQUAL); }
  {Identifier}    { return symbolFactory.newSymbol("IDENTIFIER", IDENTIFIER, yytext()); }
  {Newline}       { return symbolFactory.newSymbol("NEWLINE", NEWLINE); } 
}



// error fallback
.|\n          { emit_warning("Unrecognized character '" +yytext()+"' -- ignored"); }
