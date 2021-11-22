//
//  OnboardingDescriptionViewController.swift
//  Seehyang-iOS
//
//  Created by JeongMinho on 2021/11/19.
//

import UIKit
import SnapKit

class OnboardingDescriptionViewController: UIViewController {
    
    // MARK: - Variable    
    lazy var onboardingImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let onboardingDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let descriptionLabelView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .coolgrey6
        return view
    }()
    
    let firstDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 2
        label.text = "다양한 향수 이미지를 \n 통해 눈으로 시향해보세요 :)"
        label.textAlignment = .center
        label.textColor = .purple
        return label
    }()
    
    let secondDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.text = "직접 사용한 사람들이 올리는 \n 향수에 대한 이미지들을 통해 시향할 수 있습니다."
        label.textAlignment = .center
        label.textColor = .grey3
        return label
    }()
    
    private func setLayout() {
        self.onboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        self.descriptionLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.onboardingImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(183)
        }
        
        self.firstDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(9)
        }
        
        self.secondDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstDescriptionLabel.snp.bottom).offset(24)
        }
    }
    
    private func setup() {
        self.view.backgroundColor = .coolgrey6
        self.view.addSubview(onboardingImageView)
        self.view.addSubview(descriptionLabelView)
        self.view.addSubview(onboardingDescriptionLabel)
        
        self.descriptionLabelView.addSubview(firstDescriptionLabel)
        self.descriptionLabelView.addSubview(secondDescriptionLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setLayout()
    }
}
