import Vapor
import Foundation

// MARK: -- Properties
let maxList: Int = 100 //Maximum amount of names which can be reqested in one shot
//let defaultHead: String = "<head><meta charset='utf-8'></head>"

// MARK: -- Configuration
let nameBuilder = NameBuilder() // create NameBuilder object


// MARK: -- Routes
public func routes(_ router: Router) throws {

	//default route -> standard name generation
	router.get { req in return "\(nameBuilder.next())\n" }

	//get many names all at once
	router.get("list", Int.parameter) { req -> String in
		let amount = try req.parameters.next(Int.self)
		guard amount <= maxList else { return "ERROR: Parameter 'amount' must be a natural number between 0 and \(maxList).\nYou can't request more than \(maxList) names all at once.\n\nNon è possibile richiedere più di \(maxList) nomi in un colpo solo.\n" } //check we aren't requesting too many names
		var names: String = ""
	    for _ in 0 ..< amount {
    		names += "\(nameBuilder.next())\n"
  		}
  		return names
	}

	//Alexa-newsfeed skill formatted JSON response
	router.get("alexa") { req -> NewsJSON in
		let txt = "\(nameBuilder.next()). \(nameBuilder.next()). \(nameBuilder.next()). \(nameBuilder.next()). \(nameBuilder.next())."
		return AlexaJSON.build(with: txt, title:"Romana Nomina:", url:"http://www.roma.sneps.xyz")
	}

	//JSON formatted list of names
	router.get("api", "list", Int.parameter) { req -> JSON in
		let n = try req.parameters.next(Int.self)
		guard n <= maxList && n > 0 else { return outOfBoundsRequestJSON }
		var nameDict: [String:String] = [:]
		for i in 0 ..< n { nameDict["nomen\(i)"] = nameBuilder.next() }
		return JSON(uid: UUID().uuidString, nomina: nameDict)
	}

	router.get("api", "list") { _ -> JSON in return noParameterSuppliedJSON }








	//Brusky's easter egg
	router.get("brusky") { req in return "BRUSCHIIIIII!! \n PARACADUTE! PARACADUTE!\n" }

	//my easter egg
	router.get("w") { req in return "Walter è un fregno della madonna\n" }






}
