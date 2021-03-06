require 'spec_helper'
require File.join(PROJECT_ROOT, 'build_tools/compiler/jinja_processor.rb')

def valid_sections
  {
    after_header: "{% block after_header %}{% endblock %}",
    body_classes: "{% block body_classes %}{% endblock %}",
    body_end: "{% block body_end %}{% endblock %}",
    content: "{% block content %}{% endblock %}",
    footer_support_links: "{% block footer_support_links %}{% endblock %}",
    footer_top: "{% block footer_top %}{% endblock %}",
    head: "{% block head %}{% endblock %}",
    header_class: "{% block header_class %}{% endblock %}",
    html_lang: "{{ html_lang|default('en-GB') }}",
    inside_header: "{% block inside_header %}{% endblock %}",
    page_title: "{% block page_title %}Exporting is GREAT{% endblock %}",
    top_of_page: "{% block top_of_page %}{% endblock %}"
  }
end

describe Compiler::JinjaProcessor do

  let(:file) {"some/file.erb"}
  subject {described_class.new(file)}


  describe "#handle_yield" do
    valid_sections.each do |key, content|
      it "should render #{content} for #{key}" do
        expect(subject.handle_yield(key)).to eql(content)
      end
    end
  end

  describe "#asset_path" do
    context "if file is stylesheet" do
      let(:asset_file) {"a/file.css"}
      before do
        subject.instance_variable_set(:@is_stylesheet, true)
      end
      it "should return the file" do
        expect(subject.asset_path(asset_file)).to eql("#{asset_file}?#{UktiTemplate::VERSION}")
      end
    end
    context "if not stylesheet" do
      context "if css file path passed in" do
        let(:css_asset_file) {"a/file.css"}
        it "should return the correct path for a stylesheet" do
          expect(subject.asset_path(css_asset_file)).to eql("{{ asset_path }}stylesheets/#{css_asset_file}?#{UktiTemplate::VERSION}")
        end
      end
      context "if javascript file path passed in" do
        let(:js_asset_file) {"a/file.js"}
        #up for debate - whole project is js
        it "should return the correct path for a javascript file" do
          expect(subject.asset_path(js_asset_file)).to eql("{{ asset_path }}javascripts/#{js_asset_file}?#{UktiTemplate::VERSION}")
        end
      end
      context "if other file path passed in" do
        let(:other_asset_file) {"a/file.png"}
        it "should return the correct path for an image" do
          expect(subject.asset_path(other_asset_file)).to eql("{{ asset_path }}images/#{other_asset_file}?#{UktiTemplate::VERSION}")
        end
      end
    end
  end

end
