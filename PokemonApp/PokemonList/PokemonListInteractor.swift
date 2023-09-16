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
    func fetchPokemonBy(id: String)
//    func fetchNextPokemonsUrl(with url: String)
}

protocol PokemonListInteractorProtocolOutput: AnyObject {
    func pokemonsDidFetched()
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
                RealmManager.add(pokemonData.results.map{$0.managedObject()})
                self?.output?.pokemonsDidFetched()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPokemonBy(id: String) {
        let url = baseUrl + "/\(id)"
        networkService.getData(urlStr: url, expecting: PokemonData.self) { [weak self] result in
            switch result {
            case .success(let pokemonData):
                print(pokemonData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func fetchNextPokemonsUrl(with url: String) {
//        networkService.getData(urlStr: url, expecting: Response.self) { [weak self] result in
//            switch result {
//            case .success(let response):
//                self?.nextPokemonsUrl = response.next
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
