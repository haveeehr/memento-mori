//
//  BirthDateInputView.swift
//  Memento Mori
//
//  Created by Javier Fransiscus on 17/07/24.
//

import SwiftUI

struct BirthdateInputView: View {
    @EnvironmentObject var userData: UserData
    @State private var birthdate = Date()
    
    var body: some View {
        VStack {
            Text("Enter your birthdate:")
                .font(.title)
                .padding()
            
            DatePicker("", selection: $birthdate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            Button(action: {
                userData.birthdate = birthdate
            }) {
                Text("Save")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct BirthdateInputView_Previews: PreviewProvider {
    static var previews: some View {
        BirthdateInputView()
            .environmentObject(UserData())
    }
}
