diziet <- list(

  make_gallery = function(preview = "preview", full = "image") {
    images <- list.files(preview, pattern="png$")
    links <- paste0(
      '<a href="', full, '/', images, '">',
      '<img src="', preview, '/', images, '">',
      '</a>'
    )
    cat('<div class="gal">')
    cat(paste(links, collapse="\n"))
    cat('</div>\n')
  }

)
