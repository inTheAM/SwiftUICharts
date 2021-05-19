//
//  SwiftUIChartsApp.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 4/30/21.
//

import SwiftUI

@main
struct SwiftUIChartsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View    {
    @State private var viewBarChart =   false
    var body:   some    View    {
        VStack  {
            if viewBarChart {
                BarChartView(title:    "Annual sales", legend: "\(ChartData.sampleData.first!.label) - \(ChartData.sampleData.last!.label)",    barColor: .blue, data: ChartData.sampleData)
            }   else    {
                PieChartView(title: "Sales by device",  legend: "", data: ChartData.samplePieData, backgroundColor: .black, accentColor: .green)
            }
            Spacer()
            Button(viewBarChart ?    "View PieChart"  :   "View BarChart") {
                viewBarChart.toggle()
            }.padding()
            .font(.headline)
            .foregroundColor(.white)
            .background(Color.blue.cornerRadius(10))
        }.padding()
        
    }
}
