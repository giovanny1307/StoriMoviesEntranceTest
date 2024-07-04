//
//  UserCard.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 5/07/24.
//

import Foundation
import UIKit
import Kingfisher

public struct UserCardModel: Hashable {
    let actorName: String
    let characterName: String
    let photoUrl: String?
    
    public init(actorName: String, characterName: String, photoUrl: String?) {
        self.actorName = actorName
        self.characterName = characterName
        self.photoUrl = photoUrl
    }
}

public class UserCard: UIView {
    
    private let fallbackURL = "https://shorturl.at/EmDL4"
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var actorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .storiMoviesGreen800
        label.font = FontProvider.getFont(of: .rubikTitle, with: 15)
        
        return label
    }()
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .storiMoviesGreen700
        label.font = FontProvider.getFont(of: .rubikContentSubHeader, with: 12)
        
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public func configureView(with model: UserCardModel) {
        actorName.text = model.actorName
        characterName.text = model.characterName
        photo.kf.setImage(with: URL(string: model.photoUrl ?? fallbackURL),
                          options: [.processor(DownsamplingImageProcessor(size: CGSize(width: photo.frame.width,
                                                                                   height: photo.frame.height))),
                                    .processor(RoundCornerImageProcessor(cornerRadius: 20)),
                                    .scaleFactor(UIScreen.main.scale),
                                    .cacheOriginalImage ])
    }
    
    private func setup() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        addSubview(photo)
        addSubview(actorName)
        addSubview(characterName)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: leadingAnchor),
            photo.heightAnchor.constraint(equalToConstant: 50),
            photo.widthAnchor.constraint(equalToConstant: 50),
            photo.topAnchor.constraint(equalTo: topAnchor),
            photo.bottomAnchor.constraint(equalTo: bottomAnchor),
          
            
            actorName.bottomAnchor.constraint(equalTo: centerYAnchor),
            actorName.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 10),
            actorName.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            characterName.topAnchor.constraint(equalTo: actorName.bottomAnchor),
            characterName.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 10),
            characterName.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
