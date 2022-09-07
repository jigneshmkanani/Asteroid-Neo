//
//  ChartViewController.swift
//  Asteroid-Neo
//
//  Created by Admin on 06/09/2022.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var txtStartDt: UITextField!
    @IBOutlet weak var txtEndDt: UITextField!
    @IBOutlet weak var lblNearest: UILabel!
    @IBOutlet weak var lblFastest: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    
    lazy var viewModel = {
        `ChartViewModel`()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {
        lineChartView.noDataText = "You need to Select date for the chart."
        
        var keyboardView = SelectDateVC(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        keyboardView.delegate = self
        keyboardView.isStart = true
        txtStartDt.inputView = keyboardView
        
        keyboardView = SelectDateVC(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        keyboardView.delegate = self
        keyboardView.isStart = false
        txtEndDt.inputView = keyboardView
    }
    
    func setChart(values: [chartValue]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i].value)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Total Number of Asteroid")
        lineChartDataSet.colors = [NSUIColor.green]//colors
        let data = LineChartData()
        data.addDataSet(lineChartDataSet)
        lineChartView.data = data
    }
    
    func initViewModel() {
        // Reload TableView closure
        viewModel.updateStatatistics = { [weak self] in
            debugPrint("Refresh")
            DispatchQueue.main.async {
                self?.setChart(values: self?.viewModel.TotalAstroid ?? [chartValue]())
                self?.lblFastest.text = "Fastest Asteroid: \(self?.viewModel.FastestAsteroid ?? 0)"
                self?.lblNearest.text = "Closest Asteroid: \(self?.viewModel.ClosestAsteroid ?? 0) KM"
                self?.lblAverage.text = "Average Size of Asteroid: \(self?.viewModel.AverageSizeAstroid ?? 0)"
            }
        }
    }
    
    @IBAction func ClkSubmit(sender: UIButton) {
        // Get feed data
        viewModel.getFeed(startDate: txtStartDt.text ?? "", endDate: txtEndDt.text ?? "")
    }
}

extension ChartViewController : DatePickDelegate {
    func dateSelected(dt : String, isStart: Bool) {
        self.view.endEditing(true)
        if isStart {
            txtStartDt.text = dt
        } else {
            txtEndDt.text = dt
        }
    }
}
