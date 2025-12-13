//
//  Created by Chrissy on 12/6/25.
//

import SwiftUI

struct CreatePlanView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var selectedTab: Int

    @State private var name: String = ""
    @State private var selectedCurrency: String = "TWD"
    @State private var hasStartedTypingName: Bool = false
    @State private var isCreating: Bool = false

    @FocusState private var isInputActive: Bool

    private var currencies = ["TWD", "USD", "JPY", "EUR"]
    private let plansRepository = PlansRepository()

    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
    }

    var isInputValid: Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    Form {
                        Section(
                            header: Text("Name"),
                            footer: Group {
                                Text("Please enter a valid plan name.")
                                    .foregroundColor(.red)
                                    .opacity(
                                        hasStartedTypingName && !isInputValid
                                        ? 1 : 0
                                    )
                            }
                        ) {
                            TextField("Enter plan Name", text: $name)
                                .font(.body)
                                .focused($isInputActive)
                                .onChange(of: name) {
                                    if !hasStartedTypingName {
                                        hasStartedTypingName = true
                                    }
                                }
                                .onChange(of: isInputActive) {
                                    if !isInputActive && !isInputValid {
                                        hasStartedTypingName = true
                                    }
                                }
                                .task {
                                    // 在 sheet 出現後稍微延遲再聚焦，避免鍵盤不出現
                                    try? await Task.sleep(for: .seconds(0.1))
                                    await MainActor.run { isInputActive = true }
                                }
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

                    Button(action: {
                        Task {
                            print("按鈕被點擊，開始存資料...")
                            isCreating = true

                            try? await Task.sleep(for: .seconds(0.2)) // 怕 api 太快回來，看不到 loading 效果
                            let plan = Plans.Insert(
                                name: name,
                                currency: selectedCurrency,
                                created_by: UUID()  // TODO:暫時隨機產生
                            )
                            try await plansRepository.createPlan(plan: plan)

                            selectedTab = 0

                            dismiss()
                        }
                    }) {
                        Text("Create")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!isInputValid)
                }

                if isCreating {
                    ZStack{
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        ProgressView("Creating...")
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Create a plan")
        }
    }
}
