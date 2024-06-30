//
//  RankingHeaderView.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 30/06/24.
//

import Foundation
import UIKit
import Kingfisher

public struct RankingHeaderViewModel: Hashable {
    
    let ranking: String
    let movieName: String
    let movieReleaseDate: String?
    let moviePosterUrl: String?
    
    public init(ranking: String, movieName: String, movieReleaseDate: String, moviePosterUrl: String?) {
        self.ranking = ranking
        self.movieName = movieName
        self.movieReleaseDate = movieReleaseDate
        self.moviePosterUrl = moviePosterUrl
    }
}

public class RankingHeaderView: UIStackView {
    
    private let fallbackURL = "https://shorturl.at/EmDL4"
    
    private lazy var posterWithRankingContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterView)
        view.addSubview(rankingLabel)
        
        return view
    }()
    
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private lazy var rankingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .storiMoviesGreen100
        label.font = FontProvider.getFont(of: .rubikTitle, with: 45)
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .storiMoviesGreen800
        label.font = FontProvider.getFont(of: .rubikTitle, with: 37)
        
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .storiMoviesGreen700
        label.font = FontProvider.getFont(of: .rubikSubTitle, with: 20)
        
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public func configureView(with model: RankingHeaderViewModel) {
        rankingLabel.text = model.ranking
        nameLabel.text = model.movieName
        releaseDateLabel.text = model.movieReleaseDate
        posterView.kf.setImage(with: URL(string: model.moviePosterUrl ?? fallbackURL),
                               placeholder: UIImage(named: "flyer-dummy",
                                                    in: Bundle(for: RankingHeaderView.self),
                                                    with: nil),
                               options: [
                                .processor(DownsamplingImageProcessor(size: CGSize(width: posterView.frame.width, 
                                                                                   height: posterView.frame.height))),
                                .scaleFactor(UIScreen.main.scale),
                                .cacheOriginalImage
                            ])
    }
    
    private func setup() {
        distribution = .fill
        alignment = .fill
        spacing = 5
        axis = .vertical
        
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        addArrangedSubview(posterWithRankingContainerView)
        addArrangedSubview(nameLabel)
        addArrangedSubview(releaseDateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: posterWithRankingContainerView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: posterWithRankingContainerView.leadingAnchor),
            posterView.bottomAnchor.constraint(equalTo: posterWithRankingContainerView.bottomAnchor),
            posterView.trailingAnchor.constraint(equalTo: posterWithRankingContainerView.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 200),
            
            rankingLabel.trailingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: -10),
            rankingLabel.topAnchor.constraint(equalTo: posterView.topAnchor, constant: 10)
        ])
    }
}
