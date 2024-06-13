//
//  ChangeUserDetailView.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 23/8/2023.
//
import SwiftUI

/// This view allows the user to change the Name is that shown on their Profile View
struct ChangeUserDetailView: View {
    
    @State private var editUserName: String = ""
    
    var body: some View {
        VStack{
            TextField("Edit Username", text: $editUserName)
                .textFieldStyle(textBoxStyle())
            Button{
                //Functionality to change username
                UserDefaults.standard.set(editUserName, forKey: "username")
                
            }label: {
                Text("Apply Changes")
            }
            .padding()
        }
        .padding()
    }
    
    

    struct textBoxStyle: TextFieldStyle {
        func _body(configuration: TextField<_Label>) -> some View {
            configuration
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 2)
                )
                .foregroundColor(.black)
                .padding(.horizontal, 10)
        }
    }
    
}
/// This view allows developers to preview the view in developement
struct ChangeUserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUserDetailView()
    }
}
