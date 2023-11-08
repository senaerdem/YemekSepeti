//
//  ContentView.swift
//  App
//
//  Created by Sena Nur Erdem  on 03.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    
    @ObservedObject var itemListener = ItemListener()
    @State private var showingBasket = false
    
 
    var categories: [String : [Food]] {
       
        .init(
          
            grouping:  itemListener.items,
            by: {$0.category.rawValue}
                
        )
    }
    
    
    var body: some View {
      
              
      
        
        NavigationView {
            

            List(categories.keys.sorted(), id: \String.self) {
                key in
                
                FoodRow(categoryName: "Enfes Lezzetler".uppercased(), foods: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom).foregroundColor(.purple)
                    
                
            }
             
            
            .navigationBarTitle(Text("Yemek Sepetim"))
         
            
                .navigationBarItems(leading:
                                        Button(action: {
                                            
                                            FUser.logOutCurrenUser {
                                                (error) in
                                                print("error loging out user, ", error?.localizedDescription)
                                            }
                                            
                                        },label: {
                                            Text("Çıkış")
                                                .foregroundColor(.orange)
                                        }), trailing:
                                        
                                            Button(action: {
                                                self.showingBasket.toggle()
                                            },label: {
                                               Image("basket")
                                            })
                                            .sheet(isPresented: $showingBasket) {
                                                
                                                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                                                    
                                                    OrderBasketView()
                                                } else if FUser.currentUser() != nil {
                                                    FinishRegistrationView()
                                                } else {
                                                    LoginView()
                                                        
                                                }
                                        }
                                    
                                    )
                                }
                            }
                        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
