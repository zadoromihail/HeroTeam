//
//  CreateTeamHeroesViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import Foundation
import UIKit

class CreateTeamHeroesViewController: BaseViewController {
    
    var team: Team?
    
    private let nextStepViewController = CreateTeamLeadViewController()
    
    private let tableView = CustomTableView()
    
    private var selectedIndexes = [Int]()
    
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
        selectedIndexes = []
    }
    
    private func setupUI() {
        
        title = "Select heroes of the team"
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
    
    @objc private func nextStep() {
        
        guard let hero = Networking.heroes else { return }
        
        if selectedIndexes.count < 3 {
            
            showAlertMessage(message: "Please сhose 3 or more heroes") {
                return
            }
        }
        
        else {
            team?.cleanTeam()
            
            selectedIndexes.forEach { index in
                team?.addHero(hero: hero[index])
            }
            
            nextStepViewController.team = team
            
            navigationController?.pushViewController(nextStepViewController, animated: false)
        }
    }
}

extension CreateTeamHeroesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Networking.heroes?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HeroCell,
            let heroProfile = Networking.heroes?[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        if selectedIndexes.contains(indexPath.row) {
            
            cell.heroIsSelected = true
        }
        
        cell.configure(info: heroProfile)
        
        return cell
    }
}

extension CreateTeamHeroesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        if !selectedIndexes.contains(index){
            selectedIndexes.append(index)
        }
        else {
            selectedIndexes = selectedIndexes.filter { $0 != index }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
