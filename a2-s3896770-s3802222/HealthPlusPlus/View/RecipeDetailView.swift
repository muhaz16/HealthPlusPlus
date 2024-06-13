//
//  RecipeDetailView.swift
//  HealthPlusPlus
//
//  Created by Muhammad Hazren Rosdi on 24/9/2023.
//

import SwiftUI
import CoreData

/// Recipe Detail View displays the ``Recipe`` detailed information and adds bookmark button, which is used to save recipe to favourites
struct RecipeDetailView: View {
    
    @State var recipe: Recipe
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isBookmarked = false
    @State private var showAlert = false
    
    // Function to save recipe to the CoreDataModel item: FavouriteRecipe
    /// Add the ``recipe`` to the core data for the favoriteRecipe
    private func addRecipe() {
        // Check if the recipe already exist in the CoreData
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "label == %@", recipe.label)
        
        do{
            // Check for recipe with the same name in CoreData
            let existingRecipes = try viewContext.fetch(fetchRequest)
            
            // If the existingRecipes is not found add the recipe to favourites
            if existingRecipes.isEmpty {
                withAnimation{
                    let newFavRecipe = FavoriteRecipe(context: viewContext)
                    newFavRecipe.label = recipe.label
                    newFavRecipe.image = recipe.image
                    newFavRecipe.calories = recipe.calories
                    newFavRecipe.totalTime = recipe.totalTime
                    newFavRecipe.ingredientLines = recipe.ingredientLines as NSObject
                    
                    do {
                        // Save all changes made to CoreData
                        
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            } else {
                // Recipe already exist, alert user
                showAlert = true
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        ScrollView{
            
            AsyncImage(url: recipe.image)
            
            VStack(alignment: .leading){
                HStack{
                    Text(recipe.label)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button(action:{
                        isBookmarked.toggle()
                        if isBookmarked {
                            // Save recipe to coreData
                            addRecipe()
                        }
                    }) {
                        Image(systemName: isBookmarked ? "bookmark.fill":"bookmark")
                            .foregroundColor(isBookmarked ? .blue : .gray)
                    }
                    .alert(isPresented: $showAlert){
                        Alert(
                            title: Text(""),
                            message: Text("This recipe is already bookmarked"),
                            dismissButton: .default(Text("OK")))
                    }
                }
                .padding(10)


                
                VStack(alignment: .leading){
                    Text("Information:")
                        .font(.title2)
                    Text("Calories: \(Int(recipe.calories)) cal")
                    Text("Time: \(Int(recipe.totalTime)) min")
                }
                .padding(10)
                
                VStack(alignment: .leading){
                    Text("Ingredient: ")
                        .font(.title2)
                    ForEach(0..<recipe.ingredientLines.count, id:\.self) { ingredient in
                        Text(recipe.ingredientLines[ingredient])
                    }
                }
                .padding(10)

            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(
            label: "Chicken Vesuvio",
            image: URL(string: "https://edamam-product-images.s3.amazonaws.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEHwaCXVzLWVhc3QtMSJGMEQCIFnqqFCgi4yUX0zvNG596mo8NljkIyUNI%2F%2B9MLyGunieAiA1ezFVos6Gg7AnFleM0L3lYG3Iiv5JwcNFjuiIVvEYwSq5BQh1EAAaDDE4NzAxNzE1MDk4NiIM3DGocO%2FjkEJhuSQOKpYFack5WP7vka6gH8a8RVeLOHkRxKDtKM9mY%2BUWE16ZYWL%2FKS%2BXdA04yw2yuqXXYQml16YB1njyU%2BGlq3R%2B%2FBsiuYujeEpwagYumGueQYfQPgz9LMJFxaATl%2BMaAWjCc1rzCStgnxuhGJelRYecpDqMdKIYKMdTa9YfbhOJmVJoxXHbh52LmOTaDe3GDEYt69O%2Bgny0ZGTzwZy1KjHS9jDHL4q3TV2fAD662Ka%2Fuh5J0%2BzUlXsWe3w1cmaa6znFD6RST1vRVHS2goN3CMkMAgiKiMuzd59JVouNuY6dNu64BLADNvgmENUMY3p5QnuRdvq6M%2FJJSa71aCwsZ8v1LX%2FOexJpViejd0haaOkqbL8EFopB6Uoi%2F5mDwfSmcy0SJ4e1A9%2FtAPzVcEEy%2BQdUkDc2wIRnXj65ZMQvZBu03XM7wLteKgL8ChyN%2Fyrvt2hIXWf%2Fx14BI8Ml9lJjJ1CYNa0Fc%2BcOyPnRHgfKXzXKK9m%2FxSicHHA1xQz5fYzmrh66JdqaSiBxMqTrLlfkA%2BGFzYJZzrY4R%2BZYLvgW6esce6FVywyI7qk99fzau%2FR74mgyp9jv%2BvXYo3UPeQIxG8rBRK5wm9hI7isMjEGxeg7TpjPHiYTbF7WFfIZsKKnmGJEvQ2R229Bp99sHyoT%2F4wsDHp65BVK9GISBR9qQo%2FnFOlBDbU%2BR9HR823OdrRLAdgBbkvWD7o2nG%2Bxmk3cTx6K54NcxMUA%2F%2FzpnjendO9gdOiD6e74%2B5qwaMXwOwAwUtU5je92e62VlidmF5gSSCk%2Fov0AVuMcCo4fTwVdAXTK3POBcQ6v2yhAnLP0Fbzu8qlGnZ6%2FMRdkJ16ugoByEjLxGEVJTIQKIG5ieB%2FCWXt2qDN1iL5J%2F3BOkBrIwiIrLqAY6sgGDATgOHblr60cjgFyeiSblVvd0i24Sh6cz2zBu%2BfDh9jdyxWbEEzbqKJsW%2BCovFzsuVuD8p4Ncyn2eHPWREyUvlkJu2ol2zpj88qdhaRg%2F9518%2BngSn7OoYCadfakU%2BxndurN1GKEWJ%2F6iJqqTViuWLATKOIic5OncLx2POCM6F1qdAAVY9844q2ydwuKrtLK%2FYOZERfUxyIiKXXujVllLF25ke5mg2Nix6Vm67s6vuODD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230926T125411Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFNXUUTCEQ%2F20230926%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=f842c1e46cd633e9c328c9ebf303078d6125993b570985dfd86f3b84a7d941b8")!,
            calories: 4228.043058200812,
            totalTime: 60.0,
            ingredientLines: [
                "1/2 cup olive oil",
            "5 cloves garlic, peeled",
            "2 large russet potatoes, peeled and cut into chunks",
            "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
            "3/4 cup white wine",
            "3/4 cup chicken stock",
            "3 tablespoons chopped parsley",
            "1 tablespoon dried oregano",
            "Salt and pepper",
            "1 cup frozen peas, thawed"
                         ]
        ))
    }
}

