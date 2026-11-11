class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  # 認証をスキップ: サインアップ（new, create）はログイン前に行うため
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "ユーザー登録が完了しました！続けてログインしてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id]) #↓PostImageモデル,Userモデル アソシエーションを持っている
    @post_images = @user.post_images.page(params[:page]) #特定のユーザ(@user)に関連づけられた全投稿(.post_images)を取得し、@post_imagesに渡す
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  private

  def user_params
    #name, email_address, password, password_confirmation, profile_image を許可
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to post_images_path
    end
  end

end
