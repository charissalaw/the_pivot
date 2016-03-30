function searchProjects(){
  $('#project-search').keyup(function(event){
    var amountSearch = ($(this).val()).toLowerCase()

    var allProjects = $('.squeek')

    allProjects.removeClass('invisible')
    var hideIdeas = allProjects.filter(function(){
      var projectTable = ($(this).find('.project-name').text()).toLowerCase()
      return !(projectTable.includes(amountSearch))
    })
    hideIdeas.addClass('invisible');
  })
}
