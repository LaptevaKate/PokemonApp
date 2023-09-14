//
//  PokemonDetailInteractor.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 14.09.23.
//

import UIKit


protocol PokemonDetailInteractorProtocol: AnyObject {
   
    var selectedPokemon: Pokemon? { get set }
    var imageData: Data? { get }
    var networkService: NetworkServiceProtocol { get }
    var pokemonDetail: PokemonDetail? { get }
    
//    var didChangePokemon: ((PokemonDetail, [String])->())? { get set }
//    var didRecieveError: ((Error)->())? { get set }
    
    func fetchPokemonDetailInfo()
    func fetchPokemonImage()
}

//protocol PokemonDetailInteractorProtocolOutput: AnyObject {
//    func pokemonDetailDidFetched(_ data: [PokemonDetail])
//}


final class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    
    // MARK: - Properties
//    weak var output: PokemonDetailInteractorProtocolOutput?
    
//    var didChangePokemon: ((PokemonDetail, [String])->())?
//    var didRecieveError: ((Error)->())?

    weak var presenter: PokemonDetailPresenterProtocol?
    
    var selectedPokemon: Pokemon? {
        didSet {
            fetchPokemonDetailInfo()
        }
    }
    
    var pokemonDetail: PokemonDetail?
    var imageData: Data?
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Methods
    func fetchPokemonDetailInfo() {
        guard let selectedPokemon else { return }
        networkService.getData(urlStr: selectedPokemon.url, expecting: PokemonDetail.self) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.pokemonDetail = pokemonDetail
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPokemonImage() {
        guard let pokemon = pokemonDetail else { return }
        networkService.getData(urlStr: pokemon.sprites.frontDefault, expecting: Data.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.imageData = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
