class AddDetailsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :details, :text
  end
end
