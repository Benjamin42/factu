class Bdl < ActiveRecord::Base
  has_many :commande
  has_many :commande_produit
  has_many :commande_service
  belongs_to :client
  
  def self.next_num_bdl
    resReq = find_by_sql("select max(num_bdl) + 1 as num_bdl from bdls").first.num_bdl
    if resReq != nil && resReq != "" then
      return resReq
    else
      return 0
    end
  end
  
  def form_title
    return " #{num_bdl} - #{label}"
  end
  
  def bdl_produit_attributes=(bdl_produit_attributes)
    if bdl_produit_attributes.kind_of? Hash
      bdl_produit_attributes.each do |id, attributes|
        bdlProduit = CommandeProduit.find(id)
        set_attribute_and_save(bdlProduit, attributes)
      end
    else
      bdl_produit_attributes.each do |attributes|
        bdlProduit = commande_produit.build(attributes)
        set_attribute_and_save(bdlProduit, attributes)
      end
    end
  end
  
  def set_attribute_and_save(bdl_produit, attributes)
    produit = Produit.find(attributes[:produit_id])
    bdl_produit.attributes = {
      :qty => attributes[:qty],
      :qty_cadeau => attributes[:qty_cadeau],
      :produit => produit,
      :tarif => Tarif.findTarif(produit, DateTime.now.strftime('%Y')),
    }
    bdl_produit.save
  end
  
  

  def bdl_service_attributes=(bdl_service_attributes)
    if bdl_service_attributes.kind_of? Hash
      bdl_service_attributes.each do |id, attributes|
        bdlService = CommandeService.find(id)
        set_service_attribute_and_save(bdlService, attributes)
      end
    else
      bdl_service_attributes.each do |attributes|
        bdlService = commande_service.build(attributes)
        set_service_attribute_and_save(bdlService, attributes)
      end
    end
  end
  
  def set_service_attribute_and_save(bdlService, attributes)
    service = Service.find(attributes[:service_id])
    bdlService.attributes = {
      :montant => attributes[:montant],
      :service => service
    }
    bdlService.save
  end  
end