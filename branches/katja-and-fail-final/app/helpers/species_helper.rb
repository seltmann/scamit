module SpeciesHelper
  
  def species_revision_status(species)
    if species.revisions_sorted.blank?
      "no revisions"
    else
      link_to(pluralize(species.revisions_sorted.size.to_s, "revision"),
        species_versions_path(species.id)) + ", latest on " + species.revisions_sorted.first.updated_at.to_s +  ' by ' + User.find(species.revisions_sorted.first.user_id).login
    end
  end
end