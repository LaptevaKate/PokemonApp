//
//  PokemonListPresenter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol PokemonListPresenterProtocol: AnyObject {
    func pokemonViewLoaded()
    func pokemonSelected(_ pokemon: Pokemon, on view: UIViewController)
}

final class PokemonListPresenter: PokemonListPresenterProtocol {
    
    // MARK: - Properties
    weak var view: PokemonListViewProtocol?
    var router: PokemonListRouterProtocol
    var interactor: PokemonListInteractorProtocolInput
    
    init(interactor: PokemonListInteractorProtocolInput, router: PokemonListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Methods
    func pokemonViewLoaded() {
        interactor.fetchPokemons()
    }
    
    func pokemonSelected(_ pokemon: Pokemon, on view: UIViewController) {
        router.moveToDetailsVC(with: pokemon, on: view)
    }
}

// MARK: - extension
extension PokemonListPresenter: PokemonListInteractorProtocolOutput{
    func pokemonsDidFetch() {
        view?.configTableView()
    }
    
    func pokemonFetchDidFinishWithError(_ error: Error) {
        view?.showError(error)
    }
}
