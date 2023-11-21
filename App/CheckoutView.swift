//
//  CheckoutView.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    static let paymentTypes = ["Nakit", "Kredi Kartı"]
    static let tipAmounts = [10, 15, 20, 0]
    
    @State private var paymentType = 0
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = basketListener.orderBasket.total
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    
    var body: some View {

        Form {
            Section {
                Picker(selection: $paymentType, label: Text("Ödeme Türü Seçin?")) {
                    
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
            }//End of Section
            
            
            Section (header: Text("Kargocuya Bahşiş Ekle?")) {
                
                Picker(selection: $tipAmount, label: Text("Yüzde: ")) {
                    
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0]) %")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }//End of Section
            
            Section(header: Text("Toplam: ₺\(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                
                Button(action: {
                    self.showingPaymentAlert.toggle()
                    self.createOrder()
                    self.emptyBasket()
                    
                }) {
                    Text("Ödemeyi Onayla")
                }
            }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            //End of Section
            
        }//End of form
        .navigationBarTitle(Text("Ödeme"), displayMode: .inline).foregroundColor(.red)
        .alert(isPresented: $showingPaymentAlert) {
                
            Alert(title: Text("Ödeme Onaylandı"), message: Text("Teşekkürler!"), dismissButton: .default(Text("OK")))
        }
    }
    
    
    private func createOrder() {
        let order = Order()
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerId = FUser.currentId()
        order.orderItems = self.basketListener.orderBasket.items
        order.saveOrderToFirestore()
    }
    
    
    private func emptyBasket() {
        self.basketListener.orderBasket.emptyBasket()
    }
    
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
