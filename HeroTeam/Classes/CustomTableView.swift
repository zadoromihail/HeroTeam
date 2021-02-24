//
//  CustomTableView.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 24.02.2021.
//

import UIKit

class CustomTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        separatorStyle = .none
        backgroundColor = .white
        register(HeroCell.self, forCellReuseIdentifier: "cell")
        rowHeight = UITableView.automaticDimension
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

