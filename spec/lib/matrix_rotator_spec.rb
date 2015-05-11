require_relative "../../lib/matrix_rotator"

RSpec.describe MatrixRotator do

  let :matrix do
    [
      ["a","b","c"],
      ["d","e","f"],
      ["g","h","i"]
    ]
  end

  let :rotated_clockwise_matrix do
    [
      ["g","d","a"],
      ["h","e","b"],
      ["i","f","c"]
    ]
  end

  subject do
    described_class.new matrix
  end

  it "raises an error if the rows aren't the same size" do
    expect{described_class.new([["a","b"],["c"]])}.to raise_error ArgumentError
  end

  it "rotates the matrix 90 degrees clockwise" do
    expect(subject.rotate).to eq rotated_clockwise_matrix
  end

  describe "#_calculate_new_coordinates" do
    it "can calculate the correct location for each cell" do
      matrix.each_with_index do |row, r|
        row.each_with_index do |value, c|
          new_r = nil
          new_c = nil
          rotated_clockwise_matrix.each_with_index do |new_row, i|
            new_r = i if new_row.index(value)
            new_c = new_row.index(value) if new_row.index(value)
          end
          expect(subject._calculate_new_coordinates(r,c)).to eq [new_r,new_c]
        end
      end
    end
  end

end
