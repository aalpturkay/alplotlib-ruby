class RemoveSlugFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :slug
  end
end
