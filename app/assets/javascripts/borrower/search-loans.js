function searchLoans(){
  $('#loan-search').keyup(function(event){
    var amountSearch = $(this).val()
    var allLoanRows = $('.loan-row')

    allLoanRows.removeClass('invisible')
    var hideIdeas = allLoanRows.filter(function(){
      var loanRow = $(this).find('.loan-value').text()
      return !(loanRow.includes(amountSearch) && loanRow.startsWith(amountSearch))
    })
    hideIdeas.addClass('invisible');
  })
}
