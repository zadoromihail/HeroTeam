//
//  DetailTeamViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 23.02.2021.
//

import Foundation
import UIKit
import SnapKit

class DetailTeamViewController: UIViewController {
    
    var team: Team?
    
    private let detailHeroViewController = DetailHeroViewController()
    
    private let teamSettingsViewController = TeamSettingsViewController()
    
    private let teamNameLabel = CustomLabel()
    
    private let teamLeaderLabel = CustomLabel()
    
    private let tableView = CustomTableView()
    
    private let teamMembersLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Team members:"
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = .gray
        
        return separator
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    private func setupSettingsButton() {
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(named: "gearB"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonPressed)
        )
        
        settingsButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    private func setupUI() {
        
        title = "Detail team"
        
        view.addSubview(tableView)
        view.addSubview(teamMembersLabel)
        view.addSubview(teamNameLabel)
        view.addSubview(separatorView)
        view.addSubview(teamLeaderLabel)
        
        setupSettingsButton()
        updateUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        teamNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        teamLeaderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        teamMembersLabel.snp.makeConstraints { (make) in
            make.top.equalTo(teamLeaderLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(teamMembersLabel.snp.bottom).offset(8)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(240)
        }
    }
    
    private func updateUI() {
        
        guard
            let title = team?.title,
            let leader = team?.leader?.name else {
            
            return
        }
        
        teamNameLabel.text = "Team name: \(String(describing: title))"
        teamLeaderLabel.text = "Team leader: \(leader)"
        tableView.reloadData()
    }
    
    @objc private func settingsButtonPressed() {
        teamSettingsViewController.team = team
        navigationController?.pushViewController(teamSettingsViewController, animated: false)
    }
}

extension DetailTeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.heroes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HeroCell,
            let teamHeroes = team?.heroes
        else {
            
            return UITableViewCell()
        }
        guard let hero = teamHeroes[indexPath.row] else { return UITableViewCell()  }
        cell.configure(info: hero)
        
        return cell
    }
}

extension DetailTeamViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailHeroViewController.hero = team?.heroes[indexPath.row]
        navigationController?.pushViewController(detailHeroViewController, animated: false)
    }
}
