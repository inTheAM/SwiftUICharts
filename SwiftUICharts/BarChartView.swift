//
//  BarChartView.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/1/21.
//

import SwiftUI

struct BarChartView:	View	{
	var title:	String
	var data: [Double]
	var barColor: Color
	
	@State private var touchLocation: CGFloat	=	-1
	@State private var showCurrentValue	=	false
	@State private var currentValue	=	""
	
	var body: some View {
		
		VStack(alignment:	.leading) {
			Text(title)
				.bold()
				.font(.largeTitle)
			
			Text("Current value: \(currentValue)")
				.font(.headline)
			
			GeometryReader { geometry in
				HStack(alignment: .bottom){
					ForEach(0..<data.count, id: \.self) { i in
						VStack {
							BarChartCell(value: self.normalizedValue(index: i), barColor: barColor)
								.opacity(barIsTouched(index:	i)	?	1	:	0.7)
								.scaleEffect(barIsTouched(index:	i) ? CGSize(width: 1.05, height: 1) : CGSize(width: 1, height: 1), anchor: .bottom)
								.animation(.spring())
						}
					}
				}
				.gesture(DragGesture(minimumDistance:	0)
							.onChanged({ position in
								let currentFrameWidth	=	geometry.frame(in:	.local).width
								let touchPosition	=	position.location.x/(currentFrameWidth)
								
								touchLocation = touchPosition
								updateCurrentValue()
							})
							.onEnded({ _ in
								DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
									withAnimation(Animation.easeOut(duration: 0.5)) {
										touchLocation = -1
										currentValue	=	""
										showCurrentValue	=	false
									}
								}
							})
				)
			}
		}.padding()
	}
	
	func barIsTouched(index:	Int)	->	Bool	{
		touchLocation > CGFloat(index)/CGFloat(data.count) && touchLocation < CGFloat(index+1)/CGFloat(data.count)
	}
	
	func updateCurrentValue()	{
		let index	=	Int(touchLocation	*	CGFloat(data.count))
		guard index	<	data.count	||	index	==	0	else	{
			showCurrentValue	=	false
			currentValue	=	""
			return
		}
		currentValue	=	"\(data[index])"
		showCurrentValue	=	true
	}
	
	func normalizedValue(index: Int) -> Double {
		guard let max = data.max() else {
			return 1
		}
		if max != 0 {
			return Double(data[index])/Double(max)
		} else	{
			return 1
		}
	}
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
		BarChartView(title:	"Chart Title",	data: [20,	15,	18,	9, 3,	5,	5,	10,	12,	30,	5,	5,	10,	12,	30], barColor: .blue)
    }
}
