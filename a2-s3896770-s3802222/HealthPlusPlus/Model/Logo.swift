//
//  Logo.swift
//  HealthPlusPlus
//
//  Created by Muhammad Hazren Rosdi on 22/8/2023.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        
        CustomLayout{
            Text("H")
                .bold()
                .font(.system(size: 70))
            HStack(spacing: 0){
                Image(systemName: "plus")
                    .resizable()
                    .bold()
                    .frame(width: 30, height: 30)
                Image(systemName: "plus")
                    .resizable()
                    .bold()
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    struct Logo_Previews: PreviewProvider {
        static var previews: some View {
            Logo()
        }
    }
    
    struct CustomLayout: Layout {
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
            for (index, subview) in subviews.enumerated() {
                // Position
                var point = CGPoint(x: 45 * index, y: 40 * index)
                    .applying(CGAffineTransform(rotationAngle: 5))
                
                // Center
                point.x += bounds.midX
                point.y += bounds.midY
                
                // Place Subviews
                subview.place(at: point, anchor: .center, proposal: .unspecified)
            }
        }
        
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
            proposal.replacingUnspecifiedDimensions()
        }
    }
}
