module Potepan::ProductDecorator
  def related_products
    Spree::Product.
      in_taxons(taxons).
      where.not(id: id).
      distinct.
      order(:id)
  end
  # rubocop:disable Rails必要な行
  Spree::Product.prepend self
end
