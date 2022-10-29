//
//  CandlestickChartViewController.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 21/10/2022.
//

import UIKit
import Charts

protocol CandlestickChartDisplayLogic {
    func displayFetchedCandlesticks(_ candlesticks: Candlesticks)
}

class CandlestickChartViewController: UIViewController {
    
    @IBOutlet var chartView: CandleStickChartView!
    
    var currency = CryptoCurrency.btc
    private var candlesticks = Candlesticks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupChartView()
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
    
    private func setChartData() {
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
}

extension CandlestickChartViewController: CandlestickChartDisplayLogic {
    func displayFetchedCandlesticks(_ candlesticks: Candlesticks) {
        setChartData()
    }
}
