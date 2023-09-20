//
//  PokemonDetailPresenter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 14.09.23.
//

import UIKit

protocol PokemonDetailPresenterProtocol: AnyObject {
    func pokemonViewDidLoad()
    func setUpPokemonInfo(with pokemon: PokemonDetail, data: Data)
}

final class PokemonDetailPresenter:  PokemonDetailPresenterProtocol {
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
    func pokemonViewDidLoad() {
        interactor.fetchPokemonDetailInfo(pokemon: selectedPokemon)
    }
    
    func setUpPokemonInfo(with pokemon: PokemonDetail, data: Data) {
        let viewModel = PokemonDetailViewModel(pokemonImage: UIImage(data: data) ?? UIImage(),
                                              pokemonName: "Types: " + pokemon.types.map{$0.type?.name ?? ""}.joined(separator: ", "),
                                              pokemonType: "Height: \(pokemon.height * 10) cm",
                                              pokemonWeight: "Weight: \(pokemon.weight / 10) kg",
                                              pokemonHeight: pokemon.name.capitalized)
        view?.setupUI(with: viewModel)
    }
}

// MARK: - extension
extension PokemonDetailPresenter: PokemonDetailInteractorProtocolOutput {
    
    func pokemonDetailDidFetch(_ pokemonDetails: PokemonDetail, imageData: Data) {
        setUpPokemonInfo(with: pokemonDetails, data: imageData)
    }
    
    func pokemonDetailsFetchDidFinishWithError(_ error: Error) {
        view?.showError(error)
    }
}




