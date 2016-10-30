class MoleculesController < ApplicationController
  def index
  end

  def search
    @molecules_b1 = BaseService.instance.search_smart(params[:base1])
    @molecules_b2 = BaseService.instance.search_smart(params[:base2])
    @dump_b1 = BaseService.compress(@molecules_b1.map{ |m| m.smiles })
    @dump_b2 = BaseService.compress(@molecules_b2.map{ |m| m.smiles })
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

  def react
    react = ReactionService.new
    react.reaction = '[C:1](=[O:2])O.[N:3]>>[C:1](=[O:2])[N:3]'
    react.add_raw_base(params[:b1])
    react.add_raw_base(params[:b2])
    @result = react.run
  end
end
