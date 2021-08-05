// funcao para esconder ou mostrar determinados campos
// js puro 

// definindo os elementos selecionados
const modal = document.querySelector('.modal');
const btnCloseModal = document.querySelector('.close-modal');
const btnsOpenModal = document.querySelectorAll('.show-modal');
const relativamenteIncapaz = document.getElementById('client_capacity_relativamente_incapaz');
const absolutamenteIncapaz = document.getElementById('client_capacity_absolutamente_incapaz');
const inputField = document.getElementById('exampleModal');

relativamenteIncapaz.addEventListener('click', function () {
  $('#exampleModal').modal('show');
});

absolutamenteIncapaz.addEventListener('click', function () {
  $('#exampleModal').modal('show');
});

// for (let i = 0; i < btnsOpenModal.length; i++)
//   btnsOpenModal[i].addEventListener('click', openModal);

// const openModal = function () {
//   modal.classList.remove('hidden');
//   overlay.classList.remove('hidden');
// };

// const closeModal = function () {
//   modal.classList.add('hidden');
//   overlay.classList.add('hidden');
// };