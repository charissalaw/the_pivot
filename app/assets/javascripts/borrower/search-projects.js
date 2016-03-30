function searchProjects(){
  $('#project-search').keyup(function(event){
    var amountSearch = $(this).val()
    var allProjects = $('.squeek')
    console.log(allProjects);

    allProjects.removeClass('invisible')
    var hideIdeas = allProjects.filter(function(){
      var projectTable = $(this).find('.project-name').text()
      return !(projectTable.includes(amountSearch))
    })
    hideIdeas.addClass('invisible');
  })
}
