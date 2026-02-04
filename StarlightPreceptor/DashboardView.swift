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

            VStack(spacing: 16) {
                Text("My Name is Kaylyn Groom")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.black)
                    .padding()
            }
        }
    }
}

#Preview {
    DashboardView()
}
