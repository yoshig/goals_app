class RemoveBooleanDefaults < ActiveRecord::Migration
  def change
    change_column_default :goals, :privacy, nil
    change_column_default :goals, :completed, nil
  end
end
