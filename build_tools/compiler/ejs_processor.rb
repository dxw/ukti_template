require 'erb'
require_relative 'template_processor'

module Compiler
  class EJSProcessor < TemplateProcessor

    def self.partial_for(key)
      "<%- partial('partials/_#{key}') %>"
    end

    @@yield_hash = {
      after_header:         partial_for(:after_header),
      body_classes:         "<%= bodyClasses %>",
      body_start:           partial_for(:body_start),
      body_end:             partial_for(:body_end),
      content:              partial_for(:content),
      footer_support_links: partial_for(:footer_support_links),
      footer_top:           partial_for(:footer_top),
      homepage_url:         "{% if (homepageUrl) { %><%= homepageUrl %><% } else { %>https://www.exportingisgreat.gov.uk/<% } %>",
      head:                 partial_for(:head),
      header_class:         "<% if (headerClass) { %><%= headerClass %><% } %>",
      html_lang:            "<% if (htmlLang) { %><%= htmlLang %><% } else { %>en-GB<% } %>",
      inside_header:        partial_for(:inside_header),
      page_title:           partial_for(:page_title),
      top_of_page:          partial_for(:top_of_page),
      skip_link_message:    "<% if (skipLinkMessage) { %><%= skipLinkMessage %><% } else { %>Skip to main content<% } %>",
      logo_link_title:      "<% if (logoLinkTitle) { %><%= logoLinkTitle %><% } else { %>Go to the Exporting is GREAT homepage<% } %>",
    }


    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      query_string = UktiTemplate::VERSION
      return "#{file}?#{query_string}" if @is_stylesheet
      case File.extname(file)
      when '.css'
        "<%= uktiTemplateAssetPath %>stylesheets/#{file}?#{query_string}"
      when '.js'
        "<%= uktiTemplateAssetPath %>javascripts/#{file}?#{query_string}"
      else
        "<%= uktiTemplateAssetPath %>images/#{file}?#{query_string}"
      end
    end
  end
end
