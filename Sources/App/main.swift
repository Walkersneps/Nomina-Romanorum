#if os(Linux)
  import Glibc
#else
  import Darwin
#endif
import Vapor


// MARK: -- NAMES
print("\n Praeparandum Nomina-Romanorum...")
print("Docendo nomina...")
let praenominaObj = Praenomina(); let praenomina = praenominaObj.list
let nominaObj = Nomina(); let nomina = nominaObj.list
let cognominaObj = Cognomina(); let cognomina = cognominaObj.list
print("Praenomina sunt: \(praenomina)")
print("Nomina sunt: \(nomina)")
print("Cognomina sunt: \(cognomina)")
print("Nomina docta sunt\n")


// MARK: -- Functions
print("Docendo artem operandi...")
func buildName (from praenomina: [String], and nomina: [String], and cognomina: [String]) -> String {
  #if os(Linux)
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
print("Ars operandi docta est\n")


// MARK: -- Properties
let defaultHead: String = "<head><meta charset='utf-8'></head>"

print("Configuratione completa est!\n\n")

// MARK: -- Program
//create Droplet object
print("Incipit executio!")
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
