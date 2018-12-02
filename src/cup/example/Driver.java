package cup.example;

import java_cup.runtime.*;

class Driver {

	public static void main(String[] args) throws Exception {
		Parser parser = new Parser();
		parser.parse();
		if (parser.errors == 0) {
			System.out.println(parser.code.toString());
		} else {
			System.out.println("There were errors in the compilation, check your code.");
			System.out.println("No code produced.");
		}
	}
	
}