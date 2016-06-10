class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :ticker
      t.string :exchange
      t.string :sector
      t.string :sub_sector
      t.string :industry_group
      t.string :country
      t.string :next_filing_date
      t.string :datetime
      t.string :status
      t.string :ein

      t.timestamps
    end
  end
end
