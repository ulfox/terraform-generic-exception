// ------------------------------------------------------------
// Exception
// ------------------------------------------------------------
resource "null_resource" "raise_error" {
    triggers = {
        expression = local.expression
    }

    provisioner "local-exec" {
        command = self.triggers.expression
        environment = {
            message = local.message
        }
    }
}

