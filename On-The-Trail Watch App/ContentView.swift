//
//  ContentView.swift
//  on_the_trail
//
//  Created by Emily Sadler on 25/02/2025.
//

import SwiftUI
import HealthKit
import HealthKitUI

struct ContentView: View {
    @State private var totalDistance = ProgressManager.shared.getTotalDistance() // Total distance walked (cummulative)
    @StateObject var healthManager = HealthKitManager.shared
    let selectedRoute: Route
    
    var progress: Double {
        min(totalDistance / selectedRoute.distance, 1.0)
    }
    
    //Percentage complete
    var body: some View {
        VStack(spacing: 6) {
            Text("On the Trail")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, -25)
            
            if progress >= 1.0 {
                // Celebration message
                Text("🎉You've made it!🎉")
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .padding(.bottom, 20)
                    .transition(.opacity)
                    .animation(.easeIn(duration: 1), value: progress)
            } else {
                // Progress message
                Text("You are \(Int(progress * 100))% there!")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
            }
            
            //Progress Bar with Walking person
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                
                //                // Flag at the start (London)
                //                Image("flag-uk")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: 60, height: 60)
                //                    .scaleEffect(1.0 - (progress * 0.5)) // Shrinks from 100% to 50%
                //                    .position(x: 67, y: -48)
                //
                //                // Flag at the end (Paris)
                //                Image("flag-france")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: 60, height: 60)
                //                    .scaleEffect(0.5 + (progress * 0.5)) // Grows from 50% to 100%
                //                    .position(x: 207, y: -48)
                
                //Moving the person based on percentage travelled
                Image("blue-figure")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .position(x: CGFloat(progress) * 240 + 10, y: -2)
                    .animation(.easeInOut(duration: 1), value: progress)

            }
            .frame(width: 200, height: 50)
            // Labels for start and end points
            HStack {
                Text(selectedRoute.name.components(separatedBy: " - ").first ?? "Start")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                Spacer()
                Text(selectedRoute.name.components(separatedBy: " - ").last ?? "End")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            .font(.caption)
            .padding(.horizontal, 10)
            .frame(width: 200)
            
            // Distance info
            Text("\(Int(totalDistance))km / \(Int(selectedRoute.distance))km")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        
        
        .onAppear {
            HealthKitManager.shared.requestAuthorization { success, error in
                if success {
                    print("HealthKit authorization granted")
                    HealthKitManager.shared.fetchWalkingDistance()
                } else if let error = error {
                    print("HealthKit authorization failed: \(error.localizedDescription)")
                } else {
                    print("HealthKit authorization was denied by the user.")
                }
            }
        }
    }
}
