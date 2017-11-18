//
//  JSONNamerRoutes.swift
//  App
//
//  Created by Walter Carli on 18/11/17.
//

import Vapor

extension Droplet {
    func setupJSONNamesRoutes (maximum maxList: Int) throws {
        //single request
        get("api") { req in return try JSON(node: ["name": NameBuilder.next()]) }
        
        //eqivalent of /list but JSON-encoded (many names in a signle JSON)
        get("api", "list", Int.parameter) { req in
            let amount = try req.parameters.next(Int.self)
            guard amount <= maxList && amount > 0 else { //check we aren't requesting too many names or zero names
                return try JSON(node: ["code": "0",
                                       "status": "error",
                                       "errCode": "1",
                                       "description": "parameter 'amount' is either too big or smaller than 1",
                                       "maxNumericParam": String(maxList)])
            }
            var nameDict: [String: String] = [:]
            for i in 0 ..< amount { nameDict["name\(i)"] = NameBuilder.next() }
            return try JSON(node: nameDict)
        }

        //in case the user hasn't specified how many names he wants
        get("api/list") { _ in return try JSON(node: ["code": "0", "status": "error", "errCode": "2", "description": "must supply numeric parameter"])}
    }
}
