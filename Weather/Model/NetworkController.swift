//
//  NetworkController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

//MARK: - Network Controller
struct NetworkController {
	
	//MARK: - Class Properties
	
	static let shared = NetworkController()
	
	private init() {}
		//prevent external initialization
	

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
			
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				completion(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completion(.failure(.invalidData))
				return
			}
			
			//on success
			do {
				let decoder = JSONDecoder()
				let feed = try decoder.decode(Feed.self, from: data)
				let weather = feed.data
				completion(.success(weather)) //pass data back
				
			} catch {
				completion(.failure(.invalidData)) //parse error
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

		//resource (json feed, image etc)
		case feed
		
		var url: URL? {
			
			switch self {
			case .feed:
				return getURLComponents(for: URLPath.json).url
			}
		}
		
		func getURLComponents(for path: String) -> URLComponents {
			var components = URLComponents()
			components.scheme = URLComponent.scheme
			components.host = URLComponent.host
			components.path = path
			return components
		}
	}
}
