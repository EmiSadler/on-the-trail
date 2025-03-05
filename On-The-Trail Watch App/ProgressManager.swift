//
//  ProgressManager.swift
//  On-The-Trail
//
//  Created by Emily Sadler on 27/02/2025.
//
import Foundation
import HealthKit

class ProgressManager {
    static let shared = ProgressManager()
    private let totalDistanceKey = "totalDistanceWalked"
    
    private init() {}
    
    // Save cumulative distance
    func saveTotalDistance(_ distance: Double) {
        let currentDistance = getTotalDistance()
        let newTotal = currentDistance + distance
        UserDefaults.standard.set(newTotal, forKey: totalDistanceKey)
    }
    
    // Retrieve total distance walked
    func getTotalDistance() -> Double {
        return UserDefaults.standard.double(forKey: totalDistanceKey)
    }
}
