//
//  MarketDeatails.swift
//  ListMarket
//
//  Created by Diego on 09-06-21.
//

import SwiftUI

struct MarketDeatails: View {
    
    let market: Market
    @State private var marketName: String = ""
    let coreDM: CoreDataManager
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            TextField(market.item ?? "", text: $marketName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Actualizar") {
                if !marketName.isEmpty {
                    market.item = marketName
                    coreDM.updateItem()
                    needsRefresh.toggle()
                }
            }
            }
    }
}

struct MarketDeatails_Previews: PreviewProvider {
    static var previews: some View {
        
        let market = Market()
        let coreDM = CoreDataManager()
        
        MarketDeatails(market: market, coreDM: coreDM, needsRefresh: .constant(false))
    }
}
