class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  def confirmation_instructions(record, token, opts={})
    if record.unconfirmed_email != nil
      opts[:subject] = "【ErrorNote】メールアドレス変更手続きを完了してください"
    else
      opts[:subject] = "【ErrorNote】会員登録手続きを完了してください"
    end
    super
  end
end
