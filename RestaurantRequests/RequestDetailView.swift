import SwiftUI

struct RequestDetailView: View {
    @Binding var request: Request

    var body: some View {
        Form {
            Section("Request") {
                Text(request.title)
                Text(request.table)
                    .foregroundStyle(.secondary)
            }

            Section("Status") {
                Picker("Status", selection: $request.status) {
                    ForEach(Request.Status.allCases, id: \.self) { s in
                        Text(s.rawValue).tag(s)
                    }
                }
            }
        }
        .navigationTitle("Details")
    }
}
