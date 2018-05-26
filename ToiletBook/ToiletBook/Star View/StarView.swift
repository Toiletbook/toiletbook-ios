//
//  StarView.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: UIView {
    
    var identifier = "StarView"
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fiveStar: UIImageView!
    
    var stars: [UIImageView] = []
    
    func setRating(_ rating: Double, inTopThree: Bool) {
        
        let stringValue = NSDecimalNumber(value: rating).stringValue
        
        let hasDecimalPart = stringValue.hasSuffix(".5")
        let wholeNumberPart = Int(stringValue.split(separator: ".").first!)!
        
        let starsWithHighlight = stars[0 ... wholeNumberPart]
        let starsWithNoHighlight = stars[wholeNumberPart ..< 5]
        
        starsWithHighlight.forEach { (star) in
            star.image = #imageLiteral(resourceName: "star-full-rating")
        }
        
        starsWithNoHighlight.forEach { (star) in
            star.image = !inTopThree ? #imageLiteral(resourceName: "star-no-rating-hi") : #imageLiteral(resourceName: "star-no-rating-lo")
        }
        
        if hasDecimalPart {
            starsWithNoHighlight.first?.image = !inTopThree ? #imageLiteral(resourceName: "star-half-rating-hi") : #imageLiteral(resourceName: "star-half-rating-lo")
        }
        
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view = viewFromNibForClass()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
        additionalSetup()
    }
    
    private func additionalSetup() {
        stars = [firstStar, secondStar, thirdStar, fourthStar, fiveStar]
        // Although the banner's height was statically set in the .xib, we set it here
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.identifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
}

