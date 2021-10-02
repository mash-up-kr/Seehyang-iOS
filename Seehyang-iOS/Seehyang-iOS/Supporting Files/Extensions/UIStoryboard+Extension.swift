//
//  UIStoryboard+Extension.swift
//  Seehyang-iOS
//
//  Created by jeongminho on 2021/10/02.
//

import UIKit

protocol StoryboardIdentifiable {
    static var identifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
extension UITableViewCell: StoryboardIdentifiable { }
extension UICollectionReusableView: StoryboardIdentifiable { }
