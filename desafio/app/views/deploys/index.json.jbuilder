json.array!(@deploys) do |deploy|
  json.extract! deploy, :id, :componente, :versao, :responsavel, :status, :created_at, :updated_at
  json.url deploy_url(deploy, format: :json)
end
