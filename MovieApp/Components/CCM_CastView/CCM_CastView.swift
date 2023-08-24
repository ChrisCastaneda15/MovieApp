//
//  CCM_CastView.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/12/21.
//  Copyright © 2021 Chris Castaneda. All rights reserved.
//

import UIKit

@IBDesignable class CCM_CastView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ViewAllButton: UIButton!
    
    @IBOutlet weak var unavailableLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    //IB PROPERTIES
    @IBInspectable var titleString: String = "Cast" {
        didSet {
            TitleLabel.text = titleString
        }
    }
    
//    private var _: ((Int)->Void)!
    
    private var castType: Media.Media_type! = .movie
    
    private var movieDetailVM: MovieDetailViewModel?
    private var tvDetailVM: TVDetailModel?
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup(){
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: CastCell.REUSE_ID)
    }
    
    fileprivate func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CCM_CastCollection", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setCast(for mediaType: Media.Media_type, _ vm: Any){
        if mediaType == .tv {
            self.tvDetailVM = vm as? TVDetailModel
            if tvDetailVM?.cast?.count ?? 0 > 0 {
                unavailableLabel.isHidden = true
            }
        } else {
            self.movieDetailVM = vm as? MovieDetailViewModel
            if movieDetailVM?.cast?.count ?? 0 > 0 {
                unavailableLabel.isHidden = true
            }
        }
        
        self.castType = mediaType
        castCollectionView.reloadData()
    }

}

extension CCM_CastView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if castType == .tv {
            if self.tvDetailVM == nil { return 0 }
            return self.tvDetailVM!.getTruncCast().count
        } else {
            if self.movieDetailVM == nil { return 0 }
            return self.movieDetailVM!.getTruncCast().count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.REUSE_ID, for: indexPath) as! CastCell
        
        if castType == .tv {
            cell.actorModel = self.tvDetailVM?.cast?[indexPath.row]
        } else {
            cell.actorModel = self.movieDetailVM?.cast?[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 203)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
