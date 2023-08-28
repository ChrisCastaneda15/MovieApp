//
//  MovieDiscoveryView.swift
//  MovieApp
//
//  Created by Chris Castaneda on 8/28/23.
//  Copyright © 2023 Chris Castaneda. All rights reserved.
//

import SwiftUI

struct MovieDiscoveryView: View {
    var movieViewModels: [MovieViewModel] = [MovieViewModel]()
    var body: some View {
        GeometryReader { geo in
            VStack {
                GenreControl(genres: MovieGenre.strings())
                    .frame(height: 25.0)
                let layout = [GridItem(.flexible())]
                ScrollViewReader { scrollView in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: layout, spacing: 20) {
                            ForEach(Array(movieViewModels.enumerated()), id: \.offset) { index, movie in
                                MovieCollectionCellView(
                                    titleText: movie.title,
                                    subtitleText: movie.genreString(),
                                    posterImageUrl: movie.getPosterImgUrl()
                                )
                                .frame(width: 125.0)
                            }
                        }
                        .frame(height: 275.0)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                    }
                }
            }
        }
    }
}

struct MovieDiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(id: 0, title: "Spida-Meng: Across da 'verse", backdrop_img: "/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg", poster_img: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg", overview: "yo", release_date: "2023", genre_ids: [28, 12, 16], vote_average: 5.0)
        let mvm = MovieViewModel(movie: movie)
        MovieDiscoveryView(movieViewModels: [mvm, mvm, mvm, mvm])
    }
}
