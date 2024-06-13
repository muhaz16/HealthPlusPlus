//
//  FavouriteActivityDetailView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 23/9/2023.
//

import SwiftUI
import CoreData

/// This view displays the information about the selected Favourited ``Exercise``
struct FavouriteActivityDetailView: View {
    var exercise: Exercise
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isDelete = false
    @State private var showAlert = false
    
    func deleteExercise(){
        //Find exercise in coredata with same name
        let fetchRequest: NSFetchRequest<FavouriteExercises> = FavouriteExercises.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", exercise.name)
        
        do{
            //Finds all the exercises that match the name
            let existingExercises = try viewContext.fetch(fetchRequest)
            
            // Loop through and delete all matching exercises
            for exerciseToDelete in existingExercises {
                viewContext.delete(exerciseToDelete)
            }
            
            do {
                /*
                 Save all changes made to Core Data
                 and toggle the alert
                 */
                try viewContext.save()
                showAlert.toggle()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        }catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        
    }
    
    var body: some View {
        /*
         Show information about the exercise
         Adds a alert that tells the user the exercise
         has been removed from the favourites
         Adds the toolbar item to delete the Exercise
         from favourites
         */
        ActivityInfoView(exercise: exercise)
            .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    Button(action:{
                        isDelete.toggle()
                        deleteExercise()
                    }){
                        Image(systemName: "trash")
                            .foregroundColor(isDelete ? .red : .black)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(""),
                        message: Text("This has been removed from favourites"),
                        dismissButton: .default(Text("OK"))
                    )
                }
    }
}

struct FavouriteActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteActivityDetailView(exercise: Exercise(
            name: "Jumping Rope",
            type: "Cardio",
            muscle: "Quadriceps",
            equipment: "Body Only",
            difficulty: "Intermediate",
            instructions: "Hold an end of the rope in each hand. Position the rope behind you on the ground. Raise your arms up and turn the rope over your head bringing it down in front of you. When it reaches the ground, jump over it. Find a good turning pace that can be maintained. Different speeds and techniques can be used to introduce variation. Rope jumping is exciting, challenges your coordination, and requires a lot of energy. A 150 lb person will burn about 350 calories jumping rope for 30 minutes, compared to over 450 calories running."
        ))
    }
}
