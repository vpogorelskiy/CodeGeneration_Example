
import SwiftUI
import CustomNavigation

struct ResultsView<Api: AbstractApi>: View {
    var viewModel: AbstractViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.items, id: \.id) { item in
                ResultsRow(viewModel: viewModel,
                           item: item)
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

struct ResultsRow: View {
    
    @State var viewModel: AbstractViewModel
    @State var item: ViewModelItem
    
    var body: some View {
        
        CustomNavigation.Link (destination: {
            DetailView()
                .environmentObject(viewModel.detailViewModel(for: item))
                .customNavigationTitle(item.title.safeString)
                .onAppear {
                    
                }
        }, label: {
            Text(item.title.safeString)
                .foregroundColor(.black)
        })
    }
}

struct DetailView: View {
    @Published var detailViewModel: DetailViewModel?
    
    var body: some View {
        List {
            ForEach(detailViewModel?.content ?? []) { item in
                VStack(alignment: .leading) {
                    Text(item.title).font(.title)
                    Text(item.value)
                }
            }
        }
    }
}
