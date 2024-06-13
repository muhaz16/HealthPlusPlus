//
//  ActivityView.swift
//  HealthPlusPlus
//
//  Created by Muhammad Hazren Rosdi on 26/8/2023.
//

import SwiftUI

/// This view handles display and search of ``Exercise``
struct ActivityView: View {
    class ExerciseViewModel: ObservableObject {
        @Published var exercises: [Exercise] = []
        
        init() {
            fetchExercises()
        }
        
        let headers = [
            "X-RapidAPI-Key": "1de43d2636msh023124cd7bdbde3p102248jsnc87b9220ded0",
            "X-RapidAPI-Host": "exercises-by-api-ninjas.p.rapidapi.com"
        ]
        
        /// This function calls the Exercise API and returns a list of exercises and their details
        ///  - Parameter input: name , muscle group, difficulty, exercise type
        ///  - Returns: List of ``Exercise`` with selected query results
        func fetchExercises(withName name: String? = nil, muscle: String? = nil, difficulty: String? = nil, type: String? = nil) {
            guard var components = URLComponents(string: "https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises") else { return }

            /*
             Add the query parameter for the name if it's not nil
             */
            if let name = name {
                components.queryItems = [URLQueryItem(name: "name", value: name)]
            }
            /*
             Add the query parameter for the muscle if it's not nil and selected muscle is not the all option
             */
            if let muscle = muscle, !muscle.isEmpty, muscle.lowercased() != "all" {
                components.queryItems?.append(URLQueryItem(name: "muscle", value: muscle))
            }

            /*
             Add the query parameter for the difficulty if it's not nil and if selected difficulty is not none option
             */
            if let difficulty = difficulty, !difficulty.isEmpty, difficulty.lowercased() != "all" {
                components.queryItems?.append(URLQueryItem(name: "difficulty", value: difficulty))
            }
            
            /*
             Add the query parameter for the execise type if it's not nil and if selected exercise type is not all option
             */
            // MARK: Check if type is not empty and value is not all
            if let type = type, !type.isEmpty, type.lowercased() != "all" {
                components.queryItems?.append(URLQueryItem(name: "type", value: type))
            }


            guard let url = components.url else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let exercises = try decoder.decode([Exercise].self, from: data)

                        DispatchQueue.main.async {
                            self.exercises = exercises
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }

        
        
    }
    
    @ObservedObject var exerciseViewModel = ExerciseViewModel()
    @State private var searchText = ""
    @State private var selectedExerciseType = "all"
    @State private var selectedDifficultyType = "all"
    @State private var selectedMuscle = "all"
    
    ///Category Options for Muscle Groups
    var muscleOptions = [
        ("Muscle Group", "all"),
        ("Abdominals", "abdominals"),
        ("Abductors", "abductors"),
        ("Adductors", "adductors"),
        ("Biceps", "biceps"),
        ("Calves", "calves"),
        ("Chest", "chest"),
        ("Forearms", "forearms"),
        ("Glutes", "glutes"),
        ("Hamstrings", "hamstrings"),
        ("Lats", "lats"),
        ("Lower Back", "lower_back"),
        ("Middle Back", "middle_back"),
        ("Neck", "neck"),
        ("Quadriceps", "quadriceps"),
        ("Traps", "traps"),
        ("Triceps", "triceps")
    ]
    ///Category Options for Exercise Difficulty
    var difficultyOptions = [
        ("Difficulty","all"),
        ("Beginner","beginner"),
        ("Intermediate","intermediate"),
        ("Expert","expert")
    ]

    ///Category Options for Exercise Type
    var exerciseTypeOptions = [
        ("Exercise Type","all"),
        ("Cardio","cardio"),
        ("Olympic Weightlifting","olympic_weightlifting"),
        ("Plyometrics","plyometrics"),
        ("Powerlifting","powerlifting"),
        ("Strength","strength"),
        ("Stretching","stretching"),
        ("Strongman","strongman")
    ]

    
    var body: some View {
        NavigationStack{
            /*
             Search Field to be used for searching exercise by name
             */
            TextField("Enter exercise name", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: searchText) { newName in
                    // When the searchName changes, trigger the API request
                    
                    exerciseViewModel.fetchExercises(withName: newName, muscle: selectedMuscle,difficulty: selectedDifficultyType,type: selectedExerciseType)
                }
            HStack{
                Spacer()
                /*
                 Drop Down Menu to select muscle type
                 */
                Picker("Muscle", selection: $selectedMuscle) {
                    ForEach(muscleOptions, id: \.1) { optionLabel, optionValue in
                        Text(optionLabel).tag(optionValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedMuscle) { newMuscle in
                        // Call your fetchExercises function here with the newMuscle value
                    exerciseViewModel.fetchExercises(withName:searchText, muscle: newMuscle, difficulty: selectedDifficultyType,type: selectedExerciseType)
                }

                
                Spacer()
                /*
                 Drop Down Menu to sort activities by exercise type
                 */
                Picker("Exercise Type", selection: $selectedExerciseType) {
                    ForEach(exerciseTypeOptions, id: \.1) { optionLabel, optionValue in
                        Text(optionLabel).tag(optionValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedExerciseType) { newType in
                        // Call your fetchExercises function here with the newType value
                    exerciseViewModel.fetchExercises(withName:searchText,muscle: selectedMuscle,difficulty: selectedDifficultyType,type: newType)
                }
                
                
                Spacer()
                /*
                 Drop Down Menu to select exercise difficulty type
                 */
                Picker("Difficulty", selection: $selectedDifficultyType) {
                    ForEach(difficultyOptions, id: \.1) { optionLabel, optionValue in
                        Text(optionLabel).tag(optionValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedDifficultyType) { newDifficulty in
                        // Call your fetchExercises function here with the newDifficulty value
                    exerciseViewModel.fetchExercises(withName:searchText,muscle: selectedMuscle,difficulty: newDifficulty,type: selectedExerciseType)
                }

                Spacer()
                
            }
            
            Spacer()
            
            ScrollView{
                //Display list of exercises
                ForEach(exerciseViewModel.exercises, id: \.id) { exercise in
                NavigationLink(destination: ActivityDetailView(exercise: exercise)) {
                    activityViewList(exercise: exercise)
                }
            }
            }
        }
        //if an exercise is not able to be found that is similar to the search query then a overlay will be shown to the user to notify them
        .overlay{
            if exerciseViewModel.exercises.isEmpty, !searchText.isEmpty{
                EmptyListPlaceholderView(text: searchText)
            }
        }
        
    }
}

// View to notify to the user that a Exercise could not be found with their search text
struct EmptyListPlaceholderView: View{
    let text: String
    var body: some View{
        VStack{
            Image(systemName: "magnifyingglass")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
            Text("No results found for \(text)")
                .foregroundColor(.black)
                .font(.headline)
            Text("Please check the spelling or try a new search")
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
}

///View to preview the Activity View in Development
struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}

/// View that displays the list of ``Exercise``
struct activityViewList: View {
    @State var exercise: Exercise
    
    var body: some View {
        Rectangle()
            .frame(width: 350,height: 125)
            .foregroundColor(.gray)
            .cornerRadius(10)

            .overlay(
                HStack{
                    VStack{
                        Text(exercise.name)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text("Difficulty : \(exercise.difficulty.capitalized)")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                            .bold()
                            .foregroundColor(.white)
                    }
                    Spacer()

                    
                }
            )
        
    }
}
