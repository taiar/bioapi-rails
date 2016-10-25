class MoleculesController < ApplicationController
  def index
  end

  def search
    @molecules = BaseService.instance.search_smart(params)
    @smarts = params[:smarts]
  end

  def print
    smiles = params[:id]
    @name = Digest::MD5.hexdigest(smiles)
    unless File.exist?("public/mols/#{@name}.svg")
      mol = Rubabel[smiles]
      mol.write(Rails.root.join('public/mols/').to_s << "#{@name}.svg")
    end
  end
end
