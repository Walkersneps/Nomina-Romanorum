import Vapor

// MARK: -- Properties
//let defaultHead: String = "<head><meta charset='utf-8'></head>"


// MARK: -- Configuration
print("\n Praeparando Nomina-Romanorum...")
print("Docendo artem operandi...")
let nameBuilder = NameBuilder() // create NameBuilder object
let drop = Droplet() //create Droplet object
print("Ars operandi docta est\n")
print("Configuratione completa est!\n\n")


// MARK: -- Program
print("Incipit executio!")
// MARK: Register routes and handlers
//default route -> name generation
drop.get { req in return nameBuilder.next() }

//Brusky's easter egg
drop.get("/brusky") { req in return "BRUSCHIIIIII!! \n PARACADUTE! PARACADUTE!" }

//my easter egg
drop.get("w") { req in return "Walter è un fregno della madonna" }


// MARK: Server start
drop.run()
