//
//  NowPlayingView.swift
//  CS_iOS_Assignment
//
//  Created by steve on 1/3/21.
//

import KingfisherSwiftUI
import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel = MoviesViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.backgroundLead
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    HStack {
                        Spacer()
                        Image("logo")
                        Spacer()
                    }
                    .listRowBackground(Color.backgroundLead)
                    .ignoresSafeArea(.all, edges: .all)
                    
                    HStack {
                        Text("Playing now")
                            .foregroundColor(Color.brandPrimary)
                    }
                    .listRowBackground(Color.brandTungsten)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(viewModel.nowPlayingMovies) { movie in
                                MovieCellView(viewModel: viewModel, movie: movie)
                                    .onTapGesture {
                                        viewModel.selectedMovie = movie
                                    }
                            }
                        }
                    }
                    .background(Color.backgroundLead)
                    .listRowInsets(EdgeInsets())
                    .ignoresSafeArea(.all, edges: .all)
                    
                    HStack {
                        Text("Most popular")
                            .foregroundColor(Color.brandPrimary)
                    }
                    .listRowBackground(Color.brandTungsten)
                    
                    ForEach(viewModel.popularMovies) { movie in
                        MovieRowView(viewModel: viewModel, movie: movie)
                            .onAppear {
                                viewModel.loadMoreContentIfNeeded(currentItem: movie)
                            }
                            .onTapGesture {
                                viewModel.selectedMovie = movie
                            }
                            .listRowBackground(Color.backgroundLead)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            .fullScreenCover(isPresented: $viewModel.isShowingDetailView) {
                MovieDetailView(viewModel: viewModel, movieId: viewModel.selectedMovie?.id ?? -1)
            }
        }
    }
}

struct MovieCellView: View {
    @ObservedObject var viewModel: MoviesViewModel
    var movie: Movie
    
    var body: some View {
        ZStack {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? "") + "?api_key=55957fcf3ba81b137f8fc01ac5a31fb5"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 200)
        }
    }
}

struct MovieRowView: View {
    @ObservedObject var viewModel: MoviesViewModel
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .center) {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? "") + "?api_key=55957fcf3ba81b137f8fc01ac5a31fb5"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .border(Color.brandSteel, width: 3)
                .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 200)
            VStack(alignment: .leading) {
                Text(movie.title ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.brandSilver)
                    .padding()
                Text(movie.releaseDateString)
                    .foregroundColor(.brandSilver)
                    .padding()
            }
            Spacer()
            RatingView(score: Int((movie.voteAverage ?? 0) * 10)).padding()
        }
        .background(Color.backgroundLead)
    }
}
