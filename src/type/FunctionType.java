package type;

import java.util.ArrayList;
import java.util.List;

public class FunctionType extends Type {
	public List<Type> parameters;
	public Type returnType;
	
	public FunctionType(Type r) {
		this.parameters = new ArrayList<Type>();
		this.returnType = r;
	}

	public void addParams(List<Type> type) {
		this.parameters.addAll(type);
	}
	
	public String getVal() {
		return this.returnType.val;
	}
	
}
