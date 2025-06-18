# aspnetcore-sample

Repo with test reusable GitHub Actions workflows


this is the fix

## [Workflows](./.github/workflows)
- [az-loadtest.yml](#az-loadtestyml)
- [main.yml](#mainyml)
- [r_basic-shared.yml (Reusable Workflow)](#r_basic-sharedyml-reusable-workflow)
- [r_build.yaml (Reusable Workflow)](#r_buildyaml-reusable-workflow)
- [r_build_dotnet_framework.yaml (Reusable Workflow)](#r_build_dotnet_frameworkyaml-reusable-workflow)
- [r_build_loop.yaml (Reusable Workflow)](#r_build_loopyaml-reusable-workflow)
- [r_deploy_win.yaml (Reusable Workflow)](#r_deploy_winyaml-reusable-workflow)
- [r_deploy_az_function_win.yaml (Reusable Workflow)](#r_deploy_az_function_winyaml-reusable-workflow)
- [r_get_version.yaml (Reusable Workflow)](#r_get_versionyaml-reusable-workflow)
- [r_get_version_csproj_win.yaml (Reusable Workflow)](#r_get_version_csproj_winyaml-reusable-workflow)
- [r_get_version_win.yaml (Reusable Workflow)](#r_get_version_winyaml-reusable-workflow)
- [r_release.yaml (Reusable Workflow)](#r_releaseyaml-reusable-workflow)
- [r_release_win.yaml (Reusable Workflow)](#r_release_winyaml-reusable-workflow)
- [redeploy-uat-prod.yaml](#redeploy-uat-prodyaml)
- [test-enhancements.yaml](#test-enhancementsyaml)
- [test-merge-pr.yml](#test-merge-pryml)
- [test_external_scripts.yaml](#test_external_scriptsyaml)
- [test_loop.yaml](#test_loopyaml)
- [update-release-notes.yml](#update-release-notesyml)

### `az-loadtest.yml`
- **Description**: This workflow is designed to perform load testing using Azure Load Testing services on both Linux and Windows environments.
- **Triggers**: 
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [az-loadtest.yml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/az-loadtest.yml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Az CLI login**: Logs in to Azure using service principal credentials.
  - **Azure Load Testing**: Runs load tests using Azure Load Testing service.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`
    - `azure/login@v1`
    - `azure/load-testing@v1`

### `main.yml`
- **Description**: This workflow handles the build and deployment process for different environments (dev, qa, uat, prod) and also manages versioning and releases.
- **Triggers**: 
  - `push` to the `main` branch.
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [main.yml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/main.yml)
- **Steps**:
  - **Build**: Calls the reusable `r_build.yaml` workflow to build the project.
  - **Deploy to Dev**: Deploys the build artifacts to the development environment.
  - **Deploy to QA**: Deploys the build artifacts to the QA environment.
  - **Get Next Version Tag**: Determines the next version tag for the release.
  - **Prerelease**: Creates a prerelease with the new version.
  - **Deploy to UAT**: Deploys the prerelease to the UAT environment.
  - **Release**: Creates a final release with the new version.
  - **Deploy to Prod**: Deploys the final release to the production environment.
- **Dependencies**:
  - Workflow Calls: 
    - `./.github/workflows/r_build.yaml`
    - `./.github/workflows/r_deploy_win.yaml`
    - `./.github/workflows/r_get_version_win.yaml`
    - `./.github/workflows/r_release_win.yaml`
  - Actions:
    - `actions/checkout@v3`

### `r_basic-shared.yml` (Reusable Workflow)
- **Description**: This is a reusable workflow that can be called by other workflows to run a simple test.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_basic-shared.yml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_basic-shared.yml)
- **Steps**:
  - **Run Test**: Executes a simple test command (`echo ok`).
- **Dependencies**:
  - None

### `r_build.yaml` (Reusable Workflow)
- **Description**: This workflow builds the .NET project, restores dependencies, and publishes artifacts.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_build.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_build.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Setup .NET Core**: Sets up the .NET Core environment.
  - **Restore**: Restores the .NET project dependencies.
  - **Build**: Builds the .NET project.
  - **Publish**: Publishes the build artifacts.
  - **Publish Artifacts**: Uploads the build artifacts for later use.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`
    - `actions/setup-dotnet@v2`
    - `actions/upload-artifact@v3`

### `r_build_dotnet_framework.yaml` (Reusable Workflow)
- **Description**: This workflow builds a .NET Framework solution, restores NuGet packages, and uploads build artifacts.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_build_dotnet_framework.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_build_dotnet_framework.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Setup NuGet**: Sets up NuGet tools.
  - **NuGet Restore**: Restores NuGet packages.
  - **Setup MSBuild**: Sets up MSBuild tools.
  - **Run MSBuild**: Builds the .NET Framework solution.
  - **Upload Artifacts**: Uploads the build artifacts for later use.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v2`
    - `nuget/setup-nuget@v1`
    - `microsoft/setup-msbuild@v1.0.2`
    - `actions/upload-artifact@v2`

### `r_build_loop.yaml` (Reusable Workflow)
- **Description**: This workflow builds multiple .NET projects in a loop, restores dependencies, and publishes artifacts.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_build_loop.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_build_loop.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Setup .NET Core**: Sets up the .NET Core environment.
  - **Restore**: Restores the .NET project dependencies in a loop.
  - **Build**: Builds the .NET projects in a loop.
  - **Publish**: Publishes the build artifacts in a loop.
  - **Publish Artifacts**: Uploads the build artifacts for later use.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`
    - `actions/setup-dotnet@v2`
    - `actions/upload-artifact@v3`

### `r_deploy_win.yaml` (Reusable Workflow)
- **Description**: This workflow handles the deployment of web applications to Azure WebApp on Windows environments.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_deploy_win.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_deploy_win.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Download Artifacts**: Downloads the build artifacts.
  - **Az CLI Login**: Logs in to Azure using service principal credentials.
  - **Deploy to Azure WebApp**: Deploys the artifacts to Azure WebApp.
  - **Update App Settings**: Updates the app settings of the Azure WebApp.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`
    - `actions/download-artifact@v3`
    - `azure/login@v1`
    - `azure/appservice-settings@v1`

### `r_deploy_az_function_win.yaml` (Reusable Workflow)
- **Description**: This workflow handles the deployment of Azure Functions on Windows environments.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_deploy_az_function_win.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_deploy_az_function_win.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Download Artifacts**: Downloads the build artifacts.
  - **Az CLI Login**: Logs in to Azure using service principal credentials.
  - **Deploy to Azure Functions**: Deploys the artifacts to Azure Functions.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`
    - `actions/download-artifact@v3`
    - `azure/login@v1`
    - `Azure/functions-action@v1`

### `r_get_version.yaml` (Reusable Workflow)
- **Description**: This workflow determines the next version to release based on the current tags.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_get_version.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_get_version.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Get Next Version**: Determines the next version based on the current tags.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`

### `r_get_version_csproj_win.yaml` (Reusable Workflow)
- **Description**: This workflow reads the version from a specified `.csproj` file and determines the next version to release.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_get_version_csproj_win.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_get_version_csproj_win.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Get Next Version**: Reads the version from the specified `.csproj` file and determines the next version.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`

### `r_get_version_win.yaml` (Reusable Workflow)
- **Description**: This workflow determines the next version to release based on the current tags, specifically for Windows environments.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_get_version_win.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_get_version_win.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Get Next Version**: Determines the next version based on the current tags.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`

### `r_release.yaml` (Reusable Workflow)
- **Description**: This workflow creates a new release, either as a prerelease or a final release.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_release.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_release.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Download Artifacts**: Downloads the build artifacts.
  - **Create Prerelease**: Creates a prerelease with the new version.
  - **Update Prerelease to Release**: Updates the prerelease to a final release if necessary.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`
    - `actions/download-artifact@v3`
  - `gh cli`

### `r_release_win.yaml` (Reusable Workflow)
- **Description**: This workflow creates a new release, either as a prerelease or a final release, specifically for Windows environments.
- **Triggers**: 
  - `workflow_call`: This workflow can be triggered by other workflows.
- **Link**: [r_release_win.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/r_release_win.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Download Artifacts**: Downloads the build artifacts.
  - **Create Prerelease**: Creates a prerelease with the new version.
  - **Update Prerelease to Release**: Updates the prerelease to a final release if necessary.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`
    - `actions/download-artifact@v3`
  - `gh cli`

### `redeploy-uat-prod.yaml`
- **Description**: This workflow redeploys a specified version to UAT and production environments.
- **Triggers**: 
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [redeploy-uat-prod.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/redeploy-uat-prod.yaml)
- **Steps**:
  - **Approve UAT**: Requires manual approval for UAT deployment.
  - **Deploy to UAT**: Deploys the specified version to the UAT environment.
  - **Release**: Creates a final release with the specified version.
  - **Deploy to Prod**: Deploys the final release to the production environment.
- **Dependencies**:
  - Workflow Calls:
    - `./.github/workflows/r_deploy.yaml`
    - `./.github/workflows/r_release.yaml`
  - Actions:
    - `actions/checkout@v3`

### `test-enhancements.yaml`
- **Description**: This workflow is for testing enhancements to the build and deployment process, including deploying to multiple web applications.
- **Triggers**: 
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [test-enhancements.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/test-enhancements.yaml)
- **Steps**:
  - **Build**: Calls the reusable `r_build.yaml` workflow to build the project.
  - **Build Inline**: Performs an inline build process.
  - **Deploy**: Calls the reusable `r_deploy_win.yaml` workflow to deploy the build artifacts.
- **Dependencies**:
  - Workflow Calls:
    - `./.github/workflows/r_build.yaml`
    - `./.github/workflows/r_deploy_win.yaml`
  - Actions:
    - `actions/checkout@v3`
    - `actions/setup-dotnet@v2`
    - `actions/upload-artifact@v3`

### `test-merge-pr.yml`
- **Description**: This workflow handles merging changes from one branch to another.
- **Triggers**: 
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [test-merge-pr.yml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/test-merge-pr.yml)
- **Steps**:
  - **Checkout**: Checks out the specified branch.
  - **Merge**: Merges changes from the main branch.
  - **Push**: Pushes the merged changes to the remote repository.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`

### `test_external_scripts.yaml`
- **Description**: This workflow tests the usage of external scripts by cloning a separate repository containing the scripts and executing them.
- **Triggers**: 
  - `push` to the `main` branch.
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [test_external_scripts.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/test_external_scripts.yaml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Clone Scripts Repository**: Clones the external scripts repository.
  - **Run Scripts**: Executes the scripts from the external repository.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v3`

### `test_loop.yaml`
- **Description**: This workflow tests the build process for multiple .NET projects in a loop.
- **Triggers**: 
  - `push` to the `main` branch.
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [test_loop.yaml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/test_loop.yaml)
- **Steps**:
  - **Build**: Calls the reusable `r_build_loop.yaml` workflow to build the projects.
- **Dependencies**:
  - Workflow Calls:
    - `./.github/workflows/r_build_loop.yaml`

### `update-release-notes.yml`
- **Description**: This workflow updates the release description with linked issues.
- **Triggers**: 
  - `push` to the `main` branch.
  - `workflow_dispatch`: This workflow can be manually triggered.
- **Link**: [update-release-notes.yml](https://github.com/jcantosz-test-org/aspnetcore-sample/blob/main/.github/workflows/update-release-notes.yml)
- **Steps**:
  - **Checkout**: Checks out the repository code.
  - **Update Release Description**: Updates the release description with linked issues.
- **Dependencies**:
  - Actions:
    - `actions/checkout@v4`
    - `jcantosz/release-issues-action@main`
