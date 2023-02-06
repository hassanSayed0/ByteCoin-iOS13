//
//  CurrencyModel.swift
//  ByteCoin
//
//  Created by hassan on 06/02/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
struct CurrencyModel: Decodable
{
    let asset_id_quote : String
    let rate : Double
}
