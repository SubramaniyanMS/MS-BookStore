//
//  ProductsCollectionViewCell.swift
//  Book Store
//
//  Created by Apple on 30/09/24.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var RatingLbl: UILabel!
    @IBOutlet weak var AddCart: UIButton!
    
    
    override func layoutSubviews() {
        // cell rounded section
        self.contentView.layer.cornerRadius = 7.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor(named: "Text")?.cgColor
        self.contentView.layer.masksToBounds = true
        
    }
}
    
//    func processImgName() {
//        if let name = nameText.text {
//            let decimalDigits = CharacterSet.decimalDigits
//            
//            if let lastNonDigitIndex = name.rangeOfCharacter(from: decimalDigits.inverted, options: .backwards)?.lowerBound {
//                let trimmedName = String(name[...lastNonDigitIndex])
//                nameText.text = trimmedName
//            }
//        }
//    }

