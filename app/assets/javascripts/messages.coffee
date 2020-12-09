# jQuery(document).on 'turbolinks:load', ->
#   $('#searchBar').select2
#     ajax: {
#       url: '/items'
#       data: (params) ->
#         {
#           term: params.term
#         }
#       dataType: 'json'
#       delay: 500
#       processResults: (data, params) ->
#         {
#           results: _.map(data, (el) ->
#             {
#               id: el.id
#               name: "#{el.surname}, #{el.name}"
#             }
#           )
#         }
#       cache: true
#     }
#     escapeMarkup: (markup) -> markup
#     minimumInputLength: 2
#     templateResult: (item) -> item.name
#     templateSelection: (item) -> item.name