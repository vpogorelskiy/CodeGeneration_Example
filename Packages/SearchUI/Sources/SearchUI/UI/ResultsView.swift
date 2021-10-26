
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
        let dict = detailViewModel.content
        let keys = dict.map{ $0.key }
        let values = dict.map { $0.value }
        
        List {
            ForEach(keys.indices) {index in
                VStack(alignment: .leading) {
                    Text(keys[index]).font(.title)
                    Text("\(values[index])")
                }
            }
        }
    }
}
