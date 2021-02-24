//
//  ChangeTeamLeaderViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 23.02.2021.
//

import UIKit
import SnapKit
import RealmSwift

class ChangeTeamLeaderViewController: UIViewController {
    
    var team: Team?
    
    private let tableView = CustomTableView()
    
    private let textLabel: UILabel = {
        let lbl = UILabel()
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
    
        tableView.reloadData()
    }
    
    private func setupUI() {
        
        title = "Change leader"
        
        view.addSubview(textLabel)
        view.addSubview(tableView)
        view.addSubview(separatorView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        textLabel.text = "Chose new leader"
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(240)
        }
    }
}

extension ChangeTeamLeaderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.heroes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HeroCell,
              let hero = team?.heroes[indexPath.row]
            
        else {
            
            return UITableViewCell()
        }
        
        cell.configure(info: hero)
        
        return cell
    }
    
    private func changeLeader(leader: Hero) {
        
        let realm = Realm.instance
        
        let currentObject = realm.objects(_Team.self).filter { [self] in $0.uuid == team?.uuid}
        
        try? realm.write {
            currentObject.first?.leader?.appearance = leader.appearance
            currentObject.first?.leader?.betterCallSaulAppearance = leader.betterCallSaulAppearance
            currentObject.first?.leader?.birthday = leader.birthday
            currentObject.first?.leader?.category = leader.category
            currentObject.first?.leader?.charId = leader.charId
            currentObject.first?.leader?.img = leader.img
            currentObject.first?.leader?.isLeader = leader.isLeader
            currentObject.first?.leader?.name = leader.name
            currentObject.first?.leader?.nickname = leader.nickname
            currentObject.first?.leader?.occupation = leader.occupation
            currentObject.first?.leader?.portrayed = leader.portrayed
            currentObject.first?.leader?.status = leader.status
        }
        
        navigationController?.popToRootViewController(animated: false)
    }
}

extension ChangeTeamLeaderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let newLeader = team?.heroes[indexPath.row] else { return }
        changeLeader(leader: newLeader )
    }
}
