return {
    exe = "latexindent",
    args = {
        "-o",
        "stdout",
        "-l",
        "-g",
        "/dev/null",
    },
    stdin = true,
}