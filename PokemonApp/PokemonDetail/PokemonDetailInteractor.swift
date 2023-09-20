//
//  PokemonDetailInteractor.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 14.09.23.
//

import UIKit
import RealmSwift


protocol PokemonDetailInteractorProtocol: AnyObject {
   
    var networkService: NetworkServiceProtocol { get }
    var pokemonDetail: PokemonDetail? { get }
    
    func fetchPokemonDetailInfo(pokemon: Pokemon)
    func fetchPokemonImage()

}

protocol PokemonDetailInteractorProtocolOutput: AnyObject {
    func pokemonDetailDidFetch(_ pokemonDetails: PokemonDetail, imageData: Data)
    func pokemonDetailsFetchDidFinishWithError(_ error: Error)
}


final class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    
    // MARK: - Properties
    weak var output: PokemonDetailInteractorProtocolOutput?
    weak var presenter: PokemonDetailPresenterProtocol?

    var pokemonDetail: PokemonDetail?
    var imageData: Data?
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Methods
    func fetchPokemonDetailInfo(pokemon: Pokemon) {
        networkService.getData(urlString: pokemon.urlString, expecting: PokemonDetail.self) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.pokemonDetail = pokemonDetail
                self?.fetchPokemonImage()
            case .failure(let error):
                self?.output?.pokemonDetailsFetchDidFinishWithError(error)
            }
        }
    }
    
    func fetchPokemonImage() {
        guard let pokemonDetail else { return }
        networkService.getData(urlString: pokemonDetail.sprites?.frontDefault ?? "", expecting: Data.self) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.output?.pokemonDetailDidFetch(pokemonDetail, imageData: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
