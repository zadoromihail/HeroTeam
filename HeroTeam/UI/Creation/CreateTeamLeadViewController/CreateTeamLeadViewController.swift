//
//  CreateTeamLeadViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import UIKit
import SnapKit

class CreateTeamLeadViewController: BaseViewController {
    
    var team: Team?
    
    private let nextViewController = CreateTeamFinalViewController()
    
    private let tableView = CustomTableView()
    
    private var selectedIndex = Int()
    
    private let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        
        return separator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func setupUI() {
        
        title = "Select leader"
        
        tableView.dataSource = self
        tableView.delegate = self
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        view.addSubview(nextStepButton)
        view.addSubview(tableView)
        view.addSubview(separatorView)
        
        nextStepButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.bottom.equalTo(nextStepButton.snp.top)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(8)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(separatorView.snp.top)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
        }
    }
    
    private func setLeader() {
        
        team?.heroes.enumerated().forEach { hero in
            team?.heroes[hero.offset]?.isLeader = false
        }
        
        let leader = team?.heroes[selectedIndex]
        
        team?.heroes[selectedIndex]?.isLeader = true
        team?.leader = leader
    }
    
    @objc private func nextStep() {
        
        setLeader()
        nextViewController.team = team
        navigationController?.pushViewController(nextViewController, animated: false)
    }
}

extension CreateTeamLeadViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return team?.heroes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HeroCell,
            let teamHeroes = team?.heroes,
            let hero = teamHeroes[indexPath.row]
        else {
            return UITableViewCell()
        }
        if selectedIndex == indexPath.row {
            cell.heroIsSelected = true
        }
        cell.configure(info: hero)
        
        return cell
    }
}

extension CreateTeamLeadViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        setLeader()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
