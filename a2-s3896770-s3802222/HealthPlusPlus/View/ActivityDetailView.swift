//
//  ActivityDetailView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 16/9/2023.
//

import SwiftUI
import CoreData

/// This View displays the ``Exercise`` Info View and  adds bookmark button, which is used to save exercises to favourites
struct ActivityDetailView: View {
    var exercise: Exercise
    @State private var isBookmarked = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showAlert = false
    
    ///    This Function  Saves exercise to CoreDataModel item : FavouriteExercises
    ///  - Parameter input: exercise
    ///  - Returns: The result error is unable to save Exercise
    private func addExercise() {
        // Check if the exercise already exists in CoreData
        let fetchRequest: NSFetchRequest<FavouriteExercises> = FavouriteExercises.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", exercise.name)
        
        do {
            //Check for exercises with the same name in coredata
            let existingExercises = try viewContext.fetch(fetchRequest)
            
            //If exisitingExercise is not found add the exercise to favourites
            if existingExercises.isEmpty {
                
                withAnimation {
                    let newFavExercise = FavouriteExercises(context: viewContext)
                    newFavExercise.id = UUID()
                    newFavExercise.name = exercise.name
                    newFavExercise.type = exercise.type
                    newFavExercise.difficulty = exercise.difficulty
                    newFavExercise.muscle = exercise.muscle
                    newFavExercise.equipment = exercise.equipment
                    newFavExercise.instructions = exercise.instructions
                    
                    do {
                        /*
                         Save all changes made to Core Data                         */
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            } else {
                // Exercise already exists, alert user
                showAlert = true
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    var body: some View {
        ActivityInfoView(exercise: exercise)
            .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    Button(action:{
                        isBookmarked.toggle()
                        if isBookmarked{
                            //Save exercise to coredata
                            addExercise()
                        }
                    }){
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(isBookmarked ? .blue : .gray)
                    }
                    
                }
                
            }
        // Alert User If the exercise they are trying to bookmark is already in favourites
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(""),
                    message: Text("This Exercise is already bookmarked"),
                    dismissButton: .default(Text("OK"))
                )
            }
        
    }
    
    struct ActivityDetailView_Previews: PreviewProvider {
        static var previews: some View {
            ActivityDetailView(exercise: Exercise(
                name: "Jumping Rope",
                type: "Cardio",
                muscle: "Quadriceps",
                equipment: "Body Only",
                difficulty: "Intermediate",
                instructions: "Hold an end of the rope in each hand. Position the rope behind you on the ground. Raise your arms up and turn the rope over your head bringing it down in front of you. When it reaches the ground, jump over it. Find a good turning pace that can be maintained. Different speeds and techniques can be used to introduce variation. Rope jumping is exciting, challenges your coordination, and requires a lot of energy. A 150 lb person will burn about 350 calories jumping rope for 30 minutes, compared to over 450 calories running."
            ))
        }
    }
}
