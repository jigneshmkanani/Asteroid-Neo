//
//  SelectDateVC.swift
//  Asteroid-Neo
//
//  Created by Admin on 07/09/2022.
//

import UIKit
protocol DatePickDelegate {
    func dateSelected(dt : String, isStart: Bool)
}

class SelectDateVC: UIView {
    var delegate: DatePickDelegate?
    var isStart: Bool! = false
    @IBOutlet weak var datePicker : UIDatePicker!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        self.backgroundColor = .yellow
        let xibFileName = "SelectDateVC"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
    }
    
    @objc func handleDateSelection() {
        
    }
    
    @IBAction func ClkDone() {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        self.delegate?.dateSelected(dt: formater.string(from: datePicker.date), isStart: isStart)
    }
}
