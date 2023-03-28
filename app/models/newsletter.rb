class Newsletter < ApplicationRecord
  belongs_to :user

  def self.find_or_create_with_name(domain:, name:)
    just_domain = self.find_by(email: domain)

    if just_domain
      just_domain.update(name: name)
      just-domain
    else
      self.find_or_create_by(email: domain, name: name)
    end
  end
end
