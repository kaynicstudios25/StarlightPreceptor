//
//  LogHoursView.swift
//  MyFirstProject
//
//  Created by Kaylyn Groom on 2/3/26.
//

import Foundation
import SwiftUI
import SwiftData

struct LogHoursView: View {
    @Environment(\.modelContext) var context
    @Query var hours: [Hours]
    @State private var isShowingHours: Bool = false
    @State private var hoursToEdit: Hours?

    var body: some View {
        NavigationStack {
            List {
                ForEach(hours) { hour in
                    HoursCell(hour: hour)
                        .onTapGesture {
                            self.hoursToEdit = hour
                            self.isShowingHours.toggle()
                        }
                }
                .onDelete(perform: deleteHours)
            }
            .navigationTitle("Logged Hours")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingHours) {
                AddHours(hoursToEdit: hoursToEdit)
            }
            .toolbar {
                if !hours.isEmpty {
                    Button("Add Hours", systemImage: "plus") {
                        isShowingHours = true
                    }
                }
            }
            .overlay {
                if hours.isEmpty {
                    ContentUnavailableView(label: {
                        Label("Add Hours", systemImage: "clock")
                        
                    }, description: {
                        Text("Start adding hours to see them here.")
                    }, actions: {
                        Button("Add Hours") {
                            isShowingHours = true
                        }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
    
    private func deleteHours(at offsets: IndexSet) {
            for index in offsets {
                let hourToDelete = hours[index]
                context.delete(hourToDelete)
            }
            
            do {
                try context.save()
            } catch {
                print("Error deleting: \(error)")
            }
        }
}

#Preview {
    LogHoursView()
        .modelContainer(for: Hours.self, inMemory: true)
}

struct HoursCell: View {
    let hour: Hours

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(hour.student_name)
                    .font(.headline)
                Text(hour.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("\(hour.hours)h")
                .font(.body)
        }
    }
}

struct AddHours: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss

    var hoursToEdit: Hours?
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var total: Int = 0

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Student")) {
                    TextField("Student Name", text: $name)
                }
                Section(header: Text("Date")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                Section(header: Text("Total Hours")) {
                    Stepper(value: $total, in: 0...100) {
                        Text("\(total) hours")
                    }
                }
            }
            .navigationTitle(hoursToEdit == nil ? "Add Hours" : "Edit Hours")
            .onAppear {
                if let hoursToEdit = hoursToEdit {
                    name = hoursToEdit.student_name
                    date = hoursToEdit.date
                    total = hoursToEdit.hours
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let hoursToEdit = hoursToEdit {
                            // Update existing hours
                            hoursToEdit.student_name = name
                            hoursToEdit.date = date
                            hoursToEdit.hours = total
                        } else {
                            // Create new hours entry
                            let newHours = Hours(student_name: name, date: date, hours: total)
                            context.insert(newHours)
                        }
                        
                        do {
                            try context.save()
                        } catch {
                            print("Error saving: \(error)")
                        }
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
