//
//  PokemonListRouter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol PokemonListRouterProtocol: AnyObject {
    func moveToDetailsVC(with pokemon: Pokemon, on: UIViewController?)
}

final class PokemonListRouter: PokemonListRouterProtocol {
    
    // MARK: - Properties
    weak var presenter: PokemonListPresenterProtocol?
    
    // MARK: - Methods
    static func build() -> UIViewController {
        
        let interactor = PokemonListInteractor(networkService: NetworkService())
        let router = PokemonListRouter()
        let presenter = PokemonListPresenter(interactor: interactor, router: router)
        let viewController = PokemonListViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.presenter = presenter
        
        return viewController
        
    }

    func moveToDetailsVC(with pokemon: Pokemon, on: UIViewController?) {
        let secondVC = PokemonDetailRouter.build(with: pokemon)
        on?.navigationController?.pushViewController(secondVC, animated: true)
    }
}
