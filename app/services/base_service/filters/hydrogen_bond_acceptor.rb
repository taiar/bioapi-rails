class BaseService::Filters::HydrogenBondAcceptor < BaseService::Filters::Filter
  HBA_SMARTS = '[!$([#6,F,Cl,Br,I,o,s,nX3,#7v5,#15v5,#16v4,#16v6,*+1,*+2,*+3])]'

  def initialize(params)
    @lower = params[:hydrogen_bond_acceptor_start].presence
    @upper = params[:hydrogen_bond_acceptor_end].presence
  end

  def valid?(mol)
    @bond_acceptors = nil
    super(mol)
  end

  def lower_bound
    unless @lower.nil?
      bond_acceptors >= @lower.to_i
    else
      true
    end
  end

  def upper_bound
    unless @upper.nil?
      bond_acceptors <= @upper.to_i
    else
      true
    end
  end

  def self.hba(mol)
    mol.matches(BaseService::Filters::HydrogenBondAcceptor::HBA_SMARTS).count
  end

  private

  def bond_acceptors
    @bond_acceptors ||= BaseService::Filters::HydrogenBondAcceptor.hba(@mol)
  end
end
