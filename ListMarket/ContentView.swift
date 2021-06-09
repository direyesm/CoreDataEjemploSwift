//
//  ContentView.swift
//  ListMarket
//
//  Created by Diego on 06-06-21.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State private var itemTitulo: String = ""
    
    @State var show = false
    
    @State private var market: [Market] = [Market]()
    @State private var needsRefresh: Bool = false
    
    private func populateItem(){
        market = coreDM.getAllItem()
    }
    var body: some View {
        NavigationView{
            VStack{
            HStack(spacing: 10){
                TextField("Ingresa el producto", text: $itemTitulo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {coreDM.saveItem(item: itemTitulo)
                    populateItem()
                } , label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.black)
                })
                .padding()
                .background(Color.white)
            }

            List {
                ForEach(market, id: \.self) {market in
                    
                NavigationLink(
                    destination: MarketDeatails(market: market, coreDM: coreDM, needsRefresh: $needsRefresh),
                    label: {
                        Text(market.item ?? "")
                    })
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach{ index in
                        let markets = market[index]
                        coreDM.deleteItem(markets: markets)
                        populateItem()
                    }
                })
            }.listStyle(PlainListStyle())
            .accentColor(needsRefresh ? .white: .black )
            Spacer()
               
        }.padding()
        .navigationTitle("Lista de Compras")
        
        .onAppear(perform: {
            populateItem()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
