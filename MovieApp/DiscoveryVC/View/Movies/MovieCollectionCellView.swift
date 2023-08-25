//
//  MovieCollectionCellView.swift
//  MovieApp
//
//  Created by Chris Castaneda on 8/25/23.
//  Copyright © 2023 Chris Castaneda. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCollectionCellView: View {
    var titleText: String
    var subtitleText: String
    var posterImageUrl: URL?
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .leading) {
                WebImage(url: posterImageUrl)
                    .resizable()
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.3))
                    .scaledToFill()
                    .frame(height: geo.size.height * 0.73)
                    .cornerRadius(20.0)
                VStack (alignment: .leading) {
                    let textColor = Color("Text")
                    Text(titleText)
                        .font(.system(size: 17))
                        .bold()
                        .foregroundColor(textColor)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(subtitleText)
                        .font(.system(size: 12, weight: .thin))
                        .foregroundColor(textColor)
                }
            }
        }
    }
}

struct MovieCollectionCellView_Previews: PreviewProvider {
    static var previews: some View {
        let posterURL = URL(string: APIManager.IMAGES.getPosterImage(path: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg", with: .large))
        VStack (alignment: .center) {
            GeometryReader { geo in
                MovieCollectionCellView(titleText: "Spiderman: Across the Spider-Verse", subtitleText: "Animation, Action, Adventure", posterImageUrl: posterURL)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2, alignment: .center)
            }
        }
    }
}
