//
//  PokemonDetailRouter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 14.09.23.
//

import UIKit

protocol PokemonDetailRouterProtocol: AnyObject {
    func moveBackToMainVC()
}


final class PokemonDetailRouter: PokemonDetailRouterProtocol {
    // MARK: - Properties
    weak var presenter: PokemonDetailPresenterProtocol?
    
    // MARK: - Methods
    static func build() -> UIViewController {
        
        let interactor = PokemonDetailInteractor(networkService: NetworkService())
        let router = PokemonDetailRouter()
        let presenter = PokemonDetailPresenter(interactor: interactor, router: router)
        let viewController = PokemonDetailViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.output = presenter
//        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
        
    }
    
    func moveBackToMainVC() {
        
        
    }
}
