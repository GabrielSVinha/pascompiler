package symbolTable;

import type.Type;

public class SymbolImpl {
	Type type;
	String name;
	boolean constant;

	public SymbolImpl(String name, Type type) {
		this(name, type, false);
	}
	
	public SymbolImpl(String nome, Type tipo, boolean constante) {
		this.name = nome;
		this.type = tipo;
		this.constant = constante;
	}

	public Type getType() {
		return type;
	}
	
	public String getName() {
		return name;
	}
	
	public boolean isConstant() {
		return constant;
	}
}
