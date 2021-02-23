//
//  GenreView.swift
//  CS_iOS_Assignment
//
//  Created by steve on 1/6/21.
//

import SwiftUI

struct GenreView: View {
    let genre: String
    
    var body: some View {
        Text(genre)
            .padding(7)
            .background(Color.primary)
            .foregroundColor(.backgroundLead)
            .cornerRadius(6)
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView(genre: "Science Fiction")
    }
}
