//
//  BaseTableViewController.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation
import UIKit

class BaseTableViewController: UITableViewController {
    
    private lazy var loadingIndicator: UIAlertController = {
        let loader = UIAlertController(title: nil, message: "3 2 1 Action! 🎬", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .storiMoviesGreen800
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        loader.view.addSubview(loadingIndicator)
        
        return loader
    }()
    
    public func showLoader() {
        navigationController?.present(loadingIndicator, animated: false)
    }
    
    public func hideLoader() {
        loadingIndicator.dismiss(animated: false)
    }
}

