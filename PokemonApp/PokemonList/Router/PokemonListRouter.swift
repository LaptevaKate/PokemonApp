//
//  PokemonListRouter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation

protocol PokemonListRouterProtocol: AnyObject {
    func moveToNextScreen()
}

final class PokemonListRouter: PokemonListRouterProtocol {
    
    weak var presenter: PokemonListPresenterProtocol?
  
    
    func moveToNextScreen() {
        //
    }
}
