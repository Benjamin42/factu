# -*- coding: utf-8 -*-
class Client < ActiveRecord::Base
  has_many :commande
  
  #attr_accessible :long_addresse, :latitude, :longitude
  geocoded_by :long_adresse
  after_validation :geocode, :if => :long_adresse_changed?
  
  validates_presence_of :num_client
  validates_presence_of :nom
  validates_presence_of :num_voie
  validates_presence_of :ville

  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  def form_title
    return " #{id} - #{nom}"
  end
  
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
      :long_adresse => self.concatAddresse(row),
      :tel => self.clean(row[9]),
      :portable => self.clean(row[11]),
      :fax => self.clean(row[10]),
      :email => self.clean(row[12]),
      :commentaire => self.clean(row[13])
    }
    return client
  end
  
  def self.concatAddresse(row)
    res = ""
    
    add4 = self.clean(row[4])
    add5 = self.clean(row[5])
    add6 = self.clean(row[6])
    add7 = self.clean(row[7])
    add8 = self.clean(row[8])
    
    if add4 != nil then
      res = res + " " + add4
    end
    if add5 != nil then
      res = res + " " + add5
    end
    if add6 != nil then
      res = res + " " + add6
    end
    if add7 != nil then
      res = res + " " + add7
    end
    if add8 != nil then
      res = res + " " + add8
    end
    return res
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
