//
//  DetailHeroViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 24.02.2021.
//

import UIKit
import SnapKit
import Kingfisher

class DetailHeroViewController: UIViewController {
    
    var hero: Hero?
    
    private let stackView = UIStackView()
    
    private let heroNameLabel = CustomLabel()
    
    private let heroQuoteLabel = CustomLabel()
    
    private let heroFavouriteThings = CustomLabel()
    
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    private func configure() {
        
        guard
            let name = hero?.name,
            let quote = hero?.quote,
            let things = hero?.things
        else {
            
            return
        }
        
        heroNameLabel.text = "Name: \(name)"
        heroQuoteLabel.text = "Favourite quote: \(quote)"
        heroFavouriteThings.text = "Favourite things:  \(things[0]), \(things[1]), \(things[2])"
        
        guard let urlString = hero?.img else { return }
        
        imageView.kf.setImage(with: URL(string: urlString))
    }
    
    private func setupUI() {
        
        title = "Hero details"
        
        view.addSubview(heroNameLabel)
        view.addSubview(heroQuoteLabel)
        view.addSubview(imageView)
        view.addSubview(stackView)
        view.addSubview(heroFavouriteThings)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(heroNameLabel)
        
        imageView.contentMode = .scaleAspectFit
        
        heroQuoteLabel.numberOfLines = 0
        heroQuoteLabel.textAlignment = .left
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        heroQuoteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
        
        heroFavouriteThings.snp.makeConstraints { (make) in
            make.top.equalTo(heroQuoteLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
    }
}
