module SkiPassesHelper
  def price_trend(ski_pass)
    ski_pass
      .price_entries
      .ordered_by_date
      .map { |price| [ price.created_at.strftime("%-e %b"), price.price_in_chf.round(2) ] }
  end
end
