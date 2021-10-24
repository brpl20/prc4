import cep from 'cep-promise'
let input = document.getElementById("client_zip");
input.addEventListener('input', function () {
  if(input.value.length == 10){
    console.log(input.value);
    let cepClean = input.value.replace("-", "").replace(".", "");
    cep(cepClean)
      .then(console.log)
  }
  console.log(input.value.length);
});
