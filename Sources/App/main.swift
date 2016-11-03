#if os(Linux)
  import Glibc
#else
  import Darwin
#endif
import Vapor


// MARK: -- NAMES
let praenomina: [String] = ["Marcus",
                        "Gaius",
                        "Titus",
                        "Publius",
                        "Lucius",
                        "Cneus"]

let nomina: [String] = ["Iulius",
                        "Cornelius",
                        "Claudius",
                        "Cassius",
                        "Sempronius",
                        "Domitius"]

let cognomina: [String] = ["Coriolanus",
                        "Brutus",
                        "Caligula",
                        "Cato",
                        "Caesar"]


// MARK: -- Functions
func buildName (from praenomina: [String], and nomina: [String], and cognomina: [String]) -> String {
  #if os(Linux)
    return Int(random() % (max + 1))
    let prae: Int = Int(random() % (praenomina.count + 1))
    let n: Int = Int(random() % (nomina.count + 1))
    let co: Int = Int(random() % (cognomina.count + 1))
  #else
    let prae: Int = Int(arc4random_uniform(UInt32(praenomina.count)))
    let n: Int = Int(arc4random_uniform(UInt32(nomina.count)))
    let co: Int = Int(arc4random_uniform(UInt32(cognomina.count)))
  #endif


  return (praenomina[prae] + " " + nomina[n] + " " + cognomina[co])
}

// MARK: -- Properties
let defaultHead: String = "<head><meta charset='utf-8'></head>"


// MARK: -- Program
//create Droplet object
let drop = Droplet()

// REGISTER Routes and handlers
//default route -> name generation
drop.get { req in
  return buildName(from: praenomina, and: nomina, and: cognomina)
}

//Brusky's easter egg
drop.get("/brusky") { req in
  return "BRUSCHIIIIII!! \n PARACADUTE! PARACADUTE!"
}

//my easter egg
drop.get("w") { req in
  return "Walter è un fregno della madonna"
}

// Start the server
drop.run()
