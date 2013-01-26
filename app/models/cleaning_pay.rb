class CleaningPay < ActiveRecord::Base
  has_many :client
  
  def form_title
    return "#{nom}"
  end
    
  def self.build_from_csv(row)
    # find existing customer from email or create new
    pays = find_or_initialize_by_id(row[0])
    pays.attributes = {
      :id => self.clean(row[0]),
      :code_pays => self.clean(row[1]),
      :nom => self.clean(row[2])
    }
    return pays
  end
  
  def self.clean(str)
    if !str.nil?
      return str.unpack('U*').pack('U*')
    end
    return str
  end  
  
  def self.findByCode(code)
    self.find(:first, :conditions => ["code_pays = ?", code])
  end  
  
  def self.findByNom(nom)
    self.find(:first, :conditions => ["nom = ?", nom])
  end    
end
