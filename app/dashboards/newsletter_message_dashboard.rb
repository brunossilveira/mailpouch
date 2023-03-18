require "administrate/base_dashboard"

class NewsletterMessageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    body: Field::Text,
    body_parsed: Field::Text,
    body_raw: Field::Text,
    body_text: Field::Text,
    newsletter: Field::BelongsTo,
    read: Field::Boolean,
    subject: Field::String,
    unsubscribe_url: Field::String,
    user: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    body
    body_parsed
    body_raw
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    body
    body_parsed
    body_raw
    body_text
    newsletter
    read
    subject
    unsubscribe_url
    user
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    body
    body_parsed
    body_raw
    body_text
    newsletter
    read
    subject
    unsubscribe_url
    user
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how newsletter messages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(newsletter_message)
  #   "NewsletterMessage ##{newsletter_message.id}"
  # end
end