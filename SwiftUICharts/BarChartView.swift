//
//  BarChartView.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/1/21.
//

import SwiftUI

struct BarChartView:	View	{
	var title:	String
	var legend:	String
	var barColor: Color
	var data: [ChartData]
	
	@State private var touchLocation: CGFloat	=	-1
	@State private var currentValue	=	""
	@State private var currentLabel	=	""
	
	var body: some View {
		
		VStack(alignment:	.leading) {
			Text(title)
				.bold()
				.font(.largeTitle)
			
			Text("\(currentValue)")
				.font(.headline)
			
			GeometryReader { geometry in
				VStack {
					HStack	{
						ForEach(0..<data.count, id: \.self) { i in
							BarChartCell(value: normalizedValue(index: i), barColor: barColor)
								.opacity(barIsTouched(index:	i)	?	1	:	0.7)
								.scaleEffect(barIsTouched(index:	i) ? CGSize(width: 1.1, height: 1) : CGSize(width: 1, height: 1), anchor: .bottom)
								.animation(.spring())
								.padding(.top)
						}
					}
					.gesture(DragGesture(minimumDistance:	0)
								.onChanged({ position in
									let touchPosition	=	position.location.x/geometry.frame(in:	.local).width
									
									touchLocation = touchPosition
									updateCurrentValue()
								})
								.onEnded({ _ in
									DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(Animation.easeOut(duration: 0.5)) {
											resetValues()
										}
									}
								})
					)
					
					if currentLabel.isEmpty {
						Text(legend)
							.bold()
							.foregroundColor(.black)
							.padding(5)
							.background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
					}	else	{
						Text(currentLabel)
							.bold()
							.foregroundColor(.black)
							.padding(5)
							.background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
							.offset(x:	labelOffset(in: geometry.frame(in: .local).width))
							.animation(.easeIn)
					}
				}
			}
		}.padding()
	}
	
	func barIsTouched(index:	Int)	->	Bool	{
		touchLocation > CGFloat(index)/CGFloat(data.count) && touchLocation < CGFloat(index+1)/CGFloat(data.count)
	}
	
	func normalizedValue(index: Int) -> Double {
		var allValues:	[Double]	{
			var values	=	[Double]()
			for data in data	{
				values.append(data.value)
			}
			
			return values
		}
		guard let max = allValues.max() else {
			return 0
		}
		if max != 0 {
			return Double(data[index].value)/Double(max)
		} else	{
			return 1
		}
	}
	
	func updateCurrentValue()	{
		let currentIndex	=	Int(touchLocation	*	CGFloat(data.count))
		guard currentIndex	<	data.count	&&	currentIndex	>=	0	else	{
			currentValue	=	""
			currentLabel	=	""
			return
		}
		
		if currentValue	!=	"\(data[currentIndex].value)"	{
			currentValue	=	"\(data[currentIndex].value)"
			currentLabel	=	data[currentIndex].label
			HapticFeedback.playSelection()
		}
		
	}
	
	func resetValues() {
		touchLocation = -1
		currentValue	=	""
		currentLabel	=	""
        HapticFeedback.playSelection()
	}
	
	func labelOffset(in width:	CGFloat)	->	CGFloat	{
		let currentIndex	=	Int(touchLocation	*	CGFloat(data.count))
		guard currentIndex	<	data.count	&&	currentIndex	>=	0	else	{
			return 0
		}
		let cellWidth	=	width	/	CGFloat(data.count)
		let actualWidth	=	width	-	cellWidth
		let position	=	cellWidth	*	CGFloat(currentIndex)	-	actualWidth/2
		
		return position
	}
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
		BarChartView(title:	"Chart Title", legend: "Legend",	barColor: .blue, data: ChartData.sampleData)
    }
}
