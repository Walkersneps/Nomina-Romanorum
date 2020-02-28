import Vapor
import Foundation

struct NewsJSON: Content {
	var uid: String
	var updateDate: String
	var titleText: String
	var mainText: String
	var redirectionUrl: String

}
