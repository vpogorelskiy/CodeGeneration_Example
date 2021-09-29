
import SwiftUI

struct ResultsView<Model: ViewModel>: View {
    @EnvironmentObject var viewModel: Model

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                NavigationLink {
                    DetailView<Model>()
                        .environmentObject(viewModel)
                        .onAppear {
                            viewModel.getDetails(forItem: item)
                        }
                } label: {
                    Text(item.title.safeString)
                }
            }
        }
        .navigationTitle("Books")
    }
}

struct DetailView<Model: ViewModel>: View {
    @EnvironmentObject var viewModel: Model
    
    var body: some View {
        List {
            ForEach(viewModel.detailItem.content) { item in
                VStack(alignment: .leading) {
                    Text(item.title).font(.title)
                    Text(item.value)
                }
            }
        }
    }
}
