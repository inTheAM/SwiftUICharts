//
//  PieChartView.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/6/21.
//

import SwiftUI

struct PieChartView: View {
	var data: [ChartData]
	var backgroundColor: Color
	var accentColor: Color
	
	@State	private var showValue	=	false
	@State	private var currentValue	=	""
	
	@State private var currentTouchedIndex = -1 {
		didSet {
			if oldValue != currentTouchedIndex {
				showValue = currentTouchedIndex != -1
				currentValue = showValue ? "\(data[currentTouchedIndex].value)" : "0"
			}
		}
	}
	
	public var body: some View {
		GeometryReader { geometry in
			ZStack{
				ForEach(0..<self.data.count){ i in
					PieChartCell(rect: geometry.frame(in: .local), startDeg: pieSlices()[i].0, endDeg: pieSlices()[i].1, index: i, accentColor: .random)
						.scaleEffect(self.currentTouchedIndex == i ? 1.1 : 1)
						.animation(Animation.spring())
				}
			}
			.gesture(DragGesture(minimumDistance: 0)
						.onChanged({ value in
							let rect = geometry.frame(in: .local)
							let isTouchInPie = isPointInCircle(point: value.location, circleRect: rect)
							if isTouchInPie {
								let touchDegree = degree(for: value.location, inCircleRect: rect)
								self.currentTouchedIndex = pieSlices().firstIndex(where: { $0.0 < touchDegree && $0.1 > touchDegree }) ?? -1
							} else {
								self.currentTouchedIndex = -1
							}
						})
						.onEnded({ value in
							self.currentTouchedIndex = -1
						}))
		}
	}
	
	func normalizedValue(index:	Int)	->	Double	{
		var total:	Double	{
			var total	=	0.0
			for data in data	{
				total	+=	data.value
			}
			return total
		}
		
		return data[index].value/total
	}
	
	func pieSlices()	->	[(Double,	Double)]	{
		var total:	Double	{
			var total	=	0.0
			for data in data	{
				total	+=	data.value
			}
			return total
		}
		
		var slices:	[(Double,	Double)]	{
			
			var slices	=	[(Double,	Double)]()
			for data in data.enumerated()	{
				let value	=	normalizedValue(index: data.0)
				if slices.isEmpty	{
					slices.append((0,	value*360))
				}	else	{
					slices.append((slices.last!.1,	(value*360	+	slices.last!.1)))
				}
			}
			return slices
		}
		return slices
	}
	
	func isPointInCircle(point: CGPoint, circleRect: CGRect) -> Bool {
		let r = min(circleRect.width, circleRect.height) / 2
		let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
		let dx = point.x - center.x
		let dy = point.y - center.y
		let distance = sqrt(dx * dx + dy * dy)
		return distance <= r
	}
	
	func degree(for point: CGPoint, inCircleRect circleRect: CGRect) -> Double {
		let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
		let dx = point.x - center.x
		let dy = point.y - center.y
		let acuteDegree = Double(atan(dy / dx)) * (180 / .pi)
		
		let isInBottomRight = dx >= 0 && dy >= 0
		let isInBottomLeft = dx <= 0 && dy >= 0
		let isInTopLeft = dx <= 0 && dy <= 0
		let isInTopRight = dx >= 0 && dy <= 0
		
		if isInBottomRight {
			return acuteDegree
		} else if isInBottomLeft {
			return 180 - abs(acuteDegree)
		} else if isInTopLeft {
			return 180 + abs(acuteDegree)
		} else if isInTopRight {
			return 360 - abs(acuteDegree)
		}
		
		return 0
	}
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
		PieChartView(data: ChartData.sampleData, backgroundColor: .black, accentColor: .green)
    }
}
