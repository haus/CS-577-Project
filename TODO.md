Eric
----

- ✔ StringLits
	+ ✔ don't emit WriteInt string each time WriteInt is called
	+ ✔ create hash of already seen strings á là citrus
- Refactor array mess
	- pull logic into ArrayInit, and call from Array Exp
	- also, boundschecking
- CallExps & functions
	- MkClosure!!??!

Matt
----

- RecordExp, RecordInit, RecordDeref
- RecordTypeDec

Both
----

- progress report!
- unify type handling
	- add llvm_type to all types, for the yummy recursive generation thereof
		+ ✔ added to NamedType, ArrayType
		- add to RecordTypeDec