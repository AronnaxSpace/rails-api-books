describe Author, type: :model do
  it { should have_many(:books).dependent(:destroy) }

  it { should validate_presence_of(:first_name) }

  describe "#name" do
    it "returns the full name" do
      author = create(:author, first_name: "John", last_name: "Doe")
      expect(author.name).to eq("John Doe")
    end

    it "returns the first name if last name is blank" do
      author = create(:author, first_name: "John", last_name: "")
      expect(author.name).to eq("John")
    end
  end
end
