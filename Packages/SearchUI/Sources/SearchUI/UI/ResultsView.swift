import Foundation
import SwiftUI
import CustomNavigation

struct ResultsView: View {
    var viewModel: IViewModel
    
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

