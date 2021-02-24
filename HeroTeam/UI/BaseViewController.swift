//
//  BaseViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextStepButton.setTitle("Next step", for: .normal)
    }
    
    let nextStepButton = CustomButton()

    func showAlertMessage(message: String, completion: (() -> ())?) {
        
        let alert = UIAlertController(title: "System message:", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            completion?()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showConfirmMessage(message: String, completion: @escaping () -> ()) {
        
        let alert = UIAlertController(title: "System message:", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            completion()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
