//
//  MovieDetail.swift
//  CS_iOS_Assignment
//
//  Created by steve on 1/4/21.
//

//"poster_sizes": [
//  "w92",
//  "w154",
//  "w185",
//  "w342",
//  "w500",
//  "w780",
//  "original"
//],

import SwiftUI
import KingfisherSwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel : MoviesViewModel
    let movieId: Int
    //@Binding var isShowingDetailView: Bool
    
    var body: some View {
        VStack {
            XDismissButton(isShowingDetailView: $viewModel.isShowingDetailView)
            
            Spacer()
            
            KFImage(URL(string: "https://image.tmdb.org/t/p/w780" + (viewModel.selectedMovieDetail?.posterPath ?? "") + "?api_key=55957fcf3ba81b137f8fc01ac5a31fb5"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .border(Color.brandSteel, width: 4)
                .frame(minWidth: 0, maxWidth: 175, minHeight: 0, maxHeight: 350)
            
            Text(viewModel.selectedMovieDetail?.title ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.brandSilver)
            Text( (viewModel.selectedMovieDetail?.releaseDateString ?? "") + " - " + (viewModel.selectedMovieDetail?.runtimeString ?? "") )
                .foregroundColor(.brandSilver)
            
            Spacer()
            
            Text("Overview")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.brandSilver)
            Text(viewModel.selectedMovieDetail?.overview ?? "")
                .font(.body)
                .foregroundColor(.brandSilver)
                .padding()
            HStack {
                ForEach((viewModel.selectedMovieDetail?.genres ?? [Genre(id: 0, name: "")])) { genre in
                    GenreView(genre: genre.name?.uppercased() ?? "")
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundLead)
        .ignoresSafeArea()
        .onAppear() {
            viewModel.getMovieDetail()
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView(viewModel: viewModel, movieId: 614911)
//    }
//}
