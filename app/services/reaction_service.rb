class ReactionService

  attr_accessor :reaction, :base

  def initialize
    @base_dir = Rails.root.join('app/services/reaction_service')
    @zinc_dir = @base_dir.join('vendor/zinc')
    @reactor = @zinc_dir.join('reactsmi.py')
    @tmp_dir =  Rails.root.join('tmp/reactions')
    @reaction_id = SecureRandom.uuid
    @reaction_dir = @tmp_dir.join(@reaction_id)
    @base_txt = []
    @base_mol = []
    @base_pos = 0
    check_reaction_dir
  end

  def check_reaction_dir
    unless File.directory?(@tmp_dir)
      Dir.mkdir(@tmp_dir)
    end
    unless File.directory?(@reaction_dir)
      Dir.mkdir(@reaction_dir)
    end
  end

  def add_compressed_base(content)
    base = BaseService.uncompress(content)
    @base_mol << base
    add_base(base.each_with_index.map{ |x, i| "#{x[0]} #{i}" }.join("\n"))
  end

  def add_base(content)
    @base_txt << content
    write_base
    @base_pos += 1
  end

  def write_base
    File.open(@reaction_dir.join(@base_pos.to_s).to_s, 'w') { |file| file.write(@base_txt[@base_pos]) }
  end

  def run
    run = `#{@reactor.to_s} '#{@reaction}' #{@reaction_dir}/0 #{@reaction_dir}/1`
    ReactionService::Spreadsheet.new(run, @base_mol, @reaction_dir).generate
  end

  def amide_formation
    '[C:1](=[O:2])[Cl:3].[H:99][NH:4][C:0]>>[C:1](=[O:2])[NH:4][C:0].[Cl:3][H:99]'
  end

  def example
    `#{@reactor.to_s} '[C:1](=[O:2])O.[N:3]>>[C:1](=[O:2])[N:3]' #{@zinc_dir}/test1.smi #{@zinc_dir}/test2.smi`
  end
end
