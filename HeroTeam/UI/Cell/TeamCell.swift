//
//  TeamCell.swift
//  TeamCell
//
//  Created by Михаил Задорожный on 22.02.2021.
//

import Foundation

import SnapKit

class TeamCell: UITableViewCell {
    
    var removeFromStorage: (() -> ())?
    
    private let deleteButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "deleteB"), for: .normal)
        bt.setImage(UIImage(named: "deleteC"), for: .highlighted)
        
        return bt
    }()
    
    private let leaderNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 5
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let teamNameLabel = UILabel()
    
    private let numberOfMembers = UILabel()
    
    private let separator = UIView()
    
    private let mainView = UIView()
    
    private let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(info: Team) {
        
        setupLeaderName(info: info)
        setupTeamName(info: info)
        setupNumberOfMember(info: info)
    }
    
    private func setupLeaderName(info: Team) {
        
        guard let leader = info.leader
        
        else {
            return
        }
        guard let leaderName = leader.name else {
            
            return
        }
        leaderNameLabel.text = "Leader is:  \(String(describing: leaderName))"
        leaderNameLabel.textColor = .black
    }
    
    private func setupTeamName(info: Team) {
        
        guard let teamName = info.title else {
            
            return
        }
        teamNameLabel.text = "Team:  \(teamName)"
    }
    
    private func setupNumberOfMember(info: Team) {
        
        let number = info.heroes.count
        numberOfMembers.text = "Number of members: \(number)"
        numberOfMembers.textColor = .black
    }
    
    private func setupUI() {
        
        deleteButton.addTarget(self, action: #selector(deleteFromStorage), for: .touchUpInside)
        
        selectionStyle = .gray
        
        backgroundColor = .white
        
        contentView.addSubview(mainView)
        contentView.addSubview(separator)
        stackView.axis = .vertical
        separator.backgroundColor = .gray
        
        mainView.addSubview(stackView)
        contentView.addSubview(deleteButton)
        
        stackView.addArrangedSubview(teamNameLabel)
        stackView.addArrangedSubview(leaderNameLabel)
        stackView.addArrangedSubview(numberOfMembers)
        
        stackView.distribution = .equalSpacing
        
        teamNameLabel.textColor = .black
        teamNameLabel.textAlignment = .left
        
        numberOfMembers.textAlignment = .left
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(deleteButton.snp.left)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(separator.snp.top)
            make.width.equalTo(50)
            make.left.equalTo(mainView.snp.right)
        }
        
        separator.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    @objc private func deleteFromStorage() {
        removeFromStorage?()
    }
}
