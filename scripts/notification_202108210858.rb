# frozen_string_literal: true

content = <<~EOS
  ErrorNoteをご利用いただきありがとうございます。
  この度、Twitterアカウントでログインができるようになりました。
  「ログイン」より、「Twitterアカウントでログイン」ボタンを押していただくと、Twitterアカウントでログインいただけます。
EOS
Notification.create!(
  title: 'Twitterアカウントでログインできるようになりました。',
  content: content,
  is_important: false,
  below_header: true
)
