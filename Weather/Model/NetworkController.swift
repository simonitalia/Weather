//
//  NetworkController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

//MARK: - Network Controller for fetching remote resources
struct NetworkController {
	
	//Shared / global accessible property
	static let shared = NetworkController()
	
	private init() {} //prevent external initialization
	
	//fetch json feed from remote server
	func getWeatherFeed(completion: @escaping (Result<[Weather], WError>) -> Void) {
		guard let url = Endpoint.feed.url else {
			fatalError("FeedError! Url is missing!") //can handle more gracefully
		}

		let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

			//handle errors
			if let _ = error {
				completion(.failure(.unableToComplete))
				return
			}
			
			//bad http response
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				completion(.failure(.invalidResponse))
				return
			}
			
			//bad data returned, or alternate message like api rate limit exceeded
			guard let data = data else {
				completion(.failure(.invalidData))
				return
			}
			
			//if success, try to parse
			do {
				let decoder = JSONDecoder()
				let feed = try decoder.decode(Feed.self, from: data)
				let weather = feed.data
				completion(.success(weather)) //pass parsed data back to callee
				
			} catch {
				completion(.failure(.invalidData))
			}
		}

		downloadTask.resume()
	}
}


//MARK: - Endpoints
extension NetworkController {
	
	//Endpoints
	private enum Endpoint {

		enum URLComponent {
			static let scheme = "https"
			static let host = "dnu5embx6omws.cloudfront.net"
		}
		
		enum URLPath {
			static let json = "/venues/weather.json"
		}

		//resource
		case feed
		
		//get resource endpoint url
		var url: URL? {
			
			switch self {
			case .feed:
				return getURLComponents(for: URLPath.json).url
			}
		}
		
		//construct endpoint URLComponents
		func getURLComponents(for path: String) -> URLComponents {
			var components = URLComponents()
			components.scheme = URLComponent.scheme
			components.host = URLComponent.host
			components.path = path
			return components
		}
	}
}
