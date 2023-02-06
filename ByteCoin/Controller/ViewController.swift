//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var coinManager = CoinManager()
    @IBOutlet weak var pickerCurrency: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        pickerCurrency.delegate = self
        pickerCurrency.dataSource = self 
    }

    
}
//MARK: - uipicker
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchCurrencyExchange(coinManager.currencyArray[ row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
}
extension ViewController: currencyDelegate {
    func didUpdateCurrency(_ currency: CurrencyModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = currency.asset_id_quote
            self.priceLabel.text = String(format: "%.3f", currency.rate)
        }
    }
}
