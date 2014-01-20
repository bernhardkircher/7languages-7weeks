#!/usr/local/bin/io

/////////////////////////////
/*
examples of Io  language day 2
*/
/////////////////////////////


// Messages
// messages are very interesting, everything seems to be a message send to/from 
// someone (also see my comments on day01- last examples when "invoking" a method,
// which is in reality sending a message to an object, but I did not know it then
postOffice := Object clone
postOffice packageSender := method(call sender)

mailer := Object clone
// the mailer just sends teh packageSender message to the postOffice 
mailer deliver := method(postOffice packageSender)

// let the mailer deliver...
// mailer is the sender of the message in postOffice
mailer deliver

postOffice messageTarget := method(call target)
// target is the postOffice
postOffice messageTarget

// get the original message name and arguments:
postOffice messageArgs := method(call message arguments)
postOffice messageName := method(call message name)

// prints: list("one", 2, :three)
postOffice messageArgs("one", 2, :three)

// prints: messageName
postOffice messageName


// implement "unless" from ruby
unless := method(
  (call sender doMessage(call message argAt(0))) 
  	ifFalse(call sender doMessage(call message argAt(1))) 
	ifTrue(call sender doMessage(call message argAt(2)))
unless(1==2, write("1 != 2"), write("1 == 2???"))

/* Reflection */
Object ancestors := method(
  prototype := self proto
  if(prototype != Object,
    writeln("Slots of ", prototype type, "\n------------")
    prototype slotNames foreach(slotName, writeln(slotName))
    writeln
    prototype ancestors     
))

Animal := Object clone
Animal speak := method("some animal noise" println)

Duck := Animal clone
Duck speak := method("quack" println)
Duck walk := method("waddle" println)

disco := Duck clone
disco ancestors

/////////////////////////////
/*
Self study io language day 2
*/
/////////////////////////////
