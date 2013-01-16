# -*- coding: utf-8 -*-
class Client < ActiveRecord::Base
  has_many :commande
  has_many :bdl
  belongs_to :civilite, :class_name => "Type"
  belongs_to :pays, :class_name => "CleaningPay"
  
  #attr_accessible :long_addresse, :latitude, :longitude
  geocoded_by :long_adresse
  after_validation :geocode, :if => :long_adresse_changed?
  
  validates_presence_of :num_client
  validates_presence_of :nom
  validates_presence_of :num_voie
  validates_presence_of :ville
  validate :must_be_unique

  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  def must_be_unique
    query = "SELECT * FROM CLIENTS WHERE upper(NOM) = upper('#{ nom }') AND upper(PRENOM) = upper('#{ prenom }')"
    if !id.nil?
      query = "#{ query } AND id != #{ id }"
    end
    res = Client.find_by_sql(query)
    if !res.nil? && res.size > 0
      self.errors.add(:nom, "Ce client existe d&eacute;j&agrave;")
    end
  end
    
    
  def form_title
    return "#{nom}"
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
      :pays => CleaningPay.findByNom(self.clean(row[8])),
      :tel => self.clean(row[9]),
      :portable => self.clean(row[11]),
      :fax => self.clean(row[10]),
      :email => self.clean(row[12]),
      :commentaire => self.clean(row[13])
    }
    client.long_adresse = self.concatAddresse(client)
    return client
  end
  
  def self.concatAddresse(client)
    res = ""
    
    res = self.concatElem(res, self.clean(client.bat))
    res = self.concatElem(res, self.clean(client.num_voie))
    res = self.concatElem(res, self.clean(client.bp))
    res = self.concatElem(res, self.clean(client.codepostal))
    res = self.concatElem(res, self.clean(client.ville))
    if !client.pays.nil?
      res = self.concatElem(res, self.clean(client.pays.nom))
    end

    return res
  end
  
  def self.concatElem(res, elem)
    if elem != nil then
      return "#{ res } #{ elem }"
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
  
  def isGeoloc
    return self.longitude != nil && self.latitude != nil
  end

end
