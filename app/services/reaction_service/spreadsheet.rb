class ReactionService::Spreadsheet
  def initialize(run, bases)
    @raw_run = run
    @bases = bases
  end

  def generate
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Base 1") { |sheet| add_base_sheet(sheet, @bases[0]) }
      p.workbook.add_worksheet(:name => "Base 2") { |sheet| add_base_sheet(sheet, @bases[1]) }
      p.workbook.add_worksheet(:name => "Reactions") do |sheet|
      end
      p.serialize('simple.xlsx')
    end
  end

  private

  def add_base_sheet(sheet, base)
    sheet.add_row ["#{sheet.name} ID", 'ZINC ID', 'Molecule Smiles', 'LogP', 'Mass',
      'Atoms number', 'Rings number', 'HBA', 'HBD', 'ZINC URL']
    num = 0
    base.each do |m|
      mol = Rubabel[m[0]]
      sheet.add_row [num, m[1], m[0], '%.5f' % BaseService::Filters::LogP.logp(mol),
        '%.2f' % mol.exact_mass, mol.count, mol.ob_sssr.count,
        BaseService::Filters::HydrogenBondDonor.hbd(mol),
        BaseService::Filters::HydrogenBondAcceptor.hba(mol), zinc_url(m)]
      num += 1
    end
  end

  def zinc_url(m)
    "http://zinc.docking.org/substance/#{m[1]}"
  end
end
