class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  has_one_attached :photo   # per una sola immagine
  # oppure has_many_attached :photos
end

