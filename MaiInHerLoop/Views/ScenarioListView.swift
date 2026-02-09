//
//  ScenarioListView.swift
//  MaiInHerLoop
//
//  Created by Mai Huynh Ngoc Nhat on 9/2/26.
//
import SwiftUI

struct ScenarioListView: View {
    let region: String
    @State private var scenarios: [Scenario] = []
    @State private var loadError: String?
    
    var body: some View {
        Group {
            if let error = loadError {
                VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("Failed to load scenarios")
                        .font(.headline)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else if scenarios.isEmpty {
                ProgressView("Loading scenarios...")
            } else {
                List {
                    ForEach(scenarios) { scenario in
                        NavigationLink(value: AppScreen.game(scenario: scenario)) {
                            ScenarioRow(scenario: scenario)
                        }
                    }
                }
                .navigationTitle(regionTitle)
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .onAppear {
            loadScenarios()
        }
    }
    
    private var regionTitle: String {
        switch region {
        case "north": return "Northern Vietnam"
        case "central": return "Central Vietnam"
        case "south": return "Southern Vietnam"
        default: return "Scenarios"
        }
    }
    
    private func loadScenarios() {
        scenarios = []
        loadError = nil
        
        for i in 1...3 {
            let scenarioID = "\(region)_easy_\(i)"
            
            if let scenario = JSONLoader.loadScenario(id: scenarioID) {
                scenarios.append(scenario)
            } else {
                loadError = "Could not load \(scenarioID)"
                return
            }
        }
    }
}

struct ScenarioRow: View {
    let scenario: Scenario
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(scenario.titleEN)
                .font(.headline)
            
            Text(scenario.introEN)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Label("7 Questions", systemImage: "questionmark.circle")
                    .font(.caption)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        ScenarioListView(region: "north")
    }
}
