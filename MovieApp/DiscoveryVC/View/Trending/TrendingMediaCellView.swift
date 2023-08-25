//
//  TrendingMediaCellView.swift
//  MovieApp
//
//  Created by Chris Castaneda on 8/24/23.
//  Copyright © 2023 Chris Castaneda. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TrendingMediaCell: View {
    var subtitleText: String
    var titleText: String
    var backgroundImageUrl: URL?
    
    var body: some View {
        GeometryReader { geo in
            WebImage(url: backgroundImageUrl)
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                        .frame(height: geo.size.width / 1.77)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.3))
                .scaledToFit()
                .frame(height: geo.size.width / 1.77)
                .cornerRadius(25.0)
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(subtitleText)
                            .font(.system(size: 11))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 1.0, x: 2, y: 1)
                        Text(titleText.uppercased())
                            .font(.system(size: 27))
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 1.0, x: 2, y: 1)
                    }
                    .padding([.leading, .bottom], 30)
                }
        }
    }
    
}

struct TrendingMediaCell_SwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        let posterURL = URL(string: APIManager.IMAGES.getPosterImage(path: "/nHf61UzkfFno5X1ofIhugCPus2R.jpg", with: .large))
        TrendingMediaCell(subtitleText: "Jul 19 2023", titleText: "BARBIE", backgroundImageUrl: posterURL)
    }
}
