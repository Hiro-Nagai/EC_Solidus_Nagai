module Potepan::ProductDecorator
  def related_products
    Spree::Product.
      in_taxons(@taxons).
      where(spree_products_taxons: { taxon_id: taxons }).joins(:taxons).
      where.not(id: id).
      distinct.
      order(:id).
      includes(master: [:default_price, images: { attachment_attachment: :blob }])
  end
  Spree::Product.prepend self

end
