//
//  Color.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/7/21.
//

import SwiftUI

extension Color	{
	static var randomColor:	Color	{
        .init(red: Double.random(in: 0.3...0.9), green: Double.random(in: 0.3...0.9), blue: Double.random(in: 0.3...0.9))
	}
}
