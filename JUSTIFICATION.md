
# Justification
In this example, we make heavy use of Docker for a simple and portable deployment solution. 

In a production release, this would likely fit into a build pipeline.
- Code kick off via merge or via pull request to a release branch
- A webhook is launched from Github to Jenkins
- Jenkins builds/tests the docker image
- Jenkins pushes a successful build to dockerhub
- Orchestration (such as: Salt, Ansible, Kube-control, Docker-swam) can be invoked to push an update of the docker image from Dockerhub

Given more time, the following would add to more robust service management:
- Build system (ex: Jenkins) to handle multiple pipelines
- Runtime log collection for the app
- Utilization metrics around the app
- Kubernetes or Swarm to provide failover of the web/content component
- Including multiple redis containers and redis-sentinel to manage redis failover
- Simple load balancing to ensure maximum uptime during deployment
- Development/Testing/Production build pipelines to allow for additional test models
- Monitoring to gauge availability/performance/state
