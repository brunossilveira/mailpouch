# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.41.0/dist/index.js"
pin "hotkeys-js", to: "https://ga.jspm.io/npm:hotkeys-js@3.8.9/dist/hotkeys.esm.js"
pin "stimulus", to: "https://ga.jspm.io/npm:stimulus@2.0.0/dist/stimulus.umd.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.5/lib/index.js"
pin "stripe", to: "https://js.stripe.com/v3/", preload: true
pin "el-transition", to: "https://ga.jspm.io/npm:el-transition@0.0.7/index.js"
