//
//  PokemonListViewController.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol PokemonListViewProtocol: AnyObject {
    
    var presenter: PokemonListPresenterProtocol? { get set }
    
    func configTableView()
    func showError(_ error: Error)
}

final class PokemonListViewController: UIViewController,  PokemonListViewProtocol {
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var presenter: PokemonListPresenterProtocol?
    private var pokemons: [Pokemon]? {
        return Array(RealmManager.manager.objects(Pokemon.self))
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.pokemonViewLoaded()
    }
    
    // MARK: - Methods
    func configTableView() {
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        AlertPresenter.showAlert(message: error.localizedDescription, on: self)
    }
}

// MARK: - extension -  UI
private extension PokemonListViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        navigationItem.title = "Choose Your Pokemon"
    }
}

// MARK: - extension - UITableViewDataSource
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

// MARK: - extension - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let pokemon = pokemons?[indexPath.row] else { return }
        presenter?.pokemonSelected(pokemon, on: self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Available Pokemons"
        }
        return nil
    }
}
