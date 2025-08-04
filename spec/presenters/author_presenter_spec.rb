describe AuthorPresenter do
  let(:author) { build(:author) }

  let(:expected_json) do
    {
      id: author.id,
      name: author.name,
      created_at: author.created_at,
      updated_at: author.updated_at,
      books: []
    }
  end

  describe "#as_json" do
    subject { described_class.new(author).as_json }

    it "returns the correct JSON structure" do
      is_expected.to eq(expected_json)
    end

    context "when the author has books" do
      before do
        create_list(:book, 2, author: author)
        expected_json[:books] = BookPresenter.present(author.books, attributes_to_exclude: [ :author ])
      end

      it "includes books key with presented books" do
        is_expected.to include(:books)
        expect(subject[:books]).to be_an(Array)
        expect(subject[:books].pluck(:id)).to match_array(author.books.ids)
        expect(subject[:books].first).not_to include(:author)
      end
    end

    context "when attributes_to_exclude is provided" do
      subject { described_class.new(author).as_json(attributes_to_exclude: [ :books ]) }

      it "excludes the specified attributes" do
        is_expected.not_to include(:books)
        expect(subject).to include(:id, :name, :created_at, :updated_at)
      end
    end
  end

  describe ".present" do
    context "with a single author" do
      subject { AuthorPresenter.present(author) }

      it { is_expected.to eq(expected_json) }
    end

    context "with multiple authors" do
      let(:authors) { create_list(:author, 3) }
      subject { AuthorPresenter.present(authors) }

      it { is_expected.to be_an(Array) }

      it "presents all authors correctly" do
        expect(subject.size).to eq(3)
        expect(subject.first).to include(*expected_json.keys)
      end
    end
  end
end
