//= require jquery
//= require rails-ujs
//= require activestorage
//= require bootstrap-growl-ifightcrime/jquery.bootstrap-growl

$(document).ready(function(){


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

  function pessoa_fisica(){
    $("#rate-client-type").append("<div class='client-type-append col-md-6 no-padding' data-cond-option='client[client_type]' data-cond-value='Pessoa Física' style='display: block;'> <div class='form-group'><b><label for='client_Tipo de Cliente'>Número do CPF</label></b> <input autocomplete='off' class='form-control' data-mask='000.000.000-00' placeholder='000.000.000-00' type='text' name='client[social_number]' id='client_social_number' maxlength='14'></div></div>" );

    $("#client_social_number").val($("#label-client-type").data('exfield'));
  };

  function pessoa_juridica(){
    $("#rate-client-type").append("<div class='client-type-append col-md-6 no-padding' data-cond-option='client[client_type]' data-cond-value='Pessoa Jurídica' style='display: block;'> <div class='form-group'><b><label for='client_Tipo de Cliente'>Número do CNPJ</label></b> <input autocomplete='off' class='form-control' data-mask='00.000.000/0000-00' placeholder='00.000.000/0000-00' type='text' name='client[social_number]'' id='client_cnpj' maxlength='18'></div> <a class='btn btn-outline btn-primary' data-toggle='modal' data-url='/clients/hunts' data-target='#modal-general' href='#'> <span>Pesquisar Representante</span></a></div> " );

    $("#client_cnpj").val($("#label-client-type").data('exfield'));
  };

  function previdenciario(){
    $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Previdenciário-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label for='work_action_aposentadoria_por_tempo_de_contribuição'><input type='radio' value='Aposentadoria Por Tempo de Contribuição' name='work[action]' id='work_action_aposentadoria_por_tempo_de_contribuição'>Aposentadoria Por Tempo de Contribuição</label><label for='work_action_aposentadoria_por_idade'><input type='radio' value='Aposentadoria Por Idade' name='work[action]' id='work_action_aposentadoria_por_idade'>Aposentadoria Por Idade</label><label for='work_action_aposentadoria_rural'><input type='radio' value='Aposentadoria Rural' name='work[action]' id='work_action_aposentadoria_rural'>Aposentadoria Rural</label><label for='work_action_benefícios_por_incapacidade_-_auxílio_doença_ou_acidente_-_invalidez_-_loas'><input type='radio' value='Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS' name='work[action]' id='work_action_benefícios_por_incapacidade_-_auxílio_doença_ou_acidente_-_invalidez_-_loas'>Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS</label><label for='work_action_revisão_de_benefício_previdenciário'><input type='radio' value='Revisão de Benefício Previdenciário' name='work[action]' id='work_action_revisão_de_benefício_previdenciário'>Revisão de Benefício Previdenciário</label> <labelfor='work_action_reconhecimento_de_tempo_averbação_serviços_administrativos'> <input type='radio' value='Reconhecimento de Tempo, Averbação, Serviços Administrativos' name='work[action]' id='work_action_reconhecimento_de_tempo_averbação_serviços_administrativos'>Reconhecimento de Tempo, Averbação, Serviços Administrativos</label> </fieldset> </div>" );

    check_subject_area();
  };

  function civel(){
      $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Cível-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label for='work_action_família'><input type='radio' value='Família' name='work[action]' id='work_action_família'>Família</label><label for='work_action_consumidor'><input type='radio' value='Consumidor' name='work[action]' id='work_action_consumidor'>Consumidor</label><label for='work_action_reparacao_cível'><input type='radio' value='Reparação Cível - Danos Materiais - Danos Morais' name='work[action]' id='work_action_reparacao_cível'>Reparação Cível - Danos Materiais - Danos Morais</label></fieldset> </div>" );

      check_subject_area();
  };

  function trabalhista(){
    $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Trabalhista-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label for='work_action_trabalhista'><input type='radio' value='Reclamatória Trabalhista' name='work[action]' id='work_action_trabalhista'>Reclamatória Trabalhista</label></fieldset> </div>" );

    check_subject_area();
  };

  function tributario(){
    $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Tributário-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label for='work_action_asfalto'><input type='radio' value='Asfalto' name='work[action]' id='work_action_asfalto'>Asfalto</label><label for='work_action_alvara'><input type='radio' value='Alvará' name='work[action]' id='work_action_alvara'>Alvará</label><label for='work_action_outros'><input type='radio' value='Outros' name='work[action]' id='work_action_outros'>Outros</label></fieldset> </div>" );

    check_subject_area();
  };

  function outros(){
    $('#subject-fields').append("<div class='subject-append col-md-8'> <fieldset class='radio_buttons grid'> <legend class='col-form-label pt-0'><b>Outros-Áreas</b></legend><input type='hidden' name='work[action]' value=''><label for='work_action_outros'><input type='radio' value='Outros' name='work[action]' id='work_action_outros'>Outros</label></fieldset> </div>" );

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
    $("#rate-work-fields").append("<div class='rate-works-append  col-md-6' data-cond-option='work[rate_work]' data-cond-value='Ambos' style='display: block;'> <div class='form-group'><b><label for='work_Valor de Honorários Fixos'>Valor de honorários fixos</label></b> <input class='form-control field-work' type='number' name='work[rate_fixed_exfield]' id='work_rate_fixed_exfield'><b><label for='work_Valor de Honorários Percentuais'>Valor de honorários percentuais</label></b><input class='form-control field-work' type='number' name='work[rate_percentage_exfield]' id='work_rate_percentage_exfield'></div> </div>");

    $("#work_rate_fixed_exfield").val($("#label-rate-work").data('exfield'));
    $("#work_rate_percentage_exfield").val($("#label-rate-work").data('percentage'));

  };

  function lawyer_user (){
    $("#oba-crc").append("<label class='user-role-append col-form-label col-md-3 col-sm-3 label-align' for='user_user_profile_attributes_OAB'>OAB</label> <div class='user-role-append col-md-6 col-sm-6 '><input class='user-role-append form-control' type='text' name='user[user_profile_attributes][oab]' id='user_user_profile_attributes_oab'></div>" );

    $("#user_user_profile_attributes_oab").val($("#label-user-role").data('exfield'));
  };

  function accountant_user (){
    $("#oba-crc").append("<label class='user-role-append col-form-label col-md-3 col-sm-3 label-align' for='user_user_profile_attributes_OAB'>CRC</label> <div class='user-role-append col-md-6 col-sm-6 '><input class='user-role-append form-control' type='text' name='user[user_profile_attributes][oab]' id='user_user_profile_attributes_oab'></div>" );

    $("#user_user_profile_attributes_oab").val($("#label-user-role").data('exfield'));
  };

  function get_type_client(value){
    switch (value) {
      case '0': pessoa_fisica(); break;
      case '1': pessoa_juridica(); break;
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
      case 'Previdenciário': previdenciario(); break;
      case 'Cível':          civel();          break;
      case 'Trabalhista':    trabalhista();    break;
      case 'Tributário':     tributario();     break;
      case 'Outros':         outros();         break;
    };
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
    if($('.accountant_role').is(":checked")){
    accountant_user ();
    $("#user_lawyer_role").prop("checked", false);
  }});


  // $("input[name='client[client_type]']").each(function(){
  //   if($(this).val() == $('#rate-client-type').data('action-for-client-type')){
  //     $(this).prop("checked", true);
  //   };
  // });

 checkAll()

});
