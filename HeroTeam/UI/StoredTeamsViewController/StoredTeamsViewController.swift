//
//  StoredTeamsViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 19.02.2021.
//

import UIKit
import SnapKit
import RealmSwift

class StoredTeamsViewController: BaseViewController {
    
    var teams = [Team]()
    
    private let detailTeamViewController = DetailTeamViewController()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(TeamCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private var getTeamsFromStorage: [Team] {
        let storage = Storage()
        let teams: [Team] = storage.cachedPlainObject()
        return teams
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        teams = getTeamsFromStorage
        
        tableView.reloadData()
    }
    
    private func setupUI() {
        
        title = "Stored teams"
        
        tableView.dataSource = self
        tableView.delegate = self
    
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
        }
        
        setupDeleteButton()
    }
    
    private func setupDeleteButton() {
        
        let deleteTeamsButton = UIBarButtonItem(
            title: "Delete all",
            style: .plain,
            target: self,
            action: #selector(deleteAllData)
        )
        
        deleteTeamsButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = deleteTeamsButton
    }
    
    @objc private func deleteAllData() {
        
        if getTeamsFromStorage.isEmpty {
            
            showAlertMessage(message: "No data to delete", completion: nil)
        }
        
        else {
            showConfirmMessage(message: "Delete all data?") { [weak self] in
                
                let storage = Storage()
                try? storage.deleteAll()
                self?.teams = []
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension StoredTeamsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let team = self.teams[indexPath.row]
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TeamCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(info: team)
        
        cell.removeFromStorage = { [weak self] in
            
            self?.showConfirmMessage(message: "Delete this team?") {
                
                let storage = Storage()
                
                try? storage.delete(object: team)
                self?.teams.remove(at: indexPath.row)
                self?.tableView.reloadData()
            }
        }
        
        return cell
    }
}

extension StoredTeamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailTeamViewController.team = teams[indexPath.row]
        navigationController?.pushViewController(detailTeamViewController, animated: false)
    }
}

