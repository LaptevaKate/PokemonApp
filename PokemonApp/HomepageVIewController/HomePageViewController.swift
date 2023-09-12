//
//  ViewController.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol HomePageViewProtocol: AnyObject {
    var configurator: HomePageConfigurator { get }
    var presenter: HomePagePresenterProtocol? {get set}
    func configTableView()
}

final class HomePageViewController: UIViewController, HomePageViewProtocol {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var pokemonsTableView: UITableView!
    
    // MARK: - Properties
    let configurator: HomePageConfigurator = HomePageConfigurator()
    var presenter: HomePagePresenterProtocol?
    var pokemonsList = [Pokemons]()
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter?.configureView()
    }
    
    func configTableView() {
        //
    }
    
}

// MARK: - UITableViewDataSource
extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


// MARK: - UITableViewDelegate
extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.itemSelected()
    }
}
