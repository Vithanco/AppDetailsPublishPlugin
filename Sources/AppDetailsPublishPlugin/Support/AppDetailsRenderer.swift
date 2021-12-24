import Foundation
import Plot

public protocol AppDetailsRenderer {
	func render(appDetails: AppDetails, subtitle: String?) throws -> String
}

public final class DefaultAppDetailsRenderer: AppDetailsRenderer {
	public init() { }
	public func render(appDetails: AppDetails,
					   subtitle: String?) throws -> String {
		Div(content: {
			if let appStoreURL = appDetails.appStoreURL {
				Paragraph {
					Image(url: appDetails.artworkUrl100, description: "")

					Link(url: appStoreURL) {
						Text(appDetails.appName)
							.addLineBreak()
					}

					subtitle.map {
						Text($0)
					}

					List {
						Span(String(format: "%1.1f out of 5", appDetails.averageUserRating))
							.class("stars")
							.style("--rating: \(appDetails.averageUserRating);")
							.attribute(named: "aria-label", value: String(format: "%1.1f out of 5", appDetails.averageUserRating))

						Text(String("\(appDetails.userRatingCount) ratings"))
					}
					.class("apprating")
				}
			}
		})
			.class("appdetails")
			.render()
	}
}
