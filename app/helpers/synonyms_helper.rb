module SynonymsHelper
  def revision_status(synonym)
    if synonym.revisions_sorted.blank?
      "no revisions"
    else
      link_to(pluralize(synonym.revisions_sorted.size.to_s, "revision"),
        synonym_versions_path(synonym.id)) + ", latest on " + synonym.revisions_sorted.first.updated_at.to_s +  ' by ' + User.find(synonym.revisions_sorted.first.user_id).login
    end
  end
end