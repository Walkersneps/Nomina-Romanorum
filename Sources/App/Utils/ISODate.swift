import Foundation

extension Date {

  static func ISOString (from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

    return dateFormatter.string(from: date).appending("Z")
  }


}
