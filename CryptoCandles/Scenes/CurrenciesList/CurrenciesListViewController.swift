//
//  CurrenciesListViewController.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import UIKit

protocol CurrenciesListDisplayLogic: AnyObject {
    func displayCurrencies(_ currencies: [CryptoCurrency])
}

class CurrenciesListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var currencies = [CryptoCurrency]()
    
    var interactor: CurrenciesListBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = CurrenciesListInteractor()
        let presenter = CurrenciesListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getCurrencies()
        setupTableView()
        FirebaseManager.shared.logFirebaseAnalyticsEvent(title: "CurrenciesList Screen", description: "CurrenciesList Screen did load.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
    }
}

extension CurrenciesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as? CurrencyCell else { return CurrencyCell() }
        cell.currencyLabel.text = currencies[indexPath.item].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chartViewController = storyboard?.instantiateViewController(withIdentifier: CandlestickChartViewController.identifier) as? CandlestickChartViewController else { return }
        chartViewController.currency = currencies[indexPath.item]
        FirebaseManager.shared.logFirebaseAnalyticsEvent(title: "Currency Selected", description: "Did select a currency from CurrenciesList Screen.")
        navigationController?.pushViewController(chartViewController, animated: true)
    }
}

extension CurrenciesListViewController: CurrenciesListDisplayLogic {
    func displayCurrencies(_ currencies: [CryptoCurrency]) {
        self.currencies = currencies
        tableView.reloadData()
    }
}
