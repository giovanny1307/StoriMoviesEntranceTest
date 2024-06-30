//
//  MovieDetailViewController.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Combine
import Foundation
import StoriMoviesUIComponents
import UIKit

final class MovieDetailViewController: UIViewController {
        
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var rankingHeaderView: RankingHeaderView = {
        let rankingView = RankingHeaderView()

        return rankingView
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.adjustsFontForContentSizeCategory = true
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.bounces = false
        textView.alwaysBounceVertical = false
        textView.alwaysBounceHorizontal = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.textAlignment = .left
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.font = FontProvider.getFont(of: .rubikContent, with: 17)
        textView.textColor = .storiMoviesGreen900
        
        return textView
    }()
    
    private lazy var showActorsButton: UIButton = {
       let button = UIButton()
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .font: FontProvider.getFont(of: .rubikContentHeader,
                                        with: 15),
            .foregroundColor: UIColor.storiMoviesGreen700,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attributedString = NSMutableAttributedString(string: "See the actors of this movie",
                                                         attributes: buttonAttributes)
        button.configuration = .plain()
        button.setAttributedTitle(attributedString, for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top:0,
                                                                     leading:4,
                                                                     bottom:0,
                                                                     trailing:0)
        
        return button
    }()
    

    private lazy var rateMovieButton: CustomButton = {
        let button = CustomButton(model: .init(title: "Add your rating",
                                               titleColor: .storiMoviesGreen200,
                                               backgroundColor: .storiMoviesGreen700,
                                               font: FontProvider.getFont(of: .rubikContent,
                                                                          with: 15),
                                               icon: .plus_one))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var subscription = Set<AnyCancellable>()
    
    var viewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        viewModel?.loadMovie()
    }
    
    private func setup() {
        self.view.backgroundColor = .storiMoviesGreen300
        setupSubViews()
        setupConstraints()
        setupButtonActions()
        bind()
    }
    
    private func setupSubViews() {
        view.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(rankingHeaderView)
        contentStackView.addArrangedSubview(descriptionTextView)
        contentStackView.addArrangedSubview(showActorsButton)
        contentStackView.setCustomSpacing(70, after: showActorsButton)
        contentStackView.addArrangedSubview(rateMovieButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                     contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
                                     contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -21)])
    }
    
    private func setupButtonActions() {
        rateMovieButton.addTarget(self, action: #selector(rateMoviesButtonPressed), for: .touchUpInside)
        showActorsButton.addTarget(self, action: #selector(showActorsButtonPressed), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel?.moviePublisher
                  .sink(receiveValue: { [unowned self] movie in
           loadView(with: movie)
        }).store(in: &subscription)
        
        viewModel?.rateMoviePubliser
                  .sink(receiveValue: { [unowned self] in
                      handleRateMovies()
        }).store(in: &subscription)
        
        viewModel?.actorsPublisher
                  .sink(receiveValue: { [unowned self] movieId in
           handleShowActors(with: movieId)
        }).store(in: &subscription)
    }
    
    private func loadView(with movie: Movie) {
        rankingHeaderView.configureView(with: .init(ranking: "\(movie.rating.rounded())/10",
                                                    movieName: movie.name,
                                                    movieReleaseDate: movie.release_date,
                                                    moviePosterUrl: "\(AppConstants.image_url)\(movie.landscape_poster_url_string)"))
  
        descriptionTextView.text = movie.description
    }
    
    @objc private func rateMoviesButtonPressed() {
        viewModel?.rateMovie()
    }
    
    private func handleRateMovies() {
        let modalViewController = PopUpViewController()
        modalViewController.modalPresentationStyle = .overFullScreen

        self.navigationController?.present(modalViewController, animated: true)
    }
    
    @objc private func showActorsButtonPressed() {
        viewModel?.transferActorsId()
    }
    
    private func handleShowActors(with id: Int) {
        let modalViewController = PopUpViewController()
        modalViewController.modalPresentationStyle = .overFullScreen

        self.navigationController?.present(modalViewController, animated: true)
    }
}
