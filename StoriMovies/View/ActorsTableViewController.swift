//
//  ActorsTableViewController.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 5/07/24.
//

import UIKit
import StoriMoviesUIComponents
import Combine

import Foundation

final class ActorsTableViewController: BaseTableViewController {
    
    private var subscription = Set<AnyCancellable>()
    
    private var backgrounColor: UIColor = .storiMoviesGreen200
    
    var viewModel: ActorsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        viewModel?.getActors()
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
        tableView.register(UserCell.self,
                           forCellReuseIdentifier: UserCell.cellId)
        tableView.backgroundColor = backgrounColor
    }
    
    private func bind() {
        viewModel?.actorsPublisher.sink { [unowned self] in
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
}

// MARK: - UITableView Delegate methods
extension ActorsTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getActorCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.cellId,
                                                       for: indexPath) as? UserCell,
              let actor = viewModel?.getActor(for: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configure(with: actor)
        cell.backgroundColor = backgrounColor
        
        return cell
    }
}
