//
//  CustomLabel.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 24.02.2021.
//

import UIKit

class CustomLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        layer.borderWidth = 1
        layer.borderColor = UIColor(.gray).cgColor
        textColor = .black
        layer.cornerRadius = 10
        textAlignment = .left
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
