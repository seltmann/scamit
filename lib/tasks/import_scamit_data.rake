$USAGE_SYNONYMS = 'Import SCAMIT synonyms table from CSV file.  Call like: rake scamit:import_synonyms csv=filename.csv'
$USAGE_SPECIES = 'Import SCAMIT species table from CSV.  Call like : rake scamit:import_species csv=filename.csv'

namespace :scamit do
    desc $USAGE_SYNONYMS
    task :import_synonyms => :environment do
      require 'fastercsv'
      csv = FasterCSV.read(ENV['csv'], :headers => true, :row_sep => :auto, :encoding => 'u')
      csv.each do |row|
          Synonym.create(:old_id => row.fields('SynonymID').first, 
            :species_id => row.fields('SpeciesID').first,
            :scamit_id => row.fields('SynSCAMITID').first,
            :genus => row.fields('SynonymGenus').first,
            :species => row.fields('SynonymSpecies').first,
            :describer => row.fields('SynonymDescriber').first,
            :dateadded => row.fields('DateSynonymAdded').first,
            :comments => row.fields('Comments').first,
            :specieslistsort_id => row.fields('SpeciesListSortID').first,
            :chkgenred => row.fields('chkSynGenRed').first,
            :chkspred => row.fields('chkSynSpRed').first,
            :chkauth => row.fields('chkSynAuth').first,
            :created_at => row.fields('DateSynonymAdded').first)
      end
    end
    
    desc $USAGE_SPECIES
    task :import_species => :environment do
      require 'fastercsv'
      require 'iconv'
      csv = FasterCSV.read(ENV['csv'], :headers => true, :row_sep => :auto, :encoding => 'u')
      csv.each do |row|
        Species.create(:sort_id => row.fields('SortID').first,
          :scamit_id => row.fields('SCAMIT_ID').first,
          :phylum => row.fields('Phylum').first,
          :subphylum => row.fields('Subphylum').first,
          :theclass => row.fields('Class').first,
          :subclass => row.fields('Subclass').first,
          :infraclass => row.fields('Infraclass').first,
          :superorder => row.fields('Superorder').first,
          :order => row.fields('Order').first,
          :suborder => row.fields('Suborder').first,
          :infraorder => row.fields('Infraorder').first,
          :superfamily => row.fields('Superfamily').first,
          :family => row.fields('Family').first,
          :subfamily => row.fields('Subfamily').first,
          :genus => row.fields('Genus').first,
          :subgenus => row.fields('Subgenus').first,
          :species => row.fields('species').first,
          :describer =>  row.fields('Describer').first,
          :red => row.fields('red').first,
          :bold => row.fields('bold').first,
          :nonstandarditalic => row.fields('non_standard_italic').first,
          :authorred => row.fields('AuthorRed').first,
          :subgenusred => row.fields('SubgenusRed').first
        )
      end
    end
end
    