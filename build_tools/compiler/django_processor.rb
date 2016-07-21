require 'erb'
require_relative 'template_processor'

module Compiler
  class DjangoProcessor < TemplateProcessor

    def self.block_for(key, default_value="")
      "{% block #{key} %}#{default_value}{% endblock %}"
    end

    def self.statement_tag_for(key, default_value)
      "{{ #{key}|default:'#{default_value}' }}"
    end

    @@yield_hash = {
      after_header:         block_for(:after_header),
      body_classes:         block_for(:body_classes),
      body_start:           block_for(:body_start),
      body_end:             block_for(:body_end),
      content:              block_for(:content),
      footer_support_links: block_for(:footer_support_links),
      footer_top:           block_for(:footer_top),
      homepage_url:         statement_tag_for(:homepage_url, 'https://www.exportingisgreat.gov.uk'),
      head:                 block_for(:head),
      header_class:         block_for(:header_class),
      html_lang:            statement_tag_for(:html_lang, 'en-GB'),
      inside_header:        block_for(:inside_header),
      page_title:           block_for(:page_title, "Exporting is GREAT"),
      top_of_page:          "{% load staticfiles %}" + block_for(:top_of_page),
      skip_link_message:    statement_tag_for(:skip_link_message, 'Skip to main content'),
      logo_link_title:      statement_tag_for(:logo_link_title, 'Go to the Exporting is GREAT homepage'),
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      query_string = UktiTemplate::VERSION
      return "#{file}?#{query_string}" if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{% static 'stylesheets/#{file}' %}"
      when '.js'
        "{% static 'javascripts/#{file}' %}"
      else
        "{% static 'images/#{file}' %}"
      end
    end
  end
end
