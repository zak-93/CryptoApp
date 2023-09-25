//
//  LaunchView.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 25.09.2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map{ String($0) }
    @State private var showLoadingText = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter = 0
    @State private var loops = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launch.background.ignoresSafeArea()
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                HStack(spacing: 0) {
                    ForEach(loadingText.indices, id: \.self) { index in
                        Text(loadingText[index])
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.launch.accent)
                            .offset(y: counter == index ? -5: 0)
                    }
                }
                .transition(AnyTransition.scale.animation(.easeIn))
            }
            .offset(y: 70)
        }
        .onAppear(perform: {
            showLoadingText.toggle()
        })
        .onReceive(timer, perform: { _ in
            withAnimation(.spring) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
