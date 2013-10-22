class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :subject
      t.text :body
      t.references :user, index: true
      t.string :datafile_url

      t.timestamps
    end
  end
end
