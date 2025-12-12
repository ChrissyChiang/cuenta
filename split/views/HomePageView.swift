//
//  PlansView.swift
//  split
//
//  Created by Chrissy on 12/6/25.
//

import SwiftUI

struct HomePageView: View {
    @State var sheetIsPresented = false
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
            }
            .navigationTitle("spilt count" )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                CreatePlanView()
            }
        }
    }
}

#Preview {
    HomePageView()
}
