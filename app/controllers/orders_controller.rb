class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    before_action :set_customer

    def index
      @orders = Order.all
    end
  
    def show
    end

    def new
      @customer = Customer.new
    end

    def create
        @order = @customer.orders.create(order_params)
        if @order.save
          flash.notice = "The order record was created successfully."
          redirect_to @customer
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit
      @order = Order.find(params[:id])
    end

    def update
      @order = Order.find(params[:id])
      @order.update(order_params)
      if @order.update(order_params)
        flash.notice = "The order record was updated successfully."
        redirect_to @customer
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      redirect_to @customer
    end
  

    private
      
      def order_params
        params.require(:order).permit(:product_name, :product_count)
      end

      def set_customer
        @customer = Customer.find(params[:customer_id])
      end

      def catch_not_found(e)
        Rails.logger.debug("We had a not found exception.")
        flash.alert = e.to_s
        redirect_to customers_path
    end
  
end
