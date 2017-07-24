class Synchronizer

  attr_reader :backup

  def backup
    @backup
  end

  def initialize(backup)
    @backup = backup
    @api_key = SiteSetting.discourse_backups_api_key
    @turned_on = SiteSetting.discourse_backups_enabled
    @number_of_backups = SiteSetting.discourse_backups_quantity
  end

  def can_sync?
    @turned_on && @api_key.present? && backup.present?
  end

  def sync
    if can_sync?
      perform_sync
    end
  end

  protected
  def perform_sync
  end

end
