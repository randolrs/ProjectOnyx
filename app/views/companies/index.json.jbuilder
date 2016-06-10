json.array!(@companies) do |company|
  json.extract! company, :id, :name, :ticker, :exchange, :sector, :sub_sector, :industry_group, :country, :next_filing_date, :datetime, :status, :ein
  json.url company_url(company, format: :json)
end
