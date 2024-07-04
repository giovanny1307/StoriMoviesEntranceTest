//
//  UserCell.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 5/07/24.
//

import Foundation
import UIKit

public class UserCell: UITableViewCell {
    
    public static let cellId = "UserCell"
    
    private lazy var userCard: UserCard = {
        let userCard = UserCard()
        userCard.translatesAutoresizingMaskIntoConstraints = false

        return userCard
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
 
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func configure(with model:UserCardModel) {
        userCard.configureView(with: model)
    }
    
    private func setup() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        addSubview(userCard)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userCard.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            userCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            userCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            userCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
