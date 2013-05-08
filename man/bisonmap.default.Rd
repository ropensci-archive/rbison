\name{bisonmap.default}
\alias{bisonmap.default}
\title{Make a simple map to visualize GBIF data.}
\usage{
  bisonmap.default(input = NULL, mapdatabase = "world",
    region = ".", geom = geom_point, jitter = NULL,
    customize = NULL)
}
\arguments{
  \item{input}{Input bison object.}

  \item{mapdatabase}{Base map layer to use.}

  \item{region}{Defaults to world.}

  \item{geom}{geom_point or geom_jitter, not quoted.}

  \item{jitter}{jitter position, see ggplot2 help.}

  \item{customize}{Pass in more to the plot.}
}
\value{
  Map (using ggplot2 package) of points on a map.
}
\description{
  Make a simple map to visualize GBIF data.
}
\examples{
\dontrun{
out <- bison(species="Bison bison", type="scientific_name", start=0, count=50)
bisonmap(input=out)
bisonmap(input=out, geom=geom_jitter, jitter=position_jitter(width = 0.3, height = 0.3))
}
}

