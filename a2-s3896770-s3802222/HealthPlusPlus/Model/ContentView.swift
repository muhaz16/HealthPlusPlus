//
//  ContentView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 15/8/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
       let persistenceController = PersistenceController.shared
    
    var body: some View {
        WelcomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}



