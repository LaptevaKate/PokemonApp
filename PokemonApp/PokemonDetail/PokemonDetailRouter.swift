//
//  PokemonDetailRouter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 14.09.23.
//

import UIKit

protocol PokemonDetailRouterProtocol: AnyObject {}

final class PokemonDetailRouter: PokemonDetailRouterProtocol {
    // MARK: - Properties
    weak var presenter: PokemonDetailPresenterProtocol?
    // MARK: - Methods
    static func build(with pokemon: Pokemon) -> UIViewController {
        
        let interactor = PokemonDetailInteractor(networkService: NetworkService())
        let router = PokemonDetailRouter()
        let presenter = PokemonDetailPresenter(interactor: interactor, router: router, pokemon: pokemon)
        let viewController = PokemonDetailViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.presenter = presenter
        
        return viewController
    }
}
