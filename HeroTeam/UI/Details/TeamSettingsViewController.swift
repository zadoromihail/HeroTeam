//
//  TeamSettingsViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 23.02.2021.
//

import Foundation
import UIKit

class TeamSettingsViewController: UIViewController {
    
    var team: Team?
    
    private let changeNameViewController = ChangeNameViewController()
    
    private let changeTeamLeaderViewController = ChangeTeamLeaderViewController()
    
    private let changeTeamName: CustomButton = {
        let bt = CustomButton()
        bt.setTitle("Change team name", for: .normal)
        bt.addTarget(self, action: #selector(goToChangeNameController), for: .touchUpInside)
        return bt
    }()
    
    private let changeTeamLeader: CustomButton = {
        let bt = CustomButton()
        bt.setTitle("Change team leader", for: .normal)
        bt.addTarget(self, action: #selector(goToChangeleaderController), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(changeTeamName)
        view.addSubview(changeTeamLeader)

        changeTeamName.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        changeTeamLeader.snp.makeConstraints { (make) in
            make.top.equalTo(changeTeamName.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
    }
    
    @objc private func goToChangeNameController() {
        changeNameViewController.team = team
        navigationController?.pushViewController(changeNameViewController, animated: false)
    }
    
    @objc private func goToChangeleaderController() {
        changeTeamLeaderViewController.team = team
        navigationController?.pushViewController(changeTeamLeaderViewController, animated: false)
    }
}
