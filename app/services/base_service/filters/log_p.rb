class BaseService::Filters::LogP < BaseService::Filters::Filter
  def initialize(params)
    @lower = params[:log_p_start].presence
    @upper = params[:log_p_end].presence
  end

  def valid?(mol)
    @ilogp = nil
    super(mol)
  end

  def lower_bound
    unless @lower.nil?
      ilogp >= @lower.to_f
    else
      true
    end
  end

  def upper_bound
    unless @upper.nil?
      ilogp <= @upper.to_f
    else
      true
    end
  end

  def self.logp(mol)
    OpenBabel::OBDescriptor.find_type('logP').predict(mol.ob)
  end

  private

  def ilogp
    @ilogp ||= BaseService::Filters::LogP.logp(@mol)
  end

end
