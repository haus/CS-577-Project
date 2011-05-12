public class AstViewer {
	public static void main(String args[]) {
		if (args.length == 1) {
			Ast.Program prog1 = AstShim.giveMeAST(args[0]);
			System.out.println(prog1.toPretty(0));
		} else {
			System.err.println("Missing fab file location argument.");
			System.exit(1);
		}
	}
}