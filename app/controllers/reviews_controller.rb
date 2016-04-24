class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]
  before_filter :find_parent



  # GET /reviews
  # GET /reviews.json

  # GET /reviews/new
  def new
    @review_type = find_reviewable
    @review = Review.new()
  end

  # GET /reviews/1/edit
  def edit
    @review_type = find_reviewable
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review_type = find_reviewable
    @review = @review_type.reviews.create(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to @review_type
    else
      render 'new'
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    @review_type = find_reviewable
    @review.user_id = current_user.id
    if @review.update(review_params)
        redirect_to @review_type
    else
      render 'new'
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review_type = find_reviewable
    @review.user_id = current_user.id

    if @review.destroy
      redirect_to @review_type, notice: "Review DELETE"
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = current_user.reviews.find(params[:id])
    end


    



    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :content).merge(user_id: current_user.id)
    end

    def find_parent
      @parent = nil
      if params[:restaurant_id]
        @parent = Restaurant.find(params[:restaurant_id])
      elsif params[:shop_id]
        @parent = Shop.find(params[:shop_id])
      end
    end

    def find_reviewable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
  end

