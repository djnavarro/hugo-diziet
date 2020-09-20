diziet <- list(

  make_gallery = function(preview = "preview", full = "image", preview_fmt = "jpg", full_fmt = "png") {
    full_images <- list.files(full, pattern = paste0(full_fmt, "$"))
    preview_images <- list.files(preview, pattern = paste0(preview_fmt, "$"))
    links <- paste0(
      '<div class="col-md-3 col-sm-6 col-xs-12 p-2">',
      '<a href="', full, '/', full_images, '">',
      '<img width = 100% src="', preview, '/', preview_images, '">',
      '</a>',
      '</div>'
    )
    cat('<div class="gal">')
    cat('<div class="container-fluid">')
    cat('  <div class="row">')
    cat(paste(links, collapse="\n"))
    cat('  </div>\n')
    cat('</div>\n')
    cat('</div>\n')
  },

  make_previews = function(path, fmt = "jpg") {

    library(magick)

    img <- dir(
      path = file.path(path, "image"),
      pattern = "png$",
      recursive = TRUE
    )

    for(i in img) {
      input <- file.path(path, "image", i)
      output <- file.path(path, "preview", i)
      output <- gsub("\\.png$", paste0(".", fmt), output)
      if(!file.exists(output)) {
        cat(input, "\n")
        im <- magick::image_read(input)
        im <- magick::image_resize(im, geometry = "800x")
        magick::image_write(im, output, format = fmt)
        Sys.sleep(1.5)
      }
    }
  }

)
