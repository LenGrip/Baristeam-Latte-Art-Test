//
//  ChoosingDrinksView.swift
//  latte-art
//
//  Created by Reza Athallah Rasendriya on 25/04/24.
//

import SwiftUI

struct ChoosingDrinksView: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.appMain)
                        .frame(height: 100)
                    Rectangle()
                        .fill(Color.appSecondaryDark)
                        .frame(height: 50)
                }
                
                HStack(spacing: 50.0) {
                    VStack {
                        Button(action: {}, label: {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 80)
                        })
                    }
                    
                    VStack {
                        Button(action: {}, label: {
                            Circle()
                                .fill(Color.brown)
                                .frame(width: 80)
                        })
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    
}

#Preview {
    ChoosingDrinksView()
}
