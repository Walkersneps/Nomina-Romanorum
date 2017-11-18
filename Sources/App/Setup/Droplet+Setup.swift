@_exported import Vapor

extension Droplet {
    public func setup() throws {
        // MARK: - Properties
        let maxRequestableNames: Int = 100

        // MARK: - Setup
        print("\n Praeparando Nomina-Romanorum...")
        try setupInfoRoutes()
        try setupPlainNamesRoutes(maximum: maxRequestableNames)
        try setupJSONNamesRoutes(maximum: maxRequestableNames)
        try setupEasterEggsRoutes()
        print("Configuratione completa est!\n\n")
    }
}
