//
//  ActivityInfoView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 23/9/2023.
//

import SwiftUI

/// This view displays the information of ``Exercise``
struct ActivityInfoView: View {
    var exercise: Exercise

    // Function to split instructions into sentences
    func splitInstructionsIntoSentences(_ instructions: String) -> [String] {
        return instructions.components(separatedBy: ".")
            .filter { !$0.isEmpty }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Display exercise details
                ExerciseDetailRow(title: "Type", value: exercise.type.capitalized)
                ExerciseDetailRow(title: "Difficulty", value: exercise.difficulty.capitalized)
                ExerciseDetailRow(title: "Muscle", value: exercise.muscle.capitalized)
                ExerciseDetailRow(title: "Equipment", value: exercise.equipment.capitalized)

                Spacer()
                // Instructions
                Text("Instructions")
                    .font(.title)
                    .fontWeight(.bold)

                // Split and display instructions by sentences
                ForEach(splitInstructionsIntoSentences(exercise.instructions), id: \.self) { sentence in
                    Text(sentence)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .navigationBarTitle(exercise.name)
    }
    
    struct ExerciseDetailRow: View {
        var title: String
        var value: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
    
    struct ActivityInfoView_Previews: PreviewProvider {
        static var previews: some View {
            ActivityInfoView(exercise: Exercise(
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

