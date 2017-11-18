//
//  EasterEggsRoutes.swift
//  App
//
//  Created by Walter Carli on 18/11/17.
//

import Vapor

extension Droplet {
    
    func setupEasterEggsRoutes() throws {
        // Brusky's easter egg
        get("brusky") { _ in return "BRUSCHIIIIII!! \n PARACADUTE! PARACADUTE!\n" }

        // my easter egg
        get("w") { _ in return "Walter è un fregno della madonna\n" }
    }
    
}
