class WorksController < ApplicationController
before_action :authenticate_user!, :amazon_client, :set_work, only: [:show, :edit, :update, :destroy, :templater]

# redirect with params
# redirect_to controller: 'thing', action: 'edit', id: 3, something: 'else'

  def index
    @works = Work.all
  end

  def show
    require 's3'
    service = S3::Service.new(
      :access_key_id => ENV['AWS_ID'],
      :secret_access_key => ENV['AWS_SECRET_KEY']
     )
    @work = Work.find(params[:id])
    doc_link = @work.document["document_name"]
    @work.documents[:aws_link]
    @meta = []
    @meta2 = []
    #criar objeto
    @bucket = service.buckets.find("prcstudio3herokubucket")
    @object = @bucket.objects.find("tmp/#{doc_link}")
    @url = @object.temporary_url(Time.now + 1800)
    @meta << @object
    @work = Work.find(params[:id])
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
    end
  end

  def work_templater(work, document)
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require 'time'

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

    # FIELD TREAT -- INICIO --

    client_ins = # arrumar instancia do cliente
    nome_completo = "#{client_ins[:name]} #{client_ins[:lastname]}".upcase
    nome_cap = "#{client_ins[:name]}".upcase
    sobrenome_cap = "#{client_ins[:lastname]}".upcase

    # NO DB FIELDS CONFIG GENDER

    # GENDER LOGIC
    if client_ins[:gender] == 2
      civilstatus = genderize(client_ins[:civilstatus])
      citizenship = genderize(client_ins[:citizenship])
      porta = "portadora"
      inscrito = "inscrita"
      domiciliado = "domiciliada"
    else
      civilstatus = client_ins[:civilstatus]
      nacionalita = client_ins[:citizenship]
      porta = "portador"
      inscrito = "inscrito"
      domiciliado = "domiciliado"
    end

    if client_ins[:capacity] = 'Capaz' || client_ins[:capacity] = nil
      capacity_treated = client_ins[:capacity]
    else
      capacity_treated = "#{client_ins[:capacity]}, representado por seu genitor(a): ------ Qualificar manualmente o representante legal ----"
    end

    # # ADVOGADOS
    laws = [].join("")
    Lawyer.all.each do | xopo |
      laws << "#{xopo.name} #{xopo.lastname}, #{xopo.civilstatus}, OAB/PR n #{xopo.oab_number}. ".to_s
    end

    # ESCRITORIO

    # erro no PRC4
    esc = Escritorio.pluck(:name, :oab, :city, :state, :email).join(", ")

    # FIELD TREAT -- FIM --

    # PODERES

    # TIME - HORARIO
    data = Time.now
    data2 = data.strftime("%d, %m, %Y")
    data.format("DD, MM, YYYY")


    # DOCUMENT REPLACES
    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|

      # CLIENT
      tr.substitute('_:nome_', nome_cap)
      tr.substitute('_:sobrenome_', sobrenome_cap)
      tr.substitute('_:estado_civil_', civilstatus)
      tr.substitute('_:profissao_', client_ins[:profession].downcase)
      tr.substitute('_:capacidade_', capacity_treated.downcase)

      # TODO ARRUMAR ISSO
      tr.substitute('_:nacionalidade_', nacionalita.downcase)
      tr.substitute('_:rg_', client_ins[:general_register])
      tr.substitute('_:cpf_', (client_ins[:social_number]).to_s)
      tr.substitute('_:nb_', (client_ins[:number_benefit]).to_s)
      tr.substitute('_:email_', client_ins[:email])
      tr.substitute('_:endereco_', client_ins[:adress])
      tr.substitute('_:cidade_', client_ins[:city])
      tr.substitute('_:state_', client_ins[:state])
      tr.substitute('_:cep_', (client_ins[:zip]).to_s)
      # tr.substitute('_:empresa_atual_', client_ins[:company])  Field nao utilizado

      # LAWYER AND SOCIETY => @Lawyer & @Office
      tr.substitute('_:lawyers_', laws)
      tr.substitute('_:sociedade_', "")
      tr.substitute('_:accountdetails_', @Office[:accountdetails])

      # NO DB FIELDS CONFIG GENDER
      tr.substitute('_:portador_', porta)
      tr.substitute('_:inscrito_', inscrito)
      tr.substitute('_:domiciliado_', domiciliado)

      # WORK FIELDS
      tr.substitute('_:procedure_', @work[:procedure])
      tr.substitute('_:acao_', @work[:acao])
      tr.substitute('_:rates_', @work[:rates])
      tr.substitute('_:rates_', @work[:rates])
      tr.substitute('_:rates_', @work[:rates])

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


  def new
    @work = Work.new
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
      :client_id,
      :note,
      :document_pendent,
      clients_attributes: [:id, :client],
      checklist: [],
      checklist_document: [],
      power: [],
      procedure: [],
      )
  end

end
