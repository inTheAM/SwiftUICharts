//
//  ChartData.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/7/21.
//

import Foundation


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
	
	static let sampleData:	[ChartData]	=	[.init("2014", 20960),	.init("2015", 15780),	.init("2016", 18250),	.init("2017", 19760), .init("2018", 14390),	.init("2019", 16350),	.init("2020", 18450)]
}
