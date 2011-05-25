# FĀBL Status Report

Matthaus Litteken & Eric O'Connell

At this point, we have successfully implemented a substantial subset of FAB on the LLVM. We have chosen to take the existing Java frontend code as a basis, but rather than develop the IR generation in Java we are using JRuby to access the fully type-checked AST. This enables us to use a fairly high-level LLVM API library written in Ruby, using its FFI support.

## What we've done

Nearly all expressions except for CallExp and RecordExp are working, similarly all statements except for CallSt, ReadSt, and ReturnSt are implemented.

- Nodes
	- Ast::RecordTypeDec
		- We use these to emit the LLVM type signatures & store them in the symbol table
	- Ast::Program
	- Ast::Block
	- Ast::VarDec
- Statements
	- Ast::AssignSt
	- Ast::WriteSt
	- Ast::IfSt
	- Ast::WhileSt
	- Ast::LoopSt
	- Ast::ForSt
	- Ast::ExitSt
	- Ast::BlockSt
	- Ast::ReadSt
- Expressions
	- Ast::BinOpExp
	- Ast::UnOpExp
	- Ast::LvalExp
	- Ast::ArrayExp
	- Ast::IntLitExp
	- Ast::RealLitExp
	- Ast::RecordExp
 	- Ast::StringLitExp
- Initializers
	- Ast::ArrayInit
- Lvalues
	- Ast::VarLvalue
	- Ast::ArrayDerefLvalue
	- Ast::RecordDerefLvalue

## What's left to do

### Implementation

The two big things on our list is to tackle record initialization/derferencing and function declarations/calls next, and then finally to implement ReadSt, which should be a simple wrapper around scanf.

- Nodes
	- Ast::FuncDecs
	- Ast::FuncDec
- Statements
	- Ast::CallSt
	- Ast::ReturnSt
- Expressions
	- Ast::CallExp


### Qualitative / Quanitative Analysis

We have been formulating opinions about our experience using LLVM, as well as the particular tools we have been using, but need to collect and organize these thoughts into a cohesive discussion of the tradeoffs. Additionally, we need to design and run some benchmark testing to compare the LLVM interpereter and compiler to the reference interpreter and compiler from the 322 course.

## Differences From Proposal

### Optimizations

We won't be doing any of the optimizations we talked about in our proposal, mostly because LLVM has some pretty excellent optimizations built in already. So for our benchmarks we will likely be comparing unoptimized LLVM to optimized LLVM (perhaps with some partially optimized LLVM in there also) to the reference material.

### Layers

Also differing from our proposal, there is no intermediate layer between the AST and LLVM IR, as we quickly discovered it wasn't needed and would unnecessarily complicate matters. However, if we were to take on any FAB specific optimizations, an intermediate layer would be helpful in that process.

At the moment we do not anticipate tackling reals, though it is very tempting.
