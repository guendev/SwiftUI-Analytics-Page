//
//  LineGraph.swift
//  Analytics Page
//
//  Created by Nguyên Trần on 03/07/2022.
//

import SwiftUI

struct LineGraph: View {
    
    var data: [CGFloat]
    
    @State var currentPlot: String = ""
    @State var offset: CGSize = .zero
    @State var showPlot: Bool = false
    @State var translation: CGFloat = .zero
    
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0) + 100
            
            let points = data.enumerated().compactMap { item -> CGPoint in
                let progress = item.element / maxPoint
                
                let pathHeight = progress * height
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            ZStack {
                
                // path
                Path { path in
                    // Vẽ đồ thị
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLines(points)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                .fill(Color("Line"))
                
                FillBG()
                    .clipShape (
                        Path { path in
                            // Vẽ đồ thị
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLines(points)
                            
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            path.addLine(to: CGPoint(x: 0, y: height))
                            
                        }
                    )
            }
            .overlay(alignment: .bottomLeading) {
                // Drag
                VStack(spacing: 0) {
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Color("Line"), in: Capsule())
                        .offset(x: translation < 10 ? 30 : 0)
                        .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                    
                    
                    Rectangle()
                        .fill(Color("Line"))
                        .frame(width: 1, height: 40)
                        .padding(.top)
                    
                    Circle()
                        .fill(Color("Line"))
                        .frame(width: 22, height: 22)
                        .overlay {
                            Circle()
                                .fill(.white)
                                .frame(width: 10, height: 10)
                        }
                    
                    Rectangle()
                        .fill(Color("Line"))
                        .frame(width: 1, height: 50)
                }
                // Fix frame
                .frame(width: 80, height: 170)
                .offset(offset)
                .offset(y: 70)
                .opacity(showPlot ? 1 : 0)
            }
            .contentShape(Rectangle())
            .gesture(DragGesture().onChanged({ value in
                withAnimation {
                    showPlot = true
                }
                let translation = value.location.x - 40
                
                let index = max(min(Int((translation/width).rounded() + 1), data.count - 1), 0)
                
                currentPlot = "$ \(data[index])"
                
                // remove half height
                offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                
                self.translation = translation

                
            }).onEnded({ value in
                withAnimation {
                    showPlot = false
                }
            }))
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    func FillBG() -> some View {
        LinearGradient(
            colors: [
                Color("Line").opacity(0.3),
                Color("Line").opacity(0.2)]
                + Array(repeating: Color("Line").opacity(0.1), count: 5)
                + Array(repeating: Color.clear, count: 2)
            ,
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
