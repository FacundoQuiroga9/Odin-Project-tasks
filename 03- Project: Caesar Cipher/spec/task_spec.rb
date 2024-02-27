require './lib/task'


describe "#caesar_cipher" do
it "encrypts a phrase with a positive number shift" do
  expect(caesar_cipher("hello", 3)).to eq("ebiil")
end

it "encrypts a phrase with a negative number shift" do
  expect(caesar_cipher("hello", -3)).to eq("khoor")
end

it "does not modify non-alphabetic characters" do
  expect(caesar_cipher("hello, world!", 5)).to eq("czggj, rjmgy!")
end

it "wraps around the alphabet" do
  expect(caesar_cipher("xyz", 3)).to eq("uvw")
end

it "returns the original phrase with a shift of 0" do
  expect(caesar_cipher("hello", 0)).to eq("hello")
end
end
