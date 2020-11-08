
// ------------------------------------------------------------
// Exception Locals
// ------------------------------------------------------------
locals {
    exit_code = var.exit_code == null ? 1 : var.exit_code
    shell_condition = var.shell_condition == null ? "" : var.shell_condition
    condition = (
        var.condition == null || var.condition == []
    ) ? [] : var.condition
    multi_condition = (
        var.multi_condition == null || var.multi_condition == []
    ) ? [] : var.multi_condition
    multi_shell_condition = (
        var.multi_shell_condition == null || var.multi_shell_condition == []
    ) ? [] : var.multi_shell_condition

    is_shell_condition = (
        local.shell_condition == ""
    ) ? false : true

    is_condition = (
        length(local.condition) == 0
    ) ? false : true

    is_multi_condition = (
        length(local.multi_condition) == 0
    ) ? false : true

    is_multi_shell_condition = (
        length(local.multi_shell_condition) == 0
    ) ? false : true

    message = var.message == null ? (
        format(
            "Error: failed to validate condition: %s",
            local.is_shell_condition == true ? (
                local.shell_condition
            ) : (
                local.is_condition == true ? (
                    local.condition
                ) : ""
            )
        )
    ) : var.message

    expression_check = (
        length(local.condition) == 3
    ) ? 3 : (
        length(local.condition) == 1 ? 1 : 0
    )

    shell_expression = (
        local.is_shell_condition == true
    ) ? (
        format(
            "trap 'info' EXIT; info() { echo $message; }; %s",
            local.shell_condition,
        )
    ) : "exit ${local.exit_code}"

    expression = (
        local.is_condition == true
    ) ? (
            local.expression_check == 3
        ) ? (
            format(
                "trap 'info' EXIT; info() { echo $message; }; if ! [ %s ]; then exit %s; fi",
                format(
                    "\"%s\" %s \"%s\"",
                    var.condition[0],
                    var.condition[1],
                    var.condition[2],
                ),
                local.exit_code,
            )
        ) : (
            (
                local.expression_check == 1
            ) ? (
                format(
                    "trap 'info' EXIT; info() { echo $message; }; if ! %s; then exit %s; fi",
                    var.condition[0],
                    local.exit_code,
                )  
            ) : ""
        ) : "exit ${local.exit_code}"
}
