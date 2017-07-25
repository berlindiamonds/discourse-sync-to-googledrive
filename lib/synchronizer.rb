class Synchronizer

  attr_reader :backup

  def initialize(backup)
    @backup = backup
  end

  def sync
    perform_sync  if can_sync?
  end

  protected

  def perform_sync
  end

end
