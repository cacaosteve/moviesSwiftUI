//
//  MoviesService.swift
//  CS_iOS_Assignment
//
//  Created by steve on 12/26/20.
//
// Networking API by Alex Brown
// https://www.swiftcompiled.com/mvvm-swiftui-and-combine/

import Foundation
import Combine
import UIKit

protocol MoviesService {
    var apiSession: APIService {get}
    
    func getNowPlayingMovies() -> AnyPublisher<MoviesAPIResponse, APIError>
    func getPopularMovies(page: Int) -> AnyPublisher<MoviesAPIResponse, APIError>
    func getMovieDetail(movieId: Int) -> AnyPublisher<Movie, APIError>
}

extension MoviesService {
    func getNowPlayingMovies() -> AnyPublisher<MoviesAPIResponse, APIError> {
        return apiSession.request(with: MoviesEndpoint.nowPlayingMovies)
            .eraseToAnyPublisher()
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<MoviesAPIResponse, APIError> {
        return apiSession.request(with: MoviesEndpoint.popularMovies(page))
            .eraseToAnyPublisher()
    }
    
    func getMovieDetail(movieId: Int) -> AnyPublisher<Movie, APIError> {
        return apiSession.request(with: MoviesEndpoint.movieDetail(movieId))
            .eraseToAnyPublisher()
    }
}
