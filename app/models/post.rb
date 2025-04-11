class Post < ApplicationRecord
  has_rich_text :body
  enum :status, { draft: 0, published: 1 }

  belongs_to :user
end
