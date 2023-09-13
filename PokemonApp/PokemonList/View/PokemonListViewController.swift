//
//  PokemonListViewController.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol PokemonListViewControllerProtocol: AnyObject {

    var presenter: PokemonListPresenterProtocol? {get set}
    func configTableView()
}

final class PokemonListViewController: UIViewController,  PokemonListViewControllerProtocol {
    
    // MARK: - Properties

    var presenter: PokemonListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    func configTableView(){
        //
    }
   
}

