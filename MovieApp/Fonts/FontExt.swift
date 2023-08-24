//
//  FontExt.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/7/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit

extension UIFont {
    static func getNavBarFont(with size: CGFloat) -> UIFont{
        return UIFont(name: "CocogoosePro-Italic", size: size) ?? UIFont()
    }
    
    static func getHeaderFont(with size: CGFloat) -> UIFont{
        return UIFont(name: "CoolveticaRg-Regular", size: size) ?? UIFont()
    }
    
    static func showFonts(){
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
}


