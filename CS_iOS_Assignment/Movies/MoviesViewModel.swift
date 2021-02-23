//
//  MoviesViewModel.swift
//  CS_iOS_Assignment
//
//  Created by steve on 12/26/20.
//
import Foundation
import Combine
import SwiftUI

class MoviesViewModel: ObservableObject, MoviesService {
    var apiSession: APIService
    @Published var nowPlayingMovies = [Movie]()
    @Published var popularMovies = [Movie]() {
        willSet {
            self.objectWillChange.send()
        }
    }
    @Published var movieDetail = [Int:Movie]()
    @Published var isShowingDetailView = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    var selectedMovie: Movie? {
        didSet { isShowingDetailView = true }
    }
    
    var selectedMovieDetail: Movie? {
        get { movieDetail[selectedMovie?.id ?? -1] }
    }
    
    var cancellables = Set<AnyCancellable>()
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        getNowPlayingMovies()
        getPopularMovies()
    }
    
    func getNowPlayingMovies() {
        let cancellable = self.getNowPlayingMovies()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
                
            }) { (nowPlaying) in
                self.nowPlayingMovies = nowPlaying.results ?? [Movie]()
        }
        cancellables.insert(cancellable)
    }
    
    func loadMoreContentIfNeeded(currentItem movie: Movie?) {
        guard let movie = movie else {
            getPopularMovies()
            return
        }
        
        let thresholdIndex = popularMovies.index(popularMovies.endIndex, offsetBy: -5)
        if popularMovies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
            getPopularMovies()
        }
    }
    
    func getPopularMovies() {
        let cancellable = self.getPopularMovies(page: currentPage)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
                
            }) { (popular) in
                self.popularMovies += popular.results ?? [Movie]()
                self.currentPage += 1
        }
        cancellables.insert(cancellable)
    }
    
    func getMovieDetail() {
        let cancellable = self.getMovieDetail(movieId: selectedMovie?.id ?? -1)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
                
            }) { (detail) in
                self.movieDetail[self.selectedMovie?.id ?? -1] = detail
        }
        cancellables.insert(cancellable)
    }
}

