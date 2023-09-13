//
//  PokemonListViewController.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol PokemonListViewProtocol: AnyObject {
    var presenter: PokemonListPresenterProtocol? { get set }
    func configTableView(with data: [Pokemon])
}

final class PokemonListViewController: UIViewController,  PokemonListViewProtocol {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var presenter: PokemonListPresenterProtocol?
    private var pokemons: [Pokemon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }

    func configTableView(with data: [Pokemon]) {
        pokemons = data
        tableView.reloadData()
    }
}

// MARK: - UI
private extension PokemonListViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemons else { return UITableViewCell() }
        let pokemon = pokemons[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = pokemon.name
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
}
