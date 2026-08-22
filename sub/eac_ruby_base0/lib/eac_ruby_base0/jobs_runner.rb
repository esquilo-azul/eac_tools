# frozen_string_literal: true

module EacRubyBase0
  module JobsRunner
    common_concern do
      enable_speaker
      include ::EacRubyUtils::SettingsProvider
    end

    def run_job(job)
      return unless run_job?(job)

      infom "Running job \"#{job}\"..."
      send(job)
    end

    def run_job?(job)
      the_method = "run_#{job}?"
      respond_to?(the_method, true) ? send(the_method) : true
    end

    def run_jobs(*jobs)
      jobs = setting_value(:jobs) if jobs.empty?
      r = nil
      jobs.each { |job| r = run_job(job) }
      success 'Done'
      r
    end
  end
end
