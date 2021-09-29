
import SwiftUI

struct ResultsView<Api: AbstractApi>: View {
    @EnvironmentObject var viewModel: ViewModel<Api>

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                NavigationLink {
                    DetailView<Api>()
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

struct DetailView<Api: AbstractApi>: View {
    @EnvironmentObject var viewModel: ViewModel<Api>
    
    var body: some View {
        List {
            ForEach(viewModel.detailItem?.content ?? []) { item in
                VStack(alignment: .leading) {
                    Text(item.title).font(.title)
                    Text(item.value)
                }
            }
        }
    }
}
