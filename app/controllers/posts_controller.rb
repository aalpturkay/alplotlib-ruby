class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  allow_unauthenticated_access only: %i[ index show ]
  before_action :authorize_post!, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    if params[:user_id]
      begin
        @user = User.find(params[:user_id])
        @posts = @user.posts
      rescue ActiveRecord::RecordNotFound
        redirect_to posts_path
      end
    else
      @posts = Post.all
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    cache_key = "post_#{@post.id}_viewer_#{session.id}"

    unless Rails.cache.exist?(cache_key)
      @post.increment!(:views_count, 1)
      Rails.cache.write(cache_key, true, expires_in: 1.minutes)
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    @post.published_at = Time.current
    @post.status = :published
    @post.user = Current.user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
      # @post = Post.find_by!(slug: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :body, :published_at, :status, :cover_image, :category_id ])
    end

    def authorize_post!
      redirect_to posts_path, alert: "Yetkin yok." unless @post.user == Current.user
    end
end
