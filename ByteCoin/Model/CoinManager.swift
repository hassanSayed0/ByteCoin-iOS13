//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol currencyDelegate{
    func didUpdateCurrency(_ currency: CurrencyModel)
}
struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "2EF90EDE-017E-48BC-ABE2-FAC40E640937"
    var delegate: currencyDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func fetchCurrencyExchange(_ currencyName:String){
        let urlString = "\(baseURL)/\(currencyName)?apikey=\(apiKey)"
        performData(urlString)
    }
    func performData (_ urlString: String){
        if let URL = URL(string: urlString){
            let session = URLSession(configuration: .default)
           let task = session.dataTask(with: URL) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }else
                {
                   
                    if let safeData = data{
                        if let currency = parsJSON(safeData){
                            delegate?.didUpdateCurrency(currency)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    func parsJSON(_ currencyData: Data)->CurrencyModel?{
        let decoder = JSONDecoder()
            do{
                let decodeData = try decoder.decode(CurrencyModel.self, from: currencyData)
               // print(decodeData.asset_id_quote)
                return decodeData
            }
            catch{
                return nil
            }
        
    }
}
