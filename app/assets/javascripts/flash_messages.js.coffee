jQuery ->
  jQuery('.flash')
    .addClass('active')
    .click -> jQuery(@).removeClass('active')

  # hide notices after 4 seconds
  jQuery('.flash.notice').each ->
    setTimeout =>
      jQuery(@).click()
    ,
      4000
