// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "@rails/ujs" // Import Rails UJS to handle method: :delete links
import "controllers"
import "@popperjs/core"
import "bootstrap"

// Initialize Rails UJS
Rails.start()
