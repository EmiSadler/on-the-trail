import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/emily/Code/On-The-Trail/On-The-Trail Watch App/ContentView.swift", line: 1)
//
//  ContentView.swift
//  on_the_trail
//
//  Created by Emily Sadler on 25/02/2025.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var healthManager = HealthManager() // Distance walked so far from Health Manager
    let goalDistance: Double = 343.0 // Distance from London to Paris
    
    var progress: Double {
        healthManager.totalDistance / goalDistance
    }
    
    //Percentage complete
    var body: some View {
        VStack(spacing: __designTimeInteger("#8858_0", fallback: 10)) {
            if progress >= __designTimeFloat("#8858_1", fallback: 1.0) {
                // Celebration message
                Text(__designTimeString("#8858_2", fallback: "Congratulations! You've made it!"))
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .padding(.bottom, __designTimeInteger("#8858_3", fallback: 20))
                    .transition(.opacity)
                    .animation(.easeIn(duration: __designTimeInteger("#8858_4", fallback: 1)), value: progress)
            } else {
                // Progress message
                Text("You are \(Int(progress * __designTimeInteger("#8858_5", fallback: 100)))% there!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, __designTimeInteger("#8858_6", fallback: 100))
            }
//            //Flag Poles
//            HStack {
//            Rectangle()
//                .frame(height: 60)
//                .foregroon    undColor(.brown)
//                .padding(.horizontal, 100)
//            }
            //Progress Bar with Walking person
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: __designTimeInteger("#8858_7", fallback: 3))
                    .foregroundColor(.gray)
                    .padding(.horizontal, __designTimeInteger("#8858_8", fallback: 60))
                
                // Flag at the start (London)
                Image(__designTimeString("#8858_9", fallback: "flag-uk"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: __designTimeInteger("#8858_10", fallback: 60), height: __designTimeInteger("#8858_11", fallback: 60))
                    .scaleEffect(__designTimeFloat("#8858_12", fallback: 1.0) - (progress * __designTimeFloat("#8858_13", fallback: 0.5))) // Shrinks from 100% to 50%
                    .position(x: __designTimeInteger("#8858_14", fallback: 67), y: __designTimeInteger("#8858_15", fallback: -48))
                
                // Flag at the end (Paris)
                Image(__designTimeString("#8858_16", fallback: "flag-france"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: __designTimeInteger("#8858_17", fallback: 60), height: __designTimeInteger("#8858_18", fallback: 60))
                    .scaleEffect(__designTimeFloat("#8858_19", fallback: 0.5) + (progress * __designTimeFloat("#8858_20", fallback: 0.5))) // Grows from 50% to 100%
                    .position(x: __designTimeInteger("#8858_21", fallback: 207), y: __designTimeInteger("#8858_22", fallback: -48))
                
                //Moving the person based on percentage travelled
                Image(__designTimeString("#8858_23", fallback: "blue-figure"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: __designTimeInteger("#8858_24", fallback: 60), height: __designTimeInteger("#8858_25", fallback: 60))
                    .position(x: CGFloat(progress) * __designTimeInteger("#8858_26", fallback: 240) + __designTimeInteger("#8858_27", fallback: 47), y: __designTimeInteger("#8858_28", fallback: -8))
            }
            .frame(width: __designTimeInteger("#8858_29", fallback: 280), height:__designTimeInteger("#8858_30", fallback: 40))
            // Labels for start and end points
            HStack {
                Text(__designTimeString("#8858_31", fallback: "London"))
                    .foregroundColor(.white)
                    .padding(.horizontal, __designTimeInteger("#8858_32", fallback: 40))
                Spacer()
                Text(__designTimeString("#8858_33", fallback: "Paris"))
                    .foregroundColor(.white)
                    .padding(.horizontal, __designTimeInteger("#8858_34", fallback: 40))
            }
            .font(.caption)
            .frame(width: __designTimeInteger("#8858_35", fallback: 280))
            
            // Distance info
            Text("\(Int(healthManager.totalDistance))km / \(Int(goalDistance))km")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding(.bottom, __designTimeInteger("#8858_36", fallback: 10))
        .background(Color.black)
        .onAppear {
            healthManager.requestAuthorization()
        }
    }
}

#Preview {
    ContentView()
}
