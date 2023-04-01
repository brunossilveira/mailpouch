require 'csv'

desc "Populates Newsletters from CSV file"
task populate_newsletters: :environment do
  CSV.foreach("inboxreads.csv", headers: true) do |row|
    newsletter = Newsletter.find_by(name: row['name'])

    if newsletter
      puts "found!"
    else
      newsletter = Newsletter.create(name: row['name']) unless newsletter
    end

    update_params = {
      tags: row['tags'].split(','),
      tagline: row['tagline'],
      category: row['topic'],
      description: row['description'],
      frequency: row['frequency'],
      subscribe_url: row['link'],
      subscribers_count: row['subscribers']
    }

    newsletter.update(update_params)
  end

  CSV.foreach("findnewsletters.csv", headers: true) do |row|
    newsletter = Newsletter.find_by(name: row['name'])

    if newsletter
      puts "found!"
    else
      newsletter = Newsletter.create(name: row['name']) unless newsletter
    end

    update_params = {
      tags: [row['topic']],
      tagline: row['tagline'],
      category: row['topic'],
      description: row['description'],
      frequency: row['frequency'],
      subscribe_url: row['link'],
      subscribers_count: row['subscribers']
    }

    newsletter.update(update_params)
  end
end
