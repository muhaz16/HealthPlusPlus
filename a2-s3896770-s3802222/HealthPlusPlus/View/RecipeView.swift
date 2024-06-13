//
//  RecipeView.swift
//  HealthPlusPlus
//
//  Created by Muhammad Hazren Rosdi on 26/8/2023.
//

import SwiftUI

/// Recipe View display and search of ``Recipe``
struct RecipeView: View {
    /// Retrieve the recipes from the API
    class RecipeViewModel: ObservableObject{
        @Published var recipes: [Recipe] = []
        
        // Retrieve recipes from the api
        func retrieveRecipes(query: String = "") async throws {
            let modquery = query.replacingOccurrences(of: " ", with: "%20")
            let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=\(modquery)&app_id=2ece70f2&app_key=10eb213e555a3dd53b92666bd914ff22")!
            
            print(url)

            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            let recipeSearchResults = try decoder.decode(RecipeSearchResult.self, from:data)

            
            DispatchQueue.main.async {
                self.recipes = recipeSearchResults.hits.map{$0.recipe}
            }
        }
    }
    
    @ObservedObject var recipeViewModel = RecipeViewModel()
    @State private var searchText = ""
    @State private var showToolTips: Bool = false
    var toolTips: [ToolTipData] =
    [ToolTipData(text: "Search by recipe name", divider: true),
     ToolTipData(text: "Search by ingredients", divider: false)
    ]
    
    
    var body: some View {
        NavigationStack{
            HStack{
                /*
                 Search field being used for seaching recipe by name or ingredient
                 */
                TextField("Enter recipe name or ingredients", text: $searchText)
                    .padding(.leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Hint label
                VStack{
                    Button {
                        showToolTips.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                            .rotationEffect(.degrees(90))
                    }
                    
                    if showToolTips{
                        VStack{
                            Image(systemName: "chevron.up")
                                .frame(width: 16, height: 6)
                            
                            VStack{
                                ForEach(toolTips) {
                                    toolTips in MenuToolTipView(text: toolTips.text, isDivider: toolTips.divider)
                                }
                            }
                            .frame(width: 220, height: 120)
                            .cornerRadius(12)
                        }.padding(20)
                    }
                }

                // Seach button being used for enter recipe name or ingredients
                Button("Search"){
                    Task {
                        try! await
                        recipeViewModel.retrieveRecipes(query: searchText)
                    }
                }
                .padding()
            }
                // List down all the recipes
            List{
                // If the no recipe found, it will print out "There is no recipe found on the page"
                if recipeViewModel.recipes.isEmpty{
                    Text("There is no recipe found")
                        .font(.headline)
                        .listRowSeparator(.hidden)
                } else {
                    // list each recipe
                    ForEach(recipeViewModel.recipes, id: \.self) { recipe in
                        NavigationLink(destination:
                                        RecipeDetailView(recipe: recipe)){
                            recipeViewList(recipe: recipe)
                        }
                    }
                }
            }
            // Retrieve recipes from the api
            .task {
                try! await recipeViewModel.retrieveRecipes()
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .navigationTitle("Recipe")
            
        }
    }

}

/// Recipe View List  showing the names, calories and the time taken for the recipes
struct recipeViewList: View {
    @State var recipe: Recipe
    
    var body: some View{
        Rectangle()
            .frame(width: 350,height: 125)
            .foregroundColor(.gray)
            .cornerRadius(10)
            .overlay(
                HStack{
                        AsyncImage(url: recipe.image, scale: 2.5)
                            .frame(width: 115, height: 90)
                            .cornerRadius(10)
                            .scaledToFill()
                        
                        VStack{
                            Text(recipe.label)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                                .bold()
                                .foregroundColor(.white)
                            HStack{
                                Text("\(Int(recipe.calories)) cal")
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                                    .padding()
                                    .bold()
                                    .foregroundColor(.white)
                                Text("\(Int(recipe.totalTime)) min")
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomTrailing)
                                    .padding()
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                    .padding(10)
            )
    }
}
        
struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}

/// Displaying the Menu of the tool tips
struct MenuToolTipView: View {
    var text: String
    var isDivider: Bool = false
    var body: some View{
        
        VStack{
            Text(text)
                .fontWeight(.bold)
            if isDivider{
                Divider()
            }
        }
    }
}


/// Tool tips detailed information
struct ToolTipData: Identifiable {
    var text: String
    var divider: Bool
    var id: String = UUID().uuidString
}
