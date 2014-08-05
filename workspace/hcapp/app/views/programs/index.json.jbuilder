json.array!(@programs) do |program|
  json.extract! program, :id, :title, :requirements, :costs, :support, :examples, :price, :next_time_from, :next_time_to, :conditions, :administrator
  json.url program_url(program, format: :json)
end
