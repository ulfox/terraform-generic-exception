// ------------------------------------------------------------
// Exception
// ------------------------------------------------------------
resource "null_resource" "shell_raise_error" {
    count = local.is_shell_condition ? 1 : 0
    triggers = {
        expression = local.shell_expression
    }

    provisioner "local-exec" {
        command = self.triggers.expression
        environment = {
            message = local.message
        }
    }
}

resource "null_resource" "raise_error" {
    count = local.is_condition ? 1 : 0
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

resource "null_resource" "multi_shell_raise_error" {
    count = local.is_multi_shell_condition ? length(local.multi_shell_condition) : 0
    triggers = {
        expression = (
            format(
                "trap 'info' EXIT; info() { echo $message; }; %s",
                local.multi_shell_condition[count.index],
            )
        )
    }

    provisioner "local-exec" {
        command = self.triggers.expression
        environment = {
            message = local.message
        }
    }
}

resource "null_resource" "multi_raise_error" {
    count = local.is_multi_condition ? length(local.multi_condition) : 0
    triggers = {
        expression = (
            length(local.multi_condition[count.index]) == 3
        ) ? (
            format(
                "trap 'info' EXIT; info() { echo $message; }; if ! [ %s ]; then exit %s; fi",
                format(
                    "\"%s\" %s \"%s\"",
                    var.multi_condition[count.index][0],
                    var.multi_condition[count.index][1],
                    var.multi_condition[count.index][2],
                ),
                local.exit_code,
            )
        ) : (
            (
                length(local.multi_condition[count.index]) == 1
            ) ? (
                format(
                    "trap 'info' EXIT; info() { echo $message; }; if ! %s; then exit %s; fi",
                    var.multi_condition[count.index][0],
                    local.exit_code,
                )  
            ) : "true == true"
        ) 
    }

    provisioner "local-exec" {
        command = self.triggers.expression
        environment = {
            message = local.message
        }
    }
}

