//
//  WelcomeView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 22/8/2023.
//

import SwiftUI


/// This view is the first Screen of the Application. It is the Welcome view that users will see on opening the application
struct WelcomeView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    //Display Logo
                    Logo()
                    
                    //Navigate Users to next view
                    NavigationLink{
                        NavigationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack{
                            Text("Get Started")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 144, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .padding(.top,120)
                }
            }
            .padding(.bottom, 80)
            
        }
        
    }
}

///Display view in development
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
