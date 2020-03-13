class WebsiteHeading < ApplicationRecord

  belongs_to :expert

  enum kind: %i[h1 h2 h3 h4 h5 h6]

  validates :heading, presence: true

end
