package symbolTable;

import java.util.HashMap;

public class SymbolTable {
	public static HashMap<String, SymbolImpl> table;
	public SymbolTable() {
		table = new HashMap<>();
	}
	
	public static void initialize() {
		table = new HashMap<>();
	}
	
	public static boolean insert(String name, SymbolImpl sym) {
		if (!table.containsKey(name)) {
			table.put(name, sym);
			return true;
		}
		return false;
	}
	
	public static SymbolImpl get(String name) {
		return table.get(name);
	}
}
