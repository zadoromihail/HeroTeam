//
//  CustomTextField.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 24.02.2021.
//

import UIKit

class CustomTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(string: "Enter team name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(.gray)])
        textColor = .black
        layer.borderWidth = 1
        layer.borderColor = UIColor(.gray).cgColor
        textAlignment = .center
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
