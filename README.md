# Github Go Boilerplate

The purpose of this repo is to provide a boilerplate for starting new go projects in github. This will provide
a basic pipeline for:

1) Vetting
2) Linting
3) Testing
4) Semantic Version bumping
5) Auto `deploy` to container
6) Auto push of container image to Dockerhub

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
The type of version bump can be controlled using a github secret `VERSION_BUMP` established either at the repo or 
organization level in github. If `VERSION_BUMP` isn't set the action defaults to `minor` version bumps.

## Docker 

The templating system is setup to build the Dockerfile located at `docker/Dockerfile`. The pipeline will automatically
tag the release in github and use the same version to push built image to Dockerhub. Additionally, the pipeline
will also automatically tag `latest` with passing builds.

NOTE: In practice, production should _only_ use a versioned release. Adding the latest tag is an enabler for
development environments. 

## License

MIT License
