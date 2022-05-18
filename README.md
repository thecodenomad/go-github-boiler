# Github Go Boilerplate

The purpose of this repo is to provide a boilerplate for starting new go projects in github. This will provide
a basic pipeline for:

1) Vetting
2) Linting
3) Testing
4) Semantic Version bumping

## Golang

The pipeline is currently configured to have a matrix test against golang versions 1.17.x and 1.18.x.

## Vetting

Vetting is currently provided by the built-in `go vet`, and the execution in the pipeline is controlled by the makefile
`vet` target.

## Linting

Linting is currently provided by `golint`, and the execution in the pipeline is controlled by the makefile `lint` 
target.

## Testing

The intention of this boilerplate is to use built-ins for testing, however, testify is a great enhancement for go
unit testing and is included as a part of the sample unittest in this repo. 

Note that the makefile target `test` can easily be modified for the specifics of a project.

## Semantic Versioning

The pipeline for this boilerplate makes use of the [Github Tag Action](https://github.com/anothrNick/github-tag-action).
This can be controlled using a github secret `VERSION_BUMP`, if not set the action defaults to `minor` version bumps.

For releasing major versions, this can quickly be changed via the Github secret associated with the repo, or an 
organization, to avoid any manual tagging that may be necessary.

---

# TODO

One useful part of a boilerplate would be the construction, and pushing of docker containers. So there are a few
outstanding todos for this repo:

~~* Create a Dockerfile for use in housing the `main` executable~~
* Publish the Docker container using the version tag produced by the semantic version bump

