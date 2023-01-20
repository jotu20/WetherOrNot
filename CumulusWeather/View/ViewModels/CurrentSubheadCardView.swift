//
//  CurrentSubheadCardView.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 9/21/22.
//

import UIKit

class AppIconImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 8.0
        clipsToBounds = true
    }
}
