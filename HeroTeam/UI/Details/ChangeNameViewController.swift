//
//  ChangeNameViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 23.02.2021.
//

import UIKit
import RealmSwift

class ChangeNameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var team: Team?
    
    private let textField = CustomTextField()
    
    private let confirmButton: CustomButton = {
        let bt = CustomButton()
        bt.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        bt.setTitle("Confirm changes", for: .normal)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        title = "Change team name"
        
        view.addSubview(textField)
        view.addSubview(confirmButton)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
    }
    
    @objc private func changeName() {
        
        guard let newName = textField.text, !newName.isEmpty else { return }
        
        let realm = Realm.instance
        
        let currentObject = realm.objects(_Team.self).filter { [self] in $0.uuid == team?.uuid}
        
        try? realm.write {
            currentObject.first?.title = newName
        }
        
        textField.text = ""
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
