//
//  HealthPlusPlusTests.swift
//  HealthPlusPlusTests
//
//  Created by Lucas Bui on 8/10/2023.
//

import XCTest
import CoreData
@testable import HealthPlusPlus

final class HealthPlusPlusTests: XCTestCase {
    // NOTE: Each of the unit tests must be explained so that its purpose and intent is clear for any future code development.
    
    /* Test 1 : Exercise Search (Regular - Only Search Bar - No Categories Selected)
     This is the most common use case for the exercise search. This test checks that the function delivers the correct response when used in its most common use case. The user will input a keyword or keyphrase intothe search bar and attempt to find exercises related to that keyword or phrase.
    */
    func testExerciseSearchNameQuery(){
        // This test completes by checking that when a search is run, the results are not empty, and that the first item in the array has the same name as they expected value.
        //Arange
        // Create Instance of Activity View
        let sut = ActivityView()
        let execiseViewModel = sut.exerciseViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Fetch Exercises")
        
        //Act
        // Call the fetchExercises function
        execiseViewModel.fetchExercises(withName: "push")
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            
            //Assert
            // Check if array is not empty
            XCTAssertFalse(execiseViewModel.exercises.isEmpty)
            XCTAssertEqual(execiseViewModel.exercises[0].name, "Single-arm kettlebell push-press")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)

    }
        
    
        
    /*Test 2 : Recipe Search (Regular - Search a recipe)
     This is the most common use case for the recipe search. The user will input a keyword or keyphrase into
     the search bar and attempt to find recipes related to that keyword or phrase.
     */
    func testRecipeSearchNameQuery() {
        // This test completes by checking that when a search is run, the results are not empty, and that the first item in array has the same label as expected value
        
        // Create Instance of Recipe View
        let sut = RecipeView()
        let recipeViewModel = sut.recipeViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Retrieve Recipes")
        
        // Call the retrieveRecipes function
        Task{
            try! await recipeViewModel.retrieveRecipes(query: "chicken")
        }
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5){
            
            
            // Assert
            // Check if array is not empty
            XCTAssertFalse(recipeViewModel.recipes.isEmpty)
            XCTAssertEqual(recipeViewModel.recipes[0].label, "Chicken Vesuvio")
            // Fulfill the expectation to indicate that hte async task has completed
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    /*Test 3 : Exercise Search (Difficulty Category Only)*/
    func testExerciseSearchWithDifficultyCategory(){
        // This test completes by checking that when a search is run, the results are not empty, and that the first item in the array has the same name as they expected value.
        
        //Arange
        // Create Instance of Activity View
        let sut = ActivityView()
        let execiseViewModel = sut.exerciseViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Fetch Exercises")
        
        //Act
        // Call the fetchExercises function
        execiseViewModel.fetchExercises(difficulty: "beginner")
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            
            //Assert
            // Check if array is not empty
            XCTAssertFalse(execiseViewModel.exercises.isEmpty)
            XCTAssertEqual(execiseViewModel.exercises[0].name, "Rickshaw Carry")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)
    }
    
    /*Test 4 : Recipe Search (Empty Result)
     This test will check if the Recipe view handles the error of having no results properly.
     */
    func testRecipeSearchEmptyResult() {
        // This test completes by checking that when a search is run, and return an empty result
        
        // Create Instance of Recipe View
        let sut = RecipeView()
        let recipeViewModel = sut.recipeViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Retrieve Recipes")
        
        // Call the retrieveRecipes function
        Task{
            try! await recipeViewModel.retrieveRecipes(query: "")
        }
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5){
            
            
            // Assert
            // Check if array is empty
            XCTAssertTrue(recipeViewModel.recipes.isEmpty)
            // Fulfill the expectation to indicate that hte async task has completed
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    /*Test 5 : Exercise Search (Exercise Type Only)
     */
    func testExerciseSearchWithExerciseTypeQueryOnly(){
        // This test completes by checking that when a search is run, the results are not empty, and that the first item in the array has the same name as they expected value.
        
        //Arange
        // Create Instance of Activity View
        let sut = ActivityView()
        let execiseViewModel = sut.exerciseViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Fetch Exercises")
        
        //Act
        // Call the fetchExercises function
        execiseViewModel.fetchExercises(type: "cardio")
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            
            //Assert
            // Check if array is not empty
            XCTAssertFalse(execiseViewModel.exercises.isEmpty)
            XCTAssertEqual(execiseViewModel.exercises[0].name, "Jumping rope")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)
    }
    
    
    /*Test 6 : Exercise Search (Muscle Group Only)
     */
    func testExerciseSearchWithMuscleGroupQueryOnly(){
        // This test completes by checking that when a search is run, the results are not empty, and that the first item in the array has the same name as they expected value.
        
        //Arange
        // Create Instance of Activity View
        let sut = ActivityView()
        let execiseViewModel = sut.exerciseViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Fetch Exercises")
        
        //Act
        // Call the fetchExercises function
        execiseViewModel.fetchExercises(muscle: "abdominals")
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            
            //Assert
            // Check if array is not empty
            XCTAssertFalse(execiseViewModel.exercises.isEmpty)
            XCTAssertEqual(execiseViewModel.exercises[0].name, "Landmine twist")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)
    }
    
    /*Test 7 : Exercise Search (All Options)
     This is the a common use case for the exercise search. This test checks that the Exercise view hanldes a common use case correctly. The user will input a keyword or keyphrase into the search bar and will use all category options attempt to find exercises related to that keyword or phrase, that is within the catergory options selected.
     */
    func testExerciseSearchWithAllCategories(){
        // This test completes by checking that when a search is run, the results are not empty, and that the first item in the array has the same name as they expected value.
        
        //Arange
        // Create Instance of Activity View
        let sut = ActivityView()
        let execiseViewModel = sut.exerciseViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Fetch Exercises")
        
        //Act
        // Call the fetchExercises function
        execiseViewModel.fetchExercises(withName: "side",muscle: "quadriceps", difficulty: "expert", type: "strength")
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            
            //Assert
            // Check if array is not empty
            XCTAssertFalse(execiseViewModel.exercises.isEmpty)
            XCTAssertEqual(execiseViewModel.exercises[0].name, "Single-arm side deadlift")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)
    }
    
    
    /*Test 8 : Recipe Search (Search By Ingredients)
     This is the most common use case for the recipe search. This test checks that the Recipe view hanldes a common use case correctly. The user will input a number of ingridents into the search bar, either seperated by a "," or blank spaces.
     */
    
    func testRecipeSearchByIngredients(){
        // Create Instance of Recipe View
        let sut = RecipeView()
        let recipeViewModel = sut.recipeViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Retrieve Recipes")
        
        // Call the retrieveRecipes function
        Task{
            try! await recipeViewModel.retrieveRecipes(query: "chicken,carrot")
        }
        
        // wait for amount of time for the API to call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5){
            
            // Check if array is not empty
            XCTAssertFalse(recipeViewModel.recipes.isEmpty)
            // Check if the result is the same as the first label of recipe in the array
            XCTAssertEqual(recipeViewModel.recipes[0].label, "Chicken, carrot & avocado rolls")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled or fail if it times out
        wait(for: [expectation], timeout: 10)
        
    }
    
    /*Test 9 : Exercise Search with Empty Query
     */
    func testExerciseSearchEmptyQuery(){
        // This is the a common use case for the exercise search. This test checks that the Exercise view hanldes a common use case correctly. The API will be called without any query or input.
        
        //Arange
        // Create Instance of Activity View
        let sut = ActivityView()
        let execiseViewModel = sut.exerciseViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Fetch Exercises")
        
        //Act
        // Call the fetchExercises function
        execiseViewModel.fetchExercises()
        
        // Wait for a reasonable amount of time for the API call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            
            //Assert
            // Check if array is not empty
            XCTAssertFalse(execiseViewModel.exercises.isEmpty)
            XCTAssertEqual(execiseViewModel.exercises[0].name, "Rickshaw Carry")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled, or fail if it times out
        wait(for: [expectation], timeout: 10)
    }
    
    /*Test 10 : Recipe Search by Type of Meal
     This is the most common use case for the recipe search. This test checks that the Recipe view hanldes a common use case correctly. The user will input a type of meal into the search bar
     */
    
    func testRecipeSearchByTypeOfMeal(){
        // Create Instance of Recipe View
        let sut = RecipeView()
        let recipeViewModel = sut.recipeViewModel
        
        // Create an expectation for API Call
        let expectation = XCTestExpectation(description: "Retrieve Recipes")
        
        // Call the retrieveRecipes function
        Task{
            try! await recipeViewModel.retrieveRecipes(query: "main")
        }
        
        // wait for amount of time for the API to call to complete
        DispatchQueue.global().asyncAfter(deadline: .now() + 5){
            
            // Check if array is not empty
            XCTAssertFalse(recipeViewModel.recipes.isEmpty)
            // Check if the result is the same as the first label of recipe in the array
            XCTAssertEqual(recipeViewModel.recipes[0].label, "Vibrant Tasty Green Bean ecipes")
            // Fulfill the expectation to indicate that the async task has completed
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled or fail if it times out
        wait(for: [expectation], timeout: 10)
        
    }

}
