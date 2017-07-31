import Vapor

// MARK: -- Properties
let maxList: Int = 100 //Maximum amount of names which can be reqested in one shot
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
drop.get { req in return "\(nameBuilder.next())\n" }

//get many names all at once
drop.get("list", Int.self) { req, amount in
  guard amount <= maxList else { //check we aren't requesting too many names
      return "ERROR: Parameter 'amount' must be a natural number between 0 and \(maxList).\nYou can't request more than \(maxList) names all at once.\n\nNon è possibile richiedere più di \(maxList) nomi in un colpo solo.\n"
  }
  var names: String = ""
  for i in 0 ..< amount {
    names += "\(nameBuilder.next())\n"
  }
  return names
}


// MARK: API
drop.get("api") { req in return try JSON(node: ["name": nameBuilder.next()]) }

//eqivalent of /list but JSON-encoded
drop.get("api", "list", Int.self) { req, amount in
  guard amount <= maxList else { //check we aren't requesting too many names
      return try JSON(node: ["code": "0",
                            "status": "error",
                            "errCode": "1",
                            "description": "parameter 'amount' is too big",
                            "maxNumericParam": String(maxList)])
  }

  var nameDict: [String: String] = [:]
  for i in 0 ..< amount {
    nameDict["name\(i)"] = nameBuilder.next()
  }
  return try JSON(node: nameDict)
}



//Brusky's easter egg
drop.get("brusky") { req in return "BRUSCHIIIIII!! \n PARACADUTE! PARACADUTE!\n" }

//my easter egg
drop.get("w") { req in return "Walter è un fregno della madonna\n" }


// MARK: Server start
drop.run()
