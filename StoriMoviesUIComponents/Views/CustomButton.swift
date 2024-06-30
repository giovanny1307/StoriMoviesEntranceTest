//
//  CustomButton.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 3/07/24.
//

import UIKit

public enum buttonIcon {
    case approve
    case plus_one
    case edit
    case none
    
    func getButtonImage()-> UIImage? {
        switch self {
        case .approve:
            return UIImage(named: "done", in:
                            Bundle(for: CustomButton.self),
                           with: nil)
        case .plus_one:
            return UIImage(named: "add_more",
                           in: Bundle(for: CustomButton.self),
                           with: nil)
        case .edit:
            return UIImage(named: "edit",
                           in: Bundle(for: CustomButton.self),
                           with: nil)
        default:
            return nil
        }
    }
}

public struct CustomButtonModel {
    
    let title: String
    let titleColor: UIColor
    let backgroundColor: UIColor
    let font: UIFont
    let icon: UIImage?
    
    public init(title: String, titleColor: UIColor, backgroundColor: UIColor, font: UIFont, icon: buttonIcon) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.icon = icon.getButtonImage()
    }
}

public class CustomButton: UIButton {
    
    private var model: CustomButtonModel?
    
    public init(model: CustomButtonModel) {
        super.init(frame: .zero)
        self.model = model
        setup()
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        configuration = .plain()
        configuration?.imagePadding = 15
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                               leading: 20,
                                                               bottom: 10,
                                                               trailing: 20)
        
        guard let model =  model else {
            return
        }
        
        var container = AttributeContainer()
        container.font = model.font
        
        configuration?.attributedTitle = AttributedString(model.title, attributes: container)
        configuration?.image = model.icon
        configuration?.imagePlacement = .trailing
        configuration?.background.backgroundColor = model.backgroundColor
        configuration?.baseForegroundColor = model.titleColor
        configuration?.cornerStyle = .capsule
    }
}
