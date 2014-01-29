\name{bison_providers}
\alias{bison_providers}
\title{Get information about .}
\usage{
bison_providers(details = FALSE, provider_no = NULL, callopts = list())
}
\arguments{
  \item{details}{(logical) If TRUE, returns a list of
  data.frame's for each provider, including their resource
  details. If FALSE (default), only coarse grained data
  returned.}

  \item{provider_no}{(numeric) Provider number. If this
  parameter is provided, details is forced to be FALSE.}

  \item{callopts}{Further args passed on to httr::GET for
  HTTP debugging/inspecting.}
}
\value{
A data.frame or list of data.frame's
}
\description{
Get information about .
}
\examples{
\dontrun{
bison_providers()
bison_providers(details=TRUE)
bison_providers(provider_no=131)
}
}

