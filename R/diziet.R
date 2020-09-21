diziet <- list(

  guess_name = function() {
    path_here <- normalizePath(file.path("."))
    path_split <- strsplit(path_here, .Platform$file.sep, TRUE)[[1]]
    name_guess <- path_split[length(path_split)]
    return(name_guess)
  },

  make_gallery = function(
    name = diziet$guess_name(),
    preview = "preview",
    full = "image",
    preview_fmt = "jpg",
    full_fmt = "png"
  ) {

    # paths
    root <- rprojroot::find_root("_hugodown.yaml")
    static <- file.path(root, "static", "gallery", name)
    content <- file.path(root, "content", "gallery", name)

    # image names are found at render time by looking in the static folder
    full_images <- list.files(file.path(static, full), pattern = paste0(full_fmt, "$"))
    preview_images <- list.files(file.path(static, preview), pattern = paste0(preview_fmt, "$"))

    # at build/view time, the images will end up in the relevant subfolder:
    links <- paste0(
      '<div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 p-2">',
      '<a href="', full, '/', full_images, '">',
      '<img width = 100% src="', preview, '/', preview_images, '">',
      '</a>',
      '</div>'
    )

    # wrap in html and write to document
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
  },

  rebuild_site = function(clean = FALSE) {

    # removes all .md files from content folder
    if(clean == TRUE) {
      content <- here::here("content")
      md_files <- list.files(
        path = content,
        pattern = "\\.md$",
        recursive = TRUE,
        full.names = TRUE
      )
      lapply(md_files, file.remove)
    }

    outdated <- hugodown::site_outdated()
    lapply(outdated, function(x) {
      cat(x, "\n")
      rmarkdown::render(x, quiet = TRUE)
    })
    return(invisible(NULL))
  }

)
