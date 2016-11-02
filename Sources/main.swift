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


// Create HTTP server.
let server = HTTPServer()

// Register your own routes and handlers
var routes = Routes()
routes.add(method: .get, uri:"/", handler: { request, response in
    let prae: Int = Int(arc4random_uniform(UInt32(praenomina.count)))
    let n: Int = Int(arc4random_uniform(UInt32(nomina.count)))
    let co: Int = Int(arc4random_uniform(UInt32(cognomina.count)))
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>CARTHAGO DELENDA EST!</title><body>Il tuo nome romano è: <br><br> <b>\(praenomina[prae]) \(nomina[n]) \(cognomina[co])</b></body></html>")
    response.completed()
    })

routes.add(method: .get, uri: "/brusky", handler: { request, response in
		response.setHeader(.contentType, value: "text/html")
		response.appendBody(string: "<html><title>PARACADUTE!</title><body>BRUSCHIIIIII!! <br><br> PARACADUTE! PARACADUTE!</body></html>")
		response.completed()
	})
routes.add(method: .get, uri:"/w", handler: { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>YOOOOOOO</title><body>Walter è un fregno della madonna</body></html>")
    response.completed()
    })


// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**
server.documentRoot = "./webroot"

// Gather command line options and further configure the server.
// Run the server with --help to see the list of supported arguments.
// Command line arguments will supplant any of the values set above.
configureServer(server)

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
