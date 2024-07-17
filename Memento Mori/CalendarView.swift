//
//  CalendarView.swift
//  Memento Mori
//
//  Created by Javier Fransiscus on 17/07/24.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var userData: UserData
    @State private var weeksPassed = 0
    let totalWeeks = 4160
    
    var body: some View {
        VStack {
            Text("You could leave life right now. Let that determine what you do and say and think.")
                .padding()
            
            ProgressView(value: Double(weeksPassed), total: Double(totalWeeks))
                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                .padding()
            
            Text("\(weeksPassed) weeks have passed")
                .font(.subheadline)
                .padding()
        }
        .onAppear {
            calculateWeeksPassed()
        }
    }
    
    func calculateWeeksPassed() {
        guard let birthdate = userData.birthdate else { return }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekOfYear], from: birthdate, to: Date())
        weeksPassed = components.weekOfYear ?? 0
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(UserData())
    }
}
