class BaseService::Filters::Filter

  attr_reader :lower, :upper

  def valid?(mol)
    @mol = mol
    lower_bound && upper_bound
  end
end
