class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :tipo
      t.string :materia
      t.string :acao
      t.integer :numero
      t.string :honorariosp
      t.string :honorariosp_exfield
      t.string :honorariosf
      t.string :honorariosf_exfield
      t.string :honorarios_trab_x_exito
      t.string :honorarios_parcelamento
      t.string :escritorio
      t.text :poderes
      t.string :indicacao
      t.string :indicacao_comissao
      t.string :pasta
      t.string :atendimento_inicial
      t.string :advogado_responsavel
      t.string :advogado_procuracao
      t.string :estagiarios_procuracao
      t.string :paralegais_procuracao
      t.string :advogado_parceiro
      t.text :notas
      t.string :checklist
      t.string :checklist_documentos
      t.string :documentos_pendentes

      t.timestamps
    end
  end
end
