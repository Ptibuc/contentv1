module CategoriesHelper

  def exist_category(private_category)
    Categorie.exists?(:private_id => private_category, :site_id => session[:site])
  end

  def get_categories
    HTTParty.get "#{SITE_URL}/api/categories", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_category(category)
    HTTParty.get "#{SITE_URL}/api/categories/#{category}", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_category_name(category)
    response = get_category(category)
    return response['prestashop']['category']['name']['language']['__content__']
  end

  def get_category_id_by_private_id(id)
    categorie_id = Categorie.find_by(private_id: id)
    return categorie_id.id
  end

  def add_categorie(category_name, private_id, site)
    c = Categorie.new
    c.name = category_name
    c.private_id = private_id
    c.site_id = site
    c.save
  end

end
