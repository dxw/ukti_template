module UktiTemplate
  class Engine < ::Rails::Engine
    initializer "ukti_template.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        favicon.png
        favicon.svg
        ukti-template.scss
        ukti-template.js
        modernizr.min.js
        oldie-support.min.js
        prismjs.js
      )
    end
  end
end
