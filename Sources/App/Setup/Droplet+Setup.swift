@_exported import Vapor

extension Droplet {
    public func setup() throws {
        // MARK: - Properties
        let MAX_REQUESTABLE_NAMES: Int = 100

        // MARK: - Setup
        print("\n Praeparando Nomina-Romanorum...")
        try setupInfoRoutes()
        try setupPlainNamesRoutes(maximum: MAX_REQUESTABLE_NAMES)
        try setupJSONNamesRoutes(maximum: MAX_REQUESTABLE_NAMES)
        try setupEasterEggsRoutes()
        print("Configuratione completa est!\n\n")
    }
}
