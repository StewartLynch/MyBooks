//
// Created for MyBooks
// by  Stewart Lynch on 2023-10-03
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI
import PhotosUI

struct EditBookView: View {
    @Environment(\.dismiss) private var dismiss
    let book: Book
    @State private var status: Status
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var synopsis = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var recommendedBy = ""
    @State private var showGenres = false
    @State private var selectedBookCover: PhotosPickerItem?
    @State private var selectedBookCoverData: Data?
    
    init(book: Book) {
        self.book = book
        _status = State(initialValue: Status(rawValue: book.status)!)
    }
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    switch status {
                    case .onShelf:
                        DatePicker("", selection: $dateAdded, displayedComponents: .date)
                    case .inProgress, .completed:
                        DatePicker("", selection: $dateAdded, in: ...dateStarted, displayedComponents: .date)
                    }
                    
                } label: {
                    Text("Date Added")
                }
                if status == .inProgress || status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if newValue == .onShelf {
                    dateStarted = Date.distantPast
                    dateCompleted = Date.distantPast
                } else if newValue == .inProgress && oldValue == .completed {
                    // from completed to inProgress
                    dateCompleted = Date.distantPast
                } else if newValue == .inProgress && oldValue == .onShelf {
                    // Book has been started
                    dateStarted = Date.now
                } else if newValue == .completed && oldValue == .onShelf {
                    // Forgot to start book
                    dateCompleted = Date.now
                    dateStarted = dateAdded
                } else {
                    // completed
                    dateCompleted = Date.now
                }
            }
            Divider()
            HStack {
                PhotosPicker(
                    selection: $selectedBookCover,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Group {
                            if let selectedBookCoverData,
                               let uiImage = UIImage(data: selectedBookCoverData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .tint(.primary)
                            }
                        }
                        .frame(width: 75, height: 100)
                        .overlay(alignment: .bottomTrailing) {
                            if selectedBookCoverData != nil {
                                Button {
                                    selectedBookCover = nil
                                    selectedBookCoverData = nil
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                VStack {
                    LabeledContent {
                        RatingsView(maxRating: 5, currentRating: $rating, width: 30)
                    } label: {
                        Text("Rating")
                    }
                    LabeledContent {
                        TextField("", text: $title)
                    } label: {
                        Text("Title").foregroundStyle(.secondary)
                    }
                    LabeledContent {
                        TextField("", text: $author)
                    } label: {
                        Text("Author").foregroundStyle(.secondary)
                    }
                }
            }
            LabeledContent {
                TextField("", text: $recommendedBy)
            } label: {
                Text("Recommended by").foregroundStyle(.secondary)
            }
            Divider()
            Text("Synopsis").foregroundStyle(.secondary)
            TextEditor(text: $synopsis)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
            if let genres = book.genres {
                ViewThatFits {
                    GenresStackView(genres: genres)
                    ScrollView(.horizontal, showsIndicators: false) {
                        GenresStackView(genres: genres)
                    }
                }
            }
            HStack {
                Button("Genres", systemImage: "bookmark.fill") {
                    showGenres.toggle()
                }
                .sheet(isPresented: $showGenres) {
                    GenresView(book: book)
                }
                NavigationLink {
                    QuotesListView(book: book)
                } label: {
                    let count = book.quotes?.count ?? 0
                    Label("\(count) Quotes", systemImage: "quote.opening")
                }
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()

        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    book.status = status.rawValue
                    book.rating = rating
                    book.title = title
                    book.author = author
                    book.synopsis = synopsis
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateCompleted = dateCompleted
                    book.recommendedBy = recommendedBy
                    book.bookCover = selectedBookCoverData
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            rating = book.rating
            title = book.title
            author = book.author
            synopsis = book.synopsis
            dateAdded = book.dateAdded
            dateStarted = book.dateStarted
            dateCompleted = book.dateCompleted
            recommendedBy = book.recommendedBy
            selectedBookCoverData = book.bookCover
        }
        .task(id: selectedBookCover) {
            if let data = try? await selectedBookCover?.loadTransferable(type: Data.self) {
                selectedBookCoverData = data
            }
        }
    }
    
    var changed: Bool {
        status != Status(rawValue: book.status)!
        || rating != book.rating
        || title != book.title
        || author != book.author
        || synopsis != book.synopsis
        || dateAdded != book.dateAdded
        || dateStarted != book.dateStarted
        || dateCompleted != book.dateCompleted
        || recommendedBy != book.recommendedBy
        || selectedBookCoverData != book.bookCover
    }
}

#Preview {
    let preview = Preview(Book.self)
   return  NavigationStack {
       EditBookView(book: Book.sampleBooks[4])
           .modelContainer(preview.container)
    }
}
