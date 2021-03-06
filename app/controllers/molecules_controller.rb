class MoleculesController < ApplicationController
  def index
  end

  def search
    redirect_to root_path, flash: { error: I18n.t('error.insert_smarts') } and return unless params[:base1][:smarts].present? || params[:base2][:smarts].present?
    redirect_to root_path, flash: { error: I18n.t('error.invalid_smarts') } and return unless BaseService::valid_smarts(params[:base1][:smarts]) && BaseService::valid_smarts(params[:base2][:smarts])

    @molecules_b1 = BaseService.instance.search_smart(params[:base1])
    @molecules_b2 = BaseService.instance.search_smart(params[:base2])
    @dump_b1 = BaseService.compress(@molecules_b1.map{ |m| [m.smiles, m.title] })
    @dump_b2 = BaseService.compress(@molecules_b2.map{ |m| [m.smiles, m.title] })
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
    react.reaction = params[:reaction]
    react.add_compressed_base(params[:b1])
    react.add_compressed_base(params[:b2])
    time = Time.now.strftime('%Y%d%m_%H%M%S')
    send_file(react.run, filename: "Reaction_#{time}.xlsx")
  end
end
