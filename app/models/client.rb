class Client < ActiveRecord::Base

  validates_presence_of :num_client
  validates_presence_of :nom
  validates_presence_of :num_voie
  validates_presence_of :ville

  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  def self.build_from_csv(row)
    # find existing customer from email or create new
    client = find_or_initialize_by_nom(row[2])
    client.attributes = {

      :num_client => self.clean(row[0]),
      :num_tva => self.clean(row[1]),
      :nom => self.clean(row[2]),
      :nom_info => self.clean(row[3]),
      :bat => self.clean(row[4]),
      :num_voie => self.clean(row[5]),
      :bp => self.clean(row[6]),
      #:codepostal => self.clean(row[]),
      :ville => self.clean(row[7]),
      :pays => self.clean(row[8]),
      :tel => self.clean(row[9]),
      :portable => self.clean(row[11]),
      :fax => self.clean(row[10]),
      :email => self.clean(row[12]),
      :commentaire => self.clean(row[13])
    }
    return client
  end
  
  def self.clean(str)
    if str != nil
      return str.unpack('U*').pack('U*')
    end
    return str
  end

  def self.next_num_client
    return find_by_sql("select max(num_client) + 1 as num_client from clients").first.num_client
  end

end
