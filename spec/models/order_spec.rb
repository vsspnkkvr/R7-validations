require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new( product_name: "apples", product_count: 7, customer: FactoryBot.create(:customer))}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a product_name" do
    subject.product_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a product_count" do
    subject.product_count=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if the product count is not all valid digits" do
    expect(subject.product_count.to_s.to_i).to_not eq(0)
  end
  it "returns the correct product_name" do
    expect(subject.product_name).to eq("apples")
  end
end


