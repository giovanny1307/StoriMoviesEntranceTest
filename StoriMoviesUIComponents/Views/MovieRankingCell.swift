//
//  ContentCell.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 30/06/24.
//

import Foundation
import UIKit

public struct MovieRankingCellModel: Hashable {
    var headerModel: RankingHeaderViewModel
    
    public init(headerModel: RankingHeaderViewModel) {
        self.headerModel = headerModel
    }
}

public class MovieRankingCell: UITableViewCell {
    
    public static let cellId = "MovieRankingCell"
    
    private lazy var rankingHeaderView: RankingHeaderView = {
        let rankingView = RankingHeaderView()
        rankingView.translatesAutoresizingMaskIntoConstraints = false

        return rankingView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
 
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func configure(with model:MovieRankingCellModel) {
        rankingHeaderView.configureView(with: model.headerModel)
    }
    
    private func setup() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        addSubview(rankingHeaderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rankingHeaderView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            rankingHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            rankingHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            rankingHeaderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
