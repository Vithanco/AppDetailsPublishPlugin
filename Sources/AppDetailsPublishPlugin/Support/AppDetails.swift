import Foundation
import Publish
import Ink

public struct AppDetails: Decodable, Hashable {
	private static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		return formatter
	}()

	private enum CodingKeys: String, CodingKey {
		case bundleId
		case appName = "trackName"
		case descriptionString = "description"
		case sellerName
		case contentAdvisoryRating
		case genres
		case minimumOsVersion
		case originalReleaseDateString = "releaseDate"
		case releaseNotes
		case appStoreURLString = "trackViewUrl"

		case artworkUrl60 = "artworkUrl60"
		case artworkUrl100 = "artworkUrl100"
		case artworkUrl512 = "artworkUrl512"

		case screenshotUrlStrings = "screenshotUrls"
		case ipadScreenshotUrlStrings = "ipadScreenshotUrls"
		case appletvScreenshotUrlStrings = "appletvScreenshotUrls"

		case currencyCode = "currency"
		case price
		case formattedPrice

		case averageUserRating
		case userRatingCount

		case version
		case currentVersionReleaseDateString = "currentVersionReleaseDate"
		case fileSizeBytesString = "fileSizeBytes"
		case averageUserRatingForCurrentVersion
		case userRatingCountForCurrentVersion
	}

	// MARK: - app details

	public let bundleId: String
	public let appName: String
	public let descriptionString: String
	public let sellerName: String
	public let contentAdvisoryRating: String
	public let genres: [String]
	public let minimumOsVersion: String
	private let originalReleaseDateString: String
	public var originalReleaseDate: Date? {
		get {
			Self.dateFormatter.date(from: originalReleaseDateString)
		}
	}
	public let releaseNotes: String
	public let appStoreURLString: String
	public var appStoreURL: URL? {
		get {
			URL(string: appStoreURLString)
		}
	}

	// MARK: - artwork

	public let artworkUrl60: String
	public let artworkUrl100: String
	public let artworkUrl512: String

	// MARK: - screenshots

	private let screenshotUrlStrings: [String]
	public var screenshotUrls: [URL] {
		get {
			self.screenshotUrlStrings.compactMap { URL(string: $0) }
		}
	}

	private let ipadScreenshotUrlStrings: [String]
	public var ipadScreenshotUrls: [URL] {
		get {
			self.ipadScreenshotUrlStrings.compactMap { URL(string: $0) }
		}
	}

	private let appletvScreenshotUrlStrings: [String]
	public var appletvScreenshotUrls: [URL] {
		get {
			self.appletvScreenshotUrlStrings.compactMap { URL(string: $0) }
		}
	}


	// MARK: - pricing

	public let currencyCode: String
	public let price: Decimal
	public let formattedPrice: String

	// MARK: - rating

	public let averageUserRating: Double
	public let userRatingCount: Int

	// MARK: - metadata for the current version

	public let version: String
	private let currentVersionReleaseDateString: String
	public var currentVersionReleaseDate: Date? {
		get {
			Self.dateFormatter.date(from: currentVersionReleaseDateString)
		}
	}
	private let fileSizeBytesString: String
	public var fileSizeBytes: Int64? {
		get {
			Int64(self.fileSizeBytesString)
		}
	}
	public let averageUserRatingForCurrentVersion: Double
	public let userRatingCountForCurrentVersion: Int
}
