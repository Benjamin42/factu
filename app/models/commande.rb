class Commande < ActiveRecord::Base
  has_many :commande_produit
  has_many :commande_service
  belongs_to :bdl
  belongs_to :client
  validates_associated :commande_produit

  validates_presence_of :client
  
  def self.next_num_factu
    resReq = find_by_sql("select max(num_factu) + 1 as num_factu from commandes").first.num_factu
    if resReq != nil && resReq != "" then
      return resReq
    else
      return 0
    end
  end

  def commande_produit_attributes=(commande_produit_attributes)
    if commande_produit_attributes.kind_of? Hash
      commande_produit_attributes.each do |id, attributes|
        commandeProduit = CommandeProduit.find(id)
        set_produit_attribute_and_save(commandeProduit, attributes)
      end
    else
      commande_produit_attributes.each do |attributes|
        commandeProduit = commande_produit.build(attributes)
        set_produit_attribute_and_save(commandeProduit, attributes)
      end
    end
  end
  
  def set_produit_attribute_and_save(commande_produit, attributes)
    produit = Produit.find(attributes[:produit_id])
    commande_produit.attributes = {
      :qty => if attributes[:qty] == nil || attributes[:qty] == "" then 0 else attributes[:qty] end,
      :qty_cadeau => attributes[:qty_cadeau],
      :commande => self,
      :produit => produit,
      :tarif => Tarif.findTarif(produit, DateTime.now.strftime('%Y')),
    }
    commande_produit.save
  end
  
  def commande_service_attributes=(commande_service_attributes)
    if commande_service_attributes.kind_of? Hash
      commande_service_attributes.each do |id, attributes|
        commandeService = CommandeService.find(id)
        set_service_attribute_and_save(commandeService, attributes)
      end
    else
      commande_service_attributes.each do |attributes|
        commandeService = commande_service.build(attributes)
        set_service_attribute_and_save(commandeService, attributes)
      end
    end
  end
  
  def set_service_attribute_and_save(commande_service, attributes)
    service = Service.find(attributes[:service_id])
    commande_service.attributes = {
      :montant => attributes[:montant],
      :service => service
    }
    commande_service.save
  end  
    

  def qtyTotal
    count = 0
    self.commande_produit.all.each do |commandeProduit|
      if commandeProduit.qty != nil
      count += commandeProduit.qty
      end
    end

    return count
  end
  
  def mntTotalService
    count = 0
    self.commande_service.all.each do |commandeService|
      if commandeService.montant != nil && commandeService.montant > 0
        count += commandeService.montant
      end
    end

    return count
  end

  def self.build_from_csv(row)
    # find existing customer from email or create new
    commande = nil
    client = Client.find(:all, :conditions => ['num_client = ?', row[3]]).first
    if client != nil
      dateFactu = DateTime.strptime(row[4], '%d/%m/%y').to_date
      
      commande = find_or_initialize_by_num_factu(row[0])
      commande.attributes = {
        :num_factu => row[0],
        #:bdl_id => row[1], # TODO
        :client_id => client.id,
        :date_factu => dateFactu,
        #:nb_etiquette => row[21],
        :is_livraison => true,
        :date_livraison => dateFactu,
        :is_paiement => true,
        :date_paiement => dateFactu
      }
    end
    return commande
  end
  
  def mustBeFreeze
    return self.date_livraison != nil || self.date_paiement != nil || self.date_factu != nil
  end
  
  def isFreeze
    return self.is_freeze
  end
  
end
