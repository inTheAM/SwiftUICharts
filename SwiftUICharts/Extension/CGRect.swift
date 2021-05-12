//
//  CGRect.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/6/21.
//

import SwiftUI

extension CGRect	{
	var mid: CGPoint {
		CGPoint(x:self.midX, y: self.midY)
	}
}
