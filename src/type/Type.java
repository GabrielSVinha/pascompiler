package type;

import java.util.HashMap;

public class Type {
	public static final int REAL = 1;
	public static final int INTEGER = 2;
	public static final int BOOLEAN = 4;
	public static final int TIPO_VOID = 5;
	public static final int ERRO = 6;
	public static final int STRING = 9;
	public static final int SHORTINT = 11;
	public static final int LONGINT = 13;
	public static final int REFERENCIA = 90;
	public static final int FUNCAO = 93;
	public static final int NIL = 0;
	
	static HashMap<String, Type> types = new HashMap<String, Type>();

	int tag;
	int width = 0;
	String val;
	
	public Type(int tag, int width, String val) {
		this.tag = tag;
		this.width = width;
		this.val = val;
	}
	public Type() {
		
	}
	
	public int getWidth() {
		return width;
	}
	
	public int getTag() {
		return tag;
	}
	
	public String getVal() {
		return val;
	}
	
	public static void buildTypes() {
		types.put(REAL+"", new Type(REAL, 1, "real"));
		types.put(INTEGER+"", new Type(INTEGER, 2, "integer"));
		types.put(LONGINT+"", new Type(LONGINT, 4, "longint"));
		types.put(SHORTINT+"", new Type(SHORTINT, 1, "integer"));
		types.put(STRING+"", new Type(STRING, 8, "string"));
		types.put(BOOLEAN+"", new Type(BOOLEAN, 1, "boolean"));
		types.put(FUNCAO+"", new Type(FUNCAO, 93, "function"));
		types.put(TIPO_VOID+"", new Type(TIPO_VOID, 0, "void"));
		types.put(NIL+"", new Type(NIL, 0, "nil"));
		types.put(ERRO+"", new Type(ERRO, 0, "error"));
	}
	
	public static Type getType(int tag) {
		return types.get(""+tag);
	}
	
	public static Type getType(String val) {
		for(Type tipo : types.values()) {
			if(tipo.getVal().equals(val))
				return tipo;
		}
		return null;
	}
	
	public static Type max(Type t1, Type t2) {
		return t1.width > t2.width ? t1 : t2;
	}
}
