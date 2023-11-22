//
//  ItemDetail.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//

import SwiftUI

struct FoodDetail: View {
    @State private var showingAlert = false
    @State private var  showingLogin = false
    
    var food: Food
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
                
            ZStack(alignment: .bottom) {
                
                Image(food.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
               
                HStack {
                    VStack( alignment: .leading) {
                        Text(food.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Spacer()
                }//End of HStack
                
            }//End of ZStack
                .listRowInsets(EdgeInsets())
            
            Text(food.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            
            HStack {
                Spacer()
                OrderButton( showAlert: $showingAlert, showLogin: $showingLogin, food: food)
                Spacer()
            }
            .padding(.top, 50)
            
            
            
        } //End of Scroll view
            .edgesIgnoringSafeArea(.top)
    
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Sepete Eklendi"),  dismissButton: .default(Text("Ok")))
        }
         
        }
        

    }

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: foodData.first!)
    }
}

struct OrderButton: View  {
    
    @ObservedObject var basketListener = BasketListener()
 
    @Binding var showAlert: Bool
    @Binding var showLogin: Bool
    var food:Food
    
    var body: some View {
        Button (action:  {
            
            
            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                
                self.showAlert.toggle()
                self.addFoodToBasket()
                
            } else  {
                self.showLogin.toggle()
            }

            
        }) {
            Text("Sepete Ekle")
        }
        .frame(width: 200, height: 50, alignment: .center)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.red)
        .cornerRadius(8)
        .sheet(isPresented: self.$showLogin) {
            
            if FUser.currentUser() != nil {
            FinishRegistrationView()
        } else {
            LoginView()
        }
    }
    
}
    
    private func addFoodToBasket() {
        
      
        var orderBasket: OrderBasket!
        if self.basketListener.orderBasket != nil {
            orderBasket = self.basketListener.orderBasket
        }else {
            orderBasket = OrderBasket()
            orderBasket.ownerId = FUser.currentId()
            orderBasket.id = UUID().uuidString
            
        }
        
    orderBasket.add(self.food)
        orderBasket.saveBasketToFirestore()
    }
}
