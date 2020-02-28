import Foundation
import Vapor

struct JSON: Content {}

struct NamesJSON: JSON {
	var uid: String
	var nomina: [String:String]
}

struct ErrJSON: JSON {
	var status: String
	var errCode: String
	var description: String
	var maxNumericParam: String
}

let outOfBoundsRequestJSON = ErrJSON(status: "error",
																			errCode: "1",
																			description: "parameter 'amount' is either too big or smaller than 1",
																			maxNumericParam: String(maxList));
let noParameterSuppliedJSON = ErrJSON(status: "error",
																			errCode: "2",
																			description: "must supply numeric parameter",
																			maxNumericParam: String(maxList))
