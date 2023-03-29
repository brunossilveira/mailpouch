require 'csv'

desc "Populates Newsletters from CSV file"
task populate_newsletters: :environment do
  newsletters = CSV.read("newsletters.csv", headers: true)

  newsletters.each do |n|
    newsletter = Newsletter.find_or_create_by(name: n['name'])

    update_params = {
      tags: n['tags'].split(','),
      tagline: n['tagline'],
      description: n['description'],
      frequency: n['frequency'],
      subscribe_url: n['link'],
      subscribers_count: n['subscribers']
    }

    newsletter.update(update_params)
  end
end
