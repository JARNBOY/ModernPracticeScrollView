//
//  DetailMessage.swift
//  ModernPracticeScrollView
//
//  Created by Papon Supamongkonchai on 30/4/2567 BE.
//

import SwiftUI

struct DetailMessage: View {
    // View Properties
    @Environment(\.presentationMode) var presentationMode
    @State private var activeTab: DetailTab = .overAll
    @Environment(\.colorScheme) private var scheme
    @Namespace private var animation
    private let heightCustomBar = 120.0
    private let heightImageDetail = 160.0
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15, content: {
                PagingImageDetail()
                DummyMessagesView()
            })
            .safeAreaInset(edge: .top, spacing: 0) {
                CustomNavigationBar()
            }
        }
        .background(
            .gray.opacity(0.15)
        )
        .navigationBarHidden(true)
    }
    
    // Custom Navigation Bar
    @ViewBuilder
    func CustomNavigationBar() -> some View {
        GeometryReader(content: { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let fasterTheScrollAnimationValue = 70.0
            let progress = max(min( -minY / fasterTheScrollAnimationValue, 1), 0)
            
            VStack {
                /// Navigation Bar
                HStack(spacing: 10, content: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "lessthan.square.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                })
                .foregroundStyle(Color.primary)
                
                /// Custom Segmented Picker
                ScrollView(.horizontal) {
                    HStack(spacing: 12, content: {
                        ForEach(DetailTab.allCases, id: \.rawValue) { tab in
                            Button(action: {
                                withAnimation(.snappy) {
                                    activeTab = tab
                                }
                            }, label: {
                                if activeTab == tab {
                                    Text(tab.rawValue)
                                        .font(.callout)
                                        .foregroundStyle((scheme == .dark ? .black : . white))
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .background(
                                            Capsule()
                                                .fill(Color.primary)
                                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                        )
                                } else {
                                    Text(tab.rawValue)
                                        .font(.callout)
                                        .foregroundStyle(Color.primary)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .background(
                                            Capsule()
                                                .fill(.background)
                                        )
                                }
                            })
                            .buttonStyle(.plain)
                        }
                    })
                }
                .frame(height: 50)
                .opacity(progress)
            }
            .background(
                RoundedRectangle(cornerRadius: 25.0 - (progress * 25))
                    .fill(.background.opacity(progress))
                    .padding(.top, -progress * heightCustomBar)
                    .padding(.horizontal, -progress * 15)
            )
            .offset(y: minY < 0 ? -minY : 0)
            .offset(y: -progress * 10)
        })
        .frame(height: heightCustomBar)
        .padding(.horizontal, 15)
        
    }
    
    // Image
    @ViewBuilder
    func PagingImageDetail() -> some View {
        TabView {
          ForEach(players) { player in
              Image(player.image)
                  .resizable()
                  .scaledToFit()
                  .cornerRadius(12)
                  .padding(.top, 10)
                  .padding(.horizontal, 15)
          }
        } //: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: heightImageDetail + (heightCustomBar / 1.5))
    }
    
    // Dummy Messages View
    @ViewBuilder
    func DummyMessagesView() -> some View {
        ForEach(1..<20, id: \.self) { count in
            HStack(spacing: 12, content: {
                Circle()
                    .frame(width: 55, height: 55)

                VStack(alignment: .leading, spacing: 6, content: {
                    Rectangle()
                        .frame(width: 140, height: 8)

                    Rectangle()
                        .frame(height: 8)

                    Rectangle()
                        .frame(width: 80, height: 8)
                })
            })
            .foregroundStyle(.gray.opacity(0.4))
            .padding(.horizontal, 15)
        }
    }
}

//#Preview {
//    DetailMessage()
//}
