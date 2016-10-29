class BaseService::Filters
  FILTERS = [
    'MolecularMass'.freeze,
    'LogP'.freeze,
    'AtomNumber'.freeze,
    'HydrogenBondDonor'.freeze,
    'HydrogenBondAcceptor'.freeze,
    'RingNumber'.freeze
  ]

  def initialize(params)
    @params = params
  end

  # Check if a Molecule fits the provided filters
  def valid?(mol)
    !(active_filters.map { |f| f.valid?(mol) }.include?(false))
  end

  # Constants of filters
  def filters
    @filters ||= FILTERS.map { |f| "BaseService::Filters::#{f}".constantize }
  end

  private

  def active_filters
    @active_filters ||= @params.map { |p, _| p.sub('_start', '').sub('_end', '').camelize }.uniq
     .select { |f| FILTERS.include?(f) }
     .map { |f| Object.const_get("BaseService::Filters::#{f}").new(@params) }
     .select { |f| !(f.lower.nil?) || !(f.upper.nil?) }
  end
end
