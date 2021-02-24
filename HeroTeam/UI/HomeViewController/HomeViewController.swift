//
//  HomeViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 19.02.2021.
//

import UIKit
import SnapKit
import Alamofire

class HomeViewController: UIViewController {
    
    private let createTeamButton = CustomButton()
    
    private let createTeamNameViewController = CreateTeamNameViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        title = "Home"
        
        Networking.getInfo()
        
        view.addSubview(createTeamButton)
        
        createTeamButton.addTarget(self, action: #selector(createTeam), for: .touchUpInside)
        createTeamButton.setTitle("Create team", for: .normal)
        createTeamButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
    }
    
    @objc private func createTeam() {
        
        navigationController?.pushViewController(createTeamNameViewController, animated: true)
    }
}
