import SwiftUI

struct DetailView: View {
    let detailViewModel: IDetailViewModel
    @State var rows: [IDetailViewModelItem] = []
    
    var body: some View {
        List {
            ForEach(rows, id: \.id) { row in
                VStack(alignment: .leading) {
                    Text(row.title).font(.title)
                    Text(row.value)
                }
            }
        }
        .onReceive(detailViewModel.contentPublisher) { rows = $0 }
    }
}
