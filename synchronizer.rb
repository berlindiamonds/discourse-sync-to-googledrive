class Synchronizer

	attr_reader :backup

	def initialize
		@backup 						= backup
    @api_key 						= SiteSetting.load_settings(api_key)	# need to find a way to take the
    @turned_on 					= SiteSetting.enabled?								# values from the yml file and
    @number_of_backups 	= SiteSetting.load_settings(quantity) # assign it to the right var
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