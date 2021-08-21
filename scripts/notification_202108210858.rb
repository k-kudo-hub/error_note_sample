# frozen_string_literal: true

Notification.destroy_all
ActiveRecord::Base.connection.execute('alter table notifications auto_increment = 1;')
content = <<~EOS
  ErrorNoteをご利用いただきありがとうございます。
  この度、Twitterアカウントでログインができるようになりました。
  「ログイン」より、「Twitterアカウントでログイン」ボタンを押していただくと、Twitterアカウントでログインいただけます。
EOS
Notification.create!(
  title: '【お知らせ】Twitterアカウントでログインできるようになりました。',
  content: content,
  is_important: false,
  below_header: true
)
