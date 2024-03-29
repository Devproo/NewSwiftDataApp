//
//  DetailView.swift
//  SwiftDataApp
//
//  Created by ipeerless on 09/02/2024.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var item: Item
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            TextField("Add item", text: $item.item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle(isOn: $item.reminderIOn, label: {
                Text("Set reminder")
            })
            .padding(.top)
            .listRowSeparator(.hidden)
            
            DatePicker("Date", selection: $item.dueDate)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                .disabled(!item.reminderIOn)
            
            Text("notes")
                .padding(.top)
            TextField("Notes", text: $item.notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed", isOn: $item.isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    modelContext.insert(item)
                    dismiss()
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailView( item: Item())
            .modelContainer(for: Item.self)
    }
}
