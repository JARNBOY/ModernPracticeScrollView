//
//  HandleCurrentScrollOffset.swift
//  ModernPracticeScrollView
//
//  Created by Papon Supamongkonchai on 30/4/2567 BE.
//

import SwiftUI

struct HandleCurrentScrollOffset: View {
    
    @State var currentOffset: CGPoint = .init(x: 0, y: 0)
    
    var body: some View {
        OffsetObservingScrollView(offset: $currentOffset) {
            VStack(spacing: 15) {
                ProductsView()
            }
            .padding(.horizontal, 15)
        }
        
    }
    
    // Dummy Products View
    @ViewBuilder
    func ProductsView() -> some View {
        ForEach(1..<20, id: \.self) { count in
            HStack(spacing: 12, content: {
                Circle()
                    .frame(width: 55, height: 55)

                VStack(alignment: .leading, spacing: 10, content: {
                    Rectangle()
                        .frame(width: 140, height: 8)
                    
                    Text("currentOffset")
                        .frame(height: 8)
                    
                    Text("\(currentOffset.x), \(currentOffset.y)")
                        .frame(height: 8)

                    Rectangle()
                        .frame(height: 8)
                })
                
                Spacer()
            })
            .foregroundStyle(.gray.opacity(0.4))
            .padding(.horizontal, 15)
        }
    }
}
