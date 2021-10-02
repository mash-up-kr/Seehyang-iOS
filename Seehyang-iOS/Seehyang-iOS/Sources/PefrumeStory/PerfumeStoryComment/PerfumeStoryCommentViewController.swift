//
//  PerfumeStoryCommentViewController.swift
//  Seehyang-iOS
//
//  Created by jeongminho on 2021/10/03.
//

import UIKit

class PerfumeStoryCommentViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Variablew
    private let cellIdentifier: String = "PerfumeStoryCommentTableViewCell"
    
    // MARK: - IBAction
    @IBAction func closeButtonIsTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Method
    private func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension PerfumeStoryCommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeued: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let cell = dequeued as? PerfumeStoryCommentTableViewCell else {
            return dequeued
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        145
    }
}

// MARK: - UITableViewDelegate
extension PerfumeStoryCommentViewController: UITableViewDelegate {
    
}

