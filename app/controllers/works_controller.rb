class WorksController < ApplicationController
  before_action :authenticate_user!, :amazon_client, :set_work, only: [:show, :edit, :update, :destroy, :templater]

  def index
    @works = Work.includes(:clients).all
  end

  def new
    @work = Work.new
    @work.client_works.build
    @work.work_offices.build
    if params[:client]
      @client = Client.find(params[:client])
    end
  end

  def show
    @work = Work.find(params[:id])
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      work_templater(@work, 'wdocs')
      redirect_to @work
    else
      render :new,
      notice: "Erro!!"
    end
  end

  # FEMININ x MASCULIN (TODO: Create Module or Helper)
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



  def work_templater(work, document)
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require 'time'
    require 'rails-i18n'
    require 'pdf_forms'

    # AWS STUFF -- INICIO --
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(ENV['AWS_ID'],ENV['AWS_SECRET_KEY'])})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/#{document}.docx")
    aws_body = aws_doc.body
    # AWS STUFF -- FIM --

    # FIELD TREAT -- INICIO --
    # SIMPLE FIELDS
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

    # NUMERO DE BENEFICIO FIELD
    if client.number_benefit.nil?
      nb_exist = ""
    else
      nb_exist = "número de benefício #{client.number_benefit},"
    end

    # TIME - HORARIO
    dia = I18n.l(Time.now, format: "%d de %B de %Y")

    # NO DB FIELDS CONFIG GENDER
    # GENDER LOGIC
    if client.gender == 2
      civilstatus = genderize.client.civilstatus
      nacionalita = genderize.client.citizenship
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

    # RATE - COBRANCAS 
    # VER RATER 
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

      # :rate_percentage,
      # :rate_percentage_exfield,
      # :rate_fixed,
      # :rate_fixed_exfield,
      # :rate_work,
      # :rate_parceled,
      # :rate_parceled_exfield,

    # LAWYERS E SOCIETY
    laws = [].join("")
    User.all.each.with_index do | xopo, xopi |
       if xopo.id.to_s.include?("#{work.user}")
        next
      else
       laws << "#{xopo.user_profile.name} #{xopo.user_profile.lastname}, inscrito na OAB número #{xopo.oab_number},".to_s
      end
    end
    lawyer_selected = Lawyer.find(@work.responsible_lawyer.to_i)
    lawyer_complete = "sendo como advogado responsável da sociedade #{lawyer_selected.name.upcase} #{lawyer_selected.lastname.upcase}, inscrito na OAB número #{lawyer_selected.oab_number}, e demais:".to_s

    # TODO: Criar logica para ver se e o mesmo endereco dos componentes
    # TODO: Organizar Office aqui - e multiplos offices
    office_select = Office.find(1)
    office = "Escritório de advocacia #{office_select.name.upcase}, inscrito na OAB/PR n #{office_select.oab}, e no CNPJ n #{office_select.cnpj_number}"
    office_bank = "Banco #{office_select.bank} Agência #{office_select.agency}, Conta #{office_select.account}"
    proced = work.procedure.gsub("[", "")
    # Antigo metodo usado pluck, nao recomendavel
    # Office.pluck(:name, :oab, :cnpj_number).join(", ")<< ','

    # DOCUMENT REPLACES
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
        # LAWYER end Society
        tr.substitute('_:lawyers_', laws)
        tr.substitute('_:society_', office)
        tr.substitute('_:lawyerresponsible_', lawyer_complete)
        # NO DB FIELDS CONFIG GENDER
        tr.substitute('_:portador_', porta)
        tr.substitute('_:inscrito_', inscrito)
        tr.substitute('_:domiciliado_', domiciliado)
        # Procedimentos
        tr.substitute('_:procedure_', work.procedure)
        tr.substitute('_:subject_', work.subject)
        tr.substitute('_:action_', work.action)
        tr.substitute('_:number_', work.number)
        tr.substitute('_:powers_', work.power)
        tr.substitute('_:prev-powers_', "")
        # Rates - Valores e Cobrancas 
        tr.substitute('_:rates_', rate_final)
        tr.substitute('_:accountdetails_', office_bank)
        # All Measures Clause - True or False
        tr.substitute('_:timestamp_', dia)
        tr.substitute('_:sname_', office_select.name)
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
    #work.documents = metadata ---
    # Aqui era para um array de documentos que tem no Client
    work.save
    obj.upload_file(ch_file, metadata: metadata)
    
    if work.checklist.include?("Termo")
    aws_doc_tje = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/tje.docx")
    aws_body_tje = aws_doc_tje.body
    doc_tje = Docx::Document.open(aws_body_tje)
    doc_tje.paragraphs.each do |p|
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
        tr.substitute('_:timestamp_', dia)
        tr.substitute('_:sname_', office_select.name)
      end
    end
    ch_save_tje = doc_tje.save(Rails.root.join("tmp/tje-#{nome_correto}_#{@work[:id]}.docx").to_s)
    ch_file_tje = "tmp/tje-#{nome_correto}_#{@work[:id]}.docx"
    obj_tje = @s3.bucket(bucket).object(ch_file_tje)
    obj_tje.upload_file(ch_file_tje)

    end
    
    # if work.checklist.include?("Declaração")
    # end

     if work.checklist.include?("Rural")
       bucket = 'prcstudio3herokubucket'
       aws_pdf = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/aser1.pdf")
       fdf = PdfForms::Fdf.new "Caixa de texto1" => "#{client.name} #{client.lastname}", :other_key => 'other value', "Caixa de texto 5" => client.adress, "Caixa de texto 6" => client.city, "Caixa de texto 7" => client.state, "Caixa de texto 8" => client.social_number, "Caixa de texto 3" => client.birth, "Caixa de texto 3_3" => ""
       #, "Caixa de texto 3_2" => client.nickname (nao existe), "Caixa de texto 8_3" => client.expedicao (nao existe) # /V (@exp)
       puts fdf.aws_pdf
       # write fdf file
       fdf.save_to 'file.fdf'
     end

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
  end

  # GET /works/1/edit
  def edit
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'work Atualizado. Cuidado * Procuracão Não Atualizada' }
        format.json { render :show, status: :ok, location: @work, notice: 'work Atualizado. Cuidado * Procuracão Não Atualizada!!!'}
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @works.destroy
    redirect_to works_path
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
      :recommendation,
      :recommendation_comission,
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
      power_ids: [],
      procedure_ids: [],
      client_works_attributes: [:id, :client_id],
      work_offices_attributes: [:id, :office_id]
      )
  end

end
