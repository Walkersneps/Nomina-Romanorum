//
//  PlainNamesRoutes.swift
//  App
//
//  Created by Walter Carli on 18/11/17.
//

import Vapor

extension Droplet {
    func setupPlainNamesRoutes(maximum maxList: Int) throws {
        //default route -> name generation
        get { _ in return "\(NameBuilder.next())\n" }

        // get many names all at once
        get("list", Int.parameter) { req in
            let amount = try req.parameters.next(Int.self)
            guard amount <= maxList && amount > 0 else { return "ERROR: Parameter 'amount' must be a natural number between 0 and \(maxList).\nYou can't request more than \(maxList) names all at once.\n\nNon è possibile richiedere più di \(maxList) nomi in un colpo solo.\n" } // check we aren't requesting too many names
            print("Generating \(amount) name(s)...")
            var names: String = ""
            for _ in 0 ..< amount { names += "\(NameBuilder.next())\n" }
            return names
        }

        // in case the user hasn't specified how many names he wants
        get("list") { _ in return "ERROR: You must specify how many names you want me to generate, by the format '/list/amount', where 'amount is a numeric variable parameter between 1 and \(maxList).\n\nDevi specificare quanti nomi vuoi che siano generati, secondo il formato '/list/amount', dove 'amount' è un parametro numerico variabile a tua scelta compreso tra 1 e \(maxList).\n" }
    }
}
