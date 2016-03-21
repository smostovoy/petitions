class UserMailer < ApplicationMailer
  def petition_failed(petition)
    @petition = petition
    @user = petition.user

    mail(to: @user.email, subject: 'Ваша петиция не набрала голосов')
  end

  def petition_succeeded(petition)
    @petition = petition
    @user = petition.user

    mail(to: @user.email, subject: 'Ваша петиция набрала голоса')
  end
end
