//
//  HealthManager.swift
//  On-The-Trail
//
//  Created by Emily Sadler on 25/02/2025.
//
import HealthKit
import Foundation

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()
    @Published var totalDistance: Double = 0.0
    @Published var totalSteps: Int = 0
    private var timer: Timer?
    
    init() {
        startUpdatingData()
    }

    // Request authorization with a completion handler
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data not available")
            completion(false, nil)
            return
        }
        
        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        healthStore.requestAuthorization(toShare: nil, read: [distanceType]) { success, error in
            DispatchQueue.main.async {
                if success {
                    self.fetchWalkingDistance() // Fetch data immediately after authorization
                    self.startUpdatingData()
                }
                completion(success, error) // Inform the caller of the result
            }
        }
    }

    func fetchWalkingDistance() {
        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, error == nil else {
                print("Error fetching walking distance: \(String(describing: error))")
                return
            }
            
            let distance = result.sumQuantity()?.doubleValue(for: HKUnit.meter()) ?? 0
            DispatchQueue.main.async {
                self.totalDistance = distance / 1000 // Convert meters to kilometers
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchDailySteps() {
            let stepType = HKObjectType.quantityType(forIdentifier: .stepCount)!
            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
            
            let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let result = result, error == nil else {
                    print("Error fetching step count: \(String(describing: error))")
                    return
                }
                
                let steps = result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
                DispatchQueue.main.async {
                    self.totalSteps = Int(steps)
                }
            }
            
            healthStore.execute(query)
        }
    
    func startUpdatingData() {
        //  To get walking distance every 30 secs
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.fetchWalkingDistance()
            self.fetchDailySteps()
        }
    }
}
