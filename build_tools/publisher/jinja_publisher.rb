require 'ukti_template/version'
require 'tmpdir'
require 'open3'

module Publisher
  class JinjaPublisher
    GIT_URL = "git@github.com:dxw/ukti_template_jinja"

    def initialize(version = UktiTemplate::VERSION)
      @version = version
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @source_dir = @repo_root.join('pkg', "jinja_ukti_template-#{@version}")
    end

    def publish
      Dir.mktmpdir("ukti_template_jinja") do |dir|
        run "git clone -q #{GIT_URL.shellescape} #{dir.shellescape}"
        Dir.chdir(dir) do
          run "ls -1 | grep -v 'README.md' | xargs -I {} rm -rf {}"
          run "cp -r #{@source_dir.to_s.shellescape}/* ."
          run "git add -A ."
          run "git commit -q -m 'Publishing UKTI EIG Jinja template version #{@version}'"
          run "git tag v#{@version}"
          run "git push --tags origin master"
          run "npm publish ./"
        end
      end
    end

    def version_released?
      output = run("git ls-remote --tags #{GIT_URL.shellescape}")
      return !! output.match(/v#{@version}/)
    end

    private

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end
  end
end
