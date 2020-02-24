import Vapor

// MARK: -- Properties
let maxList: Int = 100 //Maximum amount of names which can be reqested in one shot
//let defaultHead: String = "<head><meta charset='utf-8'></head>"

// MARK: -- Configuration
print("\n Praeparando Nomina-Romanorum...")
print("Docendo artem operandi...")
let nameBuilder = NameBuilder() // create NameBuilder object
print("Ars operandi docta est\n")
print("Configuratione completa est!\n\n")


// MARK: --Routes
public func routes(_ router: Router) throws {
	
	//default route -> standard name generation
	router.get { req in return "\(nameBuilder.next())\n" }
	
	//get many names all at once
	router.get("list", Int.self) { req, amount in
		guard amount <= maxList else { return "ERROR: Parameter 'amount' must be a natural number between 0 and \(maxList).\nYou can't request more than \(maxList) names all at once.\n\nNon è possibile richiedere più di \(maxList) nomi in un colpo solo.\n" } //check we aren't requesting too many names
		var names: String = ""
	    for i in 0 ..< amount {
    		names += "\(nameBuilder.next())\n"
  		}
  		return names
	}	
















/*
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    
    
    
    */
    
    
    
    
}
