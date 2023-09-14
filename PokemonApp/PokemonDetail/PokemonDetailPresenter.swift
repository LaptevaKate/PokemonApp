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
    
    init(interactor: PokemonDetailInteractorProtocol, router: PokemonDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Methods
    func pokemonViewDidLoaded() {
        interactor.fetchPokemonDetailInfo()       
    }
}

// MARK: - extension
extension PokemonDetailPresenter: PokemonDetailInteractorProtocolOutput {
  
    func pokemonDetailDidFetched(_ data: [PokemonDetail]) {
        
        interactor.didChangePokemon = { [weak self] pokemon, names in
            DispatchQueue.main.async {
                guard let data = self?.interactor.imageData else { return }
                self?.view?.setUpPokemonInfo(with: pokemon, data: data, names: names)
            }
        }
    }
}
