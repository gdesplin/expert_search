class Expert < ApplicationRecord

  has_and_belongs_to_many(
    :friends,
    class_name: "Expert",
    join_table: "experts_friendships",
    foreign_key: "expert_a_id",
    association_foreign_key: "expert_b_id"
  )

  has_many :website_headings

  def self.search(search_params)
    term = "%#{search_params[:term]}%"
    field = search_params[:field]
    query = all
    case field
    when %w[name personal_website_url shortened_url].include?(field)
      query = query.where("? LIKE ?", search_params[:field], term)
    when "website headings"
      query = query.joins.website_headings.where("website_headings.heading LIKE ?", term)
    end
    query
  end

end
