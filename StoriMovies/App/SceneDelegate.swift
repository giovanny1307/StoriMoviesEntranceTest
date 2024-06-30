//
//  SceneDelegate.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 30/06/24.
//

import UIKit
import StoriMoviesUIComponents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController =  UINavigationController(rootViewController: ViewControllerCreator.topRatedMovies.createViewController())
        
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                  NSAttributedString.Key.font: FontProvider.getFont(of: .rubikTitle,
                                                                                                                    with: 20)]
        navigationController.navigationBar.tintColor = .storiMoviesGreen100
        navigationController.navigationItem.backBarButtonItem?.title = ""
        configureNavigationBarAppearance()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func configureNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                       NSAttributedString.Key.font: FontProvider.getFont(of: .rubikTitle,
                                                                                                         with: 20)]
        navigationBarAppearance.backgroundColor = UIColor.storiMoviesGreen900
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
