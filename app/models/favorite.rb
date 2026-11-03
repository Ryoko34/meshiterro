class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post_image

  # uniqueness => validatesメソッドの引数であるuser_idカラムの値が既に保存済みの値と重複していないかをチェック
  validates :user_id, uniqueness: {scope: :post_image_id} #scope => user_idとpost_image_idに既に同じがgア値のペアが保存されていないかを判定

end
