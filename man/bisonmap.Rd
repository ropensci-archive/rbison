\name{bisonmap}
\alias{bisonmap}
\title{Make map to visualize BISON data.}
\usage{
  bisonmap(input = NULL, tomap = "points",
    geom = geom_point, jitter = NULL, customize = NULL)
}
\arguments{
  \item{input}{Input bison object.}

  \item{tomap}{One of points (occurrences), county (counts
  by county), or state (counts by state).}

  \item{geom}{geom_point or geom_jitter, not quoted.}

  \item{jitter}{jitter position, see ggplot2 help.}

  \item{customize}{Pass in more to the plot.}
}
\value{
  Map (using ggplot2 package) of points on a map.
}
\description{
  Make map to visualize BISON data.
}
\examples{
\dontrun{
out <- bison(species="Bison bison", type="scientific_name", count=50)
bisonmap(input=out)
bisonmap(input=out, geom=geom_jitter, jitter=position_jitter(width = 0.3, height = 0.3))
}
}

