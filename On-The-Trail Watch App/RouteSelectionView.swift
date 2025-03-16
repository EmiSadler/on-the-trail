//
//  RouteSelectionView.swift
//  On-The-Trail
//
//  Created by Emily Sadler on 26/02/2025.
//
import SwiftUI

struct Route: Hashable {
    let id = UUID()
    let name: String
    let distance: Double
}

struct RouteSelectionView: View {
    let routes: [Route] = [
        Route(name: "London - Paris", distance: 343.0),
        Route(name: "Lisbon - Madrid", distance: 625.0),
        Route(name: "Vienna - Rome", distance: 1125.0),
        Route(name: "Berlin - Amsterdam", distance: 650.0),
        Route(name: "Brussels - Luxembourg", distance: 187.0),
        Route(name: "Tallinn - Riga", distance: 279.0),
        Route(name: "Vilnius - Warsaw", distance: 389.0),
        Route(name: "Budapest - Zagreb", distance: 299.0),
        Route(name: "Testing - Debugging", distance: 3.0)
        
    ].sorted { $0.distance < $1.distance } // Sort shortest distance first
    
    @State private var selectedRouteIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Your Trail", selection: $selectedRouteIndex) {
                    ForEach(0..<routes.count, id: \.self) { index in
                        Text(routes[index].name).tag(index)
                            .font(.headline)
                        Text("\(Int(routes[index].distance)) km")
                            .font(.subheadline)
                        // Add a divider except for the last item
                        if index < routes.count - 1 {
                            Divider()
                                .background(Color.gray)
                        }
                    }
                }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    
                    // NavigationLink using value-based navigation
                    NavigationLink("Head On The Trail!", value: routes[selectedRouteIndex])
                        .buttonStyle(.borderedProminent)
                        .padding()
                }
                // Destination for NavigationLink
                .navigationDestination(for: Route.self) { route in
                    ContentView(selectedRoute: route)
                }
            }
        }
    }
