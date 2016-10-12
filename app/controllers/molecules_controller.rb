class MoleculesController < ApplicationController
  def index
  end

  def search
    @molecules = BaseService.instance.search_smart(params[:smarts])
    @smarts = params[:smarts]
  end

  def print
    FileUtils.rm('public/mols/mol.svg')
    mol = Rubabel[params[:id]]
    mol.write(Rails.root.join('public/mols/').to_s << 'mol.svg')
  end
end
