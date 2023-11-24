//
//  OrderBasketView.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//

import SwiftUI

struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
  
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(self.basketListener.orderBasket?.items ?? []) {
                        item in
                        HStack {
                            Text (item.name)
                            Spacer()
                            Text("$\(item.price.clean) ")
                        }//Hstack
                    }//fore
                    .onDelete {(indexSet) in
                        self.deleteItems(at: indexSet)
                    }
                }
                Section{
                    NavigationLink(
                        destination: CheckoutView()){
                            Text("Öde")
                        }
                    Text ("Yemek Sepetim")
                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            }//List
            .navigationBarTitle("Ödeme Sistemi").foregroundColor(.red)
            .listStyle(GroupedListStyle())
            
        }//N v
        
    }
    func deleteItems(at offsets: IndexSet){
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderBasketView()
            OrderBasketView()
        }
    }
}
