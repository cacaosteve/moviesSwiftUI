import SwiftUI

struct RatingView: View {
    let score: Int
    
    var scoreColor: Color {
        get {
            if score < 50 {
                return .brandYellow
            }
            return .brandGreen
        }
    }

    var overlay: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(score) / 100)
                .stroke(style: StrokeStyle(lineWidth: 6))
                .foregroundColor(scoreColor)
        }
        .rotationEffect(.degrees(-90))
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.clear)
                .frame(width: 50)
                .overlay(overlay)
                .shadow(color: scoreColor, radius: 4)
            Text("\(score)%")
                .font(Font.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(.brandSilver)
        }
        .frame(width: 50, height: 50)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(score: 77)
        RatingView(score: 23)
    }
}
