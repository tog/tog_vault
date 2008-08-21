class AddStateToPage < ActiveRecord::Migration
  def self.up
    remove_column :pages, :status_id
    add_column :pages, :state, :string
  end

  def self.down
    remove_column :pages, :state
    add_column :pages, :status_id, :integer
  end
end
