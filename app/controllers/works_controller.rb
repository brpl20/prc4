class WorksController < ApplicationController
  before_action :authenticate_user!, :amazon_client, :set_work, only: [:show, :edit, :update, :destroy, :templater]

  def index
    @works = Work.includes(:clients).all
  end

  def new
    @work = Work.new
    @work.client_works.build
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

  def lip
    laws = [].join("")
      Lawyer.all.each do | xopo |
         laws << "#{xopo.name} #{xopo.lastname}, inscrito na OAB número #{xopo.oab_number}".to_s
      end
    return laws
  end

  def work_templater(work, document)
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require 'time'
    require 'rails-i18n'
    # AWS STUFF -- INICIO --
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(ENV['AWS_ID'],ENV['AWS_SECRET_KEY'])})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/#{document}.docx")
    aws_body = aws_doc.body
    # AWS STUFF -- FIM --

    # FIELD TREAT -- INICIO --
    # SIMPLE FIELDS
    client_j = Client.last.as_json
    nome_completo = "#{client_j[:name]} #{client_j[:lastname]}".upcase
    nome_cap = "#{client_j[:name]}".upcase
    sobrenome_cap = "#{client_j[:lastname]}".upcase
    emailx = client_j.emails.each { |em| em.email }

    # PHONE METHOD ARRAY
    def phone
      @client.phones.each { |tl| return tl.phone }
    end
    phonex = phone

    # EMAIL METHOD ARRAY
    def mail_check
      @client.emails.each { |em| return em.email }
    end
    mailx = "endereço de e-mail: #{mail_check}"

    # NUMERO DE BENEFICIO FIELD
    if @client[:number_benefit].nil?
      nb_exist = ""
    else
      nb_exist = "número de benefício #{@client[:number_benefit]},"
    end

    # NO DB FIELDS CONFIG GENDER
    # GENDER LOGIC
    if @client[:gender] == 2
      civilstatus = genderize(@client[:civilstatus])
      nacionalita = genderize(@client[:citizenship])
      porta = "portadora"
      inscrito = "inscrita"
      domiciliado = "domiciliada"
    else
      civilstatus = @client[:civilstatus]
      nacionalita = @client[:citizenship]
      porta = "portador"
      inscrito = "inscrito"
      domiciliado = "domiciliado"
    end

    if @client[:capacity] = 'Capaz' || @client[:capacity] = nil
      capacity_treated = @client[:capacity]
    else
      capacity_treated = "#{@client[:capacity]}, representado por seu genitor(a): ------ Qualificar manualmente o representante legal ----"
    end



    # CLIENT


    # clientx = {}
    # def client_fields(work)
    #   work.id.clients.each do | key, value |
    #     key << clientx
    #     value << clientx
    #   end
    # end
    # client_fields(@work)


    #nome_cap = "#{@client[:name]}".upcase

    # ESCRITORIOS(Office)

    # PODERES - POWERS

    # TODO: Criar logica para Office empty? e nil?
    esc = Office.where(id:1).pluck(:name, :oab, :cnpj_number, :address, :city, :state).join(", ")
    lawyer = Lawyer.find_by_id(@work[:responsible_lawyer])
    lawyer_completo = "#{lawyer.name} #{lawyer.lastname} #{lawyer.oab_number}"
    proced = @work[:procedure]
    rates = helpers.rater(@work[:rate_work], @work[:rate_work_exfield], @work[:rate_percentage_exfield])

    # TIME - HORARIO
    dia = I18n.l(Time.now, format: "%d de %B de %Y")


    # DOCUMENT REPLACES
    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|
        tr.substitute('_:nome_', nome_cap)
        tr.substitute('_:sobrenome_', sobrenome_cap)
        tr.substitute('_:estado_civil_', civilstatus.downcase)
        tr.substitute('_:profissao_', client_j['profession'].downcase)
        tr.substitute('_:capacidade_', capacity_treated.downcase)
        tr.substitute('_:nacionalidade_', nacionalita.downcase)
        tr.substitute('_:rg_', client_j['general_register'])
        tr.substitute('_:cpf_', (client_j['social_number']).to_s)
        tr.substitute('_:nb_', nb_exist)
        tr.substitute('_:email_', mailx)
        tr.substitute('_:endereco_', client_j['address'])
        tr.substitute('_:cidade_', client_j['city'])
        tr.substitute('_:state_', client_j['state'])
        tr.substitute('_:cep_', (client_j['zip']).to_s)
        tr.substitute('_:empresa_atual_', client_j['company'])

        # tr.substitute('_:society_', esc)
        # tr.substitute('_:lawyerresponsible_', lawyer_completo)
        # tr.substitute('_:procedure_', proced)
        # tr.substitute('_:subject_', @work[:subject])
        # tr.substitute('_:action_', @work[:action])
        # tr.substitute('_:rates_', rates)
        # All Measures Clause -
        tr.substitute('_:timestamp_', dia)
      end
    end
    bucket = 'prcstudio3herokubucket'
    nome_correto = Client.last[:name].downcase.gsub(/\s+/, "")
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
                :"user_id" => "#{current_user.id}",
                :document_type => document.to_s,
                :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/#{ch_file}",
                :user => "#{current_user.id}"
                 }
    #work.documents = metadata ---
    # Aqui era para um array de documentos que tem no Client
    work.save
    obj.upload_file(ch_file, metadata: metadata)
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
        format.json { render :show, status: :ok, location: @work }
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
    @work = Work.find(params[:id])
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
      :responsible_lawyer,
      :procuration_lawyer,
      :procuration_intern,
      :procuration_paralegal,
      :partner_lawyer,
      :lawyer_id,
      :note,
      :document_pendent,
      checklist: [],
      checklist_document: [],
      power: [],
      procedure: [],
      client_works_attributes: [:id, :client_id]
      )
  end

end
