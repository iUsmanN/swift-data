//
//  ContentView.swift
//  swift-data
//
//  Created by Usman N on 01/10/2024.
//

import SwiftUI
import SwiftData

// 1 Define model
@Model
final class Student {
    var id: Int
    var name: String
    var age: Int
    
    init(id: Int, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}

struct ContentView: View {
    
    // 4 Get the container in any view
    @Environment(\.modelContext) var context
    @State private var newStudent = false
    
    // 5 Fetch Items of Model type from DB
    @Query(sort: \Student.id) var students: [Student]
    
    var body: some View {
        NavigationStack {
            
            // 6 Use objects in persisted DB
            List(students){ student in
                studentCell(student: student)
            }
            .navigationTitle("Swift Data Tests")
            .overlay {
                if students.isEmpty {
                    ContentUnavailableView("Error",
                                           systemImage: "person.crop.circle.fill.badge.exclamationmark",
                                           description: Text("No Student Data Found!"))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newStudent.toggle()
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .sheet(isPresented: $newStudent) {
                NewStudentView()
            }
        }
    }
    
    @ViewBuilder
    func studentCell(student: Student) -> some View {
        HStack {
            Text("\(student.id)")
            Text(student.name)
            Text("\(student.age)")
        }
    }
}

struct NewStudentView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var id: Int = 0
    @State private var name: String = ""
    @State private var age: Int = 0
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("ID") {
                    TextField("age", value: $id, format: .number).keyboardType(.numberPad)
                }
                Section("NAME") {
                    TextField("name", text: $name)
                }
                Section("AGE") {
                    TextField("age", value: $age, format: .number).keyboardType(.numberPad)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        context.insert(Student(id: id, name: name, age: age))
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.square.fill")
                            .frame(width: 25, height: 25)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.app.fill")
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
