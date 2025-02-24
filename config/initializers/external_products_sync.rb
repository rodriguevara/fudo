Rails.application.config.after_initialize do
  if Rails.env.development?
    begin
      if ActiveRecord::Base.connection.data_source_exists?("products") && Product.count.zero?
        SyncExternalProductsJob.perform_later
      end
    rescue ActiveRecord::NoDatabaseError, PG::ConnectionBad => e
      Rails.logger.warn "Database not ready yet: #{e.message}"
    end
  end
end
