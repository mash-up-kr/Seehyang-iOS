//
//  PerfumeStoryOrderViewContoller.swift
//  Seehyang-iOS
//
//  Created by jeongminho on 2021/10/02.
//

import UIKit

class PerfumeStoryOrderViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var orderView: UIView!
    @IBOutlet private weak var completeButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - IBAction
    @IBAction func dismissButtonIsTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Method
    private func setup() {
        setOrderViewRadius()
        setCompleteButton()
    }
    
    private func setOrderViewRadius() {
        self.orderView.layer.cornerRadius = 20
        self.orderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setCompleteButton() {
        self.completeButton.layer.cornerRadius = 8
    }
}
