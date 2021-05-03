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
			BarChartView(title:	"Title",	data: [20,	15,	18,	9, 3,	5,	5,	10,	12,	30], barColor: .blue)
        }
    }
}
