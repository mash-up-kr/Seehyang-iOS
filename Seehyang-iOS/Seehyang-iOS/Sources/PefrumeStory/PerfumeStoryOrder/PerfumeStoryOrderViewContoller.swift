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
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var recentButton: UIButton!
    @IBOutlet private weak var maximumButton: UIButton!
    
    // MARK: - Variables
    weak var delegate: PerfumeStoryChanagable?
    var orderButtonState: OrderButtonState?
    @IBOutlet private var buttonArray: [UIButton] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - IBAction
    @IBAction func dismissButtonIsTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func popularButtonIsTapped(_ sender: UIButton) {
        self.orderButtonState?.orderButtonIsTapped(buttonArray: buttonArray, selectedButton: self.popularButton)
        self.orderButtonState = .popular
    }
    
    @IBAction func recentButtonIsTapped(_ sender: UIButton) {
        self.orderButtonState?.orderButtonIsTapped(buttonArray: buttonArray, selectedButton: self.recentButton)
        self.orderButtonState = .recent
    }
    
    @IBAction func maximumButtonIsTapped(_ sender: UIButton) {
        self.orderButtonState?.orderButtonIsTapped(buttonArray: buttonArray, selectedButton: self.maximumButton)
        self.orderButtonState = .maximum
    }
    
    @IBAction func completeButtonIsTapped(_ sender: UIButton) {
        if let state = self.orderButtonState {
            self.delegate?.orderButtonIsChanged(state)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Method
    private func setup() {
        setOrderViewRadius()
        setCompleteButton()
        setOrderButton()
    }
    
    private func setOrderViewRadius() {
        self.orderView.layer.cornerRadius = 20
        self.orderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setCompleteButton() {
        self.completeButton.layer.cornerRadius = 8
    }
    
    private func setOrderButton() {
        if self.orderButtonState == .popular {
            self.popularButton.setImage(UIImage(named: "check_circle_24px"), for: .normal)
        } else if self.orderButtonState == .recent {
            self.recentButton.setImage(UIImage(named: "check_circle_24px"), for: .normal)
        } else {
            self.maximumButton.setImage(UIImage(named: "check_circle_24px"), for: .normal)
        }
    }
}
