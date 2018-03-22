//
//  FavouriteButton.swift
//  Ostmodern Sample App
//
//  Created by Felix Fischer on 22.03.18.
//  Copyright © 2018 Felix Fischer. All rights reserved.
//

import UIKit

class FavouriteButton: UIButton {

    override var isSelected: Bool {
        willSet {
            tintColor = isSelected ? .favouriteRed : .favouriteGray
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        tintColor = isSelected ? .favouriteRed : .favouriteGray
    }

}
