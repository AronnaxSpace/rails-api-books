describe Author, type: :model do
  it { should have_many(:books).dependent(:destroy) }

  it { should validate_presence_of(:first_name) }

  describe "#name" do
    subject { author.name }

    let(:author) { build(:author, first_name: "John", last_name: "Doe") }

    it "returns full name when both first and last names are present" do
      is_expected.to eq("John Doe")
    end

    context "when the last name is blank" do
      before { author.last_name = "" }

      it "returns only the first name" do
        is_expected.to eq("John")
      end
    end
  end
end
