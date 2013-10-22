class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.integer :article_id
      t.string :data_file_name
      t.string :data_content_type
      t.string :data_file_size

      t.timestamps
    end
  end
end
