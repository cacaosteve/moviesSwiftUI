//
//  MoviesEndpoint.swift
//  CS_iOS_Assignment
//
//  Created by steve on 12/26/20.
//

import Foundation

enum MoviesEndpoint {
    case nowPlayingMovies
    case popularMovies(Int)
    case movieDetail(Int)
}

extension MoviesEndpoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .nowPlayingMovies:
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.themoviedb.org"
            urlComponents.path = "/3/movie/now_playing"

            urlComponents.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: "55957fcf3ba81b137f8fc01ac5a31fb5"),
            ]
            
            guard let url = urlComponents.url
                else {preconditionFailure("Invalid URL format")}
            let request = URLRequest(url: url)
            return request
            
        case .popularMovies(let page):
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.themoviedb.org"
            urlComponents.path = "/3/movie/popular"

            urlComponents.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: "55957fcf3ba81b137f8fc01ac5a31fb5"),
                URLQueryItem(name: "page", value: "\(page)"),
            ]
            
            guard let url = urlComponents.url
                else {preconditionFailure("Invalid URL format")}
            let request = URLRequest(url: url)
            return request
            
        case .movieDetail(let movieId):
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.themoviedb.org"
            urlComponents.path = "/3/movie/\(movieId)"

            urlComponents.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: "55957fcf3ba81b137f8fc01ac5a31fb5"),
            ]
            
            guard let url = urlComponents.url
                else {preconditionFailure("Invalid URL format")}
            let request = URLRequest(url: url)
            return request
        }
    }
}
