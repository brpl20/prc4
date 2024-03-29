# frozen_string_literal: true

module JobsHelper
  def options_for_job_status
    [['Pendente', 0], ['Atrasado', 1], ['Finalizado', 2]]
  end

  def options_for_job_priority
    [['Normal', 0], ['Alta', 1]]
  end

  def options_for_job_work
    Work.order(:id).map{|c| [c.id, "#{c.number} - #{c.subject}"] }
  end
end
