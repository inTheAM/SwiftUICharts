//
//  PieChartCell.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/6/21.
//

import SwiftUI

struct PieChartCell: View {
	var rect: CGRect
	var radius: CGFloat {
		return min(rect.width, rect.height)/2
	}
	var startDeg: Double
	var endDeg: Double
	var path: Path {
		var path = Path()
		path.addArc(center:rect.mid , radius:self.radius, startAngle: Angle(degrees: self.startDeg), endAngle: Angle(degrees: self.endDeg), clockwise: false)
		path.addLine(to: rect.mid)
		path.closeSubpath()
		return path
	}
	var index: Int
	var accentColor:Color
	
	
	var body: some View {
		path
			.fill()
			.padding(2)
			.foregroundColor(self.accentColor)
//			.overlay(path.stroke(Color.clear, lineWidth: 2))
			.animation(Animation.spring().delay(Double(self.index) * 0.04))
	}
}

struct PieChartCell_Previews: PreviewProvider {
    static var previews: some View {
		GeometryReader { geometry in
			PieChartCell(rect: geometry.frame(in: .local),startDeg: 0.0,endDeg: 90.0, index: 0, accentColor: Color(red: 225.0/255.0, green: 97.0/255.0, blue: 76.0/255.0))
		}.frame(width:100, height:100)
		
	
    }
}
