describe BookPresenter do
  let(:author) { create(:author, first_name: "John", last_name: "Doe") }
  let(:book) { create(:book, title: "Test Book", author: author) }

  describe "#as_json" do
    subject { described_class.new(book).as_json }

    context "with a book that has an author" do
      it "returns the correct JSON structure" do
        is_expected.to include(
          id: book.id,
          title: "Test Book",
          author: {
            id: author.id,
            name: "John Doe"
          },
          created_at: book.created_at,
          updated_at: book.updated_at
        )
      end
    end

    context "with a book that has no author" do
      let(:book) { create(:book, title: "Orphan Book", author: nil) }

      it "returns nil for author info" do
        is_expected.to include(
          id: book.id,
          title: "Orphan Book",
          author: nil,
          created_at: book.created_at,
          updated_at: book.updated_at
        )
      end
    end
  end

  describe ".present" do
    context "with a single book" do
      subject { BookPresenter.present(book) }

      it { is_expected.to include(title: "Test Book") }
      it { is_expected.to have_key(:author) }
    end

    context "with multiple books" do
      let(:books) { create_list(:book, 2, author: author) }
      subject { BookPresenter.present(books) }

      it { is_expected.to be_an(Array) }

      it "presents all books correctly" do
        expect(subject.size).to eq(2)
        expect(subject.first).to include(:id, :title, :author, :created_at, :updated_at)
      end
    end
  end
end
