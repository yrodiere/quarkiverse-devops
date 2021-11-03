# Create repository
resource "github_repository" "quarkus_logging_manager" {
  name                   = "quarkus-logging-manager"
  description            = "Quarkus extension that allows you to view the log online and change log levels using a UI"
  delete_branch_on_merge = true
  has_issues             = true
  vulnerability_alerts   = true
  topics                 = ["quarkus-extension"]

  # Do not use the template below in new repositories. This is kept for backward compatibility with existing repositories
  template {
    owner      = "quarkiverse"
    repository = "quarkiverse-template"
  }
}

# Create team
resource "github_team" "quarkus_logging_manager" {
  name                      = "quarkiverse-logging-manager"
  description               = "Quarkiverse team for the logging-manager extension"
  create_default_maintainer = false
  privacy                   = "closed"
}

# Add team to repository
resource "github_team_repository" "quarkus_logging_manager" {
  team_id    = github_team.quarkus_logging_manager.id
  repository = github_repository.quarkus_logging_manager.name
  permission = "maintain"
}

# Add users to the team
resource "github_team_membership" "quarkus_logging_manager" {
  for_each = { for tm in ["oscarfh", "phillip-kruger"] : tm => tm }
  team_id  = github_team.quarkus_logging_manager.id
  username = each.value
  role     = "maintainer"
}