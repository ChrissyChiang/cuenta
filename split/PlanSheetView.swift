//
//  SettingsView.swift
//  split
//
//  Created by Chrissy on 12/6/25.
//

import SwiftUI

struct PlanSheetView: View {
    @State private var text: String = ""
    @State private var selectedCurrency: String = "TWD"

    @FocusState private var isInputActive: Bool

    private var currencies = ["TWD", "USD", "JPY", "EUR"]

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Name")) {
                        TextField("Enter plan Name", text: $text)
                            .font(.body)
                            // 輸入框綁定變數
                            .focused($isInputActive)
                    }

                    Section(header: Text("Currency")) {
                        Picker(
                            selection: $selectedCurrency,
                            label: Text("Currency")
                        ) {
                            ForEach(currencies, id: \.self) { currency in
                                Text(currency).tag(currency)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }

                Button(action: {}) {
                    Text("Create")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .navigationTitle("Create a plan")
        }
    }
}

#Preview {
    PlanSheetView()
}
