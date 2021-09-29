import SwiftUI
import BooksApi

struct BooksView: View {
    @EnvironmentObject var booksViewModel: BooksAPI

    var body: some View {
        List {
            ForEach(booksViewModel.bookVolumes) { volume in
                let title = volume.volumeInfo.title
                NavigationLink {
                    BooksDetailView(detailInfo: volume.volumeInfo)
                        .navigationTitle(title)
                } label: {
                    Text(title)
                }
            }
        }
        .navigationTitle("Books")
    }
}

extension BooksVolume: Identifiable {}

struct BooksDetailView: View {
    @State var detailInfo: VolumeInfo
    @State var image: Image? = nil
    
    enum Titles {
        static let title = "Title"
        static let description = "Description"
        static let authors = "Authors"
        
        static let ordered  = [title, authors, description]
    }
    
    private var detailMap: [(String, String)] {
        return [(Titles.title, detailInfo.title),
                (Titles.authors, detailInfo.authors?.joined(separator: ", ") ?? ""),
                (Titles.description, detailInfo.description.safeString)
        ]
    }
    
    var body: some View {
        List {
            ForEach(detailMap, id: \.0) { title in
                VStack(alignment: .leading) {
                    Text(title.0).font(.title)
                    Text(title.1)
                }
            }
        }
    }
}

struct BooksDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BooksDetailView(detailInfo: VolumeInfo(title: "Dune",
                                               authors: ["One", "Two"],
                                               publisher: "Some Publisher",
                                               publishedDate: "1984",
                                               description: "A guide to Frank Herbert\'s imaginary world offers scientific speculation on such topics as physics, chemistry, ecology, evolution, psychology, technology, and genetics.",
                                               industryIdentifiers: nil,
                                               readingModes: nil,
                                               printType: nil,
                                               categories: nil,
                                               maturityRating: nil,
                                               allowAnonLogging: nil,
                                               contentVersion: nil,
                                               panelizationSummary: nil,
                                               imageLinks: VolumeInfoImageLinks(),
                                               language: nil,
                                               previewLink: nil,
                                               infoLink: nil,
                                               canonicalVolumeLink: nil))
    }
}
