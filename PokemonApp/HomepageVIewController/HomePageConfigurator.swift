//
//  HomePageConfigurator.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation

protocol HomePageConfiguratorProtocol {
    func configure(with viewController: HomePageViewProtocol)
}

final class HomePageConfigurator: HomePageConfiguratorProtocol {
    func configure(with viewController: HomePageViewProtocol) {
        let presenter = HomePagePresenter(view: viewController)
        let interactor = HomePageInteractor(presenter: presenter)
        let router = HomePageRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
