//
//  PokemonListModuleBuilder.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit


class PokemonListModuleBuilder {
    
    static func build() -> PokemonListViewController {
        
        let interactor = PokemonListInteractor(networkService: NetworkService.self as! NetworkServiceProtocol)
        let router = PokemonListRouter()
        let presenter = PokemonListPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PokemonListViewController") as! PokemonListViewController
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
        
    }
}
