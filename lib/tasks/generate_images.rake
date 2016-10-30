namespace :images do
  task generate_all: :environment do
    threads = []
    threads_n = 8
    threads_interval = (0..(threads_n - 1))
    molecules = BaseService.instance.molecules
    mol_per_thread = molecules.count / threads_n

    threads_interval.each do |n|
      threads[n] = Thread.new do
        molecules[(n * mol_per_thread)..(((n + 1) * mol_per_thread) - 1)].each do |m|
          name = Digest::MD5.hexdigest(m.smiles)
          file_name = Rails.root.join('public/mols/').to_s << "#{name}.svg"
          unless File.exist?(file_name)
            m.write(file_name)
          end
        end
      end
      threads[n].join
    end

    # BaseService.instance.molecules.each do |m|
    #   name = Digest::MD5.hexdigest(m.smiles)
    #   file_name = Rails.root.join('public/mols/').to_s << "#{name}.svg"
    #   unless File.exist?(file_name)
    #     m.write(file_name)
    #   end
    # end
  end
end
