#!/usr/local/bin/io

/*
Self study io language day 1
*/

// Is Io strongly or weakly typed???
// A: Io is strongly typed, since you cannot add a number and a string (for example)

// What is ture/false in Io:
// A: everyting except false and nil is true (even 0, empty string etc)

// how can you tell what slots a prototype supports?
// you can use the "slotNames" method to retrieve all slots and "getSlot("nameOfSlot") to get a specific one

// what is the difference between = (equals), := (colon equals) and ::= (colon colon equals)? when would you use each one?
// A: equals is used to assign a value to an existing slot/variable (gives an error if the slot does not exist
// := is used to create and assign
// ::= is used to create a slot, and create a setter and assigns a value
/*
::= 	Creates slot, creates setter, assigns value
:= 	Creates slot, assigns value
= 	Assigns value to slot if it exists, otherwise raises exception 
*/


/* 
self study: DO:
*/

// 1. how to run an Io program from a file
// A: Io nameOfTheFile.io

// 2. Execute code in a slot given its name
myObj := Object clone
// just create a dummy method/slot we can invoke dynamically
myObj myMethod := method("Hello world" println)

// this should display "myMethod"
myObj slotNames
// get the created method/slot by it's name
myMethodSlot := myObj getSlot("myMethod")

// invoke the method (parens are not required)
// attention: we do not add context on what to execute the method: since the method does not need "state" other slots from the object itself 
myMethodSlot

// to test how Io behaves when invoking methods, create a slot that will be accessed from another slot
myObj name := "Benny"
// our new method prints out the name of the object
myObj myMethodWithSlotAccess := method(name println)

// invoke the method itself (prints "Benny")
myObj myMethodWithSlotAccess

methodToInvoke := myObj getSlot("myMethodWithSlotAccess")

// invoke it, which should give an error, since it requires the objects name slot
methodToInvoke
// indeed: gives Exception: Object does not respond to "name"

myOtherObjWithName := Object clone
myOtherObjWithName name := "Christina"

// invoke the method on the "new object that has a name slot, which should print "Christina"
myOhterObjWithName methodToInvoke

