class VotingEndingJob < ActiveJob::Base
  queue_as :default

  def perform
    Petition.expired.each do |petition|
      Rails.logger.info "Rake end_voting: processing petition #{petition.id}"
      if petition.collected_votes?
        UserMailer.petition_succeeded(petition).deliver_now
      else
        UserMailer.petition_failed(petition).deliver_now
      end
    end
  end
end
