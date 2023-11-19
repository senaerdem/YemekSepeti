//
//  ItemRow.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//

import SwiftUI

struct FoodRow: View {
    
    var categoryName: String
    var foods: [Food]
    
    var body: some View {
        
        VStack(alignment: .leading) {
           
            
            Text(self.categoryName)
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false ) {
                HStack{
                    ForEach(self.foods ) {
                        foods in
                        NavigationLink(destination: FoodDetail(food: foods)) {
                    
                            FoodItem(food: foods)
                        .frame(width:300).padding(.trailing,30)
                
                        }
                    }
                }
            }
            
            
        }
    }
    
    
    
}


struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(categoryName: "Enfes Lezzetler", foods: foodData)
    }
}
