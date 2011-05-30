JAVAC = javac -classpath ./:frontend.jar

all: AstShim.class AstViewer.class

AstViewer.class: Ast.class
	$(JAVAC) AstViewer.java

AstShim.class: Ast.class
	$(JAVAC) AstShim.java

Ast.class: Ast.java frontend.jar
	$(JAVAC) Ast.java

clean:
	rm *.class