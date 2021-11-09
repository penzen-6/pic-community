class AddContentTitleToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :content_title, :text
  end
end
