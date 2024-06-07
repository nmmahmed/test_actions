# github-actions-docker-build

Automatically build a Docker image on GitHub Actions, hosted on GitHub Container Registry

## 1. Setup

Fork this repository, or add all its contents into an existing repository. You
will need a GitHub account to continue.


## 2. Customize the image

The [Dockerfile] defines the Docker image.. Refer to [Docker Docs] for examples
on how to make changes to this file.

Once the Dockerfile has been updated on GitHub, it will automatically trigger a
build of the image on GitHub Container Registry as an image tagged with the
repository's name and owner.

> [!NOTE]
> The first push in a repository may fail due to lack of GitHub permissions on a
> package that hasn't been created yet. Subsequent pushes should succeed.

[Dockerfile]: ./Dockerfile
[Docker Docs]: https://docs.docker.com/build/building/packaging/

## 3. Customize the automatic build

### Trigger

The automatic build is defined in [docker.yml], a GitHub Actions workflow. By
default, it is set to run:

1. on pushes to the `main` branch that change certain files
2. on manual invocation from the [workflow webpage]

You can tweak this to use other [workflow triggers].

[docker.yml]: ./.github/workflows/docker.yml
[workflow webpage]: https://github.com/victorlin/github-actions-docker-build/actions/workflows/docker.yml
[workflow triggers]: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows

### Platform

By default, the build is done only for the native platform of the GitHub runner,
`linux/amd64`. You can pass [`--platform`] to `./build --platform` or more
directly by modifying the `docker buildx build` command within that script.

Note that building for non-native platforms introduces complications and can
slow the build process. See the Docker's official guide for more information:
[Building multi-platform images]

[`--platform`]: https://docs.docker.com/reference/cli/docker/buildx/build/#platform
[Building multi-platform images]: https://docs.docker.com/build/building/multi-platform/#building-multi-platform-images
