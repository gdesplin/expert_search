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
    query = all
    if column_names.include?(search_params[:field])
      term = "%#{search_params[:term].downcase}%"
      field = search_params[:field] 
      case field
      when "name", "personal_website_url", "short_url"
        query = query.where("lower(#{field}) LIKE ?", term)
      when "website headings"
        query = query.joins.website_headings.where("website_headings.heading LIKE ?", term)
      end
    end
    query
  end

  def friend_search(search_params)
    if Expert.column_names.include?(search_params[:field])
      term = "%#{search_params[:term].downcase}%"
      field = search_params[:field] 
      query = Expert.all
      case field
      when "name", "personal_website_url", "short_url"
        query = query.where("lower(#{field}) LIKE ?", term)
      when "website headings"
        query = query.joins.website_headings.where("website_headings.heading LIKE ?", term)
      end
      query.where.not(id: friends.pluck(:id).push(id))
    end
  end

end
