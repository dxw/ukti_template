require 'gem_publisher'
require 'ukti_template/version'

module Publisher
  class GemPublisher
    def initialize(version = UktiTemplate::VERSION)
      @version = version
      @publisher = ::GemPublisher::Publisher.new('ukti_template.gemspec')
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @source_file = @repo_root.join('pkg', "pkg/ukti_template-#{@version}.gem")
    end

    def publish
      @publisher.pusher.push(@source_file, :rubygems)
      @publisher.git_remote.add_tag("v#{@version}")
    end

    def version_released?
      @publisher.version_released?
    end
  end
end
