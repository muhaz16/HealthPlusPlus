//
//  NavigationView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 25/8/2023.
//
import SwiftUI

/// This view handles the navigation to different views
struct NavigationView: View {
    var body: some View {
        TabView{
            //Navigate to Activity View
            ActivityView()
                .tabItem{
                    Label("Activites", systemImage: "dumbbell.fill")
                }
            //Navigate to Recipe View
            RecipeView()
                .tabItem{
                    Label("Recipe",systemImage: "laurel.leading")
                }
            //Navigate to Favourites View
            FavouritesView()
                .tabItem{
                    Label("Favourites",systemImage: "star.fill")
                }
            //Navigate to Profile View
            ProfileView()
                .tabItem{
                    Label("Profile",systemImage: "person.fill")
                }
        }
    }
}

///Display view in developement Mode
struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
