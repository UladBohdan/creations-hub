module CreationHelper

  def get_translated_categories
    Category.to_a.map { |cat, i| [ t("enumerations.category.#{cat.downcase}"), i] } .push(["",0])
  end

end