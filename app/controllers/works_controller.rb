# frozen_string_literal: true

class WorksController < BackofficeController
  before_action :amazon_client, :set_work, only: [:show, :edit, :update, :destroy, :templater]

  def index
    @works = Work.includes(:clients).all
  end

  def new
    @work = Work.new
    @work.client_works.build
    @work.work_offices.build
    @work.powers.build
    @work.build_tributary
    @client = Client.find(params[:client]) if params[:client]
  end

  def show
    @work = Work.find(params[:id])
    @client = @work.clients.last
    @url = @work.document['aws_link'] if @work.document
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      #work_templater(@work, 'wdocs')
      redirect_to @work
    else
      render :new,
      notice: "Erro!!"
    end
  end

   def genderize(field)
     case field
     when "Casado"
       field.sub! 'Casado', 'Casada'
     when "Solteiro"
       field.sub! 'Solteiro', 'Solteira'
     when "Divorciado"
       field.sub! 'Divorciado', 'Divorciada'
     when "Viúvo"
       field.sub! 'Viúvo', 'Viúva'
     when "Brasileiro"
       field.sub! 'Brasileiro', 'Brasileira'
     when "Estrangeiro"
       field.sub! 'Estrangeiro', 'Estrangeira'
     else
       "em União Estável"
     end
   end

   def fullqual(person)
     if person.gender == 1
       qual = "#{person.name} #{person.lastname}, #{person.citizenship}, #{person.civilstatus}, #{person.profession}, inscrita no CPF #{person.social_number} e portadora do RG n #{person.general_register}, residente e domiciliada à #{person.address}, #{person.city} #{person.state}."
     else
       qual = "#{person.name} #{person.lastname}, #{person.citizenship}, #{person.civilstatus}, #{person.profession}, inscrito no CPF #{person.social_number} e portador do RG n #{person.general_register}, residente e domiciliado à #{person.address}, #{person.city} #{person.state}."
     end
   end

  def work_templater(work, document)
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require 'time'
    require 'rails-i18n'
    require 'pdf_forms'

    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(ENV['AWS_ID'],ENV['AWS_SECRET_KEY'])})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/#{document}.docx")
    aws_body = aws_doc.body

    client = work.clients.last
    nome_cap = client.name.upcase
    sobrenome_cap = client.lastname.upcase
    nome_completo = "#{nome_cap} #{sobrenome_cap}"

    emails = [].join("")
    client.emails.each do | em |
      emails << "#{em.email}, "
    end

    phones = [].join("")
    client.phones.each do | tl |
      phones << "#{tl.phone}, "
    end

    if client.number_benefit.nil? || client.number_benefit == ""
      nb_exist = ""
    else
      nb_exist = "número de benefício #{client.number_benefit},"
    end

    dia = I18n.l(Time.now, format: "%d de %B de %Y")

    if client.gender == 1
      civilstatus = client.civilstatus
      nacionalita = genderize(client.citizenship)
      porta = "portadora"
      inscrito = "inscrita"
      domiciliado = "domiciliada"
    else
      civilstatus = client.civilstatus
      nacionalita = client.citizenship
      porta = "portador"
      inscrito = "inscrito"
      domiciliado = "domiciliado"
    end

    if client.capacity = 'Capaz' || client.capacity = nil
      capacity_treated = client.capacity
    else
      capacity_treated = "#{client.capacity}, representado por seu genitor(a): ------ Qualificar manualmente o representante legal ----"
    end

    bank = ". Dados bancários: Banco: #{client.bank.name}, Agência #{client.bank.agency}, Conta: #{client.bank.account}"

    proceds = [].join("")
    work.procedures.each do | des |
      proceds << des.description
    end

    powerxx = [].join("")
    # work.powers.each_with_index do | pw, ind |
    #   if ind.equal?(work..last)
    #     powerxx << "#{JSON.parse(pw.description)[1]}, "
    #   else
    #     powerxx << "#{JSON.parse(pw.description)[1]}."
    #   end
    # end

    work.powers.each do | pw |
      if pw.equal?(work.powers.last)
        powerxx << "#{JSON.parse(pw.description)[1]}."
      else
        powerxx << "#{JSON.parse(pw.description)[1]}, "
      end
    end

    def rater(rate, trabalho, exito)
      if trabalho.to_i < 100
        trabalho = "#{trabalho} benefícios previdenciários"
      else
        trabalho = "R$ #{trabalho},00 (#{Extenso.moeda(trabalho.to_f).downcase})"
      end
      if rate == "Trabalho"
        return "o cliente pagará ao advogado o valor de #{trabalho}"
      elsif rate == "Êxito"
         return "o cliente pagará ao advogado o valor de #{exito}\% sobre os benefícios advindos do processo"
       else
        return "o cliente pagará ao advogado o valor de #{trabalho} e o total de #{exito}\% dos benefícios advindos do processo"
      end
    end

    rate_final = rater(work.rate_work, work.rate_fixed_exfield, work.rate_percentage_exfield)

    def rate_parcel(parcel)
     if parcel.rate_parceled == "Sim"
      return ". O valor fixo poderá ser parcelado em #{parcel.rate_parceled_exfield}, a critério do cliente."
    else
      return "[configurar parcelamento]"
      end
    end

    rate_parceled_final = rate_parcel(work)

    lawyers = UserProfile.lawyer
    paralegals = UserProfile.paralegal
    interns = UserProfile.intern

    if lawyers.size > 0.5
      laws = ["Advogados: "].join("")
      lawyerresp = []
    else
      laws = [""].join("")
    end

    if paralegals.size > 0.5
      parals = ["Paralegais: "].join("")
    else
      parals = [""].join("")
    end

    if interns.size > 0.5
      inters = ["Estagiários: "].join("")
    else
      inters = [""].join("")
    end

    lawyers.each_with_index do | x, index |
      if index == lawyers.size-1
        laws << "#{x.name} #{x.lastname}, #{x.civilstatus}, OAB/PR #{x.oab}.".to_s
      else
        laws << "#{x.name} #{x.lastname}, #{x.civilstatus}, OAB/PR #{x.oab}, ".to_s
      end
    end

    paralegals.each_with_index do | x, index |
      if index == paralegals.size-1
        parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      else
        parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      end
    end

    interns.each_with_index do | x, index |
      if index == interns.size-1
        inters << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      else
        inters << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      end
    end

    offices = Office.all
    if offices.size > 0.5
      office_sel = Office.find_by_id(1)
      office = ["Escritório: "].join("")
      office_email = office_sel.email
      office_address = "#{office_sel.address}, #{office_sel.city}, #{office_sel.state}."
      office << "#{office_sel.name}"
    else
      office = [""].join("")
      office_address = "#{lawyers[1]}"
    end
    office_bank = "Banco #{office_sel.bank} Agência #{office_sel.agency}, Conta #{office_sel.account}"

    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|
        tr.substitute('_:nome_', nome_cap)
        tr.substitute('_:sobrenome_', sobrenome_cap)
        tr.substitute('_:estado_civil_', civilstatus.downcase)
        tr.substitute('_:profissao_', client.profession.downcase)
        tr.substitute('_:capacidade_', capacity_treated.downcase)
        tr.substitute('_:nacionalidade_', nacionalita.downcase)
        tr.substitute('_:rg_', client.general_register)
        tr.substitute('_:cpf_', client.social_number.to_s)
        tr.substitute('_:nb_', nb_exist)
        tr.substitute('_:email_', emails)
        tr.substitute('_:phone_', phones)
        tr.substitute('_:endereco_', client.address)
        tr.substitute('_:cidade_', client.city)
        tr.substitute('_:state_', client.state)
        tr.substitute('_:cep_', client.zip.to_s)
        tr.substitute('_:empresa_atual_', client.company)
        tr.substitute('_:banco_', bank)

        tr.substitute('_:lawyers_', laws)
        tr.substitute('_:society_', office)
        tr.substitute('_:lawyerresponsible_',  @work.user[:name].to_s)

        tr.substitute('_:portador_', porta)
        tr.substitute('_:inscrito_', inscrito)
        tr.substitute('_:domiciliado_', domiciliado)

         tr.substitute('_:procedure_', proceds)
         tr.substitute('_:subject_', work.subject)
         tr.substitute('_:action_', work.action)
         tr.substitute('_:number_', work.number)
         tr.substitute('_:powers_', powerxx)

         tr.substitute('_:lawyers_', laws)
         tr.substitute('_:sociedade_', office)
         tr.substitute('_$parl_', parals)
         tr.substitute('$es', inters)
         tr.substitute('_:addressoficial_', office_address)
         # tr.substitute('_:emailoficial_', office_email)
         #tr.substitute('_:prev-powers_', "")

        tr.substitute('_:rates_', rate_final)
        tr.substitute('_:parcel_', rate_parceled_final)
        tr.substitute('_:accountdetails_', office_bank)

        tr.substitute('_:timestamp_', dia)
        tr.substitute('_:sname_', office_sel.name.upcase)
        tr.substitute('_:fullqual_', fullqual(client))
      end
    end
    bucket = 'prcstudio3herokubucket'
    nome_correto = client.name.downcase.gsub(/\s+/, "")
    ch_save = doc.save(Rails.root.join("tmp/wdocs-#{nome_correto}_#{@work[:id]}.docx").to_s)
    ch_file = "tmp/wdocs-#{nome_correto}_#{@work[:id]}.docx"
    obj = @s3.bucket(bucket).object(ch_file)
    #backup
      #ch_save = doc.save(Rails.root.join("public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
      #ch_file = "public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx"
      #obj = @s3.bucket(bucket).object(ch_file)
    #backup
    metadata = {
                :document_key => ch_file,
                :document_name => "wdocs-#{@work[:id]}.docx",
                :work_id => "#{@work.id}",
                :user_id => "#{current_user.id}",
                :document_type => document.to_s,
                :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/#{ch_file}",
                :user => "#{current_user.email}"
                 }
    work.document = metadata
    work.save
    obj.upload_file(ch_file, metadata: metadata)


    # if work.checklist.include?("Termo")
    # aws_doc_tje = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/tje.docx")
    # aws_body_tje = aws_doc_tje.body
    # doc_tje = Docx::Document.open(aws_body_tje)
    # doc_tje.paragraphs.each do |p|
    #   p.each_text_run do |tr|
    #     tr.substitute('_:nome_', nome_cap)
    #     tr.substitute('_:sobrenome_', sobrenome_cap)
    #     tr.substitute('_:estado_civil_', civilstatus.downcase)
    #     tr.substitute('_:profissao_', client.profession.downcase)
    #     tr.substitute('_:capacidade_', capacity_treated.downcase)
    #     tr.substitute('_:nacionalidade_', nacionalita.downcase)
    #     tr.substitute('_:rg_', client.general_register)
    #     tr.substitute('_:cpf_', client.social_number.to_s)
    #     tr.substitute('_:nb_', nb_exist)
    #     tr.substitute('_:email_', emails)
    #     tr.substitute('_:phone_', phones)
    #     tr.substitute('_:timestamp_', dia)
    #     tr.substitute('_:sname_', office_select.name)
    #   end
    # end
    # ch_save_tje = doc_tje.save(Rails.root.join("tmp/tje-#{nome_correto}_#{@work[:id]}.docx").to_s)
    # ch_file_tje = "tmp/tje-#{nome_correto}_#{@work[:id]}.docx"
    # obj_tje = @s3.bucket(bucket).object(ch_file_tje)
    # obj_tje.upload_file(ch_file_tje)

  end

    # if work.checklist.include?("Declaração")
    # end


    # if work.checklist.include?("Rural")
    # Elementos de cada arquivo
       # bucket = 'prcstudio3herokubucket'
       # aws_pdf = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/aser1.pdf")
       # fdf = PdfForms::Fdf.new "Caixa de texto1" => "#{client.name} #{client.lastname}", :other_key => 'other value', "Caixa de texto 5" => client.address, "Caixa de texto 6" => client.city, "Caixa de texto 7" => client.state, "Caixa de texto 8" => client.social_number, "Caixa de texto 3" => client.birth, "Caixa de texto 3_3" => ""
       #, "Caixa de texto 3_2" => client.nickname (nao existe), "Caixa de texto 8_3" => client.expedicao (nao existe) # /V (@exp)
       # puts fdf.aws_pdf
       # pdf_save = fdf_trabalhado.save(Rails.root.join("tmp/rural-fdf.pdf").to_s)
       # pdf_file = "tmp/rural-fdf.pdf"
       # obj_tje = @s3.bucket(bucket).object(pdf_file)
       # obj_tje.upload_file(pdf_file)
       # write fdf file
       #fdf.save_to 'file.fdf'
    #end

      #           nome_correto = client.name.downcase.gsub(/\s+/, "")
      #     ch_save = doc.save(Rails.root.join("tmp/wdocs-#{nome_correto}_#{@work[:id]}.docx").to_s)
      #     ch_file = "tmp/wdocs-#{nome_correto}_#{@work[:id]}.docx"
      #     obj = @s3.bucket(bucket).object(ch_file)
      #     #backup
      #       #ch_save = doc.save(Rails.root.join("public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
      #       #ch_file = "public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx"
      #       #obj = @s3.bucket(bucket).object(ch_file)
      #     #backup
      #     metadata = {
      #                 :document_key => ch_file,
      #                 :document_name => "wdocs-#{@work[:id]}.docx",
      #                 :work_id => "#{@work.id}",
      #                 :user_id => "#{current_user.id}",
      #                 :document_type => document.to_s,
      #                 :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/#{ch_file}",
      #                 :user => "#{current_user.email}"
      #                  }
      #     #work.documents = metadata ---
      #     # Aqui era para um array de documentos que tem no Client
      #     work.save
      #     obj.upload_file(ch_file, metadata: metadata)
      #     end
      # end
  #end

  def edit
    @client = Client.find(params[:client_id])
  end

  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'Trabalho Atualizado. Cuidado * Procuracão Não Atualizada' }
        format.json { render :show, status: :ok, location: @work, notice: 'Trabalho Atualizado. Cuidado * Procuracão Não Atualizada!!!'}
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @work.destroy
      redirect_to works_path, notice: "Excluído com sucesso!"
    else
      redirect_to works_path, notice: "Houve um problema"
    end
  end

  private

  def set_work
    @work = Work.includes(:work_offices, :offices, :clients, :client_works).find(params[:id])
  end

  def amazon_client
   require 'aws-sdk-s3'
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
  end

  def work_params
    params.require(:work).permit(
      :subject,
      :action,
      :number,
      :rate_percentage,
      :rate_percentage_exfield,
      :rate_fixed,
      :rate_fixed_exfield,
      :rate_work,
      :rate_parceled,
      :rate_parceled_exfield,
      :folder,
      :initial_atendee,
      :user_id,
      :procuration_lawyer,
      :procuration_intern,
      :procuration_paralegal,
      :partner_lawyer,
      :lawyer_id,
      :note,
      :document_pendent,
      checklist_document_ids: [],
      checklist_ids: [],
      procedure_ids: [],
      power_ids: [],
      archive_file: [],
      client_works_attributes: %i[id client_id recommendation value percentage],
      work_offices_attributes: %i[id office_id],
      tributary_attributes: [:id,
                            :compensation,
                            :craft,
                            :lawsuit,
                            :projection,
                            :work_id]
      )
  end

end
