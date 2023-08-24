//
//  SideMenuCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/23/21.
//  Copyright © 2021 Chris Castaneda. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    public static let REUSE_ID = "MenuReuse"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        shrink()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        grow()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        grow()
    }
    
    private func grow(){
        SideMenuCell.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        }) { ( _ ) in
            UIButton.animate(withDuration: 0.07) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func shrink(){
        SideMenuCell.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

}
