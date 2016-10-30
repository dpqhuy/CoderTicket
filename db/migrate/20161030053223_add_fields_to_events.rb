class AddFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :published_at, :datetime
    add_reference :events, :user, foreign_key: true
  end
end
