//
//  CreateTeamFinalViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import UIKit
import SnapKit

class CreateTeamFinalViewController: BaseViewController {
    
    var team: Team?
    
    private let teamNameLabel = CustomLabel()
    
    private let tableView = CustomTableView()
    
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
        updateUI()
    }
    
    private func updateUI() {
        
        guard let name = team?.title else { return }
        
        teamNameLabel.text = "Team name: \(name)"
        
        tableView.reloadData()
    }
    
    private func setupUI() {
        
        title = "Confirm team creation"
        
        updateUI()
        
        teamNameLabel.textAlignment = .center
        teamNameLabel.textColor = .black
        
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        nextStepButton.setTitle("Confirm", for: .normal)
        
        view.addSubview(nextStepButton)
        view.addSubview(tableView)
        view.addSubview(separatorView)
        view.addSubview(teamNameLabel)
        
        teamNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
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
            make.top.equalTo(teamNameLabel.snp.bottom).offset(8)
        }
    }
    
    @objc private func nextStep() {
        
        showAlertMessage(message: "Team is created") { [weak self] in
            let storage = Storage()
            
            guard let team = self?.team else { return }
            try? storage.save(objetct: team)
            self?.navigationController?.popToRootViewController(animated: false)
        }
    }
}

extension CreateTeamFinalViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.heroes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HeroCell,
            let hero = team?.heroes[indexPath.row]
        else {
            
            return UITableViewCell()
        }
     
        cell.configure(info: hero)
        
        return cell
    }
}

extension CreateTeamFinalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
