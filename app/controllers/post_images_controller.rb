class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = Current.user.id #Model名.カラム名 = ログイン中のユーザ情報を取得して代入
    if @post_image.save
      redirect_to post_images_path #複数形は投稿一覧
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @post_images = PostImage.page(params[:page])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption) #post_imageモデルで定義した各カラムの型の入出力？を許可する
  end
end
