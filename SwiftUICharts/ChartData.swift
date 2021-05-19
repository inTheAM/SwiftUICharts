//
//  ChartData.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/7/21.
//

import SwiftUI


struct ChartData	{
	var label:	String
	var value:	Double
	
	init(_	label:	String?	=	"",	_	value:	Double)	{
		self.label	=	label!
		self.value	=	value
	}
	
	init(_	value:	Double)	{
		label	=	"Label"
		self.value	=	value
	}
	
	static let sampleData:	[ChartData]	=	[.init("2014", 20960),	.init("2015", 12780),	.init("2016", 16250),	.init("2017", 25760), .init("2018", 14390),	.init("2019", 16350),	.init("2020", 30450)]
    static let samplePieData:    [ChartData]    =    [.init("iPod", 20960),    .init("Airpods", 12780),    .init("Airtag", 16250),    .init("Macbook", 25760), .init("iMac", 14390),    .init("iPad", 16350),    .init("iPhone", 30450)]
}


class HapticFeedback {
	static func playSelection() {
		UISelectionFeedbackGenerator().selectionChanged()
	}
}




struct PieChartData {
    var label:    String
    var value:    Double
}
