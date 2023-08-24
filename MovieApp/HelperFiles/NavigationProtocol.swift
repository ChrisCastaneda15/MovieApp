//
//  NavigationProtocol.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/9/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit

protocol NavigationProtocol {
    func goToMovieDetail(for movieVM: MovieViewModel)
    func goToTVDetail(for tvVM: TVViewModel)
}
