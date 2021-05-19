//
//  PieChartCell.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/6/21.
//

import SwiftUI

struct PieChartCell: View {
	var center: CGPoint
	var radius: CGFloat
	var startDeg: Double
	var endDeg: Double
    var isTouched:  Bool
    var accentColor:Color
    
	var path: Path {
		var path = Path()
		path.addArc(center: center ,
                    radius:self.radius,
                    startAngle: Angle(degrees: self.startDeg),
                    endAngle: Angle(degrees: self.endDeg),
                    clockwise: false)
		path.addLine(to: center)
		path.closeSubpath()
		return path
	}
	
	
	
	var body: some View {
		path
            .fill(!isTouched ?   Color.blue :   .gray)
            .overlay(path.stroke(Color.white, lineWidth: 2))
            
            .scaleEffect(isTouched ? 1.05 : 1)
            .animation(Animation.spring())
            .onChange(of: isTouched)    { isTouched in
                if isTouched    {
                    HapticFeedback.playSelection()
                }
            }
	}
}

