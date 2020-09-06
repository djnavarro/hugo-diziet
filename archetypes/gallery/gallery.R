make_gallery <- function(preview = "preview", full = "image") {
  images <- list.files(preview, pattern="png$")
  links <- paste0('<a href="', full,'/',images,'"><img src="',preview,'/',images,'"></a>')
  cat(paste(links, collapse="\n"))
}

make_previews <- function(path) {

  library(magick)

  img <- dir(
    path = file.path(path, "image"),
    pattern = "png$",
    recursive = TRUE
  )

  for(i in img) {
    input <- file.path(path, "image", i)
    output <- file.path(path, "preview", i)
    if(!file.exists(output)) {
      cat(input, "\n")
      im <- magick::image_read(input)
      im <- magick::image_resize(im, geometry = "400x")
      magick::image_write(im, output)
      Sys.sleep(1.5)
    }
  }
}
