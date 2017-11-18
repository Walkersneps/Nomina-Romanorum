import Vapor

extension Droplet {
    
    func setupInfoRoutes() throws {
        // plain hello
        get("hello") { _ in return "Hello World!" }

        // other formats hello
        get("hello", String.parameter) { req in
            var json = JSON() // create a JSON object
            let kind = try req.parameters.next(String.self) // get the parameter (response type)
            guard kind == "json" else { try json.set("error", "Bad Request"); return json } // check we've been asked for a JSON
            try json.set("hello", "world"); return json // answer with a fancy JSON
        }

        // infos
        get("info") { req in return req.description }

        // idk what this does, but it was in the template, so I'm not gonna remove it
        try resource("posts", PostController.self)
    }
    
}
