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
  
  private func randomInt (min: Int, max: Int) -> Int {
    #if os(Linux)
      return Gblibc.random() % max
    #else
      return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    #endif
  }

  private func buildName (from praenomina: [String], and nomina: [String], and cognomina: [String]) -> String {
    let prae: Int = randomInt(min: 0, max: praenomina.count)
    let n: Int = randomInt(min: 0, max: nomina.count)
    let co: Int = randomInt(min: 0, max: cognomina.count)

    return (praenomina[prae] + " " + nomina[n] + " " + cognomina[co])
  }

  func next () -> String {
    return buildName(from: praenomina, and: nomina, and: cognomina)
  }
}
