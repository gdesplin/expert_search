class AddKindToWebsiteHeadings < ActiveRecord::Migration[6.0]

  def change
    add_column :website_headings, :kind, :integer
  end

end
