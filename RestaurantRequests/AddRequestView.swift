import SwiftUI

struct AddRequestView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var table = ""
    @State private var errorText: String? = nil

    let onAdd: (Request) -> Void

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !table.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("New request") {
                    TextField("Request (ex: Water refill)", text: $title)
                    TextField("Table (ex: Table 12)", text: $table)
                }

                if let errorText {
                    Text(errorText)
                        .foregroundStyle(.red)
                }
            }
            .navigationTitle("Add Request")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !isValid {
                            errorText = "Please fill out both fields."
                            return
                        }
                        let req = Request(title: title, table: table, status: .new)
                        onAdd(req)
                        dismiss()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
}

