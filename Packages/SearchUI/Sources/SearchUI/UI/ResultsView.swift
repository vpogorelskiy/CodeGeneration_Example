
import SwiftUI
import CustomNavigation
import Foundation
import Combine

struct ResultsView: View {
    var viewModel: IViewModel
//    {
//        didSet {
//            viewModel.itemsPublisher
//                .receive(on: RunLoop.main)
//                .sink { items in
//                    self.updateItems(items)
//                }
//                .store(in: &cancellables)
//            viewModel.isLoadingPublisher
//                .receive(on: RunLoop.main)
//                .sink { isLoading in
//                    self.isLoading = isLoading
//                }
//                .store(in: &cancellables)
//        }
//    }
    
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var items: [IViewModelItem] = []
    @State private var isLoading: Bool = false
    
    public init(viewModel: IViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                ResultsRow(viewModel: viewModel,
                           item: item)
                    .onAppear {
                        viewModel.loadNextIfNeeded(for: item)
                    }
            }
            if isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .onReceive(viewModel.itemsPublisher) { items = $0 }
        .onReceive(viewModel.isLoadingPublisher) { isLoading = $0 }
    }
    
    mutating func updateItems(_ items: [IViewModelItem]) {
        self.items = items
    }
}

struct ResultsRow: View {
    
    var viewModel: IViewModel
    var item: IViewModelItem
    
    var body: some View {
        
        CustomNavigation.Link (destination: {
            CustomNavigation.NavigationLazyView {
                if let vm = viewModel.detailViewModel(for: item) {
                    DetailView(detailViewModel: vm)
                        .customNavigationTitle(item.title)
                        .onAppear {
                            vm.getDetails()
                        }
                } else {
                    EmptyView()
                }
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
