Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, 'Iv1.c1c2f7bfd56a933c', '9fe18659d4e431a53f6e73da4d4be15737dc6ba5'
  else
    provider :github,
    Rails.application.credentials.github[:client_id],
    Rails.application.credentials.github[:client_secret]
  end
end
