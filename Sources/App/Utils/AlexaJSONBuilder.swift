import Foundation

struct AlexaJSON {

  static func build(with mainText: String, title: String, url: String) -> NewsJSON {
    return NewsJSON(uid: UUID().uuidString,
                    updateDate: Date.ISOString(from: Date()),
                    titleText: title,
                    mainText: mainText,
                    redirectionUrl: url)
  }


}
