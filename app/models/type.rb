class Type < ActiveRecord::Base
  has_many :client
  has_many :mailing
  
  def form_title
    return "#{label}"
  end
  
  def self.findAllWithGroupe(grp)
    self.where("grp = ?", grp)
  end
  
  def self.findAllWithGroupeAndCode(grp, code)
    self.where("grp = ? and code = ?", grp, code).first
  end  
end
