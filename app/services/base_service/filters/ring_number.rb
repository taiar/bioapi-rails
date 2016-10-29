class BaseService::Filters::RingNumber < BaseService::Filters::Filter
  def initialize(params)
    @lower = params[:ring_number_start].presence
    @upper = params[:ring_number_end].presence
  end

  def lower_bound
    unless @lower.nil?
      @mol.ob_sssr.count >= @lower.to_i
    else
      true
    end
  end

  def upper_bound
    unless @upper.nil?
      @mol.ob_sssr.count <= @upper.to_i
    else
      true
    end
  end
end
