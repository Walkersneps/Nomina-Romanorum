import Vapor

extension Droplet {
    func setupRoutes() throws {

        // MARK: - Properties
        let maxList: Int = 100 //Maximum amount of names which can be reqested in one shot
        //let defaultHead: String = "<head><meta charset='utf-8'></head>"

        // MARK: - Configuration
        print("\n Praeparando Nomina-Romanorum...")
        print("Docendo artem operandi...")
        let nameBuilder = NameBuilder() // create NameBuilder object
        print("Ars operandi docta est\n")
        print("Configuratione completa est!\n\n")


        // MARK: - -Routes
        print("Incipit executio!")

        //default route -> name generation
        get { _ in return "\(nameBuilder.next())\n" }

        //get many names all at once
        get("list", Int.parameter) { req in
            let amount = try req.parameters.next(Int.self)
            guard amount <= maxList && amount > 0 else { return "ERROR: Parameter 'amount' must be a natural number between 0 and \(maxList).\nYou can't request more than \(maxList) names all at once.\n\nNon è possibile richiedere più di \(maxList) nomi in un colpo solo.\n" } //check we aren't requesting too many names
            print("Generating \(amount) name(s)...")
            var names: String = ""
            for _ in 0 ..< amount {
                names += "\(nameBuilder.next())\n"
            }
            return names
        }

        //in case the user hasn't specified how many names he wants
        get("list") { _ in return "ERROR: You must specify how many names you want me to generate, by the format '/list/amount', where 'amount is a numeric variable parameter between 1 and \(maxList).\n\nDevi specificare quanti nomi vuoi che siano generati, secondo il formato '/list/amount', dove 'amount' è un parametro numerico variabile a tua scelta compreso tra 1 e \(maxList).\n" }


        // MARK: API
        get("api") { req in return try JSON(node: ["name": nameBuilder.next()]) }

        //eqivalent of /list but JSON-encoded
        get("api", "list", Int.parameter) { req in
            let amount = try req.parameters.next(Int.self)
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


        // MARK: Tests
        get("hello") { _ in return "Hello World!" }
        get("hello", String.parameter) { req in
            var json = JSON() //create a JSON object
            let kind = try req.parameters.next(String.self) //get the parameter (response type)
            guard kind == "json" else { try json.set("error", "Bad Request"); return json } //check we've been asked for a JSON
            try json.set("hello", "world"); return json //answer with a fancy JSON
        }
        get("info") { req in return req.description }


        // MARK: Easter Eggs
        //Brusky's easter egg
        get("brusky") { _ in return "BRUSCHIIIIII!! \n PARACADUTE! PARACADUTE!\n" }

        //my easter egg
        get("w") { _ in return "Walter è un fregno della madonna\n" }



        //idk what this does, but it was in the template, so I'm not gonna remove it
        try resource("posts", PostController.self)
    }
}
