//
//  TrendingMediaCell_SwiftUI.swift
//  MovieApp
//
//  Created by Chris Castaneda on 8/24/23.
//  Copyright © 2023 Chris Castaneda. All rights reserved.
//

import SwiftUI

struct TrendingMediaCell_SwiftUI: View {
    var body: some View {
        let poster =
        URL(string: APIManager.IMAGES.getPosterImage(path: "/nHf61UzkfFno5X1ofIhugCPus2R.jpg", with: 3))
        ZStack {
            AsyncImage(url: poster) {_ in
                Text("Loading...")
            }
            //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TrendingMediaCell_SwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        TrendingMediaCell_SwiftUI()
    }
}
