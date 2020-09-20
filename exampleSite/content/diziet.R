diziet <- list(

  make_gallery = function(
    preview = "preview",
    full = "image",
    preview_fmt = "jpg",
    full_fmt = "png"
  ) {

    full_images <- list.files(full, pattern = paste0(full_fmt, "$"))
    preview_images <- list.files(preview, pattern = paste0(preview_fmt, "$"))

    # make a card for each person
    links <- paste0(

      '<div class="card col-12 col-sm-12 col-md-4 col-lg-3">',
      '  <a href="', full, '/', full_images, '">',
      '    <img width="100%" class="card-img-top" src="', preview, '/', preview_images, '">',
      '  </a>',
      '</div>'
    )

    cat('<div class="card-deck">')
    cat(paste(links, collapse="\n"))
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
