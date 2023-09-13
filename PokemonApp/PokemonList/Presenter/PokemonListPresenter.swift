//
//  PokemonListPresenter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol PokemonListPresenterProtocol: AnyObject {
    
    func viewDidLoaded()
}

final class PokemonListPresenter: PokemonListPresenterProtocol {
    
    weak var view: PokemonListViewControllerProtocol?
    var router: PokemonListRouterProtocol
    var interactor: PokemonListInteractorProtocol
    
    init(interactor: PokemonListInteractorProtocol, router: PokemonListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    
    func viewDidLoaded(){
        interactor.configureViewPokemons(completion: <#T##(Result<Void, Error>) -> Void#>)
    }
    
}
