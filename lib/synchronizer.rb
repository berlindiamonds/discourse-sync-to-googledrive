class Synchronizer

  attr_reader :backup

  def initialize(backup)
    @backup = backup
  end

  def sync
    perform_sync if can_sync?
  end

  protected

  def can_sync?
    raise "implement this method as a boolean method in your subclass"
  end

  def perform_sync
    raise "implement this method in your subclass"
  end

end
