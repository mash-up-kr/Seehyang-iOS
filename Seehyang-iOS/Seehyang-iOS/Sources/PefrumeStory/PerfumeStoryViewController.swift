//
//  PerfumeStoryViewController.swift
//  Seehyang-iOS
//
//  Created by jeongminho on 2021/10/02.
//

import UIKit

protocol PerfumeStoryChanagable: class {
    func orderButtonIsChanged(_ state: OrderButtonState)
}

class PerfumeStoryViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var currentStoryCount: UILabel!
    @IBOutlet private weak var totalStoryCount: UILabel!
    @IBOutlet private weak var orderButton: UIButton!
    
    // MARK: - Variable
    private var storyCount: Int = 10
    var orderButtonState: OrderButtonState = OrderButtonState.popular {
        didSet {
            setOrderButtonText()
        }
    }
    
    // MARK: - IBAction
    @IBAction func commentButtonIsTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "PerfumeStoryComment", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: PerfumeStoryCommentViewController.identifier) as? PerfumeStoryCommentViewController else {
             return
        }
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    // MAKR: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @IBAction private func orderButtonIsTapped(_ sender: UIButton) {
 
        let storyboard: UIStoryboard = UIStoryboard(name: "PerfumeStoryOrder", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: PerfumeStoryOrderViewController.identifier) as? PerfumeStoryOrderViewController else {
            return
        }
        
        viewController.delegate = self
        viewController.orderButtonState = self.orderButtonState
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
        self.orderButton.setTitle(orderButtonState.orderButtonText, for: .normal)
    }
    
    private func setOrderButtonText() {
        self.orderButton.setTitle(orderButtonState.orderButtonText, for: .normal)
    }
}

extension PerfumeStoryViewController: PerfumeStoryChanagable {
    func orderButtonIsChanged(_ state: OrderButtonState) {
        self.orderButtonState = state
    }
}

enum OrderButtonState {
    case popular
    case recent
    case maximum
    
    var orderButtonText: String {
        switch self {
        case .popular:
            return " 인기순 ↓ "
        case .recent:
            return " 최신 등록순 ↓ "
        case .maximum:
            return " 최다 댓글순 ↓ "
        }
    }
    
    func orderButtonIsTapped(buttonArray: [UIButton], selectedButton: UIButton) {
    
        buttonArray.forEach { button in
            if button == selectedButton {
                button.setImage(UIImage(named: "check_circle_24px"), for: .normal)
            } else {
                button.setImage(UIImage(named: "check_circle_outline_24px"), for: .normal)
            }
        }
    }
}
