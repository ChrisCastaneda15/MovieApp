//
//  SideMenuVC.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/18/21.
//  Copyright © 2021 Chris Castaneda. All rights reserved.
//

import UIKit
import SideMenuSwift

class SideMenuVC: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userWelcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView(){
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }
    
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource{
    //Cell Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.REUSE_ID, for: indexPath) as! SideMenuCell
        cell.cellTitleLabel.text = "Home"
        cell.iconImageView.image = UIImage(named: "menu_home_icon")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            sideMenuController?.hideMenu()
        }
    }
}
