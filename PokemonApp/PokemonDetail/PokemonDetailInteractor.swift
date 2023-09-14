//
//  PokemonDetailInteractor.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 14.09.23.
//

import UIKit


protocol PokemonDetailInteractorProtocol: AnyObject {
   
//    var selectedPokemon: Pokemon? { get set }
    var networkService: NetworkServiceProtocol { get }
    var pokemonDetail: PokemonDetail? { get }
    
    func fetchPokemonDetailInfo(pokemon: Pokemon)
    func fetchPokemonImage()
}

protocol PokemonDetailInteractorProtocolOutput: AnyObject {
    func pokemonDetailDidFetched(_ pokemonDetails: PokemonDetail, imageData: Data)
}


final class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    
    // MARK: - Properties
    weak var output: PokemonDetailInteractorProtocolOutput?
    weak var presenter: PokemonDetailPresenterProtocol?
    
//    var selectedPokemon: Pokemon? {
//        didSet {
//            fetchPokemonDetailInfo()
//        }
//    }
    
    var pokemonDetail: PokemonDetail?
    var imageData: Data?
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Methods
    func fetchPokemonDetailInfo(pokemon: Pokemon) {
        networkService.getData(urlStr: pokemon.url, expecting: PokemonDetail.self) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.pokemonDetail = pokemonDetail
                self?.fetchPokemonImage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPokemonImage() {
        guard let pokemonDetail else { return }
        networkService.getData(urlStr: pokemonDetail.sprites.frontDefault, expecting: Data.self) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.output?.pokemonDetailDidFetched(pokemonDetail, imageData: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
