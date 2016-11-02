//
//  main.swift
//  Nomina-Romanorum
//
//  Created by Walter Carli on 28/10/16.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation

// MARK: -- CONFIGURATION
let serverPort: UInt16 = 8181
/* CONFIGURATION ENDS HERE */


// MARK: -- NAMES
let praenomina: [String] = ["Marcus",
                        "Gaius",
                        "Titus",
                        "Publius",
                        "Lucius",
                        "Cneus"]

let nomina: [String] = ["Iulius",
                        "Cornelius",
                        "Claudius",
                        "Cassius",
                        "Sempronius",
                        "Domitius"]

let cognomina: [String] = ["Coriolanus",
                        "Brutus",
                        "Caligula",
                        "Cato",
                        "Caesar"]


// MARK: -- Functions
func buildName (from praenomina: [String], and nomina: [String], and cognomina: [String]) -> String {
  let prae: Int = Int(arc4random_uniform(UInt32(praenomina.count)))
  let n: Int = Int(arc4random_uniform(UInt32(nomina.count)))
  let co: Int = Int(arc4random_uniform(UInt32(cognomina.count)))

  return (praenomina[prae] + " " + nomina[n] + " " + cognomina[co])
}

// MARK: -- Properties
let defaultHead: String = "<head><meta charset='utf-8'></head>"


// MARK: -- Program
// Create HTTP server.
let server = HTTPServer()

// Register routes and handlers
var routes = Routes()

// Default router
routes.add(method: .get, uri:"/", handler: { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html>\(defaultHead)<title>CARTHAGO DELENDA EST!</title><body>Il tuo nome romano è: <br><br> <b>\(buildName(from: praenomina, and: nomina, and: cognomina))</b></body></html>")
    response.completed()
    })

// Brusky's easter egg
routes.add(method: .get, uri: "/brusky", handler: { request, response in
		response.setHeader(.contentType, value: "text/html")
		response.appendBody(string: "<html>\(defaultHead)<title>PARACADUTE!</title><body>BRUSCHIIIIII!! <br><br> PARACADUTE! PARACADUTE!</body></html>")
		response.completed()
	})

// My easter egg
routes.add(method: .get, uri:"/w", handler: { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html>\(defaultHead)<title>YOOOOOOO</title><body>Walter è un fregno della madonna</body></html>")
    response.completed()
    })


// Add the routes to the server.
server.addRoutes(routes)

// Set listen port
server.serverPort = serverPort

// Gather command line options and further configure the server.
configureServer(server)

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
