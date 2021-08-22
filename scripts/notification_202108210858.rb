# frozen_string_literal: true

Notification.destroy_all
ActiveRecord::Base.connection.execute('alter table notifications auto_increment = 1;')
content = <<~EOS
  ErrorNoteをご利用いただきありがとうございます。
  この度、Twitterアカウントでログインができるようになりました。
  画面右上の「ログイン」から、「Twitterアカウントでログイン」ボタンを押していただくと、Twitterアカウントでログインいただけます。
  新しい認証方法をぜひご利用ください。
EOS
Notification.create!(
  title: '【お知らせ】Twitterアカウントでログインできるようになりました。',
  content: content,
  is_important: false,
  below_header: true
)
