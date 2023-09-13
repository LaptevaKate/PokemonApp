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
    func fetchNextPokemonsUrl(with url: String)
}

protocol PokemonListInteractorProtocolOutput: AnyObject {
    func pokemonsDidFetched(_ data: [Pokemon])
}

final class PokemonListInteractor: PokemonListInteractorProtocolInput {
    
    weak var output: PokemonListInteractorProtocolOutput?
    
    var nextPokemonsUrl: String?
    let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    
    func fetchPokemons() {
        networkService.getData(urlStr: baseUrl, expecting: Response.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.pokemonsDidFetched(response.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPokemonBy(id: String) {
        let url = baseUrl + "/\(id)"
        networkService.getData(urlStr: url, expecting: Response.self) { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNextPokemonsUrl(with url: String) {
        networkService.getData(urlStr: url, expecting: Response.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.nextPokemonsUrl = response.next
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
