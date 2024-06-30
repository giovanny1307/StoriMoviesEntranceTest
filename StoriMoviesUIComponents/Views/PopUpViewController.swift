//
//  PopUpViewController.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation
import UIKit

public class PopUpViewController: UIViewController {
    
    private lazy var dialogStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .storiMoviesGreen100
        
        return stackView
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "cancel", 
                                  in: Bundle(for: PopUpViewController.self),
                                  with: nil)
        
        NSLayoutConstraint.activate([imageView.heightAnchor.constraint(equalToConstant: 50),
                                     imageView.widthAnchor.constraint(equalToConstant: 50)])
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Upsy 😵"
        
        label.font = FontProvider.getFont(of: .rubikTitle, with: 27)
        label.textColor = .storiMoviesGreen800
       
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "This service hasn't been implemented yet.\n\nPlease comeback soon 💅."
        
        label.font = FontProvider.getFont(of: .rubikSubTitle, with: 18)
        label.textColor = .storiMoviesGreen700
    
        return label
    }()
    
    private lazy var actionButton: CustomButton = {
        let button = CustomButton(model: .init(title: "I understand",
                                               titleColor: .storiMoviesGreen200,
                                               backgroundColor: .storiMoviesGreen900,
                                               font: FontProvider.getFont(of: .rubikContentSubHeader, with: 16),
                                               icon: .none))
        return button
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .clear
        
        setupSubViews()
        setupConstraints()
 
        actionButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    private func setupSubViews() {
        let spacerView1 = UIView()
        let spacerView2 = UIView()
        
        dialogStackView.addArrangedSubview(spacerView1)
        dialogStackView.setCustomSpacing(30, after: spacerView1)
        dialogStackView.addArrangedSubview(iconView)
        dialogStackView.setCustomSpacing(40, after: iconView)
        dialogStackView.addArrangedSubview(titleLabel)
        dialogStackView.setCustomSpacing(10, after: titleLabel)
        dialogStackView.addArrangedSubview(messageLabel)
        dialogStackView.setCustomSpacing(60, after: messageLabel)
        dialogStackView.addArrangedSubview(actionButton)
        dialogStackView.setCustomSpacing(30, after: actionButton)
        dialogStackView.addArrangedSubview(spacerView2)
        
        self.view.addSubview(dialogStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dialogStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            dialogStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dialogStackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
}
