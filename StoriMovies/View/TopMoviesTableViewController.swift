//
//  TopMoviesTableViewController.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 30/06/24.
//

import UIKit
import StoriMoviesUIComponents
import Combine

final class TopMoviesTableViewController: BaseTableViewController {
    
    private var subscription = Set<AnyCancellable>()
    
    private var backgrounColor: UIColor = .storiMoviesGreen200
    
    var viewModel: TopMoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        viewModel?.getTopRatedMovies()
    }
    
    private func setup() {
        self.title = "Stori Movies 📽️"
        setupTableView()
        bind()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MovieRankingCell.self,
                           forCellReuseIdentifier: MovieRankingCell.cellId)
        tableView.backgroundColor = backgrounColor
    }
    
    private func bind() {
        viewModel?.selectionPublisher.sink(receiveValue: { [unowned self] movie in
            handleRowSelection(for: movie)
        }).store(in: &subscription)
        
        viewModel?.moviesPublisher.sink { [unowned self] in
            tableView.reloadData()
        }.store(in: &subscription)
        
        viewModel?.$isLoading.sink(receiveValue: { [unowned self] active in
            if active {
                showLoader()
            } else {
                hideLoader()
            }
        }).store(in: &subscription)
        
        viewModel?.errorPublisher.sink(receiveValue: { error in
            print("Pending implementaiton of error alert, will do it when you guys hire me ;)")
        }).store(in: &subscription)
    }
    
    private func handleRowSelection(for movie: Movie) {
        navigationController?.pushViewController(ViewControllerCreator.movieDetail(movie: movie).createViewController(), animated: true)
    }
    
}

// MARK: - UITableView Delegate methods
extension TopMoviesTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getMovieCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieRankingCell.cellId, 
                                                       for: indexPath) as? MovieRankingCell,
              let movie = viewModel?.getMovie(for: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configure(with: movie)
        cell.backgroundColor = backgrounColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.getMovieSelected(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.shouldGetMoreMovies(indexPath.row)
    }
    
}
