
import SwiftUI

struct ResultsView<Api: AbstractApi>: View {
    @EnvironmentObject var viewModel: ViewModel<Api>

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                CustomNavigation.Link (destination: DetailView<Api>()
                                        .environmentObject(viewModel)
                                        .customNavigationTitle(item.title.safeString)
                                        .onAppear {
                                            viewModel.getDetails(forItem: item)},
                                       label: { Text(item.title.safeString) })
                    .onAppear {
                        viewModel.loadNextIfNeeded(for: item)
                    }
            }
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                
            }
        }
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
