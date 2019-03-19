//
//  HotKeywordCell.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import Kingfisher

class HotKeywordCell: UICollectionViewCell {
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var keywordBgView: UIView!
    
    static let minWidth: CGFloat = 96.0
    static let minHeight: CGFloat = 200.0
    static let minTextHeight: CGFloat = 40.0
    static let minTextPadding: CGFloat = (8.0 * 2)
    static let font = UIFont.systemFont(ofSize: 14.0)
    static let ContentColor = ["#16702e", "#005a51", "#996c00",
                               "#5c0a6b", "#006d90", "#974e06",
                               "#99272e", "#89221f", "#00345d"]
    
    static func getSizeForText(_ text: String) -> CGSize {
        let size = Utilities.calculateSize(text: text, height: minTextHeight, font: font)
        return CGSize(width: max(size.width + minTextPadding, minWidth), height: minHeight)
    }
    
    static let identifier = "HotKeywordCell"
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        keywordLabel.font = HotKeywordCell.font
        keywordBgView.layer.cornerRadius = 6.0
        keywordBgView.clipsToBounds = true
    }
    
    func bind(viewModel: HotKeywordViewModel, color: UIColor) {
        keywordLabel.text = viewModel.text
        if let url = viewModel.iconURL {
            iconImgView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "no_image")) {
                (img, error, cacheType, url) in
                if let err = error {
                    logger.error("\(err.localizedDescription)")
                }
            }
        } else {
            iconImgView.image = #imageLiteral(resourceName: "no_image")
        }
        keywordBgView.backgroundColor = color
    }
}
