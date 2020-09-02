Rails.application.config.middleware.insert_before 0, Rack::Cors do

  if Rails.env.development?
    allow do 
      origins "http://localhost:3000"
      resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head],
    credentials: true
    end 
  end


  if Rails.env.production?
    allow do 
      origins "www.disco-computer.com"
      resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head],
    credentials: true
    end
  end
end