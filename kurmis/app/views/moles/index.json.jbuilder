json.array!(@moles) do |mole|
  json.extract! mole, :id, :name, :score, :avatar
  json.url mole_url(mole, format: :json)
end
