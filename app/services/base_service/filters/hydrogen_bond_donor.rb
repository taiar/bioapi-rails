class BaseService::Filters::HydrogenBondDonor < BaseService::Filters::Filter

  HBD_SMARTS = '[!#6;!H0]'

  def initialize(params)
    @lower = params[:hydrogen_bond_donor_start].presence
    @upper = params[:hydrogen_bond_donor_end].presence
  end

  def lower_bound
    puts bond_donnors
    unless @lower.nil?
      bond_donnors >= @lower.to_i
    else
      true
    end
  end

  def upper_bound
    unless @upper.nil?
      bond_donnors <= @upper.to_i
    else
      true
    end
  end

  def self.hbd(mol)
    mol.matches(BaseService::Filters::HydrogenBondDonor::HBD_SMARTS).count
  end

  private

  def bond_donnors
    BaseService::Filters::HydrogenBondDonor.hbd(@mol)
  end
end
