//
//  ProfileView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 21/8/2023.
//

import SwiftUI

/// View that displays user information
struct ProfileView: View {
    // MARK: THIS PAGE COULD BE REMOVED AS IT DOES NOT BRING ANY VALUE TO THE APP
    @State private var isActive: Bool = false
    
   @AppStorage("username") private var username = "User"
    
    var body: some View {
        VStack(alignment:.leading){
            //Profile Header
            Text("Profile")
                .font(.largeTitle)
                .bold()
                .padding()
            //User Image + User Name
            HStack{
                Image(systemName:"person.crop.circle")
                    .font(.system(size: 40))
                Text(username)
                    .font(.title)
                    .fontWeight(.regular)
            }
            
            NavigationStack{
                Form{
                    UserDetails
                    
                }
                
            }
            
            
        }
    }
    
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
    
    
    var UserDetails: some View {
        // Send User to view to change name field
        Section{
            NavigationLink{
                ChangeUserDetailView()
            } label: {
                Text("Change Username")
            }
            
        } header: {
                Text("User Details")
        }
        
    }
    
    
    
}
