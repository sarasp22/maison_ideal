json.extract! apartment, :id, :title, :description, :address, :price, :host_id, :created_at, :updated_at
json.url apartment_url(apartment, format: :json)
