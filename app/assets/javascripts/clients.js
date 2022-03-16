$(document).ready(function(){

// CEP INICIO
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
            // IF => Undefined <=
            // IF => Cep Cidade Incmpleta
            // $('#client_address').val('')

          });
    }
    // console.log(input.value.length);
  });

// CEP FINAL

})
