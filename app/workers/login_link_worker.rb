class LoginLinkWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    DI.get(SendLoginLink).call(user)
  end
end
