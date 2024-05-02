//
//  CircleButton.swift
//  latte-art
//
//  Created by Reza Athallah Rasendriya on 29/04/24.
//

import SwiftUI

struct CircleButton: View {
//    typealias Size = ("large", "small")
    @State var icon: String
    @State var size: String
    
    var body: some View {
        if size == "small" {
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 10.0)
                    .fill(Color.appSecondaryLight)
                    .stroke(Color.appSecondaryDark, lineWidth: 4.0)
                    .frame(width: 50)
                Image(systemName: icon)
                    .resizable()
//                    .padding(.leading, 6.0)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.white)
            }
        } else if size == "large" {
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 15.0)
                    .fill(Color.appSecondaryLight)
                    .stroke(Color.appSecondaryDark, lineWidth: 5.0)
                    .frame(width: 110)
                Image(systemName: icon)
                    .resizable()
//                    .padding(.leading, 6.0)
                    .frame(width: 45, height: 45)
                    .foregroundColor(Color.white)
            }
        } else {
            EmptyView()
        }
            
    }
}
