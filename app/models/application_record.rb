class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(table, search_params)
    table.where('name ILIKE ?', "%#{search_params}%")
    .order(name: :asc)
  end
end
