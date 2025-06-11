import Foundation
import SwiftUI

struct CircularProgressView: View {
    var progress: Double
    var color: Color
    var lineWidth: CGFloat 
    
    var body: some View {
        ZStack {
            //background Circle
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)
            
            //progress Circle
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0))) // Trimmed based on progress
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90)) // Start from the top
                .animation(.easeOut(duration: 0.6), value: progress)
        }
    }
}
