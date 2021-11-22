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
    
    private let pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .red
        pageControl.currentPageIndicatorTintColor = .coolgrey5
        return pageControl
    }()
    
    private let nextButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .purple
        button.titleLabel?.text = "다음"
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        return button
    }()

    // MARK: - Variable
    var contentViewController: [OnboardingDescriptionViewController]? = []
    
    // MARK: - Method
    private func setLayout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(42)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(48)
        }
        
        pageControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(157)
            make.bottom.equalTo(nextButton.snp.top).offset(84)
            make.height.equalTo(12)
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
    
    func setup() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setLayout()
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
        
        let movedIndex = index - 1
        guard movedIndex >= 0 else {
            return contentViewController?.last
        }
        return contentViewController?[movedIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingDescriptionViewController,
              let index = contentViewController?.firstIndex(of: viewController) else {
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
