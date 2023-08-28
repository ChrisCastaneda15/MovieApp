//
//  ViewController.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/16/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit
import SwiftUI

class DiscoveryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    weak var movieCollectionView: UICollectionView!
    
    var trendingMediaViewModels = [MediaViewModel]()
    var movieViewModels = [MovieViewModel]()
    
    @IBAction func menuPressed(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        fetchTrending()
        fetchMovies(with: nil)
    }

    fileprivate func fetchTrending(){
        MovieService.shared.fetchTrending { (movies, error) in
            if (error != nil) {
                return
            }

            self.trendingMediaViewModels = movies?.map({return MediaViewModel(item: $0)}) ?? []
            self.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
        }
    }
    
    fileprivate func fetchMovies(with Genre: Int?){
        MovieService.shared.fetchMovies(with: Genre) { (movies, error) in
            if (error != nil) {
                return
            }
            self.movieViewModels = movies?.map({return MovieViewModel(movie: $0)}) ?? []
            self.tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .fade)
        }
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension DiscoveryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Trending" }
        if section == 1 { return "Movies" }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = (view as! UITableViewHeaderFooterView)
        
        header.contentView.backgroundColor = UIColor(named: "Main")
        header.textLabel?.textColor = UIColor(named: "Text")
        
        header.textLabel?.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let width = self.view.frame.width
            let height = width / 1.77
            return height
        } else if indexPath.section == 1 {
            let width = self.view.frame.width
            let height = width * 0.8
            return height
        }
        return 50.0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.REUSE_ID, for: indexPath) as! TrendingCell
            cell.mediaViewModels = trendingMediaViewModels
            cell.navigationProtocol = self
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCellReuse", for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration(content: {
                MovieDiscoveryView(movieViewModels: movieViewModels)
                    .frame(width: self.view.frame.width)
            })
            return cell
        }
        return UITableViewCell()
    }
    
}


// MARK: - NAV PROTOCOL
extension DiscoveryViewController: NavigationProtocol {
    func goToMovieDetail(for movieVM: MovieViewModel) {
        let vc = MovieDetailVC.fromStoryboard
        vc.movieViewModel = movieVM
        self.present(vc, animated: true, completion: nil)
    }
    
    func goToTVDetail(for tvVM: TVViewModel){
        let vc = TVDetailVC.fromStoryboard
        vc.tvViewModel = tvVM
        self.present(vc, animated: true, completion: nil)
    }
}

