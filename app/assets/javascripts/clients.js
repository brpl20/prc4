$(document).ready(function(){

  let input = document.getElementById("client_zip");
  let inputAdressStreet = document.getElementById("client_address");
  let inputAdressCity = document.getElementById("client_city");
  let inputAdressState = document.getElementById("client_state");
  let focus = document.getElementById("client_bank_attributes_name");


  input.addEventListener('input', function () {
    if(input.value.length == 10){
      let cepClean = input.value.replace("-", "").replace(".", "");
      fetch(`https://viacep.com.br/ws/${cepClean}/json/ `)
        .then(response => response.json())
        .then(function(data)
          {
            inputAdressStreet.value = data.logradouro + ", "
            inputAdressCity.value = data.localidade
            inputAdressState.value = data.uf
            inputAdressStreet.focus()
          });
    }
  });

})
