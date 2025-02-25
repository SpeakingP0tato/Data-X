Rails.application.routes.draw do
  get "home/top"
  
  # 루트 경로 추가 (루트 URL 접근 시 home#top을 실행)
  root "home#top"

  # 기본적으로 제공되는 Rails health check (유지)
  get "up" => "rails/health#show", as: :rails_health_check
end
