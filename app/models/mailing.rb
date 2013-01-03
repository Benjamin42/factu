class Mailing < ActiveRecord::Base
  belongs_to :statut, :class_name => "Type"
end
