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
    func fetchPokemons()
}
protocol PokemonListInteractorProtocolOutput: AnyObject {
    func pokemonsDidFetch()
    func pokemonFetchDidFinishWithError(_ error: Error)
}

final class PokemonListInteractor: PokemonListInteractorProtocolInput {
    // MARK: - Properties
    weak var output: PokemonListInteractorProtocolOutput?
    private let baseUrl = BaseURL.authorization.rawValue
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    // MARK: - Methods
    func fetchPokemons() {
        networkService.getData(urlString: baseUrl, expecting: PokemonData.self) { [weak self] result in
            switch result {
            case .success(let pokemonData):
                RealmManager.manager.add(pokemonData)
                self?.output?.pokemonsDidFetch()
            case .failure(let error):
                self?.output?.pokemonFetchDidFinishWithError(error)
            }
        }
    }
}
