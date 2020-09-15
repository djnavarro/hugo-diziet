diziet <- list(

  make_gallery = function(preview = "preview", full = "image") {
    images <- list.files(preview, pattern="png$")
    links <- paste0(
      '<a href="', full, '/', images, '">',
      '<img src="', preview, '/', images, '">',
      '</a>'
    )
    cat('<div class="d-flex justify-content-between">\n')
    cat('<div class="gal">\n')
    cat(paste(links, collapse="\n"))
    cat('</div>\n')
    cat('</div>\n')
  }

)
