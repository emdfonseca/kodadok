# KODADOK

Kodadok helps you deploy you own customized cloud code editor.

![Kodadok solution](./doc/images/kodadok_architecture.png)

*Deployment diagram of kodadok using [Kubernetes Deployment Language](https://www.openshift.com/blog/kdl-notation-kubernetes-app-deploy)*

# Run workspace on docker

Any defined workspace is released as a docker image. This means you can easily run each one of the workspaces directly from docker without depending on a kubernetes instance.

At the moment you can build your own workspace image or run any of the images available on docker hub:

- kodadok/code-server
- kodadok/code-server-node
- kodadok/code-server-node-golang
- kodadok/code-server-node-jdk
- kodadok/theia
- kodadok/theia-node
- kodadok/theia-node-golang
- kodadok/theia-node-jdk

For example, if you would like to run code server on an environment ready for node and golang development you can execute the following command:

```console
docker run -p 28801:28801 kodadok/code-server-node-golang
```

After starting the docker container you can open your browser on [http://localhost:28801](http://localhost:28801) and the code editor will be ready to use.

# Run workspace on kubernetes

The folder 'kodadok-chart' contains an helm chart that you can use to deploy your own workspace - detailed documentation is still missing but if helm is not new to you it should be straightforward to create your own values.yaml and deploy your instance.

> If you would like to deploy, but do not find out how, create a ticket and I will do my best to support you and improve the documentation accordingly.

# TODO

- [x] Add code-server editor
- [x] Add theia editor
- [x] Add helm chart to quickly deploy workspace on kubernetes
- [ ] Write better documentation
- [ ] Setup code-server password 
- [ ] Rootless docker as an option
- [ ] Kubernetes operator
