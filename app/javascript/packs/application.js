// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// import cocoon

require ("jquery")
require ("@nathanvda/cocoon")

require('datatables.net-bs4')
require('jquery-mask-plugin')

import $ from 'jquery';
global.$ = jQuery;
$.jMaskGlobals.watchDataMask = true;

$(document).ready(function(){

  $('.power-checked').prop('checked', true);

  $('#datatable-dash').DataTable({
      dom: '<"top"fl>tr<"bottom"ip><"clear">',
      order: [[0, "desc"]],
      lengthMenu: [5, 10, 20],
      language: {
                  "sEmptyTable": "Nenhum registro encontrado",
                  "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                  "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
                  "sInfoFiltered": "(Filtrados de _MAX_ registros)",
                  "sInfoPostFix": "",
                  "sInfoThousands": ".",
                  "sLengthMenu": "_MENU_ resultados por página",
                  "sLoadingRecords": "Carregando...",
                  "sProcessing": "Processando...",
                  "sZeroRecords": "Nenhum registro encontrado",
                  "sSearch": "Pesquisar",
                  "oPaginate": {
                      "sNext": "Próximo",
                      "sPrevious": "Anterior",
                      "sFirst": "Primeiro",
                      "sLast": "Último"
                  },
                  "oAria": {
                      "sSortAscending": ": Ordenar colunas de forma ascendente",
                      "sSortDescending": ": Ordenar colunas de forma descendente"
                  }
                }});


  $('#datatable-list').DataTable({
    order: [[0, "desc"]],
    lengthMenu: [10, 25, 50],
    language: {
                "sEmptyTable": "Nenhum registro encontrado",
                "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
                "sInfoFiltered": "(Filtrados de _MAX_ registros)",
                "sInfoPostFix": "",
                "sInfoThousands": ".",
                "sLengthMenu": "_MENU_ resultados por página",
                "sLoadingRecords": "Carregando...",
                "sProcessing": "Processando...",
                "sZeroRecords": "Nenhum registro encontrado",
                "sSearch": "Pesquisar",
                "oPaginate": {
                    "sNext": "Próximo",
                    "sPrevious": "Anterior",
                    "sFirst": "Primeiro",
                    "sLast": "Último"
                },
                "oAria": {
                    "sSortAscending": ": Ordenar colunas de forma ascendente",
                    "sSortDescending": ": Ordenar colunas de forma descendente"
                }
              }});

  $('#datatable-list_filter label').addClass("pull-right");

});
