//
//  CreateTeamNameViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 19.02.2021.
//

import UIKit

import SnapKit

class CreateTeamNameViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    private let nextStepViewController = CreateTeamHeroesViewController()
    
    private let textField = CustomTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.text = ""
        textField.resignFirstResponder()
    }
    
    private func setupUI() {
        
        title = "Team name"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        
        view.addGestureRecognizer(tap)
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.addSubview(textField)
        view.addSubview(nextStepButton)
        
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        nextStepButton.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @objc private func nextStep() {
        
        guard let text = textField.text, !text.isEmpty else { return }
        
        nextStepViewController.team = Team(name: text)
        
        guard
            let heroes = Networking.heroes,
            !heroes.isEmpty else {
            
            showAlertMessage(message: "Data is loading from the web, please wait", completion: nil)
            
            return
        }
        navigationController?.pushViewController(nextStepViewController, animated: false)
    }
}

