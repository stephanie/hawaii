class Category < ActiveRecord::Base
  has_and_belongs_to_many :businesses

  def self.update_category_labels
    factual = Factual.new Factual::KEY, Factual::SECRET

    (0..9).each do |i|
      factual_categories = factual.table("place-categories").offset(50*i).limit(50)

      factual_categories.each do |factual_category|
        category = Category.find_or_initialize_by_id(factual_category['category_id'])
        category.update(:name => factual_category['en'])
        puts 'Updating ' + category
        puts factual_category['category_id']
        puts factual_category['en']
      end

    end
  end


end