Eric
----

- ✔ StringLits
	+ ✔ don't emit WriteInt string each time WriteInt is called
	+ ✔ create hash of already seen strings á là citrus
- Refactor array mess
	+ ✔ pull logic into ArrayInit, and call from Array Exp
	+ ✔ also, boundschecking
	+ ✔ consider using a struct to represent arrays: {i32, [type x 0]}
- CallExps & functions
	- MkClosure!!??!

Matt
----

+ ✔ RecordExp, RecordInit, RecordDeref
+ ✔ RecordTypeDec
+ ✔ ReadSt
+ ✔ RecordDeref needs nil check
+ ✔ RecordExp needs size information
+ ✔ ArrayExp needs type size information
+ ✔ Array stored as Struct of <length, array>
+ ✔ Types need size information

Both
----

+ ✔ progress report!
+ ✔ unify type handling
	+ ✔ add llvm_type to all types, for the yummy recursive generation thereof
		+ ✔ added to NamedType, ArrayType
		+ ✔ add to RecordTypeDec
- clean up code/comment code
- testing files
	- QuickSort(tm)
	- ...
- benchmark strategy
- benchmark results
- final write-up