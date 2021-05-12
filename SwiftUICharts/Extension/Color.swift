//
//  Color.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/7/21.
//

import SwiftUI

extension Color	{
	static var random:	Color	{
		let colors	=	[Color.blue,	.purple,	.green,	.gray,	.orange,	.red]
		return colors.randomElement()!
	}
}
