//
//  HeroCell.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import SnapKit
import Kingfisher

class HeroCell: UITableViewCell {
    
    var heroIsSelected = false
    
    private let leaderTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 5
        lbl.textColor = .black
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let heroNameLabel = UILabel()
    private let coverImage = UIImageView()
    private let separator = UIView()
    
    override func prepareForReuse() {
        heroIsSelected = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(info: Hero) {
        
        setupHeroNameLabel(info: info)
        setupAvatarImage(info: info)
        setupLeaderCell(info: info)
    }
    
    private func setupAvatarImage(info: Hero) {
        
        guard let image = info.img else {
            
            return
        }
        coverImage.kf.setImage(with: URL(string: image))
    }
    
    private func setupHeroNameLabel(info: Hero) {
        
        guard let name = info.name else {
            
            return
        }
        heroNameLabel.text = name
        
        if heroIsSelected {
            backgroundColor = .green
        }
        
        else {
            backgroundColor = .white
        }
    }
    
    private func setupLeaderCell(info: Hero) {
        
        guard let _ = info.isLeader, info.isLeader == true else {
            
            leaderTextLabel.text = nil
            
            return
        }
        leaderTextLabel.text = "Leader"
    }
    
    private func setupUI() {
        
        backgroundColor = .white
        selectionStyle = .default
        
        addSubview(heroNameLabel)
        heroNameLabel.textColor = .black
        heroNameLabel.textAlignment = .center
        heroNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(coverImage)
        coverImage.contentMode = .scaleAspectFit
        coverImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(heroNameLabel.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(contentView.snp.height)
            make.width.equalTo(heroNameLabel.snp.height)
        }
        
        addSubview(leaderTextLabel)
        leaderTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(heroNameLabel.snp.bottom)
            make.width.equalTo(60)
            make.centerX.equalTo(heroNameLabel.snp.centerX)
        }
        
        addSubview(separator)
        separator.backgroundColor = .gray
        separator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
