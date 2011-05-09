import java.util.*;

/* Copyright Andrew Tolmach 2004-2011. All rights reserved. */

class Ast {
  
  public static class Error extends Exception {
    Error(String text) {
      super(text);
    }
  }

  public abstract static class Node {
    int line;
    Node (int line) {
      this.line = line;
    }
    private static final String newline =  System.getProperty("line.separator");
    private static String tabs(int tab) {
      String r = newline;
      for (int i = 0; i< tab; i++)
        r += "  ";
      return r;
    }
    abstract String toPretty(int tab);     
    String format(int tab,String desc) {
      return tabs(tab) + "(" + line + " " + desc + ")";
    }
    String formatList(int tab, Node[] nodes) {
      String r = "(";
      for (Node n : nodes)
        r += n.toPretty(tab);
      r += ")";
      return r;
    }
    public String toString() {
      String r = this.toPretty(0);
      return r.substring(newline.length());
    }
  }


  public static class Program extends Node {
    RecordTypeDec[] rtypes;
    Block body;
    Program (int line, RecordTypeDec[] rtypes, Block body) {
      super(line);
      this.rtypes = rtypes; this.body = body;
    }
    Program (int line, List rtypes,Block body) {
      this(line,new RecordTypeDec[rtypes.size()],body);
      int n = 0;
      for (Object x : rtypes)
	this.rtypes[n++] = (RecordTypeDec) x;
    }
    String toPretty(int tab) {
      return format(tab,"Program " + formatList(tab+1,rtypes) + body.toPretty(tab+1));
    }
  }

  public static class RecordTypeDec extends Node {
    String name;
    String super_name; // can be null
    IdType[] components;
    IdType[] all_components = null;  // filled in by checker 
    RecordTypeDec(int line, String name, String super_name, IdType[] components) {
      super(line); 
      this.name = name; this.super_name = super_name; this.components = components;
    }
    RecordTypeDec(int line, String name, String super_name, List components) {
      this(line,name,super_name,new IdType[components.size()]);
      int n = 0;
      for (Object x : components)
	this.components[n++] = (IdType) x;
    }
    String toPretty(int tab) {
      return format(tab, "RecordTypeDec " + name + " " +
		    (super_name != null ? super_name : "-") + " " +
		    formatList(tab+1,components));
    }
  }


  public static class IdType extends Node {
    String name;
    int unique = -1;  // possibly filled in by checker
    TypeExp type;
    IdType (int line, String name, TypeExp type) {
      super(line);
      this.name = name; this.type = type;
    }
    String toPretty(int tab) {
      return format(tab, "IdType " + name + ((unique >= 0) ? "_" + unique : "") + " " + type);
    }
  }

  public abstract static class TypeExp extends Node {
    TypeExp(int line) {
      super(line);
    }
    abstract String unparse(); // for error messages, print type as the user entered it
    abstract Object accept(TypeExpVisitor v) throws Error; 
  }

  interface TypeExpVisitor {
    Object visit(Ast.NamedType t) throws Error;
    Object visit(Ast.ArrayType t) throws Error;
    Object visit(Ast.ArrowType t) throws Error;
  }

