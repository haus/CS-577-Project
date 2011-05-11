import java.io.*;

public class AstShim {
    public static Ast.Program giveMeAST(String path) {
    	try {
            FileInputStream is = new FileInputStream(path);
    	    Parser parser_obj = new Parser(new Scanner(is));
    	    Ast.Program prog = (Ast.Program) parser_obj.parse().value;
        	is.close();
            return prog;
    	} catch (ParseError exn) {
    	    System.err.println(exn.getMessage());
    	} catch (Check.CheckError exn) {
    	    System.err.println(exn.getMessage());
	    } catch (java.io.FileNotFoundException exn) {
    	    System.err.println(exn.getMessage());
	    } catch (java.io.IOException exn) {
    	    System.err.println(exn.getMessage());
	    } catch (java.lang.Exception exn) {
    	    System.err.println(exn.getMessage());
	    }
	    
	    return null;
    }
}