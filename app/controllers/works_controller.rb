class WorksController < ApplicationController
before_action :authenticate_user!, :amazon_client, :set_work, only: [:show, :edit, :update, :destroy, :templater]

  def index
    @works = Work.includes(:clients).all
  end

  def new
    @work = Work.new
    @work.client_works.build
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      work_templater(@work, 'wdocs') # Cuidar Aqui
      redirect_to @work
    else
      render :new,
      notice: "Erro!!"
    end
  end

  def show
    require 's3'
    service = S3::Service.new(
      :access_key_id => ENV['AWS_ID'],
      :secret_access_key => ENV['AWS_SECRET_KEY']
     )
    @work = Work.find(params[:id])
    #doc_link = @work.document["document_name"]
    #@work.documents[:aws_link]
    @meta = []
    @meta2 = []
    #criar objeto
    #@bucket = service.buckets.find("prcstudio3herokubucket")
    #@object = @bucket.objects.find("tmp/#{doc_link}")
    #@url = @object.temporary_url(Time.now + 1800)
    @meta << @object
    @work = Work.find(params[:id])
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
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/#{document}.docx")
    aws_body = aws_doc.body
    # AWS STUFF -- FIM --

    # ADVOGADOS(lawyer), ESTAGIARIOS(person_intern), PARALEGAIS(paralegals)
    lip

    # ESCRITORIOS(Office)
    # TODO Criar logica para Office empty? e nil?
    esc = Office.where(id:1).pluck(:name, :oab, :cnpj_number, :address, :city, :state, :email).join(", ")

    # WORK
    work_rate = "oieeeeeee fila da puta"
    # if rate_work == "Trabalho" append...rate_work_ex_field
    # if rate_work == "Êxito" append... rate_percentage_exfield
    # if rate_work == "Ambos" append... logic

    # t.string "rate_percentage"
    # t.string "rate_percentage_exfield"
    # t.string "rate_fixed"
    # t.string "rate_fixed_exfield"
    # t.string "rate_work"
    # t.string "rate_parceled"


    # FIELD TREAT -- FIM --

    # PODERES

    # TIME - HORARIO
    dia = I18n.l(Time.now, format: "%d, %B de %Y")

    # DOCUMENT REPLACES
    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|

      # CLIENT
      # tr.substitute('_:nome_', nome_cap)
      # tr.substitute('_:sobrenome_', sobrenome_cap)
      # tr.substitute('_:estado_civil_', civilstatus)
      # tr.substitute('_:profissao_', client_ins[:profession].downcase)
      # tr.substitute('_:capacidade_', capacity_treated.downcase)

      # TODO ARRUMAR ISSO
      # tr.substitute('_:nacionalidade_', nacionalita.downcase)
      # tr.substitute('_:rg_', client_ins[:general_register])
      # tr.substitute('_:cpf_', (client_ins[:social_number]).to_s)
      # tr.substitute('_:nb_', (client_ins[:number_benefit]).to_s)
      # tr.substitute('_:email_', client_ins[:email])
      # tr.substitute('_:endereco_', client_ins[:address])
      # tr.substitute('_:cidade_', client_ins[:city])
      # tr.substitute('_:state_', client_ins[:state])
      # tr.substitute('_:cep_', (client_ins[:zip]).to_s)
      # tr.substitute('_:empresa_atual_', client_ins[:company])  Field nao utilizado

      # LAWYER AND SOCIETY => @Lawyer & @Office
       #tr.substitute('_:lawyers_', laws)
        tr.substitute('_:society_', Office.find_by(id: 1).name)
        tr.substitute('_:accountdetails_', "Banco: #{Office.find_by(id: 1).bank}, Agência: #{Office.find_by(id: 1).agency}, Conta: #{Office.find_by(id: 1).account}" )


      # NO DB FIELDS CONFIG GENDER
      # tr.substitute('_:portador_', porta)
      # tr.substitute('_:inscrito_', inscrito)
      # tr.substitute('_:domiciliado_', domiciliado)

      # WORK FIELDS
        tr.substitute('_:procedure_', work_rate) # Procedimento Adm. ou Judicial
        tr.substitute('_:subject_', @work[:subject]) # Direito Previdenciario - Pensao Morte
        tr.substitute('_:acao_', @work[:acao]) # Acao Numero
        tr.substitute('_:rates_', work_rate)

       # tr.substitute('_:rates_', @work[:rates])
       # tr.substitute('_:rates_', @work[:rates])

      # DOCUMENT TIME STAMP
      tr.substitute('_:timestamp_', data2)
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

  def field_list
  end


  def edit; end

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
