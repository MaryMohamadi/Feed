//
//  TileTableViewCell.swift
//  Feed
//
//  Created by Maryam Alimohammadi on 2/16/20.
//  Copyright © 2020 Maryam Alimohammadi. All rights reserved.
//

import UIKit

class TileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var skeletonView : SkeletonView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var sublineLabel: UILabel!
    @IBOutlet weak var sublineViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var maskingViews: [UIView]!
    
    @IBOutlet weak var tileImageView: UIImageView!
    static private let sublineViewHeight = 30
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.skeletonView.setMaskingViews(maskingViews)
        
    }
    
    public func cellConfiguration(model: TileModel){
        self.skeletonView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.skeletonView.stopAnimating()
            self.skeletonView.layer.mask = nil
            for mv in self.maskingViews{
                mv.removeFromSuperview()
            }
        }
        
        self.headlineLabel.text = model.headline
        if let subline = model.subline {
            self.sublineLabel.text = subline
            self.sublineViewHeightConstraint.constant = 30
        }else{
            self.sublineViewHeightConstraint.constant = 0
            
        }
   
        
    }
    
}

extension TileTableViewCell: NibLoadableView{}
