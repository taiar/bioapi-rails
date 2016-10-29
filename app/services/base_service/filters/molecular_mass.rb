class BaseService::Filters::MolecularMass < BaseService::Filters::Filter
  def initialize(params)
    @lower = params[:molecular_mass_start].presence
    @upper = params[:molecular_mass_end].presence
  end

  def lower_bound
    unless @lower.nil?
      @mol.exact_mass >= @lower.to_f
    else
      true
    end
  end

  def upper_bound
    unless @upper.nil?
      @mol.exact_mass <= @upper.to_f
    else
      true
    end
  end
end
