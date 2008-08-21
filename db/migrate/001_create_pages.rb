class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.string :breadcrumb
      t.integer :status_id
      t.integer :parent_id
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :published_at
      t.integer :created_by
      t.integer :updated_by
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
