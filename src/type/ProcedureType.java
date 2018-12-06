package type;

import java.util.ArrayList;
import java.util.List;

public class ProcedureType extends Type {
	
	public ProcedureType() {
		this.parameters = new ArrayList<Type>();
	}


	public List<Type> parameters;
	
	
	public void addParams(List<Type> type) {
		if (type != null) {
			this.parameters.addAll(type);
		}
	}

}
