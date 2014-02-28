class ChangeGoalsPublicColumnToPrivacy < ActiveRecord::Migration
  def change
    rename_column :goals, :public, :privacy
  end
end
