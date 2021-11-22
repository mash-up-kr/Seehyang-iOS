//
//  OnboardingViewController.swift
//  Seehyang-iOS
//
//  Created by JeongMinho on 2021/11/13.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    // MARK: - View
    private var pageViewController: UIPageViewController = {
        let pageViewController: UIPageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        return pageViewController
    }()

    // MARK: - Variable
    var contentViewController: [OnboardingDescriptionViewController]? = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Method
    private func setPageControl() {
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .red
        pageControl.currentPageIndicatorTintColor = .coolgrey5
        
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
        }
    }

    private func removeTapGestureRecognizer() {
        guard let tapGesture = pageViewController.view.gestureRecognizers?.first(where: { recognizer in
            recognizer is UITapGestureRecognizer
            
        }) else {
            return
        }
        
        pageViewController.view.removeGestureRecognizer(tapGesture)
    }
    
    func setPageViewController() {
        self.view.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(183)
        }
        
        guard let first = contentViewController?.first else {
            return
        }
        pageViewController.view.backgroundColor = .clear
        pageViewController.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        self.addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        self.view.addSubview(pageViewController.view)
    }
    
    func addContentViewController() {
        contentViewController = [
            UIImage(named: "onboarding1"),
            UIImage(named: "onboarding2"),
            UIImage(named: "onboarding3")
        ].map { image in
            let viewController = OnboardingDescriptionViewController()
            viewController.onboardingImageView.image = image
            return viewController
        }
    }
    
    private func setNextButton() {
        nextButton.layer.cornerRadius = 8
    }
    
    private func setPageControlCount(index: Int) {
        pageControl.currentPage = index
    }
    
    func setup() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setNextButton()
        setPageControl()
        addContentViewController()
        setPageViewController()
        removeTapGestureRecognizer()
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? OnboardingDescriptionViewController,
              let index = contentViewController?.firstIndex(of: viewController) else {
            return nil
        }
        
        var movedIndex = index - 1
        guard movedIndex >= 0 else {
            movedIndex = 0
            return nil
        }
        return contentViewController?[movedIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingDescriptionViewController,
              let index = contentViewController?.firstIndex(of: viewController) else {
            return nil
        }

        var movedIndex = index + 1
        guard movedIndex < (contentViewController?.count ?? 0) else {
            movedIndex = 2
            return nil
        }
        return contentViewController?[movedIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard let currentViewController = pageViewController.viewControllers?.first as? OnboardingDescriptionViewController,
              let index = contentViewController?.firstIndex(of: currentViewController) else {
            return
        }
        
        setPageControlCount(index: index)
    }
}
