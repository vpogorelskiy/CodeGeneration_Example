
import SwiftUI
import CustomNavigation

struct ResultsView: View {
    var viewModel: IViewModel
    
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
    
    var viewModel: IViewModel
    var item: IViewModelItem
    
    var body: some View {
        
        CustomNavigation.Link (destination: {
            DetailView(detailViewModel: viewModel.detailViewModel(for: item))
                .customNavigationTitle(item.title)
                .onAppear {
                    
                }
        }, label: {
            Text(item.title)
                .foregroundColor(.black)
        })
    }
}

struct DetailView: View {
    let detailViewModel: IDetailViewModel
    
    var body: some View {
        List {
            ForEach(detailViewModel.content) { item in
                VStack(alignment: .leading) {
                    Text(item.title).font(.title)
                    Text(item.value)
                }
            }
        }
    }
}
