//
//  CustomButton.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 23.02.2021.
//

import UIKit

class CustomButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(.gray).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
