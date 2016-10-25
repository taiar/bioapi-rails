class BaseService::Filters::AtomNumber
  def initialize(params)
    @lower = params[:atom_number_start].presence
    @upper = params[:atom_number_end].presence
  end

  def valid?(mol)
    @mol = mol
    lower_bound && upper_bound
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
