SecurityConfig = YAML.load_file("#{::Rails.root.to_s}/config/security.yml")[::Rails.env]