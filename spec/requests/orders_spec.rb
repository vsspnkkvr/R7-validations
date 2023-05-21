require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "get edit_customer_order_path(id: order.id)" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      get customer_order_path(id: order.id)
      expect(response).to render_template(:edit)
    end
  end
  describe "post customer_order_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect { post customer_order_path, params: {order: order_attributes}
    }.to change(Order, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end
  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end
  describe "post customers_order_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order_attributes.delete(:product_name)
      expect { post customer_order_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
      expect(response).to render_template(:_form)
    end
  end
  describe "delete an order record" do
    it "deletes an order record" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order)
      delete customer_order_path(id: order.id) 
      expect(order).to eq(nil)
      expect(response).to redirect_to(customers_path)
    end
  end
end
