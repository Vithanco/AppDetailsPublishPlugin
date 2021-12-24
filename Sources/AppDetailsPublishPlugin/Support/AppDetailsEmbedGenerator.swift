import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

private struct Response: Decodable {
	let resultCount: Int
	let results: [AppDetails]
}

private extension URLSessionConfiguration {
	class func AppDetailsSessionConfiguration() -> URLSessionConfiguration {
		let config = URLSessionConfiguration.default
		config.timeoutIntervalForRequest = 10
		return config
	}
}

final class AppDetailsEmbedGenerator {
	private enum Error: LocalizedError {
		case timeout(id: String)
		case unexpectedRepsonse
		case httpErrorStatus(code: Int)
		case noData
		case errorDecoding(id: String, error: Swift.Error)

		var localizedDescription: String {
			switch self {
			case .timeout(let id):
				return "The request to itunes timed out (app id: \(id))"
			case .unexpectedRepsonse:
				return "Unexpected response from itunes"
			case .httpErrorStatus(let code):
				return "Unexpected status code from itunes \(code)"
			case .noData:
				return "Received no data from itunes"
			case .errorDecoding(let id, let error):
				return "Error decoding data from itunes. App id \(id), error \(error)"
			}
		}
	}

	private let id: String
	private let country: String

	init(id: String, country: String) {
        self.id = id
		self.country = country
    }

	func generate() -> Result<AppDetails, Swift.Error> {
		var result: Result<AppDetails, Swift.Error> = .failure(Error.timeout(id: self.id))
        let sema = DispatchSemaphore(value: 0)

		let session = URLSession(configuration: URLSessionConfiguration.AppDetailsSessionConfiguration())
		let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&country=\(country)")!

        let task = session.dataTask(with: url) { data, res, error in
            defer { sema.signal() }

            guard let res = res as? HTTPURLResponse else {
				result = .failure(Error.unexpectedRepsonse)
                return
            }

            guard res.statusCode == 200 else {
				result = .failure(Error.httpErrorStatus(code: res.statusCode))
                return
            }

            guard let data = data else {
                if let error = error {
					result = .failure(error)
                } else {
					result = .failure(Error.noData)
                }
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)

				guard let appDetails = response.results.first else {
					result = .failure(Error.noData)
					return
				}

				result = .success(appDetails)
            } catch {
				result = .failure(Error.errorDecoding(id: self.id, error: error))
            }
        }

        task.resume()

        _ = sema.wait(timeout: .now() + 15)

        return result
    }
}
