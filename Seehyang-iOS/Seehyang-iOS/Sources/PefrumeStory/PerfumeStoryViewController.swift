//
//  PerfumeStoryViewController.swift
//  Seehyang-iOS
//
//  Created by jeongminho on 2021/10/02.
//

import UIKit

class PerfumeStoryViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var currentStoryCount: UILabel!
    @IBOutlet private weak var totalStoryCount: UILabel!
    @IBOutlet private weak var orderButton: UIButton!
    
    // MARK: - Variable
    private var storyCount: Int = 10
    
    // MAKR: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @IBAction private func orderButtonIsTapped(_ sender: UIButton) {
        
        guard let viewController: UIViewController = UIStoryboard(name: "PerfumeStoryOrder", bundle: nil).instantiateViewController(withIdentifier: PerfumeStoryOrderViewController.identifier) as? PerfumeStoryOrderViewController else {
            return
        }
        
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: - Method
    private func setup() {
        setStory()
        setOrderButton()
    }
    
    private func setStory() {
        self.totalStoryCount.text = "\(storyCount)"
    }
    
    private func setOrderButton() {
        self.orderButton.layer.borderColor = #colorLiteral(red: 0.8765067458, green: 0.876527369, blue: 0.8765162826, alpha: 0.8470588235)
        self.orderButton.backgroundColor = .white
        self.orderButton.layer.borderWidth = 1
        self.orderButton.layer.cornerRadius = 5
        self.orderButton.setTitle("  인기순 ↓  ", for: .normal)
    }
}
