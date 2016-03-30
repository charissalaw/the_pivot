function searchBorrowers(){
  $('#borrower-search').keyup(function(event){
    var amountSearch = ($(this).val()).toLowerCase()

    var allBorrowerRows = $('.borrower-row')

    allBorrowerRows.removeClass('invisible')
    var hideIdeas = allBorrowerRows.filter(function(){
      var projectTable = ($(this).find('.borrower-name').text()).toLowerCase()
      return !(projectTable.includes(amountSearch))
    })
    hideIdeas.addClass('invisible');
  })
}
