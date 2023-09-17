//
//  PokemonListInteractor.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//
//
import Foundation
import UIKit

protocol PokemonListInteractorProtocolInput: AnyObject {
    
    var nextPokemonsUrl: String? { get }
    var baseUrl: String { get }
    var networkService: NetworkServiceProtocol { get }
    
    func fetchPokemons()
}

protocol PokemonListInteractorProtocolOutput: AnyObject {
    func pokemonsDidFetched()
    func pokemonFetchDidFinishWithError(_ error: Error)
}

final class PokemonListInteractor: PokemonListInteractorProtocolInput {
    
    // MARK: - Properties
    weak var output: PokemonListInteractorProtocolOutput?
    
    var nextPokemonsUrl: String?
    let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func fetchPokemons() {
        networkService.getData(urlStr: baseUrl, expecting: PokemonData.self) { [weak self] result in
            switch result {
            case .success(let pokemonData):
                RealmManager.manager.add(pokemonData)
                self?.output?.pokemonsDidFetched()
            case .failure(let error):
                self?.output?.pokemonFetchDidFinishWithError(error)
            }
        }
    }
}
