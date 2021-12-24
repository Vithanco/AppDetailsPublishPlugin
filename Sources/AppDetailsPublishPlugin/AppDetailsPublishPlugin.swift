import Publish
import Ink
import Foundation

public extension Plugin {
	static func appDetails(renderer: AppDetailsRenderer = DefaultAppDetailsRenderer()) -> Self {
		Plugin(name: "AppDetails") { context in
			context.markdownParser.addModifier(
				.appDetailsBlockQuote(using: renderer)
			)
		}
	}
}

public extension Modifier {
	static func appDetailsBlockQuote(using renderer: AppDetailsRenderer) -> Self {
		return Modifier(target: .blockquotes) { html, markdown in
			let prefix = "> appstore "

			guard markdown.hasPrefix(prefix) else {
				return html
			}

			let scanner = Scanner(string: String(markdown))
			_ = scanner.scanString(prefix)
			guard let appId = scanner.scanUpToCharacters(from: .whitespaces),
				  let country = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) else {
					  fatalError("Could not find AppID and country in string '\(markdown)'")
				  }

			let optionalSubtitle = scanner.scanUpToCharacters(from: .newlines)

			let generator = AppDetailsEmbedGenerator(id: appId, country: country)

			let appDetails = try! generator.generate().get()

			return try! renderer.render(appDetails: appDetails, subtitle: optionalSubtitle)
		}
	}
}
