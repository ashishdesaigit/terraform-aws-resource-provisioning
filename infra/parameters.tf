locals {
    env = {

        default = {
        }

        qa = {

            projects_table_name     = "projects-qa"
            consultants_table_name  = "consultants-qa"
            users_table_name        = "users-qa"

        }

        prod = {

            projects_table_name     = "projects-prod"
            consultants_table_name  = "consultants-prod"
            users_table_name        = "users-prod"

        }
    }
    environmentvars = "${terraform.workspace}"
    workspace       = "${merge(local.env["default"], local.env[local.environmentvars])}"

}

