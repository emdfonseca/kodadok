# KODADOK

Kodadok is one possible deployment description that allows you to run a web based code editor, such as [code-server](https://github.com/cdr/code-server) or [theia](https://github.com/eclipse-theia/theia), on a kubernetes cluster.

![Kodadok solution](./doc/images/kodadok_architecture.png)
*Deployment diagram of kodadok using [Kubernetes Deployment Language](https://www.openshift.com/blog/kdl-notation-kubernetes-app-deploy)*

# Run workspace in docker

Any defined workspace is released as a docker image. This means you can easily run each one of the workspaces directly from docker without depending on a kubernetes instance.

The existing available workspace images are:

- 

# TODO

- [x] Add base image for theia
- [ ] Proper documentation
- [ ] Setup code-server password 
- [ ] Rootless docker as an option
- [ ] Kubernetes operator