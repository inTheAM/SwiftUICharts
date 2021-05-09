//
//  ContentView.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 4/30/21.
//

import SwiftUI

struct BarChartCell: View {
	var value: Double
	var barColor: Color

	var body: some View {
		RoundedRectangle(cornerRadius: 5)
			.fill(barColor)
			.scaleEffect(CGSize(width: 1, height: value), anchor: .bottom)
	}
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		BarChartCell(value: 5, barColor: .blue)
    }
}
