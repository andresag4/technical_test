class CartController < ApplicationController
  before_action :set_cart, only: [:add, :remove, :remove_all, :get_row]

  # GET /cart
  # GET /cart.json
  def index
    @products = Product.all
    @cart = Cart.all
  end

  # MATCH /add/1
  def add
    if @cart
      @cart.update(quantity: @cart.quantity + 1)
    else
      @cart = Cart.create(product_id: params[:product_id], quantity: 1)
    end

    respond_to do |format|
      format.json { render json: cart_json(@cart, 'add') }
    end
  end

  # MATCH /remove/1
  def remove
    if @cart.quantity > 1
      @cart.update(quantity: @cart.quantity - 1)
    end

    respond_to do |format|
      format.json { render json: cart_json(@cart, 'remove') }
    end
  end

  # MATCH /remove_all/1
  def remove_all
    respond_to do |format|
      if @cart
        @cart.destroy
        format.json { render json: cart_json(@cart, 'remove_all') }
      else
        format.json { render json: {} }
      end
    end
  end

  # GET /get_row/1
  def get_row
    respond_to do |format|
      format.js
    end
  end

  private

  def set_cart
    @cart = Cart.find_by_product_id(params[:product_id])
  end

  def cart_json(cart, status)
    {status: status, tax: Cart.get_total_tax, subtotal: Cart.get_subtotal, total: Cart.get_total}.merge cart.as_json
  end
end
