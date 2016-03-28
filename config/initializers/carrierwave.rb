CarrierWave.configure do |config|
  config.azure_storage_account_name = ENV["azure_storage_account_name"]
  config.azure_storage_access_key = ENV["azure_storage_access_key"]
  config.azure_container = ENV["azure_container"]
end