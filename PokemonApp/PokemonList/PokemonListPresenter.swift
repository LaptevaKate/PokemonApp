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
    
    weak var view: PokemonListViewProtocol?
    var router: PokemonListRouterProtocol
    var interactor: PokemonListInteractorProtocolInput
    
    init(interactor: PokemonListInteractorProtocolInput, router: PokemonListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    
    func viewDidLoaded() {
        interactor.fetchPokemons()
    }
}

extension PokemonListPresenter: PokemonListInteractorProtocolOutput{
    func pokemonsDidFetched(_ data: [Pokemon]) {
        view?.configTableView(with: data)
    }
}
