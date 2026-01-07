import SwiftUI

struct Request: Identifiable {
    let id = UUID()
    let title: String
    let table: String
    var status: Status

    enum Status: String, CaseIterable {
        case new = "New"
        case inProgress = "In Progress"
        case done = "Done"
    }
}

struct ContentView: View {
    @State private var requests: [Request] = [
        Request(title: "Water refill", table: "Table 12", status: .new),
        Request(title: "Extra napkins", table: "Table 7", status: .inProgress),
        Request(title: "Check please", table: "Table 4", status: .done)
    ]

    @State private var showAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(requests.indices, id: \.self) { i in
                    NavigationLink {
                        RequestDetailView(request: $requests[i])
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(requests[i].title)
                                .font(.headline)
                            Text(requests[i].table)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(requests[i].status.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Requests")
            .toolbar {
                Button("Add") { showAdd = true }
            }
            .sheet(isPresented: $showAdd) {
                AddRequestView { newRequest in
                    requests.insert(newRequest, at: 0)
                }
            }
        }
    }
}
