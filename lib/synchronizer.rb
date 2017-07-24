class Synchronizer

  attr_reader :backup

  def initialize
    @backup = backup
    @api_key = SiteSetting.discourse_backups_api_key
    @turned_on = SiteSetting.discourse_backups_enabled
    @number_of_backups = SiteSetting.discourse_backups_quantity
  end

  def can_sync?
    @turned_on && @api_key.present? && backup.present?
  end

  def sync
    if @backup.can_sync
      @backup.perform_sync
    end
  end

  protected
  def perform_sync
  end

end
