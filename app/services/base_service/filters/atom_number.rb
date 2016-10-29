class BaseService::Filters::AtomNumber < BaseService::Filters::Filter
  def initialize(params)
    @lower = params[:atom_number_start].presence
    @upper = params[:atom_number_end].presence
  end

  def lower_bound
    unless @lower.nil?
      @mol.count >= @lower.to_i
    else
      true
    end
  end

  def upper_bound
    unless @upper.nil?
      @mol.count <= @upper.to_i
    else
      true
    end
  end
end
