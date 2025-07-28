describe AuthorPresenter do
  let(:author) { create(:author, first_name: 'Jane', last_name: 'Smith') }

  describe '#as_json' do
    subject { described_class.new(author).as_json }

    it 'returns the correct JSON structure' do
      is_expected.to include(
        id: author.id,
        name: author.name,
        created_at: author.created_at,
        updated_at: author.updated_at
      )
    end
  end

  describe '.present' do
    context 'with a single author' do
      subject { AuthorPresenter.present(author) }

      it { is_expected.to include(id: author.id) }
      it { is_expected.to include(name: author.name) }
    end

    context 'with multiple authors' do
      let(:authors) { create_list(:author, 3) }
      subject { AuthorPresenter.present(authors) }

      it { is_expected.to be_an(Array) }

      it 'presents all authors correctly' do
        expect(subject.size).to eq(3)
        expect(subject.first).to include(:id, :name, :created_at, :updated_at)
      end
    end
  end
end