  public static class NamedType extends TypeExp {
    String name;
    NamedType(int line, String name) {
      super(line);
      this.name = name;
    }
    String toPretty(int tab) {
      return format(tab,"NamedType " + name);
    }
    String unparse() {
      return name;
    }
    Object accept(TypeExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  /* define the built-in named types once and for all */
  public static Ast.NamedType boolean_t = new Ast.NamedType(0,"boolean");
  public static Ast.NamedType unit_t = new Ast.NamedType(0,"unit");
  public static Ast.NamedType real_t = new Ast.NamedType(0,"real");
  public static Ast.NamedType integer_t = new Ast.NamedType(0,"integer");
  public static Ast.NamedType unknown_record_t = new Ast.NamedType(0,"?record");  /* for internal use only */
  public static Ast.NamedType string_t = new Ast.NamedType(0,"?string");          /* for internal use only */

  static boolean is_boolean_type (Ast.TypeExp t) {
    return (t instanceof Ast.NamedType && ((Ast.NamedType) t).name.equals(Ast.boolean_t.name));
  }
  static boolean is_unit_type (Ast.TypeExp t) {
    return (t instanceof Ast.NamedType && ((Ast.NamedType) t).name.equals(Ast.unit_t.name));
  }
  static boolean is_real_type (Ast.TypeExp t) {
    return (t instanceof Ast.NamedType && ((Ast.NamedType) t).name.equals(Ast.real_t.name));
  }
  static boolean is_integer_type (Ast.TypeExp t) {
    return (t instanceof Ast.NamedType && ((Ast.NamedType) t).name.equals(Ast.integer_t.name));
  }
  static boolean is_string_type (Ast.TypeExp t) {
    return (t instanceof Ast.NamedType && ((Ast.NamedType) t).name.equals(Ast.string_t.name));
  }

  public static class ArrayType extends TypeExp {
    TypeExp elementType;
    ArrayType (int line, TypeExp elementType) {
      super(line); 
      this.elementType = elementType;
    }
    String toPretty(int tab) {
      return format(tab, "ArrayType " + elementType);
    }
    String unparse() {
      return "@" + elementType.unparse() ;
    }
    Object accept(TypeExpVisitor v) throws Error {
      return v.visit(this);
    }

  }

  public static class ArrowType extends TypeExp {
    TypeExp[] argTypes;
    TypeExp resultType;
    ArrowType (int line, TypeExp[] argTypes, TypeExp resultType) {
      super(line); 
      this.argTypes = argTypes; this.resultType = resultType;
    }
    ArrowType (int line, List argTypes, TypeExp resultType) {
      this(line, new TypeExp[argTypes.size()], resultType);
      int n = 0;
      for (Object x : argTypes)
	this.argTypes[n++] = (TypeExp) x;
    }
    String toPretty(int tab) {
      return format(tab, "ArrowType " + formatList(tab+1,argTypes) + " " + resultType);
    }
    String unparse() {
      String s = "((";
      if (argTypes.length > 0) {
	s += argTypes[0].unparse();
	for (int i = 1; i < argTypes.length; i++)
	  s += "," + argTypes[i].unparse();
      }
      s += ") -> " + resultType.unparse() + ")";
      return s;
    }
    Object accept(TypeExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class Block extends Node {
    BlockItem[] items;
    Block (int line, BlockItem[] items) {
      super(line); 
      this.items = items;
    }
    Block (int line, List items) {
      this(line,new BlockItem[items.size()]);
      int n = 0;
      for (Object x : items)
	this.items[n++] = (BlockItem) x;
    }
    public String toPretty(int tab) {
      return format(tab, "Block " + formatList(tab+1,items));
    }
  }

  public abstract static class BlockItem extends Node {
    BlockItem(int line) {
      super(line);
    }
  }

  public abstract static class Declaration extends BlockItem {
    Declaration(int line) {
      super(line);
    }
    abstract Object accept(DeclarationVisitor v) throws Error;
  }

  interface DeclarationVisitor {
    Object visit (Ast.VarDec d) throws Error;
    Object visit (Ast.FuncDecs d) throws Error;
  }

  public static class VarDec extends Declaration {
    String name;
    int unique = -1; // filled in by checker
    TypeExp type; // can be null after parsing; filled in by checker
    Exp initializer;
    VarDec(int line, String name, TypeExp type, Exp initializer) {
      super(line); 
      this.name = name; this.type = type; this.initializer = initializer;
    }
    String toPretty(int tab) {
      return format(tab,"VarDec " + name + ((unique >= 0) ? ("_" + unique) : "") + 
		    " " + (type != null ? type : "-") + initializer.toPretty(tab+1));
    }
    Object accept(DeclarationVisitor v) throws Error {
      return v.visit(this);
    }

  }


  public static class FuncDecs extends Declaration {
    FuncDec[] decs;
    FuncDecs (int line, FuncDec[] decs) {
      super(line);
      this.decs = decs;
    }
    FuncDecs (int line, List decs) {
      this(line,new FuncDec[decs.size()]);
      int n = 0;
      for (Object x : decs)
      	this.decs[n++] = (FuncDec) x;
    }
    String toPretty(int tab) {
      return format(tab, "FuncDecs " + formatList(tab+1,decs));
    }
    Object accept(DeclarationVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class FuncDec extends Node {
    String name;
    int unique = -1; // filled in by checker
    IdType[] formals;
    TypeExp resultType;  // can be null 
    IdType[] freevars; // filled in by checker
    Block body;
    FuncDec(int line, String name, IdType[] formals, TypeExp resultType, Block body) {
      super(line); 
      this.name = name; this.formals = formals; this.resultType = resultType; this.body = body;
    }
    FuncDec(int line, String name, List formals, TypeExp resultType, Block body) {
      this(line, name, new IdType[formals.size()], resultType, body);
      int n = 0;
      for (Object x : formals)
	this.formals[n++] = (IdType) x;
    }
    String toPretty(int tab) {
      return format(tab, "FuncDec " + name + ((unique >= 0) ? ("_" + unique) : "") +
      		    " " + formatList(tab+1,formals) + 
		    (freevars != null ? (" " + formatList(tab+1,freevars)) : "") +
		    " " + (resultType != null ? resultType : "-") + 
		    body.toPretty(tab+1));
    }
  }
	

  public abstract static class St extends BlockItem {
    St (int line) {
      super(line);
    }
    abstract Object accept(StVisitor v) throws Error;
  }

  interface StVisitor {
    Object visit (Ast.AssignSt st0) throws Error;
    Object visit (Ast.CallSt st0) throws Error;
    Object visit (Ast.ReadSt st0) throws Error;
    Object visit (Ast.WriteSt st0) throws Error;
    Object visit (Ast.IfSt st0) throws Error;
    Object visit (Ast.WhileSt st0) throws Error;
    Object visit (Ast.LoopSt st0) throws Error;
    Object visit (Ast.ForSt st0) throws Error;
    Object visit (Ast.ExitSt st0) throws Error;
    Object visit (Ast.ReturnSt st0) throws Error;
    Object visit (Ast.BlockSt st0) throws Error;
  }

  public static class AssignSt extends St {
    Lvalue lhs;
    Exp rhs;
    AssignSt(int line, Lvalue lhs, Exp rhs) {
      super(line); 
      this.lhs = lhs; this.rhs = rhs;
    }
    String toPretty(int tab) {
      return format(tab,"AssignSt" + lhs.toPretty(tab+1) + rhs.toPretty(tab+1));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }


  public static class CallSt extends St {
    Exp func;
    Exp[] args;
    CallSt(int line, Exp func, Exp[] args) {
      super(line); 
      this.func = func;  this.args = args;
    }
    CallSt(int line, Exp func, List args) {
      this(line, func, new Exp[args.size()]);
      int n = 0;
      for (Object x : args)
	this.args[n++] = (Exp) x;
    }
    String toPretty(int tab) {
      return format(tab, "CallSt " + func.toPretty(tab+1) + formatList(tab+1,args));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class ReadSt extends St {
    Lvalue[] targets;
    ReadSt(int line, Lvalue[] targets) {
      super(line); 
      this.targets = targets;
    }
    ReadSt(int line, List targets) {
      this(line, new Lvalue[targets.size()]);
      int n = 0;
      for (Object x : targets) 
	this.targets[n++] = (Lvalue) x;
    }
    String toPretty(int tab) {
      return format(tab, "ReadSt " + formatList(tab+1,targets));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class WriteSt extends St {
    Exp[] exps;
    WriteSt(int line, Exp[] exps) {
      super(line); 
      this.exps = exps;
    }
    WriteSt(int line, List exps) {
      this(line, new Exp[exps.size()]);
      int n = 0;
      for (Object x : exps) 
	this.exps[n++] = (Exp) x;
    }
    String toPretty(int tab) {
      return format(tab, "WriteSt " + formatList(tab+1,exps));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class IfSt extends St {
    Exp test;
    St ifTrue;
    St ifFalse; 
    IfSt(int line, Exp test, St ifTrue, St ifFalse) {
      super(line); 
      this.test = test; this.ifTrue = ifTrue; this.ifFalse = ifFalse;
    }
    String toPretty(int tab) {
      return format(tab,"IfSt" + test.toPretty(tab+1) + ifTrue.toPretty(tab+1) + ifFalse.toPretty(tab+1));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class WhileSt extends St {
    Exp test;
    St body;
    WhileSt(int line, Exp test, St body) {
      super(line); 
      this.test = test; this.body = body;
    }
    String toPretty(int tab) {
      return format(tab, "WhileSt" + test.toPretty(tab+1) + body.toPretty(tab+1));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class LoopSt extends St {
    St body;
    LoopSt(int line, St body) {
      super(line); 
      this.body = body;
    }
    String toPretty(int tab) {
      return format(tab,"LoopSt" + body.toPretty(tab+1));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }
  
  public static class ForSt extends St {
    String loopVar;  // could have had parser build a VarLvalue node here instead
    int unique = -1; // filled in by checker
    Exp start;
    Exp stop;
    Exp step;
    St body;
    ForSt (int line, String loopVar, Exp start, Exp stop, Exp step, St body) {
      super(line); 
      this.loopVar = loopVar; this.start = start;
      this.stop = stop; this.step = step; this.body = body;
    }
    String toPretty(int tab) {
      return format(tab, "ForSt " + loopVar + (unique >= 0 ? ("_" + unique) : "") +
		          start.toPretty(tab+1) + 
		          stop.toPretty(tab+1) + step.toPretty(tab+1) + body.toPretty(tab+1));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }


  public static class ExitSt extends St {
    ExitSt(int line) {
      super(line);
    }
    String toPretty(int tab) {
      return format(tab,"ExitSt");
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class ReturnSt extends St {
    Exp returnValue; // can be null
    ReturnSt(int line, Exp returnValue) {
      super(line); 
      this.returnValue = returnValue;
    }
    String toPretty(int tab) {
      return format(tab,"RetSt" + (returnValue != null ? returnValue.toPretty(tab+1) : " - "));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class BlockSt extends St {
    Block body;
    BlockSt(int line, Block body) {
      super(line);
      this.body = body;
    }
    String toPretty(int tab) {
      return format(tab,"BlockSt" + body.toPretty(tab+1));
    }
    Object accept(StVisitor v) throws Error {
      return v.visit(this);
    }
  }


  public abstract static class Exp extends Node {
    TypeExp type = null; // filled in by checker
    Exp (int line) {
      super(line);
    }
    abstract Object accept(ExpVisitor v) throws Error;
    String typify(int tab,String desc) {
      return format(tab,desc + " " +  (type != null ? type : "-"));
    }
  }

  interface ExpVisitor {
    Object visit (Ast.BinOpExp e0) throws Error;
    Object visit (Ast.UnOpExp e0) throws Error;
    Object visit (Ast.LvalExp e0) throws Error;
    Object visit (Ast.CallExp e0) throws Error;
    Object visit (Ast.ArrayExp e0) throws Error;
    Object visit (Ast.RecordExp e0) throws Error;
    Object visit (Ast.IntLitExp e0) throws Error;
    Object visit (Ast.RealLitExp e0) throws Error;
    Object visit (Ast.StringLitExp e0) throws Error;
  }


  // BinOp codes

  // BinOp codes
  public static final int  
    LT = 0,
    LEQ = 1,
    GT = 2,
    GEQ = 3,
    EQ = 4,
    NEQ = 5,
    PLUS = 6,
    MINUS = 7,
    TIMES = 8,
    SLASH = 9,
    DIV = 10,
    MOD = 11,
    AND = 12,
    OR = 13;

  public static class BinOpExp extends Exp {
    int /* BinOp */ binOp;
    Exp left;
    Exp right;
    BinOpExp(int line, int /* BinOp */ binOp, Exp left, Exp right) {
      super(line);
      this.binOp = binOp; this.left = left; this.right = right;
    }
    String toPretty(int tab) {
      return typify(tab,"BinOpExp " + binOp + left.toPretty(tab+1) + right.toPretty(tab+1));
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  // UnOp codes
  public static final int
    UMINUS = 0,
    NOT = 1;
  //  public static enum UnOp { UMINUS, NOT }

  public static class UnOpExp extends Exp {
    int /* UnOp */ unOp;
    Exp operand;
    UnOpExp(int line, int /* UnOp */ unOp, Exp operand) {
      super(line);
      this.unOp = unOp; this.operand = operand;
    }
    String toPretty(int tab) {
      return typify(tab, "UnOpExp " + unOp + operand.toPretty(tab+1));
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class LvalExp extends Exp {
    Lvalue lval;
    LvalExp(int line, Lvalue lval) {
      super(line);
      this.lval = lval;
    }
    String toPretty(int tab) {
      return typify(tab, "LvalExp" + lval.toPretty(tab+1));
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class CallExp extends Exp {
    Exp func;
    Exp[] args;
    CallExp(int line, Exp func, Exp[] args) {
      super(line);
      this.func = func; this.args = args;
    }
    CallExp(int line, Exp func, List args) {
      this(line, func, new Exp[args.size()]);
      int n = 0;
      for (Object x : args) 
	this.args[n++] = (Exp) x;
    }
    String toPretty(int tab) {
      return typify(tab, "CallExp " + func.toPretty(tab+1) + formatList(tab+1,args));
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }


  public static class ArrayExp extends Exp {
    TypeExp type; // element type
    ArrayInit[] initializers;
    ArrayExp(int line, TypeExp type, ArrayInit[] initializers) {
      super(line);
      this.type = type; this.initializers = initializers;
    }
    ArrayExp(int line, TypeExp type, List initializers) {
      this(line, type, new ArrayInit[initializers.size()]);
      int n = 0;
      for (Object x : initializers)
	this.initializers[n++] = (ArrayInit) x;
    }
    String toPretty(int tab) {
      return typify(tab, "ArrayExp " + type + " " + formatList(tab+1,initializers));
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class RecordExp extends Exp {
    String typeName;
    RecordInit[] initializers;
    RecordTypeDec typeDec = null; // filled in by checker
    RecordExp(int line, String typeName, RecordInit[] initializers) {
      super(line);
      this.typeName = typeName; this.initializers = initializers;
    }
    RecordExp(int line, String typeName, List initializers) {
      this(line, typeName, new RecordInit[initializers.size()]);
      int n = 0;
      for (Object x : initializers)
	this.initializers[n++] = (RecordInit) x;
    }
    String toPretty(int tab) {
      return typify(tab, "RecordExp " + typeName + " " + formatList(tab+1,initializers));
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class IntLitExp extends Exp {
    int lit;
    IntLitExp(int line, int lit) {
      super(line);
      this.lit = lit;
    }
    IntLitExp(int line, Integer lit) {
      this(line, lit.intValue());
    }
    String toPretty(int tab) {
      return typify(tab, "IntLit " + lit);
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class RealLitExp extends Exp {
    String lit;
    RealLitExp(int line, String lit) {
      super(line);
      this.lit = lit;
    }
    String toPretty(int tab) {
      return typify(tab, "RealLit \"" + lit + "\"");
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class StringLitExp extends Exp {
    String lit;
    StringLitExp(int line, String lit) {
      super(line);
      this.lit = lit;
    }
    String toPretty(int tab) {
      return format(tab, "StringLit \"" + lit + "\"");
    }
    Object accept(ExpVisitor v) throws Error {
      return v.visit(this);
    }
  }

  public static class ArrayInit extends Node {
    Exp count;
    Exp value;
    ArrayInit(int line, Exp count, Exp value) {
      super(line); 
      this.count = count; this.value = value;
    }
    String toPretty(int tab) {
      return format(tab, "ArrayInit" + count.toPretty(tab+1) + value.toPretty(tab+1));
    }
  }

  public static class RecordInit extends Node {
    String name;
    Exp value;
    TypeExp type = null; // filled in by checker
    int offset = -1; // filled in by checker
    RecordInit(int line, String name, Exp value) {
      super(line);
      this.name = name; this.value = value;
    }
    String toPretty(int tab) {
      return format(tab, "RecordInit " + name + " " + offset + " " + value.toPretty(tab+1) + 
		    " " + (type != null ? type : "-"));
    }
  }

  public abstract static class Lvalue extends Node {
    TypeExp type = null; // filled in by checker
    Lvalue(int line) {
      super(line);
    }
    abstract Object accept(LvalueVisitor v) throws Error; 
    String typify(int tab,String desc) {
      return format(tab,desc + " " +  (type != null ? type : "-"));
    }
  }

  interface LvalueVisitor {
    Object visit(Ast.VarLvalue lv) throws Error;
    Object visit(Ast.ArrayDerefLvalue lv) throws Error;
    Object visit(Ast.RecordDerefLvalue lv) throws Error;
  }
    
  public static class VarLvalue extends Lvalue {
    String name;
    int unique = -1; // filled in by checker
    VarLvalue(int line, String name) {
      super(line);
      this.name = name;
    }
    String toPretty(int tab) {
      return typify(tab, "Var " + name + ((unique >= 0) ? ("_" + unique) : ""));
    }
    Object accept(LvalueVisitor v) throws Error {
      return v.visit(this);
    }
  }


  public static class ArrayDerefLvalue extends Lvalue {
    Lvalue array;
    Exp index;
    ArrayDerefLvalue(int line, Lvalue array, Exp index) {
      super(line);
      this.array = array; this.index = index;
    }
    String toPretty(int tab) {
      return typify(tab, "ArrayDeref" + array.toPretty(tab+1) + index.toPretty(tab+1));
    }
    Object accept(LvalueVisitor v) throws Error {
      return v.visit(this);
    }
  }
      
  public static class RecordDerefLvalue extends Lvalue {
    Lvalue record;
    String name;
    RecordTypeDec typeDec = null; // filled in by checker
    int offset = -1; // filled in by checker
    RecordDerefLvalue(int line, Lvalue record, String name) {
      super(line);
      this.record = record; this.name = name; 
    }
    String toPretty(int tab) {
      return typify(tab, "RecordDeref" + record.toPretty(tab+1) + " " + name + " " + offset);
    }
    Object accept(LvalueVisitor v) throws Error {
      return v.visit(this);
    }
  }

}
