# dev-container

Dev container for day to day development on a windows machine where WSL doesn't work so well due to corporate networking (for some reason..).

To use, build the container normally:

```bash
docker build . -t dev-container
```

Then run it with a volume for persistence and a github access token that is used to auth git using the gh cli:

```bash
docker run -d --name dev-c -v ./state/:/work-dir/ -e GITHUB_TOKEN=<my-token> dev-container
```
