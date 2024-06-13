//
//  FavouritesView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 23/8/2023.
//

import SwiftUI

///This view handles display all ``Exercise`` and ``Recipe`` that the users has in their favouritesDataModel
struct FavouritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    ///Fetch All Exercises from FavouriteExercises from the datamodel
    @FetchRequest(entity: FavouriteExercises.entity(), sortDescriptors: []) var favoriteExercises: FetchedResults<FavouriteExercises>
    
    ///Fetch All Recipes from FavouriteExercises from the datamodel
    @FetchRequest(entity: FavoriteRecipe.entity(), sortDescriptors: []) var favoriteRecipes: FetchedResults<FavoriteRecipe>
    
    /// Maps favouriteExercieses from Datamodel to ``Exercise`` Model to be used in displaying the list in the view
    var exercises: [Exercise] {
        favoriteExercises.map { favoriteExercise in
            Exercise(
                name: favoriteExercise.name ?? "",
                type: favoriteExercise.type ?? "",
                muscle: favoriteExercise.muscle ?? "",
                equipment: favoriteExercise.equipment ?? "",
                difficulty: favoriteExercise.difficulty ?? "",
                instructions: favoriteExercise.instructions ?? ""
            )
        }
    }
    
    /// Maps favouriteRecipes from Datamodel to ``Recipe`` Model to be used in displaying the list in the view
    var recipes: [Recipe]{
        favoriteRecipes.map { favoriteRecipe in
            Recipe(
                label: favoriteRecipe.label ?? "",
                image: favoriteRecipe.image ?? URL(string: "")!,
                calories: favoriteRecipe.calories ,
                totalTime: favoriteRecipe.totalTime, 
                ingredientLines: (favoriteRecipe.ingredientLines ?? nil) as! [String]
                )
        }
    }
    
    
    var body: some View {
        VStack{
            // Header
            HStack{
                // Header
                Text("Favourites")
                    .padding(20)
                    .font(.largeTitle)
                    .frame(alignment: .topLeading)
                    .bold()
                Spacer()
            }
            HStack{
                //Display Favourite Exercises and Recipes of User
                navStack
            }
        }
    }
    
    var navStack: some View{
        NavigationStack{
            VStack{
                //Activity Section
                Text("Exercises")
                activitySection
                
                //Split Sections
                Spacer()
                
                //Recipe Section
                Text("Recipes")
                recipeSection
            }
            .padding()
        }
        .padding()
    }
    
    ///View to display the list of Exercises that user has in their favourites
    var activitySection: some View{
        return ScrollView{
            if exercises.isEmpty{
                //Display Placeholder View
                EmptyListPlaceholderViewExerciese()
            }
            //Display List of Exercises in Favourites
            ForEach(exercises, id: \.self) { exercise in
                NavigationLink(destination:
                                FavouriteActivityDetailView(exercise: exercise)) {
                    activityViewList(exercise: exercise)
                    
                }
            }
        }
        
        
    }
    
    ///View to display the list of Recipes that user has in their favourites
    var recipeSection: some View {
        return ScrollView{
            if recipes.isEmpty{
                //Display Placeholder View
                EmptyListPlaceholderViewRecipe()
            }
            //Display List of Recipes in Favourites
            ForEach(recipes, id:\.self) { recipe in
                NavigationLink(destination: FavouriteRecipeDetailView(recipe: recipe)) {
                    recipeViewList(recipe: recipe)
                }
            }
        }
    }
    
    ///Placeholder View to identify to user that there are no exercises in their favourites
    struct EmptyListPlaceholderViewExerciese: View{
        
        var body: some View{
            Text("No favourites exercieses have been added yet.")
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
    
    ///Placeholder View to identify to user that there are no recipes in their favourites
    struct EmptyListPlaceholderViewRecipe: View{
        
        var body: some View{
            Text("No favourites recipes have been added yet.")
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
}

///Displays the view in the development
struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
