# Pin npm packages by running ./bin/importmap

pin "application"
pin "jquery3"
pin "jquery_ujs"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin "select2", to: "https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"
# pin "select2/dist/css/select2.css", to: "https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.css"
# pin "bootstrap", to: "bootstrap.min.js", preload: true
# pin "@popperjs/core", to: "popper.js", preload: true
pin "fontawesome", to: "fontawesome/js/fontawesome.js"
pin "fontawesome-solid", to: "fontawesome/js/solid.js"
pin "popper", to: "popper.js"
pin "bootstrap", to: "bootstrap.min.js"
