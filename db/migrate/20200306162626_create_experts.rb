class CreateExperts < ActiveRecord::Migration[6.0]

  def change
    create_table :experts do |t|
      t.string :name
      t.string :personal_website_url
      t.string :shortened_url

      t.timestamps
    end
  end

end
