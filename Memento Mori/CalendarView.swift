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
    @State private var timePassedText = ""
    @State private var timeRemainingText = ""
    let totalWeeks = 4160
    let lifeExpectancyYears = 80
    
    var body: some View {
        VStack {
            headerSection
            
            Spacer()
            
            Text(timePassedText)
            
            ProgressView(value: Double(weeksPassed), total: Double(totalWeeks))
                .progressViewStyle(.linear)
                .tint(.red)
                .padding()
            
            Text(timeRemainingText)
            
            progressText
            
            Spacer()
            
            quoteSection
        }
        .onAppear(perform: calculateTime)
    }
    
    private var headerSection: some View {
        VStack {
            Text("Memento Mori")
                .font(.largeTitle)
            
            Text("Make each day pass with purpose")
                .font(.body)
        }
    }
    
    private var progressText: some View {
        Text("\(weeksPassed)/\(totalWeeks - weeksPassed)")
            .font(.subheadline)
            .padding()
    }
    
    private var quoteSection: some View {
        VStack {
            Text("\"You could leave life right now. Let that determine what you do and say and think.\"")
                .font(.headline)
                .padding()
            
            Text("Marcus Aurelius")
                .font(.subheadline)
                .padding()
        }
    }
    
    private func calculateTime() {
        guard let birthdate = userData.birthdate else { return }
        let calendar = Calendar.current
        let now = Date()
        
        let ageComponents = calendar.dateComponents([.year, .month, .day], from: birthdate, to: now)
        let yearsPassed = ageComponents.year ?? 0
        let monthsPassed = ageComponents.month ?? 0
        let daysPassed = ageComponents.day ?? 0
        
        timePassedText = "You have died \(yearsPassed) years \(monthsPassed) months \(daysPassed) days"
        
        let lifeExpectancyDate = calendar.date(byAdding: .year, value: lifeExpectancyYears, to: birthdate)!
        let remainingComponents = calendar.dateComponents([.year, .month, .day], from: now, to: lifeExpectancyDate)
        let yearsRemaining = remainingComponents.year ?? 0
        let monthsRemaining = remainingComponents.month ?? 0
        let daysRemaining = remainingComponents.day ?? 0
        
        timeRemainingText = "You have \(yearsRemaining) years \(monthsRemaining) months \(daysRemaining) days left"
        
        let weekComponents = calendar.dateComponents([.weekOfYear], from: birthdate, to: now)
        weeksPassed = weekComponents.weekOfYear ?? 0
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(UserData())
    }
}
