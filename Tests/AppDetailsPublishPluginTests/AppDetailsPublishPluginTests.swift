import XCTest
@testable import AppDetailsPublishPlugin

final class AppDetailsPublishPluginTests: XCTestCase {
	func testAppDetails() throws {
		let appDetails = try AppDetailsEmbedGenerator(id: "982783760", country: "gb").generate().get()
		XCTAssertEqual(appDetails.bundleId, "uk.co.greenlightapps.nearlydeparted")
		XCTAssertEqual(appDetails.appName, "Nearly Departed")
		XCTAssertEqual(appDetails.sellerName, "Matthew Flint")
		XCTAssertNotNil(appDetails.originalReleaseDate)
		XCTAssertNotNil(appDetails.currentVersionReleaseDate)
		XCTAssertTrue(appDetails.screenshotUrls.count > 0)
		XCTAssertTrue(appDetails.ipadScreenshotUrls.count > 0)
		XCTAssertEqual(appDetails.appletvScreenshotUrls.count, 0)
		let fileSizeBytes = try XCTUnwrap(appDetails.fileSizeBytes)
		XCTAssertTrue(fileSizeBytes > 5_000_000)
    }
}
