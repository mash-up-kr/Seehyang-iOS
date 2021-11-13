//
//  OnboardingViewController.swift
//  Seehyang-iOS
//
//  Created by JeongMinho on 2021/11/13.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Variable
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
 
    var contentViewController: [UIViewController]? = []
    
    // MARK: - Method
    private func removeTapGestureRecognizer() {
        guard let tapGesture = pageViewController.view.gestureRecognizers?.first(where: { recognizer in
            recognizer is UITapGestureRecognizer
        }) else {
            return
        }
        
        pageViewController.view.removeGestureRecognizer(tapGesture)
    }
    
    func setPageViewController() {
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        guard let first = contentViewController?.first else {
            return
        }
        pageViewController.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        self.addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        self.view.addSubview(pageViewController.view)
    }
    
    func addContentViewController() {
        contentViewController = [UIColor.red, UIColor.orange, UIColor.yellow].map {
            let viewController = UIViewController()
            viewController.view.backgroundColor = $0
            return viewController
        }
    }
    
    func setup() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addContentViewController()
        setPageViewController()
        removeTapGestureRecognizer()
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = contentViewController?.firstIndex(of: viewController) else {
            return nil
        }
        
        let movedIndex = index - 1
        guard movedIndex >= 0 else {
            return contentViewController?.last
        }
        return contentViewController?[movedIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contentViewController?.firstIndex(of: viewController) else {
            return nil
        }
        
        let movedIndex = index + 1
        guard movedIndex < (contentViewController?.count ?? 0) else {
            return contentViewController?.first
        }
        
        return contentViewController?[movedIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            print(completed)
        }
    }
}
