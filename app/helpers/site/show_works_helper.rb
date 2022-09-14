module Site::ShowWorksHelper
  def updatings(work)
    work.where.not(show_to: 'Equipe')
  end

  def retrieve_doc_url(work)
    work.document['aws_link'] if work.document
  end
end
