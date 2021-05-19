//
//  PieChartView.swift
//  SwiftUICharts
//
//  Created by Ahmed Mgua on 5/6/21.
//

import SwiftUI

struct PieChartView: View {
    var title:    String
    var legend:    String
	var data: [ChartData]
	var backgroundColor: Color
	var accentColor: Color
	
	@State	private var currentValue	=	""
    @State private var currentLabel    =    ""
    @State private var touchLocation:   CGPoint =   .init(x:    -1,  y:  -1)
	
	var body: some View {
        VStack {
            Text(title)
                .bold()
                .font(.largeTitle)
            
            
            GeometryReader { geometry in
                ZStack  {
                    ForEach(0..<self.data.count){ i in
                        PieChartCell(center: geometry.frame(in: .local).mid,
                                     radius:    geometry.frame(in: .local).width/2,
                                     startDeg: pieSlices()[i].startDegree,
                                     endDeg: pieSlices()[i].endDegree,
                                     isTouched: sliceIsTouched(index: i, inPie: geometry.frame(in:  .local)),
                                     accentColor: .random
                        )
                    }
                }
                .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ position in
                                let pieSize = geometry.frame(in: .local)
                                
                                touchLocation   =   position.location
                                updateValue(inPie: pieSize)
                                
                            })
                            .onEnded({ value in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation(Animation.easeOut) {
                                        resetValues()
                                    }
                                    HapticFeedback.playSelection()
                                }
                            }))
            }.aspectRatio(contentMode: .fit)
            
            VStack  {
                if !currentLabel.isEmpty   {
                    Text(currentLabel)
                        .bold()
                        .foregroundColor(.black)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                }   else if !legend.isEmpty {
                        Text(legend)
                            .bold()
                            .foregroundColor(.black)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                }
                
                if !currentValue.isEmpty {
                    Text("\(currentValue)")
                        .bold()
                        .foregroundColor(.black)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                }


            }.padding()
            
        }.padding()
	}
    
    
    func sliceIsTouched(index:  Int,    inPie   pieSize:    CGRect)    ->  Bool    {
        guard let angle =   angleAtTouchLocation(inPie: pieSize)    else    {return false}
        return pieSlices().firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle })    ==  index
    }
    
    
    func updateValue(inPie   pieSize:    CGRect)  {
        guard let angle =   angleAtTouchLocation(inPie: pieSize)    else    {return}
        let currentIndex = pieSlices().firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) ?? -1
        
        currentLabel    =   data[currentIndex].label
        currentValue    =   "\(data[currentIndex].value)"
    }
    
    func angleAtTouchLocation(inPie pieSize:    CGRect) ->  Double?  {
        let dx = touchLocation.x - pieSize.midX
        let dy = touchLocation.y - pieSize.midY
        
        let distanceToCenter = (dx * dx + dy * dy).squareRoot()
        let radius  =   pieSize.width/2
        guard distanceToCenter  <=  radius  else    {
            return nil
        }
        
        var angle:  Double {
            let angleAtTouchLocation    =   Double(atan2(dy, dx) *   (180  /   .pi))
            
            if angleAtTouchLocation <   0   {
                return (180  -   abs(angleAtTouchLocation))  + 180
            }   else    {
                return angleAtTouchLocation
            }
        }
        return angle
    }
    
    
    func resetValues() {
        currentValue    =   ""
        currentLabel    =   ""
        touchLocation   =   .init(x:    -1,  y:  -1)
    }
	
	func normalizedValue(index:	Int)	->	Double	{
        var total   =    0.0
        data.forEach    {   data in
            total    +=    data.value
        }
        return data[index].value/total
	}
	
	func pieSlices()	->	[PieSlice]	{
		var slices  =	[PieSlice]()
        data.enumerated().forEach 	{  (index,  data) in
            let value	=	normalizedValue(index: index)
            if slices.isEmpty	{
                slices.append((.init(startDegree: 0, endDegree: value   *   360)))
            }	else	{
                slices.append(.init(startDegree:    slices.last!.endDegree,	endDegree: (value  *   360	+	slices.last!.endDegree)))
            }
        }
		return slices
	}
}

extension PieChartView  {
    struct PieSlice {
        var startDegree:    Double
        var endDegree:  Double
    }
}



struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(title: "Chart Title",  legend: "Legend", data: ChartData.sampleData, backgroundColor: .black, accentColor: .green)
    }
}
