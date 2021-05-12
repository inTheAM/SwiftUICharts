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
			BarChartView(title:	"Annual Sales", legend: "\(ChartData.sampleData.first!.label) - \(ChartData.sampleData.last!.label)",	barColor: .blue, data: ChartData.sampleData)
//				.frame(width:	250,	height:	350)
        }
    }
}
