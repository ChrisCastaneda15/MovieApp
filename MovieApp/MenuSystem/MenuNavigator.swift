//
//  MenuNavigator.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/18/21.
//  Copyright © 2021 Chris Castaneda. All rights reserved.
//

import UIKit
import SideMenuSwift

class MenuNavigator: SideMenuController {
    static var fromStoryboard: SideMenuController {
        return UIStoryboard(name: "MenuNav", bundle: nil).instantiateViewController(withIdentifier: "NavigatorVC") as! SideMenuController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

}
