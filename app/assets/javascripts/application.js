//= require jquery
//= require rails-ujs
//= require activestorage
//= require bootstrap-growl-ifightcrime/jquery.bootstrap-growl
//= require select2
//= require select2-full

$(document).ready(function(){

$('[data-toggle="tooltip"]').tooltip()


$('.rate').focus();
  function change_status_color(status) {
    status = status.replace(/^\s+|\s+$/gm,'');

    switch (status) {
      case 'Ativo':
        $('#status-client').css( "background", "#27ae60" );
      break;
      case 'Inativo' || '':
        $('#status-client').css( "background", "#e74c3c" );
      break;
      case 'Prospecção':
        $('#status-client').css( "background", "#3498db" );
      break;
      case 'Abandonado/ Desistente':
      $('#status-client').css( "background", "#f1c40f" ).css( "color", "#111111" );
      break;
      case 'Atrasado':
        $('#status-client').css( "background", "#e74c3c" );
      break;
      case 'Pendente':
        $('#status-client').css( "background", "#3498db" );
      break;
      case 'Finalizado':
        $('#status-client').css( "background", "#27ae60" );
      break;
    }
  }

  if (window.location.href.match('clients/') || window.location.href.match('jobs/')) {
    change_status_color($('#status-client').text());
  }

  $('#modal-general').on("show.bs.modal", function(e) {
    $(this).find('.modal-body').load(e.relatedTarget.dataset.url);
  });

 function checkAll(){
 $("#checkAll").click(function () {
     if($('#checkAll').is(":checked")){
       $(".power").prop('checked', true);
     } else {
       $(".power").prop('checked', false);
     }
 })};

  $('.phone-cli').each(function(index){
    $(this).addClass('col-md-12').css('padding', '0');
    $('.client').css('margin', '0')
  });

  function timeFunctionLong(input) {
    setTimeout(function() {
      input.type = 'text';
    }, 60000);
  };

  function check_subject_area(){
    var area = $("#subject-fields").data('action-for-subject');
    var c_type = $("#rate-client-type").data('action-for-client-type');
    $(".subject-append-pis").val($("#label-tributary-work").data('action-for-tributary-work'));

    $('input[name="work[action]"]').each(function(){
      if ($(this).val() == area) {
        $(this).prop("checked", true);
      };
    });

    $('input[name="client[client_type]"]').each(function(){
      if ($(this).val() == c_type) {
        $(this).prop("checked", true);
      };
    });

  };

  function add_button_rep(){
    $(".add-button-rep").append("<div class='col-md-6 capacity'><a class='btn btn-outline btn-primary' id='btn-add-reps' data-toggle='modal' data-url='/clients/modal/representative_search' data-target='#modal-general' href='#'> <span>Pesquisar Representante</span></a></div>")
  };

  function pessoa_fisica(){

    if($("#client_capacity_relativamente_incapaz").is(':checked') || $("#client_capacity_absolutamente_incapaz").is(':checked') && $("#client_client_type_0").is(':checked')){
      add_button_rep();
    }

  };

  function previdenciario(){
    $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Previdenciário-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label class='inline-radio'  for='work_action_aposentadoria_por_tempo_de_contribuição'><input type='radio' value='Aposentadoria Por Tempo de Contribuição' name='work[action]' id='work_action_aposentadoria_por_tempo_de_contribuição'>Aposentadoria Por Tempo de Contribuição</label><label class='inline-radio'  for='work_action_aposentadoria_por_idade'><input type='radio' value='Aposentadoria Por Idade' name='work[action]' id='work_action_aposentadoria_por_idade'>Aposentadoria Por Idade</label><label class='inline-radio' for='work_action_aposentadoria_rural'><input type='radio' value='Aposentadoria Rural' name='work[action]' id='work_action_aposentadoria_rural'>Aposentadoria Rural</label><label class='inline-radio' for='work_action_benefícios_por_incapacidade_-_auxílio_doença_ou_acidente_-_invalidez_-_loas'><input type='radio' value='Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS' name='work[action]' id='work_action_benefícios_por_incapacidade_-_auxílio_doença_ou_acidente_-_invalidez_-_loas'>Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS</label><label class='inline-radio' for='work_action_revisão_de_benefício_previdenciário'><input type='radio' value='Revisão de Benefício Previdenciário' name='work[action]' id='work_action_revisão_de_benefício_previdenciário'>Revisão de Benefício Previdenciário</label> <label class='inline-radio' for='work_action_reconhecimento_de_tempo_averbação_serviços_administrativos'> <input type='radio' value='Reconhecimento de Tempo, Averbação, Serviços Administrativos' name='work[action]' id='work_action_reconhecimento_de_tempo_averbação_serviços_administrativos'>Reconhecimento de Tempo, Averbação, Serviços Administrativos</label> </fieldset> </div>" );

    check_subject_area();

    $(".prev-powers").removeClass('hidden');
    $(".adm-proc").addClass('hidden');
    $(".all-powers").removeClass('hidden');
    $(".trib-powers").addClass('hidden');
    $(".adm-powers").addClass('hidden');
    $(".civil-powers").addClass('hidden');
    $(".trab-powers").addClass('hidden');
    $(".crim-powers").addClass('hidden');
  };

  function civel(){
      $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Cível-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label class='inline-radio' for='work_action_família'><input type='radio' value='Família' name='work[action]' id='work_action_família'>Família</label><label class='inline-radio' for='work_action_consumidor'><input type='radio' value='Consumidor' name='work[action]' id='work_action_consumidor'>Consumidor</label><label class='inline-radio' for='work_action_reparacao_cível'><input type='radio' value='Reparação Cível - Danos Materiais - Danos Morais' name='work[action]' id='work_action_reparacao_cível'>Reparação Cível - Danos Materiais - Danos Morais</label></fieldset> </div>" );

      check_subject_area();

      $(".prev-powers").addClass('hidden');
      $(".adm-proc").addClass('hidden');
      $(".all-powers").removeClass('hidden');
      $(".trib-powers").addClass('hidden');
      $(".adm-powers").addClass('hidden');
      $(".civil-powers").removeClass('hidden');
      $(".trab-powers").addClass('hidden');
      $(".crim-powers").addClass('hidden');

  };

  function administrativo(){

    check_subject_area();

    $(".prev-powers").addClass('hidden');
    $(".adm-proc").removeClass('hidden');
    $(".all-powers").removeClass('hidden');
    $(".trib-powers").addClass('hidden');
    $(".adm-powers").addClass('hidden');
    $(".civil-powers").addClass('hidden');
    $(".trab-powers").addClass('hidden');
    $(".crim-powers").addClass('hidden');

  };

  function criminal(){

    check_subject_area();

    $(".prev-powers").addClass('hidden');
    $(".adm-proc").addClass('hidden');
    $(".all-powers").removeClass('hidden');
    $(".trib-powers").addClass('hidden');
    $(".adm-powers").addClass('hidden');
    $(".civil-powers").addClass('hidden');
    $(".trab-powers").addClass('hidden');
    $(".crim-powers").addClass('hidden');

  };

  function trabalhista(){
    $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Trabalhista-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label class='inline-radio' for='work_action_trabalhista'><input type='radio' value='Reclamatória Trabalhista' name='work[action]' id='work_action_trabalhista'>Reclamatória Trabalhista</label></fieldset> </div>" );

    check_subject_area();

    $(".prev-powers").addClass('hidden');
    $(".adm-proc").addClass('hidden');
    $(".all-powers").removeClass('hidden');
    $(".trib-powers").addClass('hidden');
    $(".adm-powers").addClass('hidden');
    $(".civil-powers").addClass('hidden');
    $(".trab-powers").removeClass('hidden');
    $(".crim-powers").addClass('hidden');
  };

  function tributario(){
    $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Tributário-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label class='inline-radio' for='work_action_asfalto'><input type='radio' value='Asfalto' name='work[action]' id='work_action_asfalto'>Asfalto</label><label class='inline-radio' for='work_action_alvara'><input type='radio' value='Alvará' name='work[action]' id='work_action_alvara'>Alvará</label><label class='inline-radio' for='work_action_outros'><input type='radio' value='Outros' name='work[action]' id='work_action_outros'>Outros</label></fieldset> </div>" );

    check_subject_area();

    $(".prev-powers").addClass('hidden');
    $(".adm-proc").addClass('hidden');
    $(".all-powers").removeClass('hidden');
    $(".trib-powers").removeClass('hidden');
    $(".adm-powers").addClass('hidden');
    $(".civil-powers").addClass('hidden');
    $(".trab-powers").addClass('hidden');
    $(".crim-powers").addClass('hidden');
  };

  function tributarioPisCofins(){
    $(".subject-append-pis").removeClass('hidden');

    check_subject_area();

    $(".prev-powers").addClass('hidden');
    $(".adm-proc").addClass('hidden');
    $(".all-powers").removeClass('hidden');
    $(".trib-powers").removeClass('hidden');
    $(".adm-powers").addClass('hidden');
    $(".civil-powers").addClass('hidden');
    $(".trab-powers").addClass('hidden');
    $(".crim-powers").addClass('hidden');
  };

  function outros(){
    $(".subject-append-outros").removeClass('hidden');

    check_subject_area();
  };

  function trabalho(){
    $("#rate-work-fields").append("<div class='rate-works-append col-md-6' data-cond-option='work[rate_work]' data-cond-value='Trabalho' style='display: block;'> <div class='form-group'><b><label for='work_Valor de Honorários Fixos'>Valor de honorários fixos</label></b> <input class='form-control field-work' type='text' name='work[rate_fixed_exfield]' id='work_rate_fixed_exfield'></div></div>" );

    $("#work_rate_fixed_exfield").val($("#label-rate-work").data('exfield'));
  };

  function exito(){
    $("#rate-work-fields").append("<div class='rate-works-append  col-md-6' data-cond-option='work[rate_work]' data-cond-value='Exito' style='display: block;'><div class='form-group'><b><label for='work_Valor de Honorários Percentuais'>Valor de honorários percentuais</label></b><input class='form-control field-work' type='text' name='work[rate_percentage_exfield]' id='work_rate_percentage_exfield'></div></div>");

    $("#work_rate_percentage_exfield").val($("#label-rate-work").data('percentage'));
  };

  function ambos(){
    $("#rate-work-fields").append("<div class='rate-works-append  col-md-6' data-cond-option='work[rate_work]' data-cond-value='Ambos' style='display: block;'> <div class='form-group'><b><label for='work_Valor de Honorários Fixos'>Valor de honorários fixos</label></b> <input class='form-control field-work' type='text' name='work[rate_fixed_exfield]' id='work_rate_fixed_exfield'><b><label for='work_Valor de Honorários Percentuais'>Valor de honorários percentuais</label></b><input class='form-control field-work' type='text' name='work[rate_percentage_exfield]' id='work_rate_percentage_exfield'></div> </div>");

    $("#work_rate_fixed_exfield").val($("#label-rate-work").data('exfield'));
    $("#work_rate_percentage_exfield").val($("#label-rate-work").data('percentage'));

  };

  function lawyer_user (){
    $("#oba-crc").append("<label class='user-role-append col-form-label col-md-3 col-sm-3 label-align' for='user_user_profile_attributes_OAB'>OAB</label> <div class='user-role-append col-md-6 col-sm-6 '><input class='user-role-append form-control' type='text' name='user[user_profile_attributes][oab]' id='user_user_profile_attributes_oab'></div>" );

    $("#user_user_profile_attributes_oab").val($("#label-user-role").data('exfield'));
  };

  function accountant_user (){
    $('.user-role-append').remove();
    $("#oba-crc").append("<label class='user-role-append col-form-label col-md-3 col-sm-3 label-align' for='user_user_profile_attributes_OAB'>CRC</label> <div class='user-role-append col-md-6 col-sm-6 '><input class='user-role-append form-control' type='text' name='user[user_profile_attributes][oab]' id='user_user_profile_attributes_oab'></div>" );

    $("#user_user_profile_attributes_oab").val($("#label-user-role").data('exfield'));
  };

  function get_type_client(value){
    switch (value) {
      case '0': pessoa_fisica(); break;
    };
  };

  function get_role_user(law, out_accountant, accountant){
    if (law == true){
      lawyer_user ();
    } else if (out_accountant == true || accountant == true) {
      accountant_user();
    } else {
      $('.user-role-append').remove();
    }
  };

  function get_action(value){
    switch (value) {
      case 'Previdenciário':                  previdenciario();         break;
      case 'Cível':                           civel();                  break;
      case 'Trabalhista':                     trabalhista();            break;
      case 'Tributário':                      tributario();             break;
      case 'Tributário Pis/Cofins insumos':     tributarioPisCofins();  break;
      case 'Outros':                          outros();                 break;
      case 'Criminal':                        criminal();               break;
      case 'Administrativo':                  administrativo ();        break;
    };
    if(value != 'Tributário Pis/Cofins insumos'){
      $(".subject-append-pis").addClass('hidden');
    }
    if(value != 'Outros'){
      $(".subject-append-outros").addClass('hidden');
    }
  };

  function get_rate_work(value){
    switch (value) {
      case 'Trabalho': trabalho(); break;
      case 'Êxito':    exito();    break;
      case 'Ambos':    ambos();    break;
    };
  };

  $('.client-type').click(function(){
    $('.client-type-append').remove();
    get_type_client($(this).val());
  });

  $('.subject').click(function(){
    $('.subject-append').remove();
    get_type_client($(this).val());
  });

  $('.subject').click(function(){
    $('.subject-append').remove();
    get_action($(this).val());
  });

  $('.rate-works').click(function(){
    $('.rate-works-append').remove();
    get_rate_work($(this).val());
  });

  $('.lawyer_role').click(function(){
    $('.user-role-append').remove();
    get_type_client($(this).val());
  });

  $('.accountant_role').click(function(){
    $('.user-role-append').remove();
    get_type_client($(this).val());
  });

  get_type_client($("input[name='client[client_type]']:checked").val());

  get_role_user($("input[name='user[lawyer_role]']:checked").val(), $("input[name='user[outside_accountant_role]']:checked").val(), $("input[name='user[accountant_role]']:checked").val());

  get_action($("input[name='work[subject]']:checked").val());

  get_rate_work($("input[name='work[rate_work]']:checked").val());

  $("input[name='work[action]']").each(function(){
    if($(this).val() == $('#subject-fields').data('action-for-subject')){
      $(this).prop("checked", true);
    };
  });

  if (window.location.href.match('clients/new')) {
    $("#client_status_0").prop("checked", true);
  }

  $('.remove-ind').on("click", function(){
    $("#label-comissao").addClass('hidden');
    $('.indId').val("");
    $('.indName').text("Escolha uma indicação.");
    document.getElementById('ind-btn-remove').style.visibility = 'hidden';
  });

  if ($('.indName').text() == "Escolha uma indicação.") {
  document.getElementById('ind-btn-remove').style.visibility = 'hidden';
  }

  $('.lawyer_role').on('click', function(){
    if($('.lawyer_role').is(":checked")){
    lawyer_user ();
    $("#user_accountant_role").prop("checked", false);
    $("#user_outside_accountant_role").prop("checked", false);
  }});

  $('.accountant_role').on('click', function(){
    if($(this).is(":checked")){
      accountant_user ();
      $(".outside_accountant_role").prop("checked", false);
      $("#user_lawyer_role").prop("checked", false);    }
  });

  $('.outside_accountant_role').on('click', function(){
    if($(this).is(":checked")){
      accountant_user ();
      $("#user_lawyer_role").prop("checked", false);
      $(".accountant_role").prop("checked", false);
    }
  });

  if (window.location.href.match('clients/new')) {
    $(".btn-remove-rep").click();
    //document.getElementById('customer_types_add').style.visibility = 'hidden';
  }

  if (window.location.href.match('clients/edit')) {
    //$(".btn-remove-rep").click();
    //document.getElementById('customer_types_add').style.visibility = 'hidden';
  }

  $(".client-type").on('click', function(){
    if ($(this).val() == 0){
      $("#client_capacity_capaz").prop("checked", false);
      $("#client_capacity_relativamente_incapaz").prop("disabled", false);
      $("#client_capacity_absolutamente_incapaz").prop("disabled", false);
    } else {
      $("#client_capacity_capaz").prop("checked", true);
      $("#client_capacity_relativamente_incapaz").prop("disabled", true);
      $("#client_capacity_absolutamente_incapaz").prop("disabled", true);
    }
  });

  $(".btn-capacity").on('click', function(){
    if($(this).val() == 'Capaz' && $("#client_client_type_0").is(':checked')){
      $("#btn-add-reps").remove();
      $(".parcial-rep").remove();
      $(".capacity").remove();
    } else {
      $("#btn-add-reps").remove();
      $(".capacity").remove();
      add_button_rep();
    }
  });

  if (window.location.href.match('clients/show')) {
    $("#client_status_0").prop("checked", true);
  }

  $('input[name="client[files][]"]').change(function(ev){
    if ($('input[name="client[files][]"]').val() == ""){
      $(".btn-file-show").prop("disabled", true);
    }
    else {
      $(".btn-file-show").prop("disabled", false);
    }
  });

  $(".cep").focusout(function(){
    $(".cep").removeClass('error-mark-box');
    $(".cep-label").removeClass('label_with_error');
    $.ajax({
      url: 'https://viacep.com.br/ws/'+$(this).val().replace(/\D/g, '')+'/json/',
      dataType: 'json',
      success: function(resposta){
        $(".address").val(resposta.logradouro);
        $(".city").val(resposta.localidade);
        $(".state").val(resposta.uf).trigger('change');
        $(".address").focus();
        if (resposta.erro == true)
          {
            $(".cep").addClass('error-mark-box');
            $(".cep-label").addClass('label_with_error');
            $(".cep-label").addClass('label_with_error');
            $(".add-error-cep").append('<small> CEP inválido ou não encontrado. </small>').css('color', 'red');
          }
      }
    });
  });

  $(".subBtn-cep").on('click', function(){
    cep = $(".cep").val();
    cep = cep.replace(/\D/g, '');
    console.log(cep)

  });

  $(".buttonFinish").addClass('btn btn-primary');
  $(".buttonNext").addClass('btn btn-outline-success');
  $(".buttonPrevious").addClass('btn btn-outline-warning');

 checkAll()

  $(".state-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Escolha um Estado",
   closeOnSelect: true
  });

  $(".bank-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Escolha um banco",
   closeOnSelect: true
  });

  $(".client-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Selecione ou digite um nome de um cliente",
   closeOnSelect: true,
   tags: "true"
  });

  $(".office-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   placeholder: "Selecione ou digite um nome de um escritório",
   closeOnSelect: true,
   tags: "true"
  });

  $(".adv-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Selecione um Advogado",
   closeOnSelect: true,
   tags: "true"
  });

  $(".externo-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Selecione um Advogado Externo",
   closeOnSelect: true,
   tags: "true"
  });

  $(".email-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Selecione um e-mail",
   closeOnSelect: true,
   tags: "true"
  });

  $(".intern-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Selecione um Estagiário",
   closeOnSelect: true,
   tags: "true"
  });

  $(".paralegal-select").select2({
   language: "pt-BR",
   theme: "bootstrap",
   allowClear: true,
   placeholder: "Selecione um Paralegal",
   closeOnSelect: true,
   tags: "true"
  });

  $(document).on('click', '#add-cli-work', function() {
    $(".client-select").select2({
      language: "pt-BR",
      theme: "bootstrap",
      allowClear: true,
      placeholder: "Selecione ou digite um nome de um cliente",
      closeOnSelect: true,
      tags: "true"
    });
  });

  $(document).on('click', '#add-office-work', function() {
    $(".office-select").select2({
      language: "pt-BR",
      theme: "bootstrap",
      allowClear: true,
      placeholder: "Selecione um escritório",
      closeOnSelect: true,
      tags: "true"
    });
  });

  $("#add-cli-work").addClass('hidden');
  $("#add-office-work").addClass('hidden');

  $(".client-select").change(function() {
    $("#add-cli-work").removeClass('hidden');
  });

  $(".office-select").change(function() {
    $("#add-office-work").removeClass('hidden');
  });

  $("#work_procedure_ids_1").on('click', function(){
    if($('#work_procedure_ids_1').is(":checked")){
      $(".adm-powers").removeClass('hidden');

    } else {
      $(".adm-powers").addClass('hidden');

    }

  });

  function set_user(offices){


  }

  $(".selection").focusout(function(){

    var t2 = $(this).parent().siblings('.office-select');
    if (t2.length > 0){
      console.log(t2.length);
      office_name = $(this).text();
      office_html = $(this).getAttribute;

      console.log(office_name);
      console.log($(this).value);

    };



  });

});
