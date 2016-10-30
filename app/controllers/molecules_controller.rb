class MoleculesController < ApplicationController
  def index
  end

  def search
    @molecules_b1 = BaseService.instance.search_smart(params[:base1])
    @molecules_b2 = BaseService.instance.search_smart(params[:base2])
    @smarts_b1 = params[:base1][:smarts]
    @smarts_b2 = params[:base2][:smarts]
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
