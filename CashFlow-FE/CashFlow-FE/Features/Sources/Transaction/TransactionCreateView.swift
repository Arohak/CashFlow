//
//  TransactionCreateView.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/30/25.
//

import SwiftUI
import Shared
import Networking

struct CustomTextField: View {
    let title: String
    let text: Binding<String>
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            TextField(title, text: text)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct TransactionCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var type: String = "Expense"
    @State private var value: Double = 500
    @State private var note: String = "Ameria Bank"
    @State private var categoryName: String = "Loan"
    @State private var categoryInfo: String = "My"
    @State private var showingAlert = false
    
    var onSave: (TransactionDTO) async -> Void
        
    private var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(.systemBackground),
                Color(.systemBackground).opacity(0.8)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Card
                    VStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .padding(.top)
                        
                        Text("New Transaction Entry")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    // Income Details
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Transaction Details")
                            .font(.headline)
                            .padding(.leading)
                        
                        CustomTextField(title: "Type", text: $type, icon: "tag")
                        
                        HStack {
                            Image(systemName: "banknote")
                                .foregroundColor(.blue)
                                .frame(width: 24)
                            TextField("Value", value: $value, format: .currency(code: "USD"))
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        CustomTextField(title: "Note", text: $note, icon: "note.text")
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    
                    // Category Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Category")
                            .font(.headline)
                            .padding(.leading)
                        
                        CustomTextField(title: "Category Name", text: $categoryName, icon: "folder")
                        CustomTextField(title: "Category Info", text: $categoryInfo, icon: "info.circle")
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    
                    // Save Button
                    Button(action: saveIncome) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Save")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                    .padding(.top)
                }
                .padding()
            }
            .background(backgroundGradient)
            .navigationBarItems(
                leading: Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title3)
                }
            )
        }
        .alert("Invalid Input", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please ensure all fields are filled correctly.")
        }
    }
    
    private func saveIncome() {
        guard !type.isEmpty && !note.isEmpty && !categoryName.isEmpty && !categoryInfo.isEmpty else {
            showingAlert = true
            return
        }
        
        let item =  TransactionDTO(id: nil, type: TransactionType(rawValue: type) ?? .expense, category: .init(id: nil, name: categoryName, info: categoryInfo), value: value, note: note)
        
        create(item)
        
        dismiss()
    }
    
    private func create(_ item: TransactionDTO) {
        print("create", Date.now)

        Task {
            await onSave(item)
        }
    }
}

#Preview {
    TransactionCreateView {_ in}
}
