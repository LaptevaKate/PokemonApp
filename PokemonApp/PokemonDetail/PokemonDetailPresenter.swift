//
//  PokemonDetailPresenter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 14.09.23.
//

import UIKit

protocol PokemonDetailPresenterProtocol: AnyObject {
    func pokemonViewDidLoaded()
}

final class PokemonDetailPresenter: PokemonDetailPresenterProtocol {
    
    // MARK: - Properties
    weak var view: PokemonDetailViewProtocol?
    var router: PokemonDetailRouterProtocol
    var interactor: PokemonDetailInteractorProtocol
    private let selectedPokemon: Pokemon
    
    init(interactor: PokemonDetailInteractorProtocol, router: PokemonDetailRouterProtocol, pokemon: Pokemon) {
        self.interactor = interactor
        self.router = router
        self.selectedPokemon = pokemon
    }
    
    // MARK: - Methods
    func pokemonViewDidLoaded() {
        interactor.fetchPokemonDetailInfo(pokemon: selectedPokemon)
    }

}

// MARK: - extension
extension PokemonDetailPresenter: PokemonDetailInteractorProtocolOutput {
    
    func pokemonDetailDidFetched(_ pokemonDetails: PokemonDetail, imageData: Data) {
        view?.setUpPokemonInfo(with: pokemonDetails, data: imageData)
    }
    
    func pokemonDetailsFetchDidFinishWithError(_ error: Error) {
        view?.showError(error)
    }
}
