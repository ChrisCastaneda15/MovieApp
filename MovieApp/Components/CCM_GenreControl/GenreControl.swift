//
//  GenreControl.swift
//  MovieApp
//
//  Created by Chris Castaneda on 8/28/23.
//  Copyright © 2023 Chris Castaneda. All rights reserved.
//

import SwiftUI

struct GenreControl: View {
    var genres: [String]
    var onSelect: ((String) -> Void)?
    
    @State var selectedGenre = 0
    
    var body: some View {
        let layout = [GridItem(.flexible())]
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: layout, spacing: 20) {
                    ForEach(Array(genres.enumerated()), id: \.offset) { index, genre in
                        Button(genre) {
                            withAnimation {
                                let anchor = UnitPoint.init(x: 0.05, y: 0)
                                scrollView.scrollTo(genre, anchor: anchor)
                            }
                            selectedGenre = index
                            onSelect?(genre)
                        }
                        .id(genre)
                        .foregroundColor(getButtonColor(for: index))
                        .font(.system(size: 17, weight: getButtonFontWeight(for: index)))
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
            }
        }
    }
    
    private func getButtonColor(for button: Int) -> Color {
        return selectedGenre == button ? Color("Text") : .gray
    }
    
    private func getButtonFontWeight(for button: Int) -> Font.Weight {
        return selectedGenre == button ? .bold : .light
    }
    
}

struct GenreControl_Previews: PreviewProvider {
    static var previews: some View {
        GenreControl(genres: MovieGenre.strings())
    }
}
