//
//  ViewController.swift
//  Seehyang-iOS
//
//  Created by jeongminho on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let vc = UIStoryboard(name: "PerfumeStory", bundle: nil).instantiateViewController(withIdentifier: PerfumeStoryViewController.identifier) as? PerfumeStoryViewController else {
            return
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

