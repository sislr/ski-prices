return if ENV.fetch("SECRET_KEY_BASE_DUMMY", nil).present?

MissionControl::Jobs.http_basic_auth_user = Rails.application.credentials.admin.basic_auth.user
MissionControl::Jobs.http_basic_auth_password = Rails.application.credentials.admin.basic_auth.password
