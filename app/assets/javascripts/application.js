// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require bootstrap-growl-ifightcrime/jquery.bootstrap-growl
//= require hide.js

$(document).ready(function(){

  // checkboxes init 
 function checkAll(){
 $("#checkAll").click(function () {
   $("input:checkbox").not(this).prop('checked', this.checked);
 })};
 checkAll()
  // $('.className').on('click', function(){  $(this).value() });
  // X = getElementById('class').on('click', function(){ //todo });
  // checkboxes end 
  // let x = document.getElementsByClassName("radio_buttons");
  // console.log(x);


  let input = document.getElementById("client_zip");
  let inputAdressStreet = document.getElementById("client_address");
  let inputAdressCity = document.getElementById("client_city");
  let inputAdressState = document.getElementById("client_state");
  let focus = document.getElementById("client_bank_attributes_name");




  input.addEventListener('input', function () {
    if(input.value.length == 10){
      // console.log(input.value);
      let cepClean = input.value.replace("-", "").replace(".", "");
      fetch(`https://viacep.com.br/ws/${cepClean}/json/ `)
        .then(response => response.json())
        .then(function(data)
          {
            // console.log(data);
            inputAdressStreet.value = data.logradouro + ", "
            inputAdressCity.value = data.localidade
            inputAdressState.value = data.uf
            inputAdressStreet.focus()


          });
    }
    // console.log(input.value.length);
  });


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

    $('input[name="work[action]"]').each(function(){
      if ($(this).val() == area) {
        $(this).prop("checked", true);
      };
    });

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

  $('.subject').click(function(){
    $('.subject-append').remove();
    get_action($(this).val());
  });

  $('.rate-works').click(function(){
    $('.rate-works-append').remove();
    get_rate_work($(this).val());
  });

  get_action($("input[name='work[subject]']:checked").val());

  get_rate_work($("input[name='work[rate_work]']:checked").val());

  $("input[name='work[action]']").each(function(){
    if($(this).val() == $('#subject-fields').data('action-for-subject')){
      $(this).prop("checked", true);
    };
  });


});
