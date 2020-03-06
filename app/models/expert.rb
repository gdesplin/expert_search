class Expert < ApplicationRecord

  has_and_belongs_to_many(
    :experts,
    join_table: "experts_friendships",
    foreign_key: "expert_a_id",
    association_foreign_key: "expert_b_id"
  )

  has_many :website_headings

end
