@_exported import Vapor

extension Droplet {
    public func setup() throws {
        print("\n Praeparando Nomina-Romanorum...")

        try setupRoutes()

        print("Configuratione completa est!\n\n")
    }
}
