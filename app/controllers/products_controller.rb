class ProductsController < ApplicationController
  def index
    @products = Product.includes(:images, :category, :seller).order('created_at DESC')
    @ham = Product.where(brand: '伊藤ハム')
  end


  def category
    @categories = Category.where(ancestry: nil)
    respond_to do |format|
      format.json
    end
  end

  def category_children
    @category_children = Category.find(params[:id]).children
    respond_to do |format|
      format.json
    end
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:id]).children
    respond_to do |format|
      format.json
    end
  end


  def new
    @product = Product.new
    @product.images.new
    #セレクトボックスの初期値設定
    # @category_parent_array = ["---"]
    @category_parent_array = Category.where(ancestry: nil)

    #データベースから、親カテゴリーのみ抽出し、配列化
    # Category.where(ancestry: nil).each do |parent|
    #   @category_parent_array << parent.name
    # end
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(id: params[:parent_id], ancestry: nil).children
  end

  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find(params[:child_id]).children
  end
  
  def create
    binding.pry
    @product = Product.new(product_params)
    binding.pry
    if @product.save
      redirect_to root_path
    else
      @category_parent_array = ["---"]
      #データベースから、親カテゴリーのみ抽出し、配列化
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @user = @product.seller
    @category = @product.category
  end

  def edit
  end

  def update
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to root_path
    else
      render :show
    end 
    
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :condition_id, :brand, :shipping_payer_id, :shipping_from_area_id, :shipping_duration_id, :price, :category_id, images_attributes: [:image]).merge(seller_id: current_user.id)
  end

end