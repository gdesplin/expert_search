class CreateWebsiteHeadings < ActiveRecord::Migration[6.0]

  def change
    create_table :website_headings do |t|
      t.integer :expert_id
      t.string :heading

      t.timestamps
    end
  end

end
