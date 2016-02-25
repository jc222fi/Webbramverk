Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'cde4aa3606235c958fdf', '062de7c24fa6a1b5a5deb54eb2ae335a1af82ded'
end