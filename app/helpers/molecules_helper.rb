module MoleculesHelper

  def molecule_image(smiles)
    "#{Digest::MD5.hexdigest(smiles)}.svg"
  end

end
