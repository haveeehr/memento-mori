//
//  ContentView.swift
//  Memento Mori
//
//  Created by Javier Fransiscus on 17/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userData = UserData()
    
    var body: some View {
        if userData.birthdate == nil {
            BirthdateInputView()
                .environmentObject(userData)
        } else {
            CalendarView()
                .environmentObject(userData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
