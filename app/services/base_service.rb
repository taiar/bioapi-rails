class BaseService
  include Singleton

  @@molecules = []
  @@read = false

  def molecules
    if !@@read
      Rubabel.foreach(base_file_path.to_s) { |molecule| @@molecules << molecule }
      @@read = true
    end
    @@molecules
  end

  def readen
    !!@@read
  end

  def search_smart(params)
    smarts = Rubabel::Smarts.new(params[:smarts])
    filter = BaseService::Filters.new(params)
    molecules.select { |m| m.matches(smarts).count > 0 && filter.valid?(m) }
  end

  private

  def base_file_path
    @@base_file_path ||= Rails.root.join('resource/base/base.mol2')
  end
end
