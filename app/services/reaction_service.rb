class ReactionService

  attr_accessor :reaction

  def initialize
    @base_dir = Rails.root.join('app/services/reaction_service')
    @zinc_dir = @base_dir.join('vendor/zinc')
    @reactor = @zinc_dir.join('reactsmi.py')
  end

  def example
    `#{@reactor.to_s} '[C:1](=[O:2])O.[N:3]>>[C:1](=[O:2])[N:3]' #{@zinc_dir}/test1.smi #{@zinc_dir}/test2.smi`
  end
end
