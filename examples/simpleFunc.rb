{
  var a:= 2;
  func qqq(b:integer) -> integer {
	  return b * 42
  };
  
  func writeInt(b:integer) {
    write(b)
  };
  
  write(a);
  writeInt(a);
  a := qqq(a);
  write(a);
  writeInt(a)
}