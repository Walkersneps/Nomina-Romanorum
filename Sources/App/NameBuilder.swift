#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

public struct NameBuilder {
  let praenomina, nomina, cognomina: [String]
  
  init() {
    print("Docendo nomina...")
    let praenominaObj = Praenomina(); praenomina = praenominaObj.list
    let nominaObj = Nomina(); nomina = nominaObj.list
    let cognominaObj = Cognomina(); cognomina = cognominaObj.list
    print("Praenomina sunt: \(praenomina)")
    print("Nomina sunt: \(nomina)")
    print("Cognomina sunt: \(cognomina)")
    print("Nomina docta sunt\n")
  }

  private func buildName (from praenomina: [String], and nomina: [String], and cognomina: [String]) -> String {
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

  func next () -> String {
    return buildName(from: praenomina, and: nomina, and: cognomina)
  }
}
