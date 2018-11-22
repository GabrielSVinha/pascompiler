package type;

import java.util.ArrayList;
import java.util.List;

public class FunctionType extends Type {
	public List<Type> parameters;
	public Type returnType;
	
	public FunctionType(Type r) {
		this.parameters = new ArrayList<Type>();
	}

	public void addParams(List<Type> type) {
		this.parameters.addAll(type);
	}
	
}
