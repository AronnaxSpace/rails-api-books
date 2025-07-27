describe Book, type: :model do
  it { should belong_to(:author).optional(true) }

  it { should validate_presence_of(:title) }
end
