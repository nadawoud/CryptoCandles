//
//  CandlestickChartViewController.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 21/10/2022.
//

import UIKit
import Charts

protocol CandlestickChartDisplayLogic: AnyObject {
    func displayFetchedCandlesticks(_ candlesticks: Candlesticks)
    func displayFetchingError()
}

class CandlestickChartViewController: UIViewController {
    
    @IBOutlet var chartView: CandleStickChartView!
    @IBOutlet var stateView: UIView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    
    var currency = CryptoCurrency.btc
    private var interactor: CandlestickChartBusinessLogic?
    private var state: State = .loading {
        didSet { updateViewState() }
    }
    
    
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
        let interactor = CandlestickChartInteractor()
        let presenter = CandlestickChartPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupChartView()
        state = .loading
        interactor?.fetchChartData(forCurrency: currency)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupNavigation() {
        self.title = currency.rawValue
    }
    
    private func setupChartView() {
        chartView.backgroundColor = UIColor(named: "ChartBackground")
        
        chartView.chartDescription.enabled = false
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        chartView.maxVisibleCount = 100
        
        chartView.legend.horizontalAlignment = .left
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .horizontal
        chartView.legend.drawInside = false
        chartView.legend.font = .systemFont(ofSize: 8)
        chartView.legend.textColor = .lightGray
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.labelFont = .systemFont(ofSize: 10)
        chartView.rightAxis.labelTextColor = .lightGray
        chartView.rightAxis.setLabelCount(6, force: false)
        chartView.rightAxis.axisLineColor = .lightGray
        chartView.rightAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .systemFont(ofSize: 10)
        chartView.xAxis.labelTextColor = .lightGray
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.axisLineColor = .lightGray
    }
    
    private func setChartData(candlesticks: Candlesticks) {
        var candleChartDataEntries = [CandleChartDataEntry]()
        
        for (index, candlestick) in candlesticks.enumerated() {
            let candleEntry = CandleChartDataEntry(x: Double(index),
                                                   shadowH: candlestick[2].asDouble(),
                                                   shadowL: candlestick[3].asDouble(),
                                                   open: candlestick[1].asDouble(),
                                                   close: candlestick[4].asDouble())
            candleChartDataEntries.append(candleEntry)
        }
        
        let dataSet = CandleChartDataSet(entries: candleChartDataEntries, label: currency.rawValue)
        dataSet.setColor(UIColor.lightGray)
        dataSet.drawIconsEnabled = false
        dataSet.decreasingColor = UIColor(red: 255/255, green: 91/255, blue: 91/255, alpha: 1)
        dataSet.decreasingFilled = true
        dataSet.increasingColor = UIColor(red: 0, green: 209/255, blue: 255/255, alpha: 1)
        dataSet.increasingFilled = true
        dataSet.valueTextColor = .lightGray
        
        let data = CandleChartData(dataSet: dataSet)
        chartView.data = data
        chartView.setVisibleXRangeMaximum(25)
    }
    
    private func updateViewState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch self.state {
            case .ready(let candlesticks):
                self.stateView.isHidden = true
                self.activityIndicatorView.stopAnimating()
                self.setChartData(candlesticks: candlesticks)
                
            case .loading:
                self.stateView.isHidden = false
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
                self.errorImageView.isHidden = true
                self.messageLabel.text = "Loading..."
                
            case .error:
                self.stateView.isHidden = false
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
                self.errorImageView.isHidden = false
                self.messageLabel.text = """
                                        Something went wrong!
                                        Try again later.
                                        """
            }
        }
    }
}

extension CandlestickChartViewController: CandlestickChartDisplayLogic {
    func displayFetchedCandlesticks(_ candlesticks: Candlesticks) {
        state = .ready(candlesticks)
    }
    
    func displayFetchingError() {
        state = .error
    }
}

extension CandlestickChartViewController {
    enum State {
        case loading
        case ready(Candlesticks)
        case error
    }
}
