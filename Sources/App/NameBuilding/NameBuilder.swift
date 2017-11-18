//
//  NameBuilder.swift
//  App
//
//  Created by Walter Carli on 15/11/17.
//

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

public struct NameBuilder {
    
    private static func randomInt (min: Int, max: Int) -> Int {
        #if os(Linux)
            return Glibc.random() % max
        #else
            // return min + Int(arc4random_uniform(UInt32(max - min + 1)))
            return Int(arc4random_uniform(UInt32(max)))
        #endif
    }

    private static func buildName (from praenomina: [String], and nomina: [String], and cognomina: [String]) -> String {
        let prae: Int = randomInt(min: 0, max: praenomina.count)
        let n: Int = randomInt(min: 0, max: nomina.count)
        let co: Int = randomInt(min: 0, max: cognomina.count)
        return (praenomina[prae] + " " + nomina[n] + " " + cognomina[co])
    }

    static func next () -> String { return buildName(from: Praenomina.list, and: Nomina.list, and: Cognomina.list) }
    
}
