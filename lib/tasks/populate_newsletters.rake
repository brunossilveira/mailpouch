desc "Populates Newsletters from CSV file"
task populate_newsletters: :environment do
  newsletters = CSV.read("newsletters.csv", headers: true)

  newsletters.each do |newsletter|
    newsletter = Newsletter.find_or_create_by(name: newsletter['name'])
  end
end
