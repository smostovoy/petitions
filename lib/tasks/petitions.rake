namespace :petitions do
  desc 'Прекращает голосование по петициям где срок вышел'
  task end_voting: :environment do
    Rails.logger.info "VotingEndingJob enququed"
    VotingEndingJob.perform_later
  end
end
