//
//  HomeView.swift
//  MyFirstProject
//
//  Created by Kaylyn Groom on 2/3/26.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack() {
                HStack {
                    Text("Jane Doe")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.black)
                        .padding()
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding()
                
                VStack {
                    HoursWidget()
                }
            }
        }
        
    }
}

#Preview {
    DashboardView()
}
